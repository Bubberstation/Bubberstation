/datum/species/lizard/ashwalker
	mutanteyes = /obj/item/organ/eyes/night_vision/ashwalker
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/lizard/ashwalker,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/lizard/ashwalker,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/lizard/ashwalker,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/lizard/ashwalker,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/lizard/ashwalker,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/lizard/ashwalker,
	)

/datum/species/lizard/ashwalker/on_species_gain(mob/living/carbon/carbon_target, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	ADD_TRAIT(carbon_target, TRAIT_ASHSTORM_IMMUNE, SPECIES_TRAIT)
	RegisterSignal(carbon_target, COMSIG_MOB_ITEM_ATTACK, PROC_REF(mob_attack))
	carbon_target.AddComponent(/datum/component/ash_age)
	carbon_target.apply_status_effect(/datum/status_effect/ash_age)
	carbon_target.add_faction(list(FACTION_ASHWALKER,FACTION_NEUTRAL))

/datum/species/lizard/ashwalker/on_species_loss(mob/living/carbon/carbon_target)
	. = ..()
	REMOVE_TRAIT(carbon_target, TRAIT_ASHSTORM_IMMUNE, SPECIES_TRAIT)
	UnregisterSignal(carbon_target, COMSIG_MOB_ITEM_ATTACK)
	carbon_target.remove_faction(list(FACTION_ASHWALKER,FACTION_NEUTRAL))

/datum/species/lizard/ashwalker/proc/mob_attack(datum/source, mob/mob_target, mob/user)
	SIGNAL_HANDLER

	if(!isliving(mob_target))
		return

	var/mob/living/living_target = mob_target
	var/datum/status_effect/ashwalker_damage/ashie_damage = living_target.has_status_effect(/datum/status_effect/ashwalker_damage)
	if(!ashie_damage)
		ashie_damage = living_target.apply_status_effect(/datum/status_effect/ashwalker_damage)

	ashie_damage.register_mob_damage(living_target)

/**
 * 15 minutes = armor
 * 30 minutes = base punch + boulder breaking
 * 45 minutes = hivemind
 * 60 minutes = speed
 * 75 minutes = mutated claws
 * 90 minutes = lavaproof + firebreath
 */

/datum/component/ash_age
	/// the current stage of the ash
	var/current_stage = 0
	/// the human target the element is attached to
	var/mob/living/carbon/human/human_target

/datum/component/ash_age/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	// set the target for the element so we can reference in other parts
	human_target = parent
	// when the rune successfully completes the age ritual, it will send the signal... do the proc when we receive the signal
	RegisterSignal(human_target, COMSIG_RUNE_EVOLUTION, PROC_REF(check_evolution))
	RegisterSignal(human_target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/// Age Ritual handler
/datum/component/ash_age/proc/check_evolution()
	SIGNAL_HANDLER
	// if the world time hasn't yet passed the time required for evolution
	if(human_target.has_status_effect(/datum/status_effect/ash_age))
		to_chat(human_target, span_warning("More time is necessary to evolve-- fifteen minutes between each evolution..."))
		return

	// since it was time, go up a stage and now we check what to add
	current_stage++
	human_target.apply_status_effect(/datum/status_effect/ash_age)
	var/datum/species/species_target = human_target.dna.species
	switch(current_stage)
		if(1)
			species_target.damage_modifier += 10
			to_chat(human_target, span_notice("Your body seems to be sturdier..."))

		if(2)
			var/obj/item/bodypart/arm/left/left_arm = human_target.get_bodypart(BODY_ZONE_L_ARM)
			if(left_arm)
				left_arm.unarmed_damage_low += 5
				left_arm.unarmed_damage_high += 5

			var/obj/item/bodypart/arm/right/right_arm = human_target.get_bodypart(BODY_ZONE_R_ARM)
			if(right_arm)
				right_arm.unarmed_damage_low += 5
				right_arm.unarmed_damage_high += 5

			ADD_TRAIT(human_target, TRAIT_BOULDER_BREAKER, REF(src))
			to_chat(human_target, span_notice("Your arms seem denser and stronger..."))

		if(3)
			var/datum/action/ashen_actions/hivemind_speak/grant_hivemind = new /datum/action/ashen_actions/hivemind_speak(human_target)
			grant_hivemind.Grant(human_target)

		if(4)
			human_target.add_movespeed_modifier(/datum/movespeed_modifier/ash_aged)
			to_chat(human_target, span_notice("Your body seems lighter..."))

		if(5)
			var/obj/item/organ/claw_bones/summoned_organ = new /obj/item/organ/claw_bones()
			summoned_organ.Insert(human_target)
			to_chat(human_target, span_notice("Your arm shakes in agitation..."))

		if(6)
			ADD_TRAIT(human_target, TRAIT_LAVA_IMMUNE, REF(src))
			var/datum/action/cooldown/mob_cooldown/fire_breath/granted_action
			granted_action = new(human_target)
			granted_action.Grant(human_target)
			to_chat(human_target, span_notice("Your body feels hotter..."))

		if(7 to INFINITY)
			to_chat(human_target, span_warning("You have already reached the pinnacle of your current body!"))

/// Speed mod
/datum/movespeed_modifier/ash_aged
	multiplicative_slowdown = -0.2

/// Examines
/datum/component/ash_age/proc/on_examine(atom/target_atom, mob/user, list/examine_list)
	SIGNAL_HANDLER
	if(human_target.has_status_effect(/datum/status_effect/ash_age))
		examine_list += span_notice("[human_target] has not yet reached the age for evolving.")
		return
	examine_list += span_warning("[human_target] has reached the age for evolving!")

/datum/status_effect/ash_age
	id = "ash_age"
	duration = 15 MINUTES
	show_duration = TRUE
	alert_type = /atom/movable/screen/alert/status_effect/ash_age

/atom/movable/screen/alert/status_effect/ash_age
	name = "Ashen Age Fatigue"
	desc = "Your body has recently undergone some changes, and requires more time before it can be changed further."
	icon = 'modular_skyrat/modules/ashwalkers/icons/screen_alert.dmi'
	icon_state = "ash_age"

/obj/item/organ/claw_bones
	name = "ashen knuckle bones"
	desc = "The bones of an ash walker's right hand."
	zone = BODY_ZONE_R_ARM

	/// The summoned claws
	var/obj/item/melee/strengthened_claws/grown_claws

	/// The claws action given to the owner so they can summon and unsummon the claws
	var/datum/action/ashen_actions/grow_claws/granted_action

/obj/item/organ/claw_bones/Initialize(mapload)
	. = ..()
	grown_claws = new /obj/item/melee/strengthened_claws(src)

/obj/item/organ/claw_bones/Destroy()
	QDEL_NULL(grown_claws)
	QDEL_NULL(granted_action)
	return ..()

/obj/item/organ/claw_bones/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	granted_action = new()
	granted_action.Grant(organ_owner)
	granted_action.connected_organ = src

/obj/item/organ/claw_bones/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	granted_action.connected_organ = null
	granted_action.Remove(organ_owner)
	if(!locate(grown_claws) in src) //if the claws isnt in the organ when it is removed, move the claws back into the organ
		grown_claws.forceMove(src)

/datum/action/ashen_actions
	button_icon = 'modular_skyrat/modules/ashwalkers/icons/actions.dmi'
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"

/datum/action/ashen_actions/grow_claws
	name = "Strengthened Claws"
	button_icon_state = "strong_claws"

	/// the organ that is connected to this action
	var/obj/item/organ/claw_bones/connected_organ

/datum/action/ashen_actions/grow_claws/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return

	if(locate(connected_organ.grown_claws) in connected_organ)
		owner.put_in_active_hand(connected_organ.grown_claws)
		owner.visible_message(span_warning("A pair of strong, sharp claws grow on [owner]\'s hand!"), span_warning("Our hand quickly grows a sharp looking pair of claws."), span_hear("You hear organic matter ripping and tearing!"))
		playsound(get_turf(owner), 'sound/effects/blob/blobattack.ogg', 30, TRUE)

	else
		connected_organ.grown_claws.forceMove(connected_organ)
		owner.visible_message(span_warning("Suddenly [owner] retracts [owner.p_their()] [connected_organ.grown_claws] back into their hand!"), span_notice("We retract the [connected_organ.grown_claws] back into our hand."), span_italics("You hear organic matter ripping and tearing!"))
		playsound(get_turf(owner), 'sound/effects/blob/blobattack.ogg', 30, TRUE)

/obj/item/melee/strengthened_claws
	name = "strengthened claws"
	desc = "A pair of claws that cuts through people as a hot knife through butter. These have been strengthened by unknown means."
	icon = 'modular_skyrat/modules/ashwalkers/icons/gloves.dmi'
	icon_state = "strong_claws"
	inhand_icon_state = "strong_claws"
	lefthand_file = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing_left.dmi'
	righthand_file = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing_right.dmi'
	item_flags = NEEDS_PERMIT | ABSTRACT
	w_class = WEIGHT_CLASS_HUGE
	force = 5
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	wound_bonus = 0
	exposed_wound_bonus = 0
	armour_penetration = 5

	/// how many trophies we have consumed
	var/consumed_trophies = 0

	/// how many trophies we can consume
	var/max_trophies = 7

	/// the alternate continuous sharpness phrases
	var/list/alt_continuous = list("cuts", "slashes", "claw")

	/// the alternate simple sharpness phrases
	var/list/alt_simple = list("cut", "slash", "claw")

/obj/item/melee/strengthened_claws/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, REF(src))
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_EDGED, alt_continuous, alt_simple, -5)
	AddComponent(/datum/component/butchering, speed = 6 SECONDS, effectiveness = 80)

