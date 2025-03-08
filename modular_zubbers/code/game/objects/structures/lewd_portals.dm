#define GLORYHOLE "gloryhole"
#define WALLSTUCK "wallstuck"

/obj/structure/lewd_portal
	name = "LustWish Portal"
	desc = "A portal that people can partially fit through."
	icon = 'modular_zubbers/icons/obj/structures/lewd_portals.dmi'
	icon_state = "portal"
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
		return FALSE

	return ..(M, user, check_loc = FALSE)

/obj/structure/lewd_portal/post_buckle_mob(mob/living/buckled_mob)
	if (!ishuman(buckled_mob))
		return
	if(LAZYLEN(buckled_mobs))
		if(ishuman(buckled_mobs[1]))
			current_mob = buckled_mobs[1]

	if(istype(current_mob.dna.species))
		current_mob.dir = SOUTH
		relayed_body = new /obj/lewd_portal_relay(linked_portal.loc, current_mob)
		switch(linked_portal.dir)
			if(NORTH)
				relayed_body.pixel_y = 24
			if(SOUTH)
				relayed_body.pixel_y = -24
				relayed_body.transform = turn(transform, ROTATION_FLIP)
			if(EAST)
				relayed_body.pixel_x = 24
				relayed_body.transform = turn(transform, ROTATION_COUNTERCLOCKWISE)
			if(WEST)
				relayed_body.pixel_x = -24
				relayed_body.transform = turn(transform, ROTATION_CLOCKWISE)
		relayed_body.update_visuals()
		head_only()
		RegisterSignals(current_mob, list(COMSIG_MOB_POST_EQUIP, COMSIG_HUMAN_UNEQUIPPED_ITEM, COMSIG_HUMAN_TOGGLE_UNDERWEAR), PROC_REF(head_only))
		switch(dir)
			if(NORTH)
				current_mob.pixel_y += 12
			if(SOUTH)
				current_mob.pixel_y += -12
				current_mob.transform = turn(transform, ROTATION_FLIP)
			if(EAST)
				current_mob.pixel_x += 12
				current_mob.transform = turn(transform, ROTATION_COUNTERCLOCKWISE)
			if(WEST)
				current_mob.pixel_x += -12
				current_mob.transform = turn(transform, ROTATION_CLOCKWISE)
	else
		unbuckle_all_mobs()
	..()

/obj/structure/lewd_portal/proc/head_only()
	SIGNAL_HANDLER
	current_mob.cut_overlays()
	current_mob.update_body_parts_head_only()
	current_mob.remove_overlay(BODY_ADJ_LAYER)
	current_mob.remove_overlay(BODY_LAYER)
	current_mob.remove_overlay(HANDS_LAYER)
	var/obj/item/bodypart/head/mob_head = current_mob.get_bodypart(BODY_ZONE_HEAD)
	if(mob_head.head_flags & HEAD_EYESPRITES)
		var/obj/item/organ/eyes/eye_organ = current_mob.get_organ_slot(ORGAN_SLOT_EYES)
		if(eye_organ)
			eye_organ.refresh(call_update = FALSE)
			current_mob.overlays_standing[BODY_LAYER] += eye_organ.generate_body_overlay(current_mob)
			current_mob.apply_overlay(BODY_LAYER)

/obj/structure/lewd_portal/post_unbuckle_mob(mob/living/unbuckled_mob)
	UnregisterSignal(current_mob, list(COMSIG_MOB_POST_EQUIP, COMSIG_HUMAN_UNEQUIPPED_ITEM, COMSIG_HUMAN_TOGGLE_UNDERWEAR))
	current_mob = null
	qdel(relayed_body)
	unbuckled_mob.regenerate_icons()
	switch(dir)
		if(NORTH)
			unbuckled_mob.pixel_y += -12
		if(SOUTH)
			unbuckled_mob.pixel_y += 12
		if(EAST)
			unbuckled_mob.pixel_x += -12
		if(WEST)
			unbuckled_mob.pixel_x += 12
	unbuckled_mob.transform = initial(unbuckled_mob.transform)
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
	//if(get_dir(user, on_wall) != NORTH)
		//balloon_alert(user, "Cannot face direction!")
		//return
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

/obj/lewd_portal_relay/Initialize(mapload, mob/living/carbon/human/owner_ref)
	. = ..()
	if(!owner_ref)
		return INITIALIZE_HINT_QDEL
	dir = NORTH
	owner = owner_ref
	RegisterSignals(owner, list(COMSIG_MOB_POST_EQUIP, COMSIG_HUMAN_UNEQUIPPED_ITEM, COMSIG_HUMAN_TOGGLE_UNDERWEAR), PROC_REF(update_visuals))
	become_hearing_sensitive(ROUNDSTART_TRAIT)

/obj/lewd_portal_relay/Destroy(force)
	UnregisterSignal(owner, list(COMSIG_MOB_POST_EQUIP, COMSIG_HUMAN_UNEQUIPPED_ITEM, COMSIG_HUMAN_TOGGLE_UNDERWEAR))
	lose_hearing_sensitivity(ROUNDSTART_TRAIT)
	return ..()

/obj/lewd_portal_relay/proc/update_visuals()
	SIGNAL_HANDLER
	cut_overlays()
	for(var/limb in list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, BODY_ZONE_CHEST))
		var/obj/item/bodypart/limb_object = owner.get_bodypart(limb)
		if(istype(limb_object))
			var/limb_icon_list = limb_object.get_limb_icon()
			if(limb_object == owner.get_bodypart(BODY_ZONE_CHEST))
				for(var/image/limb_icon in limb_icon_list)
					var/limb_icon_layer = limb_icon.layer * -1
					if(limb_icon_layer != BODY_BEHIND_LAYER && limb_icon_layer != BODY_FRONT_LAYER) //Tails need to be portaled
						limb_icon.add_filter("upper_body_removal", 1, list("type" = "alpha", "icon" = icon('modular_zubbers/icons/obj/structures/lewd_portals.dmi', "mask")))
			add_overlay(limb_icon_list)
	if(owner.shoes)
		add_overlay(owner.overlays_standing[SHOES_LAYER])
	if(owner.w_uniform)
		var/image/uniform_overlay = image(owner.overlays_standing[UNIFORM_LAYER])
		uniform_overlay.add_filter("upper_body_removal", 1, list("type" = "alpha", "icon" = icon('modular_zubbers/icons/obj/structures/lewd_portals.dmi', "mask")))
		add_overlay(uniform_overlay)
	var/body_layer_overlays = list()
	for(var/image/body_layer_overlay in owner.overlays_standing[BODY_LAYER])
		var/image/new_body_layer_overlay = image(body_layer_overlay)
		new_body_layer_overlay.add_filter("upper_body_removal", 1, list("type" = "alpha", "icon" = icon('modular_zubbers/icons/obj/structures/lewd_portals.dmi', "mask")))
		body_layer_overlays += new_body_layer_overlay
	add_overlay(body_layer_overlays)

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
