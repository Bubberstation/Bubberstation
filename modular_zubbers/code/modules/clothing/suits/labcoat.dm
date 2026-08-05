/obj/item/clothing/suit/toggle/labcoat/cmo
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/labcoat_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/mad
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/labcoat_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/genetics
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/chemist
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/virologist
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/coroner
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/science
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/roboticist
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/interdyne
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/hospitalgown
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/medical
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/technical
	name = "coder technical jacket"
	desc = "oh god how did this get here"
	icon = 'modular_zubbers/icons/obj/clothing/suits/labcoat.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/labcoat.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/labcoat.dmi'
	icon_state = null //Keeps this from showing up under the chameleon hat
	inhand_icon_state = "labcoat"
	blood_overlay_type = "coat"
	toggle_noun = "zipper"
	allowed = list(
		/obj/item/analyzer,
		/obj/item/biopsy_tool,
		/obj/item/defibrillator/compact,
		/obj/item/dnainjector,
		/obj/item/flashlight,
		/obj/item/gun/energy,
		/obj/item/gun/syringe,
		/obj/item/healthanalyzer,
		/obj/item/hypospray,
		/obj/item/lighter,
		/obj/item/paper,
		/obj/item/reagent_containers/applicator,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/syringe,
		/obj/item/sensor_device,
		/obj/item/soap,
		/obj/item/stack/medical,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/hypospraykit,
		/obj/item/storage/medkit,
		/obj/item/storage/pill_bottle,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
	)

/datum/armor/dept_guard
	melee = 30
	bullet = 20
	laser = 30
	energy = 40
	bomb = 25
	fire = 30
	acid = 45

/obj/item/clothing/suit/toggle/labcoat/technical/cargo
	name = "cargo technical jacket"
	desc = "A comfortable jacket in science purple."
	icon_state = "technical_cargo"

/obj/item/clothing/suit/toggle/labcoat/technical/cargo/guard
	name = "cargo praetorian jacket"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/engineer
	name = "engineering technical jacket"
	desc = "A comfortable jacket in engineering yellow."
	icon_state = "technical_eng"

/obj/item/clothing/suit/toggle/labcoat/technical/engineer/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/analyzer,
		/obj/item/construction/rcd,
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/pipe_dispenser,
		/obj/item/storage/bag/construction,
		/obj/item/t_scanner,
		/obj/item/construction/rld,
		/obj/item/construction/rtd,
		/obj/item/gun/ballistic/rifle/rebarxbow,
		/obj/item/storage/bag/rebar_quiver,
	)

/obj/item/clothing/suit/toggle/labcoat/technical/engineer/guard
	name = "engineering praetorian jacket"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/engineer/tcomm
	name = "telecomms technical jacket"
	desc = "A comfortable jacket in engineering yellow with blue telecomms trim."
	icon_state = "technical_tcomm"

/obj/item/clothing/suit/toggle/labcoat/technical/medical
	name = "medical technical jacket"
	icon_state = "technical_med_light"
	desc = "This stylish jacket is perfect for those impromptu fashion shows on the scene of an emergency. Now, you can be the brightest beacon of style while administering medical treatment! Because, after all, why save lives if you can't look fabulous while doing it?"

/obj/item/clothing/suit/toggle/labcoat/technical/medical/guard
	name = "medical praetorian jacket"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/medical/dark
	icon_state = "technical_med_dark"

/obj/item/clothing/suit/toggle/labcoat/technical/medical/dark/guard
	name = "medical praetorian jacket"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/medical/black
	icon_state = "technical_med_black"

/obj/item/clothing/suit/toggle/labcoat/technical/medical/black/guard
	name = "medical praetorian jacket"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/science
	name = "science technical jacket"
	desc = "A comfortable jacket in science purple."
	icon_state = "technical_sci"

/obj/item/clothing/suit/toggle/labcoat/technical/science/guard
	name = "science praetorian jacket"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/sec
	name = "security praetorian jacket"
	desc = "A comfortable jacket in security red. Probably against uniform regulations."
	icon_state = "technical_sec"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/sec/Initialize(mapload)
	. = ..()
	allowed = GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/labcoat/technical/service
	name = "service technical jacket"
	desc = "A comfortable jacket in a neutral shade of grey."
	icon_state = "technical_service"

/obj/item/clothing/suit/toggle/labcoat/technical/service/guard
	name = "service praetorian jacket"
	armor_type = /datum/armor/dept_guard
