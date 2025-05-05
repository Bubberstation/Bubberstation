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
	///Portal mode, gloryhole for crotch, wallstuck for lower body
	var/portal_mode = GLORYHOLE
	///The other end of the portal
	var/obj/structure/lewd_portal/linked_portal
	///The relayed body portion associated with this.
	var/obj/lewd_portal_relay/relayed_body
	///Gloryhole mode needs to make a characters penis invisible, this records the previous state
	var/initial_genital_visibility

/obj/structure/lewd_portal/Initialize(mapload)
	LAZYINITLIST(buckled_mobs)
	. = ..()

/obj/structure/wall_mount/Destroy()
	unbuckle_all_mobs(TRUE)
	. = ..()

/obj/structure/lewd_portal/user_buckle_mob(mob/living/M, mob/user, check_loc)
	if(!M.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("Looks like [M] doesn't want you to do that."))
		return FALSE
	if (!ishuman(M))
		balloon_alert(user, "[M.p_they()] does not fit!")
		return FALSE
	var/mob/living/carbon/human/penis_inspection = M
	if(!penis_inspection.has_penis(REQUIRE_GENITAL_EXPOSED) && portal_mode == GLORYHOLE)
		balloon_alert(user, "a penis is required to operate!")
		return FALSE
	if (!linked_portal)
		balloon_alert(user, "portal not linked!")
		return FALSE
	if (!isnull(linked_portal.current_mob))
		balloon_alert(user, "portal already occupied!")
		return FALSE
	visible_message("[user] begins slotting [M] into the [src]")
	if(!do_after(user, 5 SECONDS, M))
		return
	visible_message("[user] slots [M] into the [src]!")
	return ..(M, user, check_loc = FALSE)

/obj/structure/lewd_portal/post_buckle_mob(mob/living/buckled_mob)
	if (!ishuman(buckled_mob))
		return
	if(LAZYLEN(buckled_mobs))
		if(ishuman(buckled_mobs[1]))
			current_mob = buckled_mobs[1]

	if(istype(current_mob.dna.species))
		relayed_body = new /obj/lewd_portal_relay(linked_portal.loc, current_mob, linked_portal)
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
		if(portal_mode == GLORYHOLE)
			relayed_body.pixel_x = relayed_body.pixel_x * 1.125
			relayed_body.pixel_y = relayed_body.pixel_y * 1.125
			var/obj/item/organ/genital/penis/penis_reference = current_mob.get_organ_slot(ORGAN_SLOT_PENIS)
			initial_genital_visibility = penis_reference?.visibility_preference
			hide_penis()
			RegisterSignals(current_mob, list(COMSIG_MOB_POST_EQUIP, COMSIG_HUMAN_UNEQUIPPED_ITEM, COMSIG_HUMAN_TOGGLE_UNDERWEAR, COMSIG_MOB_HANDCUFFED), PROC_REF(hide_penis))
			current_mob.dir = dir
			switch(dir)
				if(NORTH)
					current_mob.pixel_y += 24
				if(SOUTH)
					current_mob.pixel_y += -6
				if(EAST)
					current_mob.pixel_x += 12
				if(WEST)
					current_mob.pixel_x += -12
		else
			current_mob.dir = SOUTH
			head_only()
			RegisterSignals(current_mob, list(COMSIG_MOB_POST_EQUIP, COMSIG_HUMAN_UNEQUIPPED_ITEM, COMSIG_HUMAN_TOGGLE_UNDERWEAR, COMSIG_MOB_HANDCUFFED), PROC_REF(head_only))
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

///hides the buckled mob's penis
/obj/structure/lewd_portal/proc/hide_penis()
	SIGNAL_HANDLER
	var/obj/item/organ/genital/penis/affected_penis = current_mob.get_organ_slot(ORGAN_SLOT_PENIS) //Stolen from Strapon code, this is bad we should probably have a cleaner way
	affected_penis?.visibility_preference = GENITAL_NEVER_SHOW
	current_mob.update_body()

