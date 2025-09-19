#define LAYDOWN_COOLDOWN 1 SECONDS

/obj/item/organ/taur_body
	name = "taur body"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_TAUR
	external_bodyshapes = BODYSHAPE_TAUR
	use_mob_sprite_as_obj_sprite = TRUE

	preference = "feature_taur"
	mutantpart_key = "taur"
	mutantpart_info = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	bodypart_overlay = /datum/bodypart_overlay/mutant/taur_body

	/// The icon state used to crop clothing not made for us. See 'modular_skyrat\master_files\icons\mob\clothing\taur_masking_helpers.dmi' for more
	var/clothing_cropping_state = DEFAULT_TAUR_CLIPPING_MASK

	/// If not null, the left leg limb we add to our mob will have this name.
	var/left_leg_name = "front legs"
	/// If not null, the right leg limb we add to our mob will have this name.
	var/right_leg_name = "back legs"

	/// The mob's old right leg. Used if the person switches to this organ and then back, so they don't just, have no legs anymore. Can be null.
	var/old_right_leg = null
	/// The mob's old left leg. Used if the person switches to this organ and then back, so they don't just, have no legs anymore. Can be null.
	var/old_left_leg = null

	/// If true, our sprite accessory will not render.
	var/hide_self

	/// If true, this taur body allows a saddle to be equipped and used.
	var/can_use_saddle = FALSE

	/// If true, can ride saddled taurs and be ridden by other taurs with this set to TRUE.
	var/can_ride_saddled_taurs = FALSE

	/// When being ridden via saddle, how much the rider is offset on the x axis when facing west or east.
	var/riding_offset_side_x = 12
	/// When being ridden via saddle, how much the rider is offset on the y axis when facing west or east.
	var/riding_offset_side_y = 2

	/// When being ridden via saddle, how much the rider is offset on the x axis when facing north or south.
	var/riding_offset_front_x = 0
	/// When being ridden via saddle, how much the rider is offset on the y axis when facing north or south.
	var/riding_offset_front_y = 5

	/// Lazylist of (TEXT_DIR -> y offset) to be applied to taur-specific clothing that isn't specifically made for this sprite.
	var/list/taur_specific_clothing_y_offsets

	/// When considering how much to offset our rider, we multiply size scaling against this.
	var/riding_offset_scaling_mult = 0.8

/obj/item/organ/taur_body/horselike
	can_use_saddle = TRUE

/obj/item/organ/taur_body/horselike/synth
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/taur_body/horselike/deer

/obj/item/organ/taur_body/horselike/deer/Initialize(mapload)
	. = ..()

	taur_specific_clothing_y_offsets = list(
		TEXT_EAST = 3,
		TEXT_WEST = 3,
		TEXT_NORTH = 0,
		TEXT_SOUTH = 0,
	)

/obj/item/organ/taur_body/serpentine
	left_leg_name = "upper serpentine body"
	right_leg_name = "lower serpentine body"

/obj/item/organ/taur_body/spider
	left_leg_name = "left legs"
	right_leg_name = "right legs"

/obj/item/organ/taur_body/tentacle
	left_leg_name = "front tentacles"
	right_leg_name = "back tentacles"

/obj/item/organ/taur_body/blob
	left_leg_name = "outer blob"
	right_leg_name = "inner blob"

/obj/item/organ/taur_body/anthro
	left_leg_name = null
	right_leg_name = null

	can_ride_saddled_taurs = TRUE

/obj/item/organ/taur_body/anthro/synth
	organ_flags = ORGAN_ROBOTIC

/datum/bodypart_overlay/mutant/taur_body
	feature_key = "taur"
	layers = ALL_EXTERNAL_OVERLAYS | EXTERNAL_FRONT_UNDER_CLOTHES | EXTERNAL_FRONT_OVER
	color_source = ORGAN_COLOR_OVERRIDE

	/// If this taur body can lay down
	var/can_lay_down = FALSE
	/// Are we currently laying down?
	var/laying_down = FALSE
	/// The offset we get from laying down. Negative values move us down
	var/laydown_offset = 0

