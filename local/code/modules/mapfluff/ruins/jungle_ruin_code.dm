/// LUNA ///
// The sword itself
/obj/item/claymore/cutlass/luna
	name = "Luna"
	desc = "Forged by a madwoman, in recognition of a time, a place - she thought almost real. Various etchings of moons are inscribed onto the surface, different phases marking different parts of the blade."
	icon = 'local/icons/obj/weapons/sword.dmi'
	lefthand_file = 'local/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'local/icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state = "luna"
	inhand_icon_state = "luna"
	slot_flags = null // Let's not.
	w_class = WEIGHT_CLASS_HUGE // This is a SWORD, coward
	light_color = LIGHT_COLOR_LIGHT_CYAN
	light_system = OVERLAY_LIGHT
	light_range = 3
	light_power = 1
	light_on = FALSE
	force = 15
	throwforce = 10
	exposed_wound_bonus = 25 // Good precision weapon, though not perfect.
	armour_penetration = 10 // Sharp enough to poke by default; but not exactly cleaving through any armor without the energy upgrade
	block_chance = 20 // Definitely agile enough to block; but keep in mind it's a rapier and not a bulkier sword
	sharpness = SHARP_POINTY // RAPIER. RAPIER. RAPIER!!!!
	/// Houses references to the current fragments we have attached.
	var/list/fragments = list()
	/// Whether or not we have access to the HPA's upgrade ability.
	var/can_bloodbeam = FALSE

/obj/item/claymore/cutlass/luna/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/unique_examine, \
	desc = "Corporate has this thing earmarked - someone pitched them that it's existence heralded an external dissident, and they've been quaking in their boots since. \
	In contrast; local reaction is much more... muted - most involved with today's deployment already used to it being nearby.", \
	desc_requirement = EXAMINE_CHECK_DEPARTMENT, \
	requirements = DEPARTMENT_SECURITY)

/obj/item/claymore/cutlass/luna/examine(mob/living/user)
	. = ..()
	. += span_notice("The design looks modular - it's possible you might be able to find additional pieces to attach.")
	for(var/found_fragment in fragments)
		var/obj/item/luna_fragment/fragment = found_fragment
		. += span_notice("\a [fragment] has been attached, allowing for Luna to [fragment.effect_desc]")

/obj/item/claymore/cutlass/luna/Destroy()
	QDEL_LIST(fragments)
	return ..()

/obj/item/claymore/cutlass/luna/Exited(atom/movable/gone, direction)
	. = ..()
	fragments -= gone

/obj/item/claymore/cutlass/luna/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()
	if(LAZYLEN(fragments))
		to_chat(user, span_notice("You remove [src]'s array of addons."))
		tool.play_tool_sound(src)
		for(var/found_fragment in fragments)
			var/obj/item/luna_fragment/Fragment = found_fragment
			Fragment.remove_upgrade(src, user)
			Fragment.forceMove(get_turf(src))
		return ITEM_INTERACT_SUCCESS
	to_chat(user, span_warning("[src] is bare of any additional baubles."))
	return ITEM_INTERACT_BLOCKING

/obj/item/claymore/cutlass/luna/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/luna_fragment))
		var/obj/item/luna_fragment/applying_fragment = tool
		applying_fragment.apply_upgrade(src, user)
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/item/claymore/cutlass/luna/attack_secondary(atom/target, mob/living/user, clickparams)
	return SECONDARY_ATTACK_CONTINUE_CHAIN

/obj/item/claymore/cutlass/luna/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!can_bloodbeam)
		return
	if(interacting_with == user)
		balloon_alert(user, "can't aim at yourself!")
		return ITEM_INTERACT_BLOCKING
	send_sword_laser(interacting_with, user, modifiers)
	user.changeNext_move(CLICK_CD_MELEE)
	return ITEM_INTERACT_SUCCESS

/obj/item/claymore/cutlass/luna/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	return interact_with_atom_secondary(interacting_with, user, modifiers)

