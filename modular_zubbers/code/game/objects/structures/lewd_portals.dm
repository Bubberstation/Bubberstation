#define GLORYHOLE "gloryhole"
#define WALLSTUCK "wallstuck"

/obj/structure/lewd_portal
	name = "LustWish Portal"
	desc = "A portal that people can partially fit through."
	can_buckle = TRUE
	anchored = TRUE
	max_buckled_mobs = 1
	buckle_lying = 0
	buckle_prevents_pull = TRUE

	///Human currently occupying
	var/mob/living/carbon/human/current_mob = null

	var/portal_mode = GLORYHOLE

	var/obj/structure/lewd_portal/linked_portal

	var/obj/lewd_portal_relay/relayed_body

/obj/structure/lewd_portal/Initialize(mapload)
	LAZYINITLIST(buckled_mobs)
	. = ..()

/obj/structure/wall_mount/Destroy()
	. = ..()
	unbuckle_all_mobs(TRUE)

/obj/structure/lewd_portal/user_buckle_mob(mob/living/M, mob/user, check_loc)
	if (!ishuman(M))
		balloon_alert(user, "[M.p_they()] does not fit!")
		return FALSE
	if (!linked_portal)
		balloon_alert(user, "portal not linked!")
		return FALSE
	if (!isnull(linked_portal.current_mob))
		balloon_alert(user, "portal already occupied!")

	return ..(M, user, check_loc = FALSE)

/obj/structure/lewd_portal/post_buckle_mob(mob/living/buckled_mob)
	if (!ishuman(buckled_mob))
		return
	if(LAZYLEN(buckled_mobs))
		if(ishuman(buckled_mobs[1]))
			current_mob = buckled_mobs[1]

	if(istype(current_mob.dna.species))
		relayed_body = new /obj/lewd_portal_relay(linked_portal.loc, current_mob)
		relayed_body.update_visuals()
		current_mob.add_filter("leg_removal", 1, list("type" = "alpha", "icon" = icon('modular_zubbers/icons/obj/structures/lewd_portals.dmi', "mask reversed")))
	else
		unbuckle_all_mobs()
	..()

/obj/structure/lewd_portal/post_unbuckle_mob(mob/living/unbuckled_mob)
	current_mob = null
	unbuckled_mob.remove_filter("leg_removal")
	qdel(relayed_body)
	unbuckled_mob.regenerate_icons()
	. = ..()

/obj/item/wallframe/lewd_portal
	name = "Lustwish Portal Bore"
	desc = "A device utilizing bluespace technology to transpose portions of people from one space to another."
	result_path = /obj/structure/lewd_portal
	pixel_shift = 32
	multi_use = TRUE
	var/creation_mode = GLORYHOLE
	var/obj/structure/lewd_portal/previous_portal

/obj/item/wallframe/lewd_portal/try_build(turf/on_wall, mob/user)
	if(get_dir(user, on_wall) != NORTH)
		balloon_alert(user, "Cannot face direction!")
		return
	. = ..()

/obj/item/wallframe/lewd_portal/after_attach(obj/attached_to)
	var/obj/structure/lewd_portal/portal_result = attached_to
	portal_result.portal_mode = creation_mode
	if(!previous_portal)
		previous_portal = portal_result
	else
		portal_result.linked_portal = previous_portal
		previous_portal.linked_portal = portal_result
		previous_portal = null
	. = ..()


/obj/lewd_portal_relay
	name = "portal relay"
	var/mob/living/carbon/human/owner
	var/mob/living/carbon/human/dummy

/obj/lewd_portal_relay/Initialize(mapload, mob/living/carbon/human/owner_ref)
	. = ..()
	if(!owner_ref)
		return INITIALIZE_HINT_QDEL
	owner = owner_ref
	RegisterSignals(owner, list(COMSIG_CARBON_APPLY_OVERLAY, COMSIG_CARBON_REMOVE_OVERLAY), PROC_REF(update_visuals))
	become_hearing_sensitive(ROUNDSTART_TRAIT)

/obj/lewd_portal_relay/Destroy(force)
	UnregisterSignal(owner, list(COMSIG_CARBON_APPLY_OVERLAY, COMSIG_CARBON_REMOVE_OVERLAY))
	lose_hearing_sensitivity(ROUNDSTART_TRAIT)
	return ..()

/obj/lewd_portal_relay/proc/update_visuals()
	SIGNAL_HANDLER
//	copy_overlays(owner, TRUE)
	cut_overlay()
	for(var/limb in list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, BODY_ZONE_CHEST))
		var/obj/item/bodypart/limb_object = owner.get_bodypart(limb)
		if(!istype(limb_object))
			return
		add_overlay(limb_object.get_limb_icon())
	if(owner.shoes)
		add_overlay(owner.overlays_standing[SHOES_LAYER])
	add_filter("chest_removal", 1, list("type" = "alpha", "icon" = icon('modular_zubbers/icons/obj/structures/lewd_portals.dmi', "mask")))
	/*
	dummy = new/mob/living/carbon/human(src)
	dummy.pixel_x = pixel_x
	dummy.pixel_y = pixel_y
	owner.dna.transfer_identity(dummy, TRUE, TRUE)
	dummy.updateappearance(mutcolor_update = TRUE, mutations_overlay_update = TRUE)
	dummy.cut_overlays()
	for(var/limb in list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, BODY_ZONE_CHEST))
		var/obj/item/bodypart/limb_object = dummy.get_bodypart(limb)
		if(!istype(limb_object))
			return
		dummy.add_overlay(limb_object.get_limb_icon())
	dummy.update_worn_undersuit()
	dummy.update_worn_shoes()
	dummy.remove_overlay(BODY_ADJ_LAYER)
	dummy.add_filter("chest_removal", 1, list("type" = "alpha", "icon" = icon('modular_zubbers/icons/obj/structures/lewd_portals.dmi', "mask")))
	appearance = dummy
	qdel(dummy)*/

/obj/lewd_portal_relay/attackby(obj/item/attacking_item, mob/user, params)
	owner.attackby(attacking_item, user, params)

/obj/lewd_portal_relay/attack_hand(mob/living/user, list/modifiers)
	owner.attack_hand(user, modifiers)

/obj/lewd_portal_relay/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods, message_range)
	. = ..()
	//if(owner)
		//owner.Hear(message, speaker, message_language, raw_message, radio_freq, spans, message_mods, message_range)

#undef GLORYHOLE
#undef WALLSTUCK
