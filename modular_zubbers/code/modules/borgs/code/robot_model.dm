// The actual code to work these in

// Cyborg model trait procs below

//For all quadruped cyborgs
/obj/item/robot_model/proc/update_quadruped()
	var/mob/living/silicon/robot/cyborg = robot || loc
	if (!istype(robot))
		return
	if (model_features && ((TRAIT_R_SQUADRUPED in model_features) || (TRAIT_R_WIDE in model_features)))
		if (model_features && (TRAIT_R_WIDE in model_features))
			cyborg.set_base_pixel_x(-16)
		add_verb(cyborg, /mob/living/silicon/robot/proc/rest_style)
	else
		if (model_features && !(TRAIT_R_WIDE in model_features))
			cyborg.set_base_pixel_x(0)
		remove_verb(cyborg, /mob/living/silicon/robot/proc/rest_style)

//For cyborgs who have a lighter chassis
// NOTE WORKS BEST WITH ONLY 32 X 32 CYBORBG SPRITES!!!
/obj/item/robot_model/proc/update_lightweight()
	var/mob/living/silicon/robot/cyborg = robot || loc
	if (!istype(robot))
		return
	if (model_features && (TRAIT_R_LIGHT_WEIGHT in model_features))
		cyborg.can_be_held = TRUE
		cyborg.held_w_class = WEIGHT_CLASS_HUGE
		cyborg.add_traits(list(TRAIT_CATLIKE_GRACE), INNATE_TRAIT)
		cyborg.mob_size = MOB_SIZE_SMALL
	else
		cyborg.can_be_held = FALSE
		cyborg.held_w_class = WEIGHT_CLASS_NORMAL
		cyborg.remove_traits(list(TRAIT_CATLIKE_GRACE), INNATE_TRAIT)
		cyborg.mob_size = MOB_SIZE_HUMAN

// To load the correct walking sounds with out removing them
/obj/item/robot_model/proc/update_footsteps()
	var/mob/living/silicon/robot/cyborg = robot || loc
	if (!istype(robot))
		return

	if (model_features)
		// This is ugly but there is unironically not a better way
		if (TRAIT_R_SQUADRUPED in model_features)
			cyborg.AddElement(/datum/element/footstep, FOOTSTEP_ROBOT_SMALL, 6, -6, sound_vary = TRUE)
		else
			cyborg.RemoveElement(/datum/element/footstep, FOOTSTEP_ROBOT_SMALL, 6, -6, sound_vary = TRUE)

		if (TRAIT_R_TALL in model_features)
			cyborg.AddElement(/datum/element/footstep, FOOTSTEP_MOB_SHOE, 2, -6, sound_vary = TRUE)
		else
			cyborg.RemoveElement(/datum/element/footstep, FOOTSTEP_MOB_SHOE, 2, -6, sound_vary = TRUE)



//For cyborgs that can rest
// Must have a resting state!
/obj/item/robot_model/proc/update_robot_rest()
	var/mob/living/silicon/robot/cyborg = robot || loc
	if (!istype(robot))
		return
	if (model_features && ((TRAIT_R_SQUADRUPED in model_features) || (TRAIT_R_WIDE in model_features) || (TRAIT_R_TALL in model_features)))
		add_verb(cyborg, /mob/living/silicon/robot/proc/robot_lay_down)
	else
		remove_verb(cyborg, /mob/living/silicon/robot/proc/robot_lay_down)

// Cyborg model types below

#define TALL_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(0, 15), "south" = list(0, 15), "east" = list(2, 15), "west" = list(-2, 15)), \
	SKIN_HAT_REST_OFFSET = list("north" = list(0, 1), "south" = list(0, 1), "east" = list(2, 1), "west" = list(-2, 1))
