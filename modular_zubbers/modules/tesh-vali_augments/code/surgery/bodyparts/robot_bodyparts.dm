#define ROBOTIC_LIGHT_BRUTE_MSG "marred"
#define ROBOTIC_MEDIUM_BRUTE_MSG "dented"
#define ROBOTIC_HEAVY_BRUTE_MSG "falling apart"

#define ROBOTIC_LIGHT_BURN_MSG "scorched"
#define ROBOTIC_MEDIUM_BURN_MSG "charred"
#define ROBOTIC_HEAVY_BURN_MSG "smoldering"

/*
 The damage modifiers here are modified to stay in line with teshari
 Although I'm not sure if it's redundant, better safe than sorry.
 */

#define TESHARI_PUNCH_LOW 2
#define TESHARI_PUNCH_HIGH 6

//Teshari normal

/obj/item/bodypart/arm/left/robot/raptoral
	name = "cybernetic left raptorial forelimb"
	desc = "A skeletal limb wrapped in pseudomuscles and membranous feathers, with a low-conductivity case."
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_augments.dmi'
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_augments.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

/obj/item/bodypart/arm/right/robot/raptoral
	name = "cybernetic right raptorial forelimb"
	desc = "A skeletal limb wrapped in pseudomuscles and membranous feathers, with a low-conductivity case."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_augments.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_augments.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

/obj/item/bodypart/leg/left/robot/raptoral
	name = "cybernetic left raptorial hindlimb"
	desc = "A skeletal limb wrapped in pseudomuscles and membranous feathers, with a low-conductivity case."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_augments.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_augments.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

/obj/item/bodypart/leg/right/robot/raptoral
	name = "cybernetic right raptorial hindlimb"
	desc = "A skeletal limb wrapped in pseudomuscles and membranous feathers, with a low-conductivity case."
	icon_static =  'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_augments.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_augments.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

/obj/item/bodypart/chest/robot/raptoral
	name = "cybernetic raptorial torso"
	desc = "A heavily reinforced case containing cyborg logic boards, with space for a standard power cell, covered in a layer of membranous feathers."
	icon_static =  'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_augments.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_augments.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	brute_modifier = 1
	burn_modifier = 0.9

	robotic_emp_paralyze_damage_percent_threshold = 0.5

/obj/item/bodypart/head/robot/raptoral
	name = "cybernetic raptorial head"
	desc = "A standard reinforced braincase, with spine-plugged neural socket and sensor gimbals. A layer of membranous feathers covers the stark metal."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_augments.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_augments.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

	head_flags = HEAD_EYESPRITES

// raptoral surplus

/obj/item/bodypart/arm/left/robot/surplus/raptoral
	name = "prosthetic left raptorial forelimb"
	desc = "A skeletal, robotic wing. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_surplus_augments.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_surplus_augments.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM


	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/right/robot/surplus/raptoral
	name = "prosthetic right raptorial forelimb"
	desc = "A skeletal, robotic wing. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_surplus_augments.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_surplus_augments.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/left/robot/surplus/raptoral
	name = "prosthetic left raptorial hindlimb"
	desc = "A skeletal, robotic hindlimb. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/surplus_augments_raptoral.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/surplus_augments_raptoral.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/right/robot/surplus/raptoral
	name = "prosthetic right raptorial hindlimb"
	desc = "A skeletal, robotic hindlimb. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/surplus_augments_raptoral.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/surplus_augments_raptoral.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/left/robot/surplus/raptoral
	name = "prosthetic left raptorial forelimb"
	desc = "A skeletal, robotic wing. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/surplus_augments_raptoral.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/surplus_augments_raptoral.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/right/robot/surplus/raptoral
	name = "prosthetic right raptorial forelimb"
	desc = "A skeletal, robotic wing. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/surplus_augments_raptoral.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/surplus_augments_raptoral.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS

	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS


	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/left/robot/raptoral_surplus
	name = "prosthetic left raptorial hindlimb"
	desc = "A skeletal, robotic hindlimb. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/surplus_augments_raptoral.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/surplus_augments_raptoral.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS

	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/right/robot/raptoral_surplus
	name = "prosthetic right raptorial hindlimb"
	desc = "A skeletal, robotic hindlimb. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/surplus_augments_raptoral.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/surplus_augments_raptoral.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

// raptoral advanced

/obj/item/bodypart/arm/left/robot/advanced/raptoral
	name = "advanced left raptorial forelimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/advanced_augments_raptoral.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/advanced_augments_raptoral.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 0.8
	burn_modifier = 1

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/right/robot/advanced/raptoral
	name = "advanced right raptorial forelimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/advanced_augments_raptoral.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/advanced_augments_raptoral.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 0.8
	burn_modifier = 1

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/left/robot/advanced/raptoral
	name = "advanced left raptorial hindlimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/advanced_augments_raptoral.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/advanced_augments_raptoral.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 0.8
	burn_modifier = 1

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/right/robot/advanced/raptoral
	name = "advanced right raptorial hindlimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_advanced_augments.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_advanced_augments.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 0.8
	burn_modifier = 1

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/left/robot/advanced/raptoral
	name = "advanced left raptorial forelimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_advanced_augments.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_advanced_augments.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 1
	burn_modifier = 0.9

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/right/robot/advanced/raptoral
	name = "advanced right raptorial forelimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_advanced_augments.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_advanced_augments.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 1
	burn_modifier = 0.9

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/left/robot/advanced/raptoral
	name = "advanced left raptorial hindlimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_advanced_augments.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_advanced_augments.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 1
	burn_modifier = 0.9

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/right/robot/advanced/raptoral
	name = "advanced right raptorial hindlimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_advanced_augments.dmi'
	icon = 'modular_zubbers/modules/tesh-vali_augments/icons/raptoral_advanced_augments.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 1
	burn_modifier = 0.9

	biological_state = (BIO_METAL|BIO_JOINTED)

#undef ROBOTIC_LIGHT_BRUTE_MSG
#undef ROBOTIC_MEDIUM_BRUTE_MSG
#undef ROBOTIC_HEAVY_BRUTE_MSG

#undef ROBOTIC_LIGHT_BURN_MSG
#undef ROBOTIC_MEDIUM_BURN_MSG
#undef ROBOTIC_HEAVY_BURN_MSG

#undef TESHARI_PUNCH_LOW
#undef TESHARI_PUNCH_HIGH