///Removes everything besides the head for the buckled mob, used in wallstuck mode
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
	UnregisterSignal(current_mob, list(COMSIG_MOB_POST_EQUIP, COMSIG_HUMAN_UNEQUIPPED_ITEM, COMSIG_HUMAN_TOGGLE_UNDERWEAR, COMSIG_MOB_HANDCUFFED))
	visible_message("[current_mob] exits the [src]")
	current_mob = null
	qdel(relayed_body)
	unbuckled_mob.regenerate_icons()
	var/offset_ammount = 24
	if(portal_mode == WALLSTUCK)
		offset_ammount = 12
	switch(dir)
		if(NORTH)
			unbuckled_mob.pixel_y -= offset_ammount
		if(SOUTH)
			if(portal_mode == GLORYHOLE)
				unbuckled_mob.pixel_y += 12
			else
				unbuckle_mob.pixel_y += 6
		if(EAST)
			unbuckled_mob.pixel_x -= 12
		if(WEST)
			unbuckled_mob.pixel_x += 12
	unbuckled_mob.transform = initial(unbuckled_mob.transform)
	if(portal_mode == GLORYHOLE)
		var/obj/item/organ/genital/penis/affected_penis = unbuckled_mob.get_organ_slot(ORGAN_SLOT_PENIS) //Stolen from Strapon code, this is bad we should probably have a cleaner way
		affected_penis?.visibility_preference = initial_genital_visibility
		unbuckled_mob.update_body()
	. = ..()

/obj/item/wallframe/lewd_portal
	name = "Lustwish Portal Bore"
	desc = "A device utilizing bluespace technology to transpose portions of people from one space to another."
	result_path = /obj/structure/lewd_portal
	pixel_shift = 32
	multi_use = TRUE
	///The mode portals created by this device will be in
	var/creation_mode = GLORYHOLE
	///The previous portal placed by the bore, recorded so that they can be linked.
	var/obj/structure/lewd_portal/previous_portal

/obj/item/wallframe/lewd_portal/examine(mob/user)
	. = ..()
	var/inspect_mode = "gloryhole"
	if(creation_mode == WALLSTUCK)
		inspect_mode = "stuck in wall"
	. += span_notice("Its currently in [inspect_mode] mode.")

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

/obj/item/wallframe/lewd_portal/attack_self(mob/user)
	if(previous_portal)
		balloon_alert(user, "portals must match")
		return
	if(creation_mode == GLORYHOLE)
		creation_mode = WALLSTUCK
		balloon_alert(user, "switched to stuck in wall mode")
	else
		creation_mode = GLORYHOLE
		balloon_alert(user, "switched to gloryhole mode")

/obj/lewd_portal_relay
	name = "portal relay"
	desc = "Someone's behind hanging out from a portal."
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	///Mob that this relay is connected to
	var/mob/living/carbon/human/owner
	///Portal that spawns this relay
	var/obj/structure/lewd_portal/owning_portal
	///What mode this portal is in
	var/portal_mode = GLORYHOLE

/obj/lewd_portal_relay/Initialize(mapload, mob/living/carbon/human/owner_ref, obj/structure/lewd_portal/owning_portal_reference)
	. = ..()
	if(!owner_ref || !owning_portal_reference)
		return INITIALIZE_HINT_QDEL
	owning_portal = owning_portal_reference
	portal_mode = owning_portal.portal_mode
	if(portal_mode == GLORYHOLE)
		if (owning_portal.dir == EAST || owning_portal.dir == WEST)
			dir = owning_portal.dir
		else
			dir = SOUTH
	else
		dir = NORTH
	owner = owner_ref
	var/species_name
	if(owner.dna?.species?.lore_protected || owner.dna?.features["custom_species"] == "")
		species_name = owner.dna.species.name
	else
		species_name = owner.dna.features["custom_species"]
	name = LOWER_TEXT("[species_name] behind")

	RegisterSignals(owner, list(COMSIG_MOB_POST_EQUIP, COMSIG_HUMAN_UNEQUIPPED_ITEM, COMSIG_HUMAN_TOGGLE_UNDERWEAR, COMSIG_MOB_HANDCUFFED), PROC_REF(update_visuals))
	become_hearing_sensitive(ROUNDSTART_TRAIT)
	var/datum/component/interactable/interact_component = owner.GetComponent(/datum/component/interactable)
	interact_component?.body_relay = src