#define ZOOMBA_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(0, -13), "south" = list(0, -13), "east" = list(0, -13), "west" = list(0, -13))
#define DROID_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(0, 4), "south" = list(0, 4), "east" = list(0, 4), "west" = list(0, 4))
#define BORGI_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(16, -7), "south" = list(16, -7), "east" = list(24, -7), "west" = list(8, -7))
#define PUP_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(16, 3), "south" = list(16, 3), "east" = list(29, 3), "west" = list(3, 3))
#define BLADE_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(16, -2), "south" = list(16, -2), "east" = list(31, -2), "west" = list(1, -2))
#define VALE_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(16, 3), "south" = list(16, 3), "east" = list(28, 4), "west" = list(4, 4)), \
	SKIN_HAT_REST_OFFSET = list("north" = list(16, -3), "south" = list(16, -3), "east" = list(28, -6), "west" = list(4, -6))
#define DRAKE_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(16, 0), "south" = list(16, 0), "east" = list(36, 0), "west" = list(-4, 0)), \
	SKIN_HAT_REST_OFFSET = list("north" = list(16, -6), "south" = list(16, -7), "east" = list(36, -6), "west" = list(-4, -6))
#define HOUND_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(16, 2), "south" = list(16, 2), "east" = list(28, 2), "west" = list(4, 2)), \
	SKIN_HAT_REST_OFFSET = list("north" = list(16, -5), "south" = list(16, -5), "east" = list(31, -6), "west" = list(1, -6))
#define OTIE_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(16, 4), "south" = list(16, 4), "east" = list(30, 4), "west" = list(2, 4))
#define ALINA_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(16, -2), "south" = list(16, -2), "east" = list(26, -2), "west" = list(6, -2))
#define RAPTOR_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(16, 14), "south" = list(16, 14), "east" = list(29, 14), "west" = list(3, 14)), \
	SKIN_HAT_REST_OFFSET = list("north" = list(16, 10), "south" = list(16, 10), "east" = list(29, 10), "west" = list(3, 10))
#define SMOL_RAPTOR_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(16, 0), "south" = list(16, -1), "east" = list(37, 0), "west" = list(-5, 0)), \
	SKIN_HAT_REST_OFFSET = list("north" = list(16, -4), "south" = list(16, -4), "east" = list(36, -3), "west" = list(-4, -3))
#define F3LINE_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(0, -10), "south" = list(0, -12), "east" = list(7, -10), "west" = list(-7, -10)), \
	SKIN_HAT_REST_OFFSET = list("north" = list(0, -18), "south" = list(0, -18), "east" = list(9, -18), "west" = list(-9, -18))
#define DULLAHAN_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(0, 16), "south" = list(0, 16), "east" = list(2, 16), "west" = list(-2, 16)), \
	SKIN_HAT_REST_OFFSET = list("north" = list(0, 1), "south" = list(0, 1), "east" = list(2, 1), "west" = list(-2, 1))
#define CORRUPT_HAT_OFFSET \
	SKIN_HAT_OFFSET = list("north" = list(16, -4), "south" = list(16, -15), "east" = list(35, -7), "west" = list(-3, -7)), \
	SKIN_HAT_REST_OFFSET = list("north" = list(16, -6), "south" = list(16, -17), "east" = list(35, -14), "west" = list(-3, -14))

// Centcom cyborgs
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
			RAPTOR_HAT_OFFSET
		), //aKhroma :)
		"Vale" = list(
			SKIN_ICON_STATE = "vale",
			SKIN_ICON = CYBORG_ICON_CENTCOM_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE)
		),
		"SmolRaptor" = list(SKIN_ICON_STATE = CYBORG_ICON_TYPE_SMOLRAPTOR,
		SKIN_ICON = CYBORG_ICON_CC_SMOLRAPTOR,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL, TRAIT_R_WIDE),
		SMOL_RAPTOR_HAT_OFFSET
		),
	)

