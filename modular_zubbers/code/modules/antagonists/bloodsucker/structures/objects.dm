//////////////////////
//     BLOODBAG     //
//////////////////////

#define BLOODBAG_GULP_SIZE 5

/obj/item/reagent_containers/blood
	var/being_drunk = FALSE

/// Taken from drinks.dm
/obj/item/reagent_containers/blood/attack(mob/living/victim, mob/living/attacker, params)
	if(!can_drink(victim, attacker) || being_drunk)
		return
	being_drunk = TRUE
	if(victim != attacker)
		// show to both victim and attacker
		INVOKE_ASYNC(src, GLOBAL_PROC_REF(do_after), victim, 5 SECONDS, attacker)
		do_after(victim, 5 SECONDS, attacker)
		if(!do_after(attacker, 5 SECONDS, victim))
			being_drunk = FALSE
			return
		attacker.visible_message(
			span_notice("[attacker] forces [victim] to drink from the [src]."),
			span_notice("You put the [src] up to [victim]'s mouth."))
		reagents.trans_to(victim, BLOODBAG_GULP_SIZE, transferred_by = attacker, methods = INGEST)
		playsound(victim.loc, 'sound/items/drink.ogg', 30, 1)
		being_drunk = FALSE
		return TRUE

	while(do_after(victim, 1 SECONDS, timed_action_flags = IGNORE_USER_LOC_CHANGE, extra_checks = CALLBACK(src, PROC_REF(can_drink), attacker, victim)))
		victim.visible_message(
			span_notice("[victim] puts the [src] up to their mouth."),
			span_notice("You take a sip from the [src]."),
		)
		reagents.trans_to(victim, BLOODBAG_GULP_SIZE, transferred_by = attacker, methods = INGEST)
		playsound(victim.loc, 'sound/items/drink.ogg', 30, 1)
	being_drunk = FALSE
	return TRUE

#undef BLOODBAG_GULP_SIZE

/obj/item/reagent_containers/blood/proc/can_drink(mob/living/victim, mob/living/attacker)
	if(!canconsume(victim, attacker))
		return FALSE
	if(!reagents || !reagents.total_volume)
		to_chat(victim, span_warning("[src] is empty!"))
		return FALSE
	return TRUE

///Bloodbag of Bloodsucker blood (used by Ghouls only)
/obj/item/reagent_containers/blood/o_minus/bloodsucker
	name = "blood pack"
	unique_blood = /datum/reagent/blood/bloodsucker

/obj/item/reagent_containers/blood/o_minus/bloodsucker/examine(mob/user)
	. = ..()
	if(user.mind.has_antag_datum(/datum/antagonist/ex_ghoul) || user.mind.has_antag_datum(/datum/antagonist/ghoul/revenge))
		. += span_notice("Seems to be just about the same color as your Master's...")

//////////////////////
//      STAKES      //
//////////////////////
/obj/item/stack/sheet/mineral/wood/attackby(obj/item/item, mob/user, params)
	if(!item.get_sharpness())
		return ..()
	user.visible_message(
		span_notice("[user] begins whittling [src] into a pointy object."),
		span_notice("You begin whittling [src] into a sharp point at one end."),
		span_hear("You hear wood carving."),
	)
	// 5 Second Timer
	if(!do_after(user, 5 SECONDS, src, NONE, TRUE))
		return
	// Make Stake
	var/obj/item/stake/new_item = new(user.loc)
	user.visible_message(
		span_notice("[user] finishes carving a stake out of [src]."),
		span_notice("You finish carving a stake out of [src]."),
	)
	// Prepare to Put in Hands (if holding wood)
	var/obj/item/stack/sheet/mineral/wood/wood_stack = src
	var/replace = (user.get_inactive_held_item() == wood_stack)
	// Use Wood
	wood_stack.use(1)
	// If stack depleted, put item in that hand (if it had one)
	if(!wood_stack && replace)
		user.put_in_hands(new_item)

