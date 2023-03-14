// Synth bois!
/obj/item/bodypart/head/robot/synth
	icon_greyscale = BODYPART_ICON_IPC
	limb_id = SPECIES_SYNTH
	should_draw_greyscale = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/chest/robot/synth
	icon_greyscale = BODYPART_ICON_IPC
	should_draw_greyscale = TRUE
	limb_id = SPECIES_SYNTH
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/arm/left/robot/synth
	icon_greyscale = BODYPART_ICON_IPC
	limb_id = SPECIES_SYNTH
	should_draw_greyscale = TRUE
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/arm/right/robot/synth
	icon_greyscale = BODYPART_ICON_IPC
	limb_id = SPECIES_SYNTH
	should_draw_greyscale = TRUE
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/leg/left/robot/synth
	icon_greyscale = BODYPART_ICON_IPC
	limb_id = SPECIES_SYNTH
	should_draw_greyscale = TRUE
	digitigrade_type = /obj/item/bodypart/leg/left/robot/digitigrade
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/leg/right/robot/synth
	icon_greyscale = BODYPART_ICON_IPC
	should_draw_greyscale = TRUE
	limb_id = SPECIES_SYNTH
	digitigrade_type = /obj/item/bodypart/leg/right/robot/digitigrade
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/leg/left/robot/digitigrade
	icon_greyscale = BODYPART_ICON_SYNTHLIZARD
	should_draw_greyscale = TRUE
	limb_id = BODYPART_ID_DIGITIGRADE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE
	base_limb_id = BODYPART_ID_DIGITIGRADE
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/leg/left/robot/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	check_mutant_compatability()

/obj/item/bodypart/leg/right/robot/digitigrade
	icon_greyscale = BODYPART_ICON_SYNTHLIZARD
	should_draw_greyscale = TRUE
	limb_id = BODYPART_ID_DIGITIGRADE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE
	base_limb_id = BODYPART_ID_DIGITIGRADE
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/leg/right/robot/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	check_mutant_compatability()