/obj/item/robot_model/centcom/rebuild_modules()
	..()
	var/mob/living/silicon/robot/cyborg = loc
	cyborg.scrambledcodes = TRUE
	cyborg.req_access = list(ACCESS_CENT_GENERAL)
	cyborg.faction |= ROLE_DEATHSQUAD //You're part of CENTCOM now

/obj/item/robot_model/centcom/remove_module(obj/item/removed_module, delete_after)
	..()
	var/mob/living/silicon/robot/cyborg = loc
	cyborg.scrambledcodes = FALSE
	cyborg.req_access = list(ACCESS_ROBOTICS)
	cyborg.faction -= ROLE_DEATHSQUAD //You're no longer part of CENTCOM

//Research cyborgs
/obj/item/robot_model/sci
	name = "Research"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/extinguisher/mini,
		/obj/item/weldingtool/largetank/cyborg,
		/obj/item/screwdriver/cyborg/power,
		/obj/item/crowbar/cyborg/power,
		/obj/item/multitool/cyborg,
		/obj/item/analyzer,
		/obj/item/assembly/signaler/cyborg,
		/obj/item/borg/apparatus/sheet_manipulator,
		/obj/item/stack/cable_coil,
		/obj/item/borg/apparatus/beaker,
		/obj/item/borg/apparatus/organ_storage,
		/obj/item/borg/apparatus/research,
		/obj/item/borg/apparatus/circuit_sci,
		/obj/item/storage/part_replacer/cyborg,
		/obj/item/surgical_drapes,
		/obj/item/healthanalyzer,
		/obj/item/experi_scanner,
		/obj/item/bonesetter,
		/obj/item/stack/medical/gauze,
		/obj/item/borg/apparatus/tank_manipulator,
	)
	radio_channels = list(RADIO_CHANNEL_SCIENCE)

//TODO: Illegal science stuff
	emag_modules = list(
		/obj/item/borg/stun,
		/obj/item/experimental_dash,
		/obj/item/borg/apparatus/illegal //To replace malf printers
	)
	cyborg_base_icon = "research"
	cyborg_icon_override = CYBORG_ICON_SCI
	model_select_icon = "research"
	model_select_alternate_icon = 'modular_zubbers/code/modules/borgs/sprites/screen_robot.dmi'
	model_traits = list(TRAIT_KNOW_ROBO_WIRES, TRAIT_RESEARCH_CYBORG)
	borg_skins = list(
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_SCI_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL, TRAIT_R_LIGHT_WEIGHT),
		F3LINE_HAT_OFFSET
		),
		"Vale" = list(
			SKIN_ICON_STATE = "vale",
			SKIN_ICON = CYBORG_ICON_SCI_WIDE,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			VALE_HAT_OFFSET
		),
		"Borgi" = list(
			SKIN_ICON_STATE = "borgi",
			SKIN_ICON = CYBORG_ICON_SCI_WIDE,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			BORGI_HAT_OFFSET
		),
		"Hound" = list(
			SKIN_ICON_STATE = "hound",
			SKIN_ICON = CYBORG_ICON_SCI_WIDE,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			HOUND_HAT_OFFSET
		),
		"DarkHound" = list(
			SKIN_ICON_STATE = "hounddark",
			SKIN_ICON = CYBORG_ICON_SCI_WIDE,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			HOUND_HAT_OFFSET
		),
		"Drake" = list(
			SKIN_ICON_STATE = "drake",
			SKIN_ICON = CYBORG_ICON_SCI_WIDE,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			DRAKE_HAT_OFFSET
		),
		"Zoomba" = list(
			SKIN_ICON_STATE = "zoomba",
			SKIN_ICON = CYBORG_ICON_SCI,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL),
			ZOOMBA_HAT_OFFSET,
		),
		"Eyebot" = list(
			SKIN_ICON_STATE = "eyebot",
			SKIN_ICON = CYBORG_ICON_SCI,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL),
		),
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_SCI_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			RAPTOR_HAT_OFFSET
		),
		"Meka" = list(
			SKIN_ICON_STATE = "mekasci",
			SKIN_ICON = CYBORG_ICON_SCI_TALL,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL), TALL_HAT_OFFSET
		),
		"NiKA" = list(
			SKIN_ICON_STATE = "fmekasci",
			SKIN_ICON = CYBORG_ICON_SCI_TALL,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL), TALL_HAT_OFFSET
		),
		"NiKO" = list(
			SKIN_ICON_STATE = "mmekasci",
			SKIN_ICON = CYBORG_ICON_SCI_TALL,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL), TALL_HAT_OFFSET
		),
		"K4T (Research)" = list(
			SKIN_ICON_STATE = "k4tsci",
			SKIN_ICON = CYBORG_ICON_SCI_TALL,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL), TALL_HAT_OFFSET
		),
		"SmolRaptor" = list(SKIN_ICON_STATE = CYBORG_ICON_TYPE_SMOLRAPTOR,
		SKIN_ICON = CYBORG_ICON_SCI_SMOLRAPTOR,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL, TRAIT_R_WIDE),
		SMOL_RAPTOR_HAT_OFFSET
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahansci",
			SKIN_ICON = CYBORG_ICON_SCI_TALL,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),

	)