/datum/bodypart_overlay/mutant/taur_body/on_mob_insert(obj/item/organ/parent, mob/living/carbon/receiver)
	. = ..()
	var/datum/sprite_accessory/taur/accessory = sprite_datum
	if(accessory.can_lay_down)
		can_lay_down = TRUE
		laydown_offset = accessory.laydown_offset

/datum/bodypart_overlay/mutant/taur_body/get_base_icon_state()
	return "[sprite_datum.icon_state][laying_down ? "_laying" : ""]"

/datum/bodypart_overlay/mutant/taur_body/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/taur_body/get_global_feature_list()
	return SSaccessories.sprite_accessories["taur"]


/obj/item/organ/taur_body/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	if(sprite_accessory_flags & SPRITE_ACCESSORY_HIDE_SHOES)
		external_bodyshapes |= BODYSHAPE_HIDE_SHOES

	var/obj/item/bodypart/leg/right/current_right_leg = receiver.get_bodypart(BODY_ZONE_R_LEG)
	var/obj/item/bodypart/leg/left/current_left_leg = receiver.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/leg/left/taur/new_left_leg
	var/obj/item/bodypart/leg/right/taur/new_right_leg

	var/datum/preferences/prefs = receiver.client?.prefs
	var/use_synthetic_taur = FALSE
	if (prefs)
		use_synthetic_taur = prefs.read_preference(/datum/preference/toggle/synthetic_taur)

	if(organ_flags & ORGAN_ORGANIC)
		new_left_leg = new /obj/item/bodypart/leg/left/taur()
		new_right_leg = new /obj/item/bodypart/leg/right/taur()

	if((organ_flags & ORGAN_ROBOTIC) || use_synthetic_taur)
		new_left_leg = new /obj/item/bodypart/leg/left/synth/taur()
		new_right_leg = new /obj/item/bodypart/leg/right/synth/taur()

	if (left_leg_name)
		new_left_leg.name = left_leg_name + " (Left leg)"
		new_left_leg.plaintext_zone = LOWER_TEXT(new_left_leg.name) // weird otherwise
	if (right_leg_name)
		new_right_leg.name = right_leg_name + " (Right leg)"
		new_right_leg.plaintext_zone = LOWER_TEXT(new_right_leg.name)

	new_left_leg.bodyshape |= external_bodyshapes
	new_left_leg.replace_limb(receiver, TRUE)
	if(current_left_leg)
		old_left_leg = current_left_leg.type
		qdel(current_left_leg)
	new_left_leg.bodytype |= BODYTYPE_TAUR

	new_right_leg.bodyshape |= external_bodyshapes
	new_right_leg.replace_limb(receiver, TRUE)
	if(current_right_leg)
		old_right_leg = current_right_leg.type
		qdel(current_right_leg)
	new_right_leg.bodytype |= BODYTYPE_TAUR

	. = ..()

	var/datum/bodypart_overlay/mutant/taur_body/overlay = bodypart_overlay
	if(overlay.can_lay_down)
		add_verb(receiver, /obj/item/organ/taur_body/proc/toggle_laying)
	add_verb(receiver, /obj/item/organ/taur_body/proc/toggle_cropping)

/obj/item/organ/taur_body/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	var/obj/item/bodypart/leg/left/left_leg = organ_owner.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/leg/right/right_leg = organ_owner.get_bodypart(BODY_ZONE_R_LEG)

	if(left_leg)
		left_leg.drop_limb()
		qdel(left_leg)

	if(right_leg)
		right_leg.drop_limb()
		qdel(right_leg)

	if(old_left_leg)
		var/obj/item/bodypart/leg/left/new_left_leg = new old_left_leg()
		new_left_leg.replace_limb(organ_owner, TRUE)

	if(old_right_leg)
		var/obj/item/bodypart/leg/right/new_right_leg = new old_right_leg()
		new_right_leg.replace_limb(organ_owner, TRUE)

	// We don't call `synchronize_bodytypes()` here, because it's already going to get called in the parent because `external_bodyshapes` has a value.
	remove_verb(organ_owner, /obj/item/organ/taur_body/proc/toggle_laying)
	remove_verb(organ_owner, /obj/item/organ/taur_body/proc/toggle_cropping)
	return ..()