/// Shoots out a laser beam; damaging the user's stamina and blood. Called by right-clicking with the HPA upgrade.
/obj/item/claymore/cutlass/luna/proc/send_sword_laser(atom/target, mob/living/user, list/modifiers)
	var/turf/proj_turf = user.loc
	if(!isturf(proj_turf))
		return
	var/obj/projectile/beam/weak/penetrator/sord_beam = new(proj_turf)
	sord_beam.aim_projectile(target, user, modifiers)
	sord_beam.firer = user
	sord_beam.fired_from = src
	playsound(user, 'sound/items/weapons/resonator_blast.ogg', 90, TRUE)
	sord_beam.fire()
	user.apply_damage(25, STAMINA, BODY_ZONE_CHEST) // Spam these and pay the price of self-ownage
	user.blood_volume -= 10 // 560 is normal blood volume

/// Upgrades ///

/obj/item/luna_fragment
	name = "coder's bane"
	desc = "report this on github! unless you got this from a christmas present!"
	icon = 'local/icons/obj/jungle_items.dmi'
	/// What does this fragment do?
	var/effect_desc = "Does literally nothing."
	/// Has this fragment done it's introductory hallucination?
	var/has_spoken = FALSE
	/// What sound effect do we play for the introductory halluciantion?
	var/hallucination_sound = 'sound/effects/hallucinations/im_here1.ogg'
	/// What do we send to chat for the introductory hallucination?
	var/hallucination_text = "Why.. do those stupid smelly nerds... not put an EXE file.. on the github..."

/// Handles the logic for checking if an upgrade is valid; adding it, and playing its introductory hallucination if it's new.
/obj/item/luna_fragment/proc/apply_upgrade(our_sord, mob/living/user)
	var/obj/item/claymore/cutlass/luna/upgrade_appliable = our_sord
	for(var/obj/item/luna_fragment/found_fragment as anything in upgrade_appliable.fragments)
		if(istype(src, found_fragment))
			to_chat(user, span_warning("You can't seem to attach [src] to [upgrade_appliable]."))
			return FALSE
	if(!user.transferItemToLoc(src, upgrade_appliable))
		return
	upgrade_appliable.fragments += src
	balloon_alert(user, "upgrade applied")
	to_chat(user, span_notice("You attach [src] to [upgrade_appliable]."))
	if(!has_spoken)
		var/mob/taylor = user
		taylor.playsound_local(src.loc, hallucination_sound, 30, FALSE, 3)
		to_chat(user, span_blue(hallucination_text))
		has_spoken = TRUE
	return

/// Runs when this fragment is removed from LUNA via a crowbar - used to reset its affects.
/obj/item/luna_fragment/proc/remove_upgrade(our_sord, mob/living/user)
	return

/obj/item/luna_fragment/examine(mob/living/user)
	. = ..()
	. += span_notice("This device looks rather.. \"home cooked\". You'll likely need a specific sword in order to make use of it.")
	if(has_spoken)
		. += span_blue(hallucination_text) // If you're gonna take it back outta the sword, you should at least be able to revisit the text.

/// Blood Beam
/obj/item/luna_fragment/blood_beam
	name = "\improper H.P.A."
	desc = "A \"hemophilic projectile apparatus\". In practice, it trades some of the electrical activity in the user's brain and some of their blood to fire off an armor-piercing laser, to be attached \
	conveniently under cross-guard of a blade. Science CAN be metal!"
	icon_state = "hpa"
	effect_desc = "shoot a laser beam when right-clicking, in exchange for your stamina - and some blood."
	hallucination_text = "Calm. Safe - A clearing. Trees that stretched on up unto the sky itself; covered in constant falls of new snowflakes on my skin. I wasn't cold."

/obj/item/luna_fragment/blood_beam/apply_upgrade(our_sord, mob/living/user)
	var/obj/item/claymore/cutlass/luna/upgrade_appliable = our_sord
	upgrade_appliable.can_bloodbeam = TRUE // This sucks and I'd love to refactor it but I have to brush up a bit more before I'm ready for components;
	return ..()

/obj/item/luna_fragment/blood_beam/remove_upgrade(our_sord, mob/living/user)
	var/obj/item/claymore/cutlass/luna/upgrade_appliable = our_sord
	upgrade_appliable.can_bloodbeam = FALSE
	return ..()