// TODO move this into bloodsuckerdatum
/// Do I have a stake in my heart?
/mob/living/proc/am_staked()
	var/obj/item/bodypart/chosen_bodypart = get_bodypart(BODY_ZONE_CHEST)
	var/obj/item/stake/stake = locate() in chosen_bodypart.embedded_objects
	return stake

/mob/living/proc/get_stakes()
	var/obj/item/bodypart/chosen_bodypart = get_bodypart(BODY_ZONE_CHEST)
	if(!chosen_bodypart)
		return FALSE
	var/list/stakes = list()
	for(var/obj/item/embedded_stake in chosen_bodypart.embedded_objects)
		if(istype(embedded_stake, /obj/item/stake))
			stakes += list(embedded_stake)
	return stakes

/datum/embed_data/stake
	embed_chance = 20

/obj/item/stake
	name = "wooden stake"
	desc = "A simple wooden stake carved to a sharp point."
	icon = 'modular_zubbers/icons/obj/equipment/stakes.dmi'
	icon_state = "wood"
	inhand_icon_state = "wood"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/bloodsucker_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/bloodsucker_righthand.dmi'
	slot_flags = ITEM_SLOT_POCKETS
	w_class = WEIGHT_CLASS_SMALL
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("staked", "stabbed", "tore into")
	attack_verb_simple = list("staked", "stabbed", "tore into")
	sharpness = SHARP_EDGED
	embed_data = /datum/embed_data/stake
	force = 6
	throwforce = 10
	max_integrity = 30
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 3)

	///Time it takes to embed the stake into someone's chest.
	var/staketime = 5 SECONDS
	var/kills_blodsuckers = FALSE

/obj/item/stake/examine_more(mob/user)
	. = ..()
	. += span_notice("You can use [src] to stake someone in the chest, if they are laying down or grabbed by the neck.")
	if(IS_BLOODSUCKER(user))
		. += span_warning("You feel a sense of dread as you look at the [src]...")

/obj/item/stake/attack(mob/living/target, mob/living/user, params)
	. = ..()
	if(.)
		return
	// Invalid Target, or not targetting the chest?
	if(check_zone(user.zone_selected) != BODY_ZONE_CHEST)
		return
	if(target == user)
		return
	if(!target.can_be_staked()) // Oops! Can't.
		to_chat(user, span_danger("You can't stake [target] when they are moving about! They have to be laying down or grabbed by the neck!"))
		return
	if(HAS_TRAIT(target, TRAIT_PIERCEIMMUNE))
		to_chat(user, span_danger("[target]'s chest resists the stake. It won't go in."))
		return

	to_chat(user, span_notice("You put all your weight into embedding the stake into [target]'s chest..."))
	playsound(user, 'sound/effects/magic/Demon_consume.ogg', 50, 1)
	if(!do_after(user, staketime, target, extra_checks = CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon, can_be_staked)))) // user / target / time / uninterruptable / show progress bar / extra checks
		return
	// Drop & Embed Stake
	user.visible_message(
		span_danger("[user.name] drives the [src] into [target]'s chest!"),
		span_danger("You drive the [src] into [target]'s chest!"),
	)
	playsound(get_turf(target), 'sound/effects/splat.ogg', 40, 1)
	if(tryEmbed(target.get_bodypart(BODY_ZONE_CHEST), TRUE, TRUE)) //and if it embeds successfully in their chest, cause a lot of pain
		target.apply_damage(max(10, force * 1.2), BRUTE, BODY_ZONE_CHEST, wound_bonus = 0, sharpness = TRUE)
		on_stake_embed(target, user)

/obj/item/stake/proc/on_stake_embed(mob/living/target, mob/living/user)
	return

/obj/item/stake/hardened/silver/on_stake_embed(mob/living/target, mob/living/user)
	var/obj/item/organ/internal/heart/heart = target.get_organ_slot(ORGAN_SLOT_HEART)
	if(!heart)
		return
	target.visible_message(
		span_danger("The [src.name] pierces [target]'s chest, destroying their [heart.name]!"),
		span_userdanger("You feel a HORRIBLE pain as the [src.name] pierces your chest, destroying your [heart.name]!"),
	)
	qdel(heart)