/obj/item/melee/strengthened_claws/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/crusher_trophy))
		if(prob(25)) // by chance, you should get at least every 3 out of 4 trophies.
			to_chat(user, span_warning("Your [src] consumes [tool] without benefit!"))
			qdel(tool)
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_warning("Your [src] consumes [tool]!"))
		playsound(get_turf(src), 'sound/effects/magic/demon_attack1.ogg', 50, TRUE)
		qdel(tool)
		consumed_trophies += 1
		if(isliving(user)) // give a reason to consume past the increased damage
			var/mob/living/living_user = user
			var/need_mob_update
			need_mob_update += living_user.adjust_brute_loss(-5, updating_health = FALSE)
			need_mob_update += living_user.adjust_fire_loss(-5, updating_health = FALSE)
			if(need_mob_update)
				living_user.updatehealth()

		if(consumed_trophies <= max_trophies)
			force += 5
			armour_penetration += 5
			wound_bonus += 2
			exposed_wound_bonus += 2

		else if(consumed_trophies == (max_trophies + 1)) // just so you aren't spammed...
			to_chat(user, span_warning("[src] can no longer grow stronger!"))

		return ITEM_INTERACT_BLOCKING

	return ..()

/datum/action/ashen_actions/hivemind_speak
	name = "Ashen Hivemend Speak"
	desc = "Enter what you wish to say into the ashen hivemind."
	button_icon_state = "hivemind"

	/// is this button currently in use?
	var/currently_used = FALSE

/datum/action/ashen_actions/hivemind_speak/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return

	if(currently_used)
		return

	currently_used = TRUE

	var/inserted_message = tgui_input_text(owner, "What would you like to say over the ashen hivemind?", "Ashen Hivemind Message", max_length = CHAT_MESSAGE_MAX_LENGTH)
	if(isnull(inserted_message))
		currently_used = FALSE
		return

	for(var/mob/living/living_ashwalker in GLOB.player_list)
		if(!isashwalker(living_ashwalker))
			continue

		to_chat(living_ashwalker, span_rose("<b>Ashen Hivemind: [owner] sings, \"[inserted_message]\"</b>"))

	for(var/mob/dead_mob in GLOB.dead_mob_list)
		var/link = FOLLOW_LINK(dead_mob, src)
		to_chat(dead_mob, span_rose("[link] <b>Ashen Hivemind: [owner] sings, \"[inserted_message]\"</b>"))

	var/logging_text = "[key_name(owner)] spoke into the hivemind: [inserted_message]"
	log_say(logging_text)
	currently_used = FALSE