/obj/item/organ/taur_body/proc/get_riding_offset(oversized = FALSE)
	var/size_scaling = (owner.dna.features["body_size"] / BODY_SIZE_NORMAL) - 1
	var/scaling_mult = 1 + (size_scaling * riding_offset_scaling_mult)

	return list(
		TEXT_NORTH = list(riding_offset_front_x, round((riding_offset_front_y + taur_specific_clothing_y_offsets?[TEXT_NORTH]) * scaling_mult, 1)),
		TEXT_SOUTH = list(riding_offset_front_x, round((riding_offset_front_y + taur_specific_clothing_y_offsets?[TEXT_SOUTH]) * scaling_mult, 1)),
		TEXT_EAST = list(round(-riding_offset_side_x * scaling_mult, 1), round((riding_offset_side_y + taur_specific_clothing_y_offsets?[TEXT_EAST]) * scaling_mult, 1)),
		TEXT_WEST = list(round(riding_offset_side_x * scaling_mult, 1), round((riding_offset_side_y + taur_specific_clothing_y_offsets?[TEXT_WEST]) * scaling_mult, 1)),
	)

/obj/item/organ/taur_body/proc/toggle_laying()
	set category = "Taur"
	set name = "Toggle Laying Down"

	var/mob/living/carbon/human/owner = src
	if(!istype(owner))
		return

	var/obj/item/organ/taur_body/organ = owner.get_organ_by_type(/obj/item/organ/taur_body)
	if(isnull(organ))
		stack_trace("Taur lay down triggered without Taur organ")
		return

	var/datum/bodypart_overlay/mutant/taur_body/overlay = organ.bodypart_overlay
	if(!overlay.can_lay_down)
		return
	if(owner.resting)
		to_chat(owner, span_notice("You have to be standing up in order to lay down properly!"))
	if(overlay.laying_down)
		// Rising up
		to_chat(owner, span_notice("You start lifting your body up."))
		if(!do_after(owner, LAYDOWN_COOLDOWN))
			return
		if(!overlay.laying_down) // Prevent multiple standups at once
			return
		overlay.laying_down = FALSE
		owner.layer = initial(owner.layer)
		owner.pixel_y -= overlay.laydown_offset
		owner.update_body_parts()

		owner.SetImmobilized(0, TRUE)
		REMOVE_TRAIT(owner, TRAIT_UNDENSE, TRAIT_SOURCE_TAURLAY)
		to_chat(owner, span_notice("You stand up."))
	else
		// And laying back down
		overlay.laying_down = TRUE
		owner.layer = LYING_MOB_LAYER
		owner.pixel_y += overlay.laydown_offset
		owner.update_body_parts()

		owner.Immobilize(INFINITY, TRUE)
		ADD_TRAIT(owner, TRAIT_UNDENSE, TRAIT_SOURCE_TAURLAY)
		to_chat(owner, span_notice("You lay down."))
		if(owner.has_gravity())
			playsound(owner, "bodyfall", 50, TRUE)

#undef LAYDOWN_COOLDOWN

/obj/item/organ/taur_body/proc/toggle_cropping()
	set category = "Taur"
	set name = "Override Taur Cropping Settings"

	var/mob/living/carbon/human/owner = src
	if(!istype(owner))
		return

	var/obj/item/organ/taur_body/organ = owner.get_organ_by_type(/obj/item/organ/taur_body)
	if(isnull(organ))
		stack_trace("Taur cropping override down triggered without Taur organ")
		return

	if (!isnull(owner))
		if (HAS_TRAIT(owner, TRAIT_TAUR_IGNORING_CROPPING))
			REMOVE_TRAIT(owner, TRAIT_TAUR_IGNORING_CROPPING, TRAIT_SOURCE_TAURCROP)
		else
			ADD_TRAIT(owner, TRAIT_TAUR_IGNORING_CROPPING, TRAIT_SOURCE_TAURCROP)

		var/setting_string = (HAS_TRAIT(owner, TRAIT_TAUR_IGNORING_CROPPING) ? "now ignoring cropping" : "no longer ignoring cropping")
		balloon_alert(owner, setting_string)

		owner.update_clothing(ITEM_SLOT_OCLOTHING|ITEM_SLOT_ICLOTHING) // the only items with taur cropping
