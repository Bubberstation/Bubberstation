#define RAPTOR_PUNCH_LOW 3
#define RAPTOR_PUNCH_HIGH 5
#define RAPTOR_BURN_MODIFIER 1.3
#define RAPTOR_BRUTE_MODIFIER 1.3
#define RAPTOR_SPEED_MODIFIER -0.3
#define RAPTOR_HUSK_ICON 'modular_zubbers/icons/mob/bodyparts/husk_bodyparts.dmi'

/obj/item/bodypart/head/mutant/raptor
	icon_greyscale = BODYPART_ICON_TESHARI
	icon_husk = RAPTOR_HUSK_ICON
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	limb_id = SPECIES_TESHARI
	brute_modifier = RAPTOR_BRUTE_MODIFIER
	burn_modifier = RAPTOR_BURN_MODIFIER
	head_flags = HEAD_EYESPRITES|HEAD_EYECOLOR|HEAD_EYEHOLES|HEAD_DEBRAIN

/obj/item/bodypart/head/mutant/raptor/Initialize(mapload)
	worn_ears_offset = new(
		attached_part = src,
		feature_key = OFFSET_EARS,
		offset_y = list("north" = -4, "south" = -4, "east" = -4, "west" = -4),
	)
	worn_head_offset = new(
		attached_part = src,
		feature_key = OFFSET_HEAD,
		offset_x = list("north" = 1, "south" = 1, "east" = 1, "west" = -1, "northwest" = -1, "southwest" = -1, "northeast" = 1, "southeast" = 1),
		offset_y = list("north" = -4, "south" = -4, "east" = -4, "west" = -4),
	)
	worn_mask_offset = new(
		attached_part = src,
		feature_key = OFFSET_FACEMASK,
		offset_y = list("north" = -5, "south" = -5, "east" = -5, "west" = -5),
	)
	return ..()

/obj/item/bodypart/chest/mutant/raptor
	icon_greyscale = BODYPART_ICON_TESHARI
	icon_husk = RAPTOR_HUSK_ICON
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	limb_id = SPECIES_TESHARI
	brute_modifier = RAPTOR_BRUTE_MODIFIER
	burn_modifier = RAPTOR_BURN_MODIFIER

/obj/item/bodypart/chest/mutant/teshari/Initialize(mapload)
	worn_back_offset = new(
		attached_part = src,
		feature_key = OFFSET_BACK,
		offset_y = list("north" = -4, "south" = -4, "east" = -4, "west" = -4),
	)
	worn_accessory_offset = new(
		attached_part = src,
		feature_key = OFFSET_ACCESSORY,
		offset_y = list("north" = -4, "south" = -4, "east" = -4, "west" = -4),
	)
	return ..()

/obj/item/bodypart/arm/left/mutant/raptor/Initialize(mapload)
	held_hand_offset =  new(
		attached_part = src,
		feature_key = OFFSET_HELD,
		offset_x = list("north" = 0, "south" = 0, "east" = 0, "west" = -6, "northwest" = -6, "southwest" = -6, "northeast" = 0, "southeast" = 0),
		offset_y = list("north" = -3, "south" = -3, "east" = -3, "west" = -3),
	)
	return ..()

/obj/item/bodypart/arm/right/mutant/raptor/Initialize(mapload)
	held_hand_offset =  new(
		attached_part = src,
		feature_key = OFFSET_HELD,
		offset_x = list("north" = 0, "south" = 0, "east" = 6, "west" = 0, "northwest" = 0, "southwest" = 0, "northeast" = 6, "southeast" = 6),
		offset_y = list("north" = -3, "south" = -3, "east" = -3, "west" = -3),
	)
	return ..()

/obj/item/bodypart/arm/left/mutant/raptor
	icon_greyscale = BODYPART_ICON_TESHARI
	icon_husk = RAPTOR_HUSK_ICON
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	limb_id = SPECIES_TESHARI
	unarmed_damage_low = RAPTOR_PUNCH_LOW
	unarmed_damage_high = RAPTOR_PUNCH_HIGH
	brute_modifier = RAPTOR_BRUTE_MODIFIER
	burn_modifier = RAPTOR_BURN_MODIFIER

/obj/item/bodypart/arm/right/mutant/raptor
	icon_greyscale = BODYPART_ICON_TESHARI
	icon_husk = RAPTOR_HUSK_ICON
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	limb_id = SPECIES_TESHARI
	unarmed_damage_low = RAPTOR_PUNCH_LOW
	unarmed_damage_high = RAPTOR_PUNCH_HIGH
	brute_modifier = RAPTOR_BRUTE_MODIFIER
	burn_modifier = RAPTOR_BURN_MODIFIER

/obj/item/bodypart/leg/left/mutant/raptor
	icon_greyscale = BODYPART_ICON_TESHARI
	icon_husk = RAPTOR_HUSK_ICON
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	limb_id = SPECIES_TESHARI
	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/raptor
	brute_modifier = RAPTOR_BRUTE_MODIFIER
	burn_modifier = RAPTOR_BURN_MODIFIER

/obj/item/bodypart/leg/right/mutant/raptor
	icon_greyscale = BODYPART_ICON_TESHARI
	icon_husk = RAPTOR_HUSK_ICON
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	limb_id = SPECIES_TESHARI
	digitigrade_type = /obj/item/bodypart/leg/right/digitigrade/raptor
	brute_modifier = RAPTOR_BRUTE_MODIFIER
	burn_modifier = RAPTOR_BURN_MODIFIER

/obj/item/bodypart/leg/left/digitigrade/raptor
	icon_greyscale = BODYPART_ICON_TESHARI
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	base_limb_id = SPECIES_TESHARI
	brute_modifier = RAPTOR_BRUTE_MODIFIER
	burn_modifier = RAPTOR_BURN_MODIFIER

/obj/item/bodypart/leg/right/digitigrade/raptor
	icon_greyscale = BODYPART_ICON_TESHARI
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	base_limb_id = SPECIES_TESHARI
	brute_modifier = RAPTOR_BRUTE_MODIFIER
	burn_modifier = RAPTOR_BURN_MODIFIER

#undef RAPTOR_PUNCH_LOW
#undef RAPTOR_PUNCH_HIGH
#undef RAPTOR_BURN_MODIFIER
#undef RAPTOR_BRUTE_MODIFIER
#undef RAPTOR_HUSK_ICON
#undef RAPTOR_SPEED_MODIFIER