/* BUBBER SPRITE ADDITIONS BELOW */
/obj/item/robot_model/clown/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"Vale" = list(
			SKIN_ICON_STATE = "vale",
			SKIN_ICON = CYBORG_ICON_CLOWN_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahanclown",
			SKIN_ICON = CYBORG_ICON_CLOWN_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),
	)

/obj/item/robot_model/standard/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_GEN_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL, TRAIT_R_LIGHT_WEIGHT),
		F3LINE_HAT_OFFSET
		),
		"SmolRaptor" = list(SKIN_ICON_STATE = CYBORG_ICON_TYPE_SMOLRAPTOR,
		SKIN_ICON = CYBORG_ICON_GEN_SMOLRAPTOR,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL, TRAIT_R_WIDE),
		SMOL_RAPTOR_HAT_OFFSET
		),
	)

/obj/item/robot_model/medical/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_MED_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL, TRAIT_R_LIGHT_WEIGHT),
		F3LINE_HAT_OFFSET
		),
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_MED_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			RAPTOR_HAT_OFFSET
		),
		"SmolRaptor" = list(SKIN_ICON_STATE = CYBORG_ICON_TYPE_SMOLRAPTOR,
		SKIN_ICON = CYBORG_ICON_MED_SMOLRAPTOR,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL, TRAIT_R_WIDE),
		SMOL_RAPTOR_HAT_OFFSET
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahanmed",
			SKIN_ICON = CYBORG_ICON_MED_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),
		"Haydee" = list(
			SKIN_ICON_STATE = "HaydeeMedFix",
			SKIN_ICON = CYBORG_ICON_MED_HAYDEE_BUBBER,
		),
	)

/obj/item/robot_model/engineering/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_ENG_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL, TRAIT_R_LIGHT_WEIGHT),
		F3LINE_HAT_OFFSET
		),
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_ENG_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			RAPTOR_HAT_OFFSET
		),
		"SmolRaptor" = list(SKIN_ICON_STATE = CYBORG_ICON_TYPE_SMOLRAPTOR,
		SKIN_ICON = CYBORG_ICON_ENG_SMOLRAPTOR,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL, TRAIT_R_WIDE),
		SMOL_RAPTOR_HAT_OFFSET
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahaneng",
			SKIN_ICON = CYBORG_ICON_ENG_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),
		"Haydee" = list(
			SKIN_ICON_STATE = "haydeeengineclassic",
			SKIN_ICON = CYBORG_ICON_ENG_HAYDEE_BUBBER,
		),
	)