/obj/item/stake/tryEmbed(atom/target, forced)
	. = ..()
	if(!(. & COMPONENT_EMBED_SUCCESS) || !isbodypart(target))
		return FALSE
	var/obj/item/bodypart/bodypart = target
	if(bodypart.body_zone != BODY_ZONE_CHEST)
		return
	SEND_SIGNAL(bodypart, COMSIG_BODYPART_STAKED, forced)
	if(bodypart.owner)
		SEND_SIGNAL(bodypart.owner, COMSIG_MOB_STAKED, forced)

///Can this target be staked? If someone stands up before this is complete, it fails. Best used on someone stationary.
/mob/living/proc/can_be_staked()
	return FALSE

/mob/living/carbon/can_be_staked()
	if(body_position == LYING_DOWN)
		return TRUE
	return FALSE

/datum/embed_data/stake/hardened
	embed_chance = 35
	fall_chance = 0

/// Created by welding and acid-treating a simple stake.
/obj/item/stake/hardened
	name = "hardened stake"
	desc = "A wooden stake carved to a sharp point and hardened by fire."
	icon_state = "hardened"
	force = 8
	throwforce = 12
	armour_penetration = 10
	embed_data = /datum/embed_data/stake/hardened
	staketime = 12 SECONDS

/obj/item/stake/hardened/examine_more(mob/user)
	. = ..()
	. += span_notice("The [src] won't fall out by itself, if embedded in someone.")

/datum/embed_data/stake/silver
	embed_chance = 0 // we want it to only be embeddable manually
	fall_chance = 0

/obj/item/stake/hardened/silver
	name = "silver stake"
	desc = "Polished and sharp at the end. For when some mofo is always trying to iceskate uphill."
	icon_state = "silver"
	inhand_icon_state = "silver"
	siemens_coefficient = 1
	force = 9
	armour_penetration = 25
	custom_materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT)
	embed_data = /datum/embed_data/stake/silver
	staketime = 15 SECONDS

/obj/item/stake/hardened/silver/examine_more(mob/user)
	. = ..()
	. += span_notice("You think that the [src] could destroy someone's heart if you really slam it in someone's ribs properly.")

//////////////////////
//     ARCHIVES     //
//////////////////////

/**
 *	# Archives of the Kindred:
 *+
 *	A book that can only be used by Curators.
 *	When used on a player, after a short timer, will reveal if the player is a Bloodsucker, including their real name and Clan.
 *	This book should not work on Bloodsuckers using the Masquerade ability.
 *	If it reveals a Bloodsucker, the Curator will then be able to tell they are a Bloodsucker on examine (Like a Ghoul).
 *	Reading it normally will allow Curators to read what each Clan does, with some extra flavor text ones.
 *
 *	Regular Bloodsuckers won't have any negative effects from the book, while everyone else will get burns/eye damage.
 */
/obj/item/book/kindred
	name = "\improper Book of Nod"
	starting_title = "the Book of Nod"
	desc = "Cryptic documents explaining hidden truths behind Undead beings. It is said only Curators can decipher what they really mean."
	icon = 'modular_zubbers/icons/obj/structures/vamp_obj.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/bloodsucker_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/bloodsucker_righthand.dmi'
	icon_state = "kindred_book"
	starting_author = "dozens of generations of Curators"
	unique = TRUE
	throw_speed = 1
	throw_range = 10
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	///Boolean on whether the book is currently being used, so you can only use it on one person at a time.
	COOLDOWN_DECLARE(bloodsucker_check_cooldown)
	var/cooldown_time = 1 MINUTES

/obj/item/book/kindred/Initialize(mapload)
	. = ..()
	SSpoints_of_interest.make_point_of_interest(src)

/obj/item/book/kindred/try_carve(obj/item/carving_item, mob/living/user, params)
	to_chat(user, span_notice("You feel the gentle whispers of a Librarian telling you not to cut [starting_title]."))
	return FALSE