/// Energy Retrofit
/// Sets LUNA's stats to be on par with a standard energy blade - for better and worse.
/obj/item/luna_fragment/energy_retrofit
	name = "\improper energy projection matrix"
	desc = "A small, egg-shaped device - kitbashed from a hardlight projector, a x-ray focused laser diode, and, of all things - a flashlight; to be applied directly against the grip of a sword - trading \
	the comfort of your thumb for a hardlight blade."
	icon_state = "energy_retrofit"
	effect_desc = "use a hardlight blade as a coating over it's own; trading its strengths and weaknesses for that of an energy sword. As Luna is a rapier, however, its reliance on precision strikes and \
	thin blade prevent it from properly parrying; and weaken its effectiveness against unarmored targets."
	hallucination_sound = 'sound/effects/hallucinations/im_here2.ogg'
	hallucination_text = "The lightest, most beautiful snowflakes I'd ever seen raining down upon me. I wasn't cold. I couldn't be. It couldn't overcome the warmth of my beating heart."

/obj/item/luna_fragment/energy_retrofit/apply_upgrade(our_sord, mob/living/user)
	var/obj/item/claymore/cutlass/luna/upgrade_appliable = our_sord
	upgrade_appliable.icon_state = "luna_energy"
	upgrade_appliable.inhand_icon_state = "luna_energy"
	update_inhand_icon(user)
	upgrade_appliable.set_light_on(TRUE)
	playsound(upgrade_appliable, 'sound/items/weapons/saberon.ogg', 35, TRUE)
	upgrade_appliable.force = /obj/item/melee/energy/sword::active_force
	upgrade_appliable.throwforce = /obj/item/melee/energy/sword::active_throwforce
	upgrade_appliable.exposed_wound_bonus = /obj/item/melee/energy/sword::exposed_wound_bonus
	upgrade_appliable.demolition_mod = /obj/item/melee/energy/sword::demolition_mod
	upgrade_appliable.armour_penetration = /obj/item/melee/energy/sword::armour_penetration
	return ..()

/obj/item/luna_fragment/energy_retrofit/remove_upgrade(our_sord, mob/living/user)
	var/obj/item/claymore/cutlass/luna/upgrade_appliable = our_sord
	upgrade_appliable.icon_state = "luna"
	upgrade_appliable.inhand_icon_state = "luna"
	update_inhand_icon(user)
	upgrade_appliable.set_light_on(FALSE)
	playsound(upgrade_appliable, 'sound/items/weapons/saberoff.ogg', 35, TRUE)
	upgrade_appliable.force = initial(upgrade_appliable.force)
	upgrade_appliable.throwforce = initial(upgrade_appliable.throwforce)
	upgrade_appliable.exposed_wound_bonus = initial(upgrade_appliable.exposed_wound_bonus)
	upgrade_appliable.demolition_mod = initial(upgrade_appliable.demolition_mod)
	upgrade_appliable.armour_penetration = initial(upgrade_appliable.armour_penetration)
	return ..()

/*
	Faustian Doll
*/

/// Come on, I gotta do SOME stupid reference or else it isn't funny. Plus I need to make it for later.
/obj/item/toy/faustian_doll
	name = "doll"
	desc = "Typically speaking, toys don't have faustian, teleporting-for-lifeforce bargains built into them. \
	This one, however, does - and it's not quite clear how much life it thirsts for."
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "assistant"

/obj/item/toy/faustian_doll/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/unique_examine, \
	desc = "Corporate's put out a brief dossier on 'remnants' of the old wartime occupation Taeloth fell under, this doll \
		being one of many the Power Recovery team ran into - and most likely, utilized. It has been determined, according to \
		them, to have an exact 50% mortality rate.", \
	desc_requirement = EXAMINE_CHECK_DEPARTMENT, \
	requirements = DEPARTMENT_SECURITY)

/obj/item/toy/faustian_doll/attack_self(mob/user as mob)
	var/turf/T = find_safe_turf(zlevels=SSmapping.levels_by_trait(ZTRAIT_STATION))

	playsound(src, 'sound/effects/screech.ogg', 70)
	if(T)
		var/atom/movable/AM = user.pulling
		if(AM)
			AM.forceMove(T)
		user.forceMove(T)
		if(AM)
			user.start_pulling(AM)
		to_chat(user, span_notice("You blink and find yourself in [get_area_name(T)]."))
	else
		to_chat(user, "Nothing happens. You feel that this is a bad sign.")
	if(istype(user, /mob/living))
		var/mob/living/guy_who_is_totally_screwed = user
		guy_who_is_totally_screwed.apply_damage(rand((guy_who_is_totally_screwed.health * 0.5),guy_who_is_totally_screwed.health))
	balloon_alert(user, "[src] crumbles!")
	qdel(src)