/obj/item/robot_model/janitor/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_JANI_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL, TRAIT_R_LIGHT_WEIGHT),
		F3LINE_HAT_OFFSET
		),
		//64x48 sprites below (Raptor)
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_JANI_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			RAPTOR_HAT_OFFSET
		),
		"SmolRaptor" = list(SKIN_ICON_STATE = CYBORG_ICON_TYPE_SMOLRAPTOR,
		SKIN_ICON = CYBORG_ICON_JANI_SMOLRAPTOR,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL, TRAIT_R_WIDE),
		SMOL_RAPTOR_HAT_OFFSET
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahanjani",
			SKIN_ICON = CYBORG_ICON_JANI_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),
		"Haydee" = list(
			SKIN_ICON_STATE = "HaydeeJannieClassic",
			SKIN_ICON = CYBORG_ICON_JANI_HAYDEE_BUBBER,
		),
	)

/obj/item/robot_model/miner/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_MINE_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL, TRAIT_R_LIGHT_WEIGHT),
		F3LINE_HAT_OFFSET
		),
		//64x32 Sprites below (Wide)
		"Corrupt" = list(
			SKIN_ICON_STATE = "corrupt",
			SKIN_ICON = CYBORG_ICON_MINING_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			CORRUPT_HAT_OFFSET
		),
		"Corrupt Alt" = list(
			SKIN_ICON_STATE = "corruptalt",
			SKIN_ICON = CYBORG_ICON_MINING_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			CORRUPT_HAT_OFFSET
		),
		//64x48 sprites below (Raptor)
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_MINING_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			RAPTOR_HAT_OFFSET
		),
		"SmolRaptor" = list(SKIN_ICON_STATE = CYBORG_ICON_TYPE_SMOLRAPTOR,
		SKIN_ICON = CYBORG_ICON_MIN_SMOLRAPTOR,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL, TRAIT_R_WIDE),
		SMOL_RAPTOR_HAT_OFFSET
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahanmine",
			SKIN_ICON = CYBORG_ICON_MINING_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),
		"Haydee" = list(
			SKIN_ICON_STATE = "HaydeeMinerClassic",
			SKIN_ICON = CYBORG_ICON_MINING_HAYDEE_BUBBER,
		),
	)

/obj/item/robot_model/security/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_SEC_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL, TRAIT_R_LIGHT_WEIGHT),
		F3LINE_HAT_OFFSET
		),
		//32x64 Sprites below (Tall)
		"Meka - Bluesec" = list(
			SKIN_ICON_STATE = "mekasecalt",
			SKIN_ICON = CYBORG_ICON_PEACEKEEPER_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			TALL_HAT_OFFSET
		),
		//64x48 sprites below (Raptor)
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_SEC_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			RAPTOR_HAT_OFFSET
		),
	)

/obj/item/robot_model/peacekeeper/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_PK_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL, TRAIT_R_LIGHT_WEIGHT),
		F3LINE_HAT_OFFSET
		),
		//32x64 Sprites below (Tall)
		"Meka - Bluesec" = list(
			SKIN_ICON_STATE = "mekasecalt",
			SKIN_ICON = CYBORG_ICON_PEACEKEEPER_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			TALL_HAT_OFFSET,
		),
		"Foxtrot - Peacekeeper" = list(
			//Sprites by Crumpaloo!
			SKIN_ICON_STATE = "ftpeace",
			SKIN_ICON = CYBORG_ICON_PEACEKEEPER_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			TALL_HAT_OFFSET,
		),
		//64x32 Sprites below (Wide)
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_PEACEKEEPER_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			RAPTOR_HAT_OFFSET
		),
		"SmolRaptor" = list(SKIN_ICON_STATE = CYBORG_ICON_TYPE_SMOLRAPTOR,
		SKIN_ICON = CYBORG_ICON_PK_SMOLRAPTOR,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL, TRAIT_R_WIDE),
		SMOL_RAPTOR_HAT_OFFSET
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahanpeace",
			SKIN_ICON = CYBORG_ICON_PEACEKEEPER_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),
		"Haydee" = list(
			SKIN_ICON_STATE = "HaydeePeaceClassic",
			SKIN_ICON = CYBORG_ICON_PEACEKEEPER_HAYDEE_BUBBER,
		),
	)