///Attacking someone with the book.
/obj/item/book/kindred/afterattack(mob/living/target, mob/living/user, flag, params)
	. = ..()
	if(!user.can_read(src) || (target == user) || !ismob(target))
		return
	if(!HAS_TRAIT(user.mind, TRAIT_BLOODSUCKER_HUNTER))
		if(IS_BLOODSUCKER(user))
			to_chat(user, span_notice("[src] seems to be too complicated for you. It would be best to leave this for someone else to take."))
			return
		to_chat(user, span_warning("[src] burns your hands as you try to use it!"))
		user.apply_damage(3, BURN, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		return

	if(!COOLDOWN_FINISHED(src, bloodsucker_check_cooldown))
		user.balloon_alert(user, "your head hurts, wait a minute ")
		addtimer(CALLBACK(user, TYPE_PROC_REF(/atom, balloon_alert), user, "You feel your head clear up."), cooldown_time)
		return
	user.balloon_alert_to_viewers(user, "reading book...")
	user.balloon_alert(target, "looks at you and checks their [src]...")
	if(!do_after(user, 3 SECONDS, target, timed_action_flags = NONE, progress = TRUE))
		to_chat(user, span_notice("You quickly close [src]."))
		return
	COOLDOWN_START(src, bloodsucker_check_cooldown, cooldown_time)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(target)
	// Are we a Bloodsucker | Are we on Masquerade. If one is true, they will fail.
	if(IS_BLOODSUCKER(target) && !HAS_TRAIT(target, TRAIT_MASQUERADE))
		if(bloodsuckerdatum.broke_masquerade)
			to_chat(user, span_warning("[target], also known as '[bloodsuckerdatum.return_full_name()]', is indeed a Bloodsucker, but you already knew this."))
			return
		to_chat(user, span_warning("[target], also known as '[bloodsuckerdatum.return_full_name()]', [bloodsuckerdatum.my_clan ? "is part of the [bloodsuckerdatum.my_clan]!" : "is not part of a clan."] You quickly note this information down, memorizing it."))
		bloodsuckerdatum.break_masquerade()
	else
		to_chat(user, span_notice("You fail to draw any conclusions to [target] being a Bloodsucker."))

/obj/item/book/kindred/attack_self(mob/living/user)
	if(user.mind && !(HAS_TRAIT(user.mind, TRAIT_BLOODSUCKER_HUNTER) || IS_BLOODSUCKER(user)))
		to_chat(user, span_warning("You feel your eyes unable to read the boring texts..."))
		user.set_eye_blur_if_lower(10 SECONDS)
		return
	ui_interact(user)

/obj/item/book/kindred/ui_interact(mob/living/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "KindredBook", name)
		ui.open()

/obj/item/book/kindred/ui_static_data(mob/user)
	var/data = list()

	for(var/datum/bloodsucker_clan/clans as anything in subtypesof(/datum/bloodsucker_clan))
		var/clan_data = list()
		clan_data["clan_name"] = initial(clans.name)
		clan_data["clan_desc"] = initial(clans.description)
		data["clans"] += list(clan_data)

	return data

/obj/structure/displaycase/curator
	desc = "This book was found inside a coffin of a long dead Curator. It is said to be able to reveal the true nature of those who feed upon mankind."
	start_showpiece_type = /obj/item/book/kindred
	req_access = list(ACCESS_LIBRARY)


/// just a typepath to specify that it's monkey-owned, used for the heart thief objective
/obj/item/organ/internal/heart/monkey

/obj/item/organ/internal/heart/examine_more(mob/user)
	. = ..()
	var/datum/antagonist/bloodsucker/vampire = IS_BLOODSUCKER(user)
	if(!vampire)
		return
	var/datum/objective/steal_n_of_type/heart_thief = locate() in vampire?.objectives
	if(!heart_thief)
		return
	if(heart_thief.check_if_valid_item(src))
		. += span_notice("This [src.name] will do for your purposes...")
	else
		. += span_notice("This [src.name] is of lesser quality, it won't do...")