/obj/lewd_portal_relay/Destroy(force)
	UnregisterSignal(owner, list(COMSIG_MOB_POST_EQUIP, COMSIG_HUMAN_UNEQUIPPED_ITEM, COMSIG_HUMAN_TOGGLE_UNDERWEAR, COMSIG_MOB_HANDCUFFED))
	visible_message("[src] vanishes into the portal!")
	lose_hearing_sensitivity(ROUNDSTART_TRAIT)
	var/datum/component/interactable/interact_component = owner.GetComponent(/datum/component/interactable)
	interact_component?.body_relay = null
	return ..()

/obj/lewd_portal_relay/examine(mob/user)
	. = ..()
	for(var/genital in GLOB.possible_genitals)
		if(genital == ORGAN_SLOT_BREASTS)
			continue
		if(owner.dna.species.mutant_bodyparts[genital])
			var/datum/sprite_accessory/genital/G = SSaccessories.sprite_accessories[genital][owner.dna.species.mutant_bodyparts[genital][MUTANT_INDEX_NAME]]
			if(G)
				if(!(G.is_hidden(owner)))
					. += "<span class='notice'>It has exposed genitals... <a href='byond://?src=[REF(src)];lookup_info=genitals'>\[Look closer...\]</a></span>"
					break

/obj/lewd_portal_relay/Topic(href, href_list)
	. = ..()
	if(href_list["lookup_info"])
		if(href_list["lookup_info"] == "genitals")
			var/list/line = list()
			for(var/genital in GLOB.possible_genitals)
				if(!owner.dna.species.mutant_bodyparts[genital] || genital == ORGAN_SLOT_BREASTS)
					continue
				var/datum/sprite_accessory/genital/G = SSaccessories.sprite_accessories[genital][owner.dna.species.mutant_bodyparts[genital][MUTANT_INDEX_NAME]]
				if(!G)
					continue
				if(G.is_hidden(owner))
					continue
				var/obj/item/organ/genital/ORG = owner.get_organ_slot(G.associated_organ_slot)
				if(!ORG)
					continue
				line += ORG.get_description_string(G)
			if(length(line))
				to_chat(usr, span_notice("[jointext(line, "\n")]"))

/obj/lewd_portal_relay/proc/update_visuals()
	SIGNAL_HANDLER
	if(portal_mode == GLORYHOLE)
		penis_only()
	else
		lower_body_only()

/obj/lewd_portal_relay/proc/penis_only()
	cut_overlays()
	var/obj/item/organ/genital/penis/penis_reference = owner.get_organ_slot(ORGAN_SLOT_PENIS)
	var/mutable_appearance/penis_image = penis_reference.bodypart_overlay.get_overlay(EXTERNAL_FRONT)
	add_overlay(penis_image)

/obj/lewd_portal_relay/proc/lower_body_only()
	owner.dna.species.handle_body(owner) //Suboptimal way for doing this but I couldn't figure out another way to maintain underwear when dropping items
	cut_overlays()
	for(var/limb in list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, BODY_ZONE_CHEST))
		var/obj/item/bodypart/limb_object = owner.get_bodypart(limb)
		if(istype(limb_object))
			var/limb_icon_list = limb_object.get_limb_icon()
			if(limb_object == owner.get_bodypart(BODY_ZONE_CHEST))
				for(var/image/limb_icon in limb_icon_list)
					var/limb_icon_layer = limb_icon.layer * -1
					if(limb_icon_layer != BODY_BEHIND_LAYER && limb_icon_layer != BODY_FRONT_LAYER || limb_icon.icon == 'modular_skyrat/master_files/icons/mob/sprite_accessory/genitals/breasts_onmob.dmi') //Tails need to be portaled
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

/obj/lewd_portal_relay/attack_hand_secondary(mob/living/user)
	if(!user.can_perform_action(src, NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING))
		return ..()
	if(portal_mode == GLORYHOLE)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(dir == NORTH)
		dir = SOUTH
	else
		dir = NORTH
	to_chat(user, span_info("You flip \the [name] over."))
	to_chat(owner, span_info("You feel your behind flip over."))
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/lewd_portal_relay/click_ctrl_shift(mob/user)
	owner.click_ctrl_shift(user)

#undef GLORYHOLE
#undef WALLSTUCK