/obj/item/robot_model/service/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_SERV_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL, TRAIT_R_LIGHT_WEIGHT),
		F3LINE_HAT_OFFSET
		),
		"Fancy Raptor" = list(
			SKIN_ICON_STATE = "fancyraptor",
			SKIN_ICON = CYBORG_ICON_SERVICE_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			RAPTOR_HAT_OFFSET
		),
		"SmolRaptor" = list(SKIN_ICON_STATE = CYBORG_ICON_TYPE_SMOLRAPTOR,
		SKIN_ICON = CYBORG_ICON_SERV_SMOLRAPTOR,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL, TRAIT_R_WIDE),
		SMOL_RAPTOR_HAT_OFFSET
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahanserv",
			SKIN_ICON = CYBORG_ICON_SERVICE_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahanserv_alt",
			SKIN_ICON = CYBORG_ICON_SERVICE_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),
		"Haydee" = list(
			SKIN_ICON_STATE = "HaydeeSlutviceClassic",
			SKIN_ICON = CYBORG_ICON_SERVICE_HAYDEE_BUBBER,
		),
		"Bundee" = list(
			SKIN_ICON_STATE = "HaydeeBunviceClassic",
			SKIN_ICON = CYBORG_ICON_SERVICE_BUNDEE_BUBBER,
		),
	)

/obj/item/robot_model/cargo/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"SmolRaptor" = list(SKIN_ICON_STATE = CYBORG_ICON_TYPE_SMOLRAPTOR,
		SKIN_ICON = CYBORG_ICON_CAR_SMOLRAPTOR,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL, TRAIT_R_WIDE),
		SMOL_RAPTOR_HAT_OFFSET
		),
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_CAR_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL, TRAIT_R_LIGHT_WEIGHT),
		F3LINE_HAT_OFFSET
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahancargo",
			SKIN_ICON = CYBORG_ICON_CARGO_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),
	)

/obj/item/robot_model/syndicatejack/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"Vale" = list(
			SKIN_ICON_STATE = "vale",
			SKIN_ICON = CYBORG_ICON_SYNDIE_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			VALE_HAT_OFFSET
		),
		"Pupdozer" = list(
			SKIN_ICON_STATE = "pupdozer",
			SKIN_ICON = CYBORG_ICON_SYNDIE_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_WIDE)
		),
		"Saboraptor" = list(
			SKIN_ICON_STATE = "Saboraptor",
			SKIN_ICON = CYBORG_ICON_SYNDIE_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
		"Mediraptor" = list(
			SKIN_ICON_STATE = "Mediraptor",
			SKIN_ICON = CYBORG_ICON_SYNDIE_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
		"Mechraptor" = list(
			SKIN_ICON_STATE = "Mechraptor",
			SKIN_ICON = CYBORG_ICON_SYNDIE_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_SYNDI_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL),
		F3LINE_HAT_OFFSET
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahansyndi",
			SKIN_ICON = CYBORG_ICON_SYNDIE_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),
		"Haydee" = list(
			SKIN_ICON_STATE = "HaydeeSecClassic",
			SKIN_ICON = CYBORG_ICON_SYNDIE_HAYDEE_BUBBER,
		),

	)

