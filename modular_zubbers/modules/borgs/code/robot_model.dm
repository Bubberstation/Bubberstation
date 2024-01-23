/obj/item/robot_model/centcom
	name = "Central Command"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/pen/cyborg,
		/obj/item/clipboard/cyborg,
		/obj/item/hand_labeler/cyborg,
		/obj/item/stamp/centcom,
		/obj/item/borg/paperplane_crossbow,
		/obj/item/weldingtool/mini,
		/obj/item/megaphone/command,
		/obj/item/paint/anycolor/cyborg,
		/obj/item/soap/nanotrasen/cyborg,
		/obj/item/borg/cyborghug/medical,
		/obj/item/borg/lollipop,
		/obj/item/reagent_containers/borghypo/centcom,
		/obj/item/extinguisher/mini,
		/obj/item/borg/apparatus/paper_manipulator,
		/obj/item/screwdriver/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/picket_sign/cyborg,
		/obj/item/borg/stun,
	)
	radio_channels = list(RADIO_CHANNEL_CENTCOM, RADIO_CHANNEL_COMMAND)
	model_traits = list(TRAIT_PUSHIMMUNE, TRAIT_NOFLASH)
	emag_modules = list(
		/obj/item/reagent_containers/spray/cyborg_lube,
		/obj/item/paperplane/syndicate/hardlight
	)
	special_light_key = null
	borg_skins = list(
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_CENTCOM_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		), //aKhroma :)
		"Vale" = list(
			SKIN_ICON_STATE = "vale",
			SKIN_ICON = CYBORG_ICON_CENTCOM_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE)
		),
	)

/obj/item/robot_model/centcom/rebuild_modules()
	..()
	var/mob/living/silicon/robot/cyborg = loc
	cyborg.faction |= ROLE_DEATHSQUAD //You're part of CENTCOM now

/obj/item/robot_model/centcom/remove_module(obj/item/removed_module, delete_after)
	..()
	var/mob/living/silicon/robot/cyborg = loc
	cyborg.faction -= ROLE_DEATHSQUAD //You're no longer part of CENTCOM

/* BUBBER SPRITE ADDITIONS BELOW */
/obj/item/robot_model/medical/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_MED_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
	)

/obj/item/robot_model/engineering/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_ENG_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
	)

/obj/item/robot_model/janitor/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		//64x48 sprites below (Raptor)
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_JANI_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
	)

/obj/item/robot_model/miner/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		//64x32 Sprites below (Wide)
		"Corrupt" = list(
			SKIN_ICON_STATE = "corrupt",
			SKIN_ICON = CYBORG_ICON_MINING_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE)
		),
		"Corrupt Alt" = list(
			SKIN_ICON_STATE = "corruptalt",
			SKIN_ICON = CYBORG_ICON_MINING_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE)
		),
		//64x48 sprites below (Raptor)
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_MINING_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
	)

/obj/item/robot_model/security/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		//32x64 Sprites below (Tall)
		"Meka - Bluesec" = list(
			SKIN_ICON_STATE = "mekasecalt",
			SKIN_ICON = CYBORG_ICON_PEACEKEEPER_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			SKIN_HAT_OFFSET = 15
		),
		//64x48 sprites below (Raptor)
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_SEC_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
	)

/obj/item/robot_model/peacekeeper/Initialize()
	. = ..()
	borg_skins |= list(
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_PEACEKEEPER_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
	)

/obj/item/robot_model/peacekeeper/Initialize(mapload)
	.=..()
	borg_skins |= list(
		//32x64 Sprites below (Tall)
		"Meka - Bluesec" = list(
			SKIN_ICON_STATE = "mekasecalt",
			SKIN_ICON = CYBORG_ICON_PEACEKEEPER_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			SKIN_HAT_OFFSET = 15
		),
		//64x32 Sprites below (Wide)
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_PEACEKEEPER_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
	)

/obj/item/robot_model/service/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"Fancy Raptor" = list(
			SKIN_ICON_STATE = "fancyraptor",
			SKIN_ICON = CYBORG_ICON_SERVICE_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
	)

/obj/item/robot_model/syndicatejack/Initialize()
	. = ..()
	borg_skins |= list(
		"Vale" = list(
			SKIN_ICON_STATE = "vale",
			SKIN_ICON = CYBORG_ICON_SYNDIE_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE)
		),
		"Pupdozer" = list(
			SKIN_ICON_STATE = "pupdozer",
			SKIN_ICON = CYBORG_ICON_SYNDIE_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_WIDE)
		),
		"Mediraptor" = list(
			SKIN_ICON_STATE = "mediraptor",
			SKIN_ICON = CYBORG_ICON_SYNDIE_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
		"Mechraptor" = list(
			SKIN_ICON_STATE = "mechraptor",
			SKIN_ICON = CYBORG_ICON_SYNDIE_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
		"Saboraptor" = list(
			SKIN_ICON_STATE = "saboraptor",
			SKIN_ICON = CYBORG_ICON_SYNDIE_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
	)

/obj/item/robot_model/syndicate
	borg_skins = list(
		//DEFAULT MEDICAL MODULE
		"Syndicate Medical" = list(
			SKIN_ICON_STATE = "synd_sec",
			SKIN_ICON = 'icons/mob/silicon/robots.dmi'
		),
		"Mechraptor" = list(
			SKIN_ICON_STATE = "mechraptor",
			SKIN_ICON = CYBORG_ICON_SYNDIE_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
		"Vale" = list(
			SKIN_ICON_STATE = "vale",
			SKIN_ICON = CYBORG_ICON_SYNDIE_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
	)

/obj/item/robot_model/syndicate_medical
	borg_skins = list(
		//DEFAULT MEDICAL MODULE
		"Syndicate Medical" = list(
			SKIN_ICON_STATE = "synd_medical",
			SKIN_ICON = 'icons/mob/silicon/robots.dmi'
		),
		//64x64 (Largerobot) Sprites Below
		"MediRaptor" = list(
			SKIN_ICON_STATE = "mediraptor",
			SKIN_ICON = CYBORG_ICON_SYNDIE_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
		//64x32 (Widerobot) Sprites Below
		"Vale" = list(
			SKIN_ICON_STATE = "vale",
			SKIN_ICON = CYBORG_ICON_SYNDIE_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
	)

/obj/item/robot_model/saboteur
	borg_skins = list(
		//DEFAULT SABOTEUR MODULE
		"Syndicate Engi" = list(
			SKIN_ICON_STATE = "synd_engi",
			SKIN_ICON = 'icons/mob/silicon/robots.dmi',
		),
		//64x64 (Largerobot) Sprites Below
		"SaboRaptor" = list(
			SKIN_ICON_STATE = "saboraptor",
			SKIN_ICON = CYBORG_ICON_SYNDIE_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
	)

/*
/obj/item/robot_model/ninja/Initialize()
	. = ..()
	borg_skins |= list(
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_NINJA_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE)
		),
		"Vale" = list(
			SKIN_ICON_STATE = "valeninja",
			SKIN_ICON = CYBORG_ICON_NINJA_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE)
		),
	)
*/
