#define GAS_PUNCH_LOW 3 // Humanoid pair of hands is extremely weak and deals reduced damage.
#define GAS_PUNCH_HIGH 5
//GAS

/obj/item/bodypart/head/mutant/serpentid
	icon_greyscale = BODYPART_ICON_GAS
	bodytype = BODYTYPE_ORGANIC
	limb_id = SPECIES_GAS
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	head_flags = HEAD_EYESPRITES|HEAD_EYECOLOR|HEAD_EYEHOLES|HEAD_DEBRAIN

/obj/item/bodypart/head/mutant/serpentid/Initialize(mapload)
	worn_ears_offset = new(
		attached_part = src,
		feature_key = OFFSET_EARS,
		offset_y = list("north" = 9, "south" = 9, "east" = 9, "west" = 9),
	)
	worn_head_offset = new(
		attached_part = src,
		feature_key = OFFSET_HEAD,
		offset_y = list("north" = 8, "south" = 8, "east" = 8, "west" = 8),
	)
	worn_mask_offset = new(
		attached_part = src,
		feature_key = OFFSET_FACEMASK,
		offset_y = list("north" = 7, "south" = 7, "east" = 7, "west" = 7),
	)
	return ..()


/obj/item/bodypart/chest/mutant/serpentid
	icon_greyscale = BODYPART_ICON_GAS
	bodytype = BODYTYPE_ORGANIC
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	limb_id = SPECIES_GAS

/obj/item/bodypart/chest/mutant/serpentid/Initialize(mapload)
	worn_back_offset = new(
		attached_part = src,
		feature_key = OFFSET_BACK,
		offset_y = list("north" = 5, "south" = 5, "east" = 5, "west" = 5),
	)
	worn_accessory_offset = new(
		attached_part = src,
		feature_key = OFFSET_ACCESSORY,
		offset_y = list("north" = 5, "south" = 5, "east" = 5, "west" = 5),
	)
	return ..()


/obj/item/bodypart/arm/left/mutant/serpentid
	icon_greyscale = BODYPART_ICON_GAS
	bodytype = BODYTYPE_ORGANIC
	limb_id = SPECIES_GAS
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	unarmed_damage_low = GAS_PUNCH_LOW
	unarmed_damage_high = GAS_PUNCH_HIGH


	brute_modifier = 0.8
	burn_modifier = 1.4


/obj/item/bodypart/arm/right/mutant/serpentid
	icon_greyscale = BODYPART_ICON_GAS
	bodytype = BODYTYPE_ORGANIC
	limb_id = SPECIES_GAS
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	unarmed_damage_low = GAS_PUNCH_LOW
	unarmed_damage_high = GAS_PUNCH_HIGH

	brute_modifier = 0.8
	burn_modifier = 1.4


/obj/item/bodypart/leg/left/mutant/serpentid
	icon_greyscale = BODYPART_ICON_GAS
	bodytype = BODYTYPE_ORGANIC
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	limb_id = SPECIES_GAS

	brute_modifier = 0.8
	burn_modifier = 1.4


/obj/item/bodypart/leg/right/mutant/serpentid
	icon_greyscale = BODYPART_ICON_GAS
	bodytype = BODYTYPE_ORGANIC
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	limb_id = SPECIES_GAS
	brute_modifier = 0.8
	burn_modifier = 1.4



#undef GAS_PUNCH_LOW
#undef GAS_PUNCH_HIGH