/obj/item/robot_model/syndicate
	borg_skins = list(
		//DEFAULT MEDICAL MODULE
		"Syndicate Medical" = list(
			SKIN_ICON_STATE = "synd_sec",
			SKIN_ICON = 'icons/mob/silicon/robots.dmi'
		),
		"Saboraptor" = list(
			SKIN_ICON_STATE = "Saboraptor",
			SKIN_ICON = CYBORG_ICON_SYNDIE_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
		"Vale" = list(
			SKIN_ICON_STATE = "vale",
			SKIN_ICON = CYBORG_ICON_SYNDIE_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_SYNDI_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL),
		F3LINE_HAT_OFFSET
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahansyndi",
			SKIN_ICON = CYBORG_ICON_SYNDIE_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),
		"Haydee" = list(
			SKIN_ICON_STATE = "HaydeeSecClassic",
			SKIN_ICON = CYBORG_ICON_SYNDIE_HAYDEE_BUBBER,
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
		"Mediraptor" = list(
			SKIN_ICON_STATE = "Mediraptor",
			SKIN_ICON = CYBORG_ICON_SYNDIE_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
		//64x32 (Widerobot) Sprites Below
		"Vale" = list(
			SKIN_ICON_STATE = "vale",
			SKIN_ICON = CYBORG_ICON_SYNDIE_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_SYNDI_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL),
		F3LINE_HAT_OFFSET
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahansyndi",
			SKIN_ICON = CYBORG_ICON_SYNDIE_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),
		"Haydee" = list(
			SKIN_ICON_STATE = "HaydeeSecClassic",
			SKIN_ICON = CYBORG_ICON_SYNDIE_HAYDEE_BUBBER,
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
		"Mechraptor" = list(
			SKIN_ICON_STATE = "Mechraptor",
			SKIN_ICON = CYBORG_ICON_SYNDIE_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
		),
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_SYNDI_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL),
		F3LINE_HAT_OFFSET
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahansyndi",
			SKIN_ICON = CYBORG_ICON_SYNDIE_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),
		"Haydee" = list(
			SKIN_ICON_STATE = "HaydeeSecClassic",
			SKIN_ICON = CYBORG_ICON_SYNDIE_HAYDEE_BUBBER,
		),

	)


/obj/item/robot_model/ninja/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		/*
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_NINJA_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			RAPTOR_HAT_OFFSET
		),
		"Vale" = list(
			SKIN_ICON_STATE = "valeninja",
			SKIN_ICON = CYBORG_ICON_NINJA_WIDE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE)
		),
		*/
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_NINJA_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL),
		F3LINE_HAT_OFFSET
		),
		"Dullahan" = list(
			SKIN_ICON_STATE = "dullahanninja",
			SKIN_ICON = CYBORG_ICON_NINJA_TALL_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL),
			DULLAHAN_HAT_OFFSET
		),
	)

/obj/item/robot_model/ninja_saboteur/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"F3-LINE" = list(
		SKIN_ICON_STATE = CYBORG_ICON_TYPE_NINJA_CATBORG,
		SKIN_ICON = CYBORG_ICON_ALL_CATBORG,
		SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SQUADRUPED, TRAIT_R_SMALL),
		F3LINE_HAT_OFFSET
		),
	)

#undef CYBORG_ICON_CENTCOM_WIDE_BUBBER
#undef CYBORG_ICON_CENTCOM_LARGE_BUBBER
#undef CYBORG_ICON_CLOWN_WIDE_BUBBER
#undef CYBORG_ICON_MED_WIDE_BUBBER
#undef CYBORG_ICON_MED_LARGE_BUBBER
#undef CYBORG_ICON_CARGO_WIDE_BUBBER
#undef CYBORG_ICON_CARGO_LARGE_BUBBER
#undef CYBORG_ICON_SEC_WIDE_BUBBER
#undef CYBORG_ICON_SEC_LARGE_BUBBER
#undef CYBORG_ICON_ENG_WIDE_BUBBER
#undef CYBORG_ICON_ENG_LARGE_BUBBER
#undef CYBORG_ICON_PEACEKEEPER_WIDE_BUBBER
#undef CYBORG_ICON_PEACEKEEPER_TALL_BUBBER
#undef CYBORG_ICON_PEACEKEEPER_LARGE_BUBBER
#undef CYBORG_ICON_SERVICE_WIDE_BUBBER
#undef CYBORG_ICON_SERVICE_LARGE_BUBBER
#undef CYBORG_ICON_MINING_WIDE_BUBBER
#undef CYBORG_ICON_MINING_LARGE_BUBBER
#undef CYBORG_ICON_JANI_WIDE_BUBBER
#undef CYBORG_ICON_JANI_LARGE_BUBBER
#undef CYBORG_ICON_SYNDIE_WIDE_BUBBER
#undef CYBORG_ICON_SYNDIE_LARGE_BUBBER
#undef CYBORG_ICON_NINJA_WIDE_BUBBER
#undef CYBORG_ICON_NINJA_LARGE_BUBBER
#undef CYBORG_ICON_TYPE_RAPTOR

//small raptors
#undef CYBORG_ICON_TYPE_SMOLRAPTOR
#undef CYBORG_ICON_GEN_SMOLRAPTOR
#undef CYBORG_ICON_SCI_SMOLRAPTOR
#undef CYBORG_ICON_ENG_SMOLRAPTOR
#undef CYBORG_ICON_MED_SMOLRAPTOR
#undef CYBORG_ICON_CAR_SMOLRAPTOR
#undef CYBORG_ICON_SERV_SMOLRAPTOR
#undef CYBORG_ICON_PK_SMOLRAPTOR
#undef CYBORG_ICON_JANI_SMOLRAPTOR
#undef CYBORG_ICON_MIN_SMOLRAPTOR
#undef CYBORG_ICON_CC_SMOLRAPTOR

//F3-LINE
#undef CYBORG_ICON_ALL_CATBORG
#undef CYBORG_ICON_TYPE_GEN_CATBORG
#undef CYBORG_ICON_TYPE_SCI_CATBORG
#undef CYBORG_ICON_TYPE_ENG_CATBORG
#undef CYBORG_ICON_TYPE_MED_CATBORG
#undef CYBORG_ICON_TYPE_SERV_CATBORG
#undef CYBORG_ICON_TYPE_PK_CATBORG
#undef CYBORG_ICON_TYPE_JANI_CATBORG
#undef CYBORG_ICON_TYPE_MINE_CATBORG
#undef CYBORG_ICON_TYPE_SEC_CATBORG
#undef CYBORG_ICON_TYPE_SYNDI_CATBORG
#undef CYBORG_ICON_TYPE_NINJA_CATBORG

//Haydeez borgs are nuts
#undef CYBORG_ICON_MED_HAYDEE_BUBBER
#undef CYBORG_ICON_ENG_HAYDEE_BUBBER
#undef CYBORG_ICON_SERVICE_HAYDEE_BUBBER
#undef CYBORG_ICON_SERVICE_BUNDEE_BUBBER
#undef CYBORG_ICON_PEACEKEEPER_HAYDEE_BUBBER
#undef CYBORG_ICON_MINING_HAYDEE_BUBBER
#undef CYBORG_ICON_JANI_HAYDEE_BUBBER
#undef CYBORG_ICON_SYNDIE_HAYDEE_BUBBER

//Hat Offsets
#undef TALL_HAT_OFFSET
#undef ZOOMBA_HAT_OFFSET
#undef DROID_HAT_OFFSET
#undef BORGI_HAT_OFFSET
#undef PUP_HAT_OFFSET
#undef BLADE_HAT_OFFSET
#undef VALE_HAT_OFFSET
#undef DRAKE_HAT_OFFSET
#undef HOUND_HAT_OFFSET
#undef OTIE_HAT_OFFSET
#undef ALINA_HAT_OFFSET
#undef RAPTOR_HAT_OFFSET
#undef SMOL_RAPTOR_HAT_OFFSET
#undef F3LINE_HAT_OFFSET
#undef DULLAHAN_HAT_OFFSET
#undef CORRUPT_HAT_OFFSET
