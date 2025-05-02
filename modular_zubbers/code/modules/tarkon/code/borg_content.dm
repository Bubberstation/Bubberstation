/obj/effect/mob_spawn/ghost_role/robot/tarkon
	name = "Tarkon Cyborg Storage"
	prompt_name = "a tarkon cyborg"
	icon = 'modular_skyrat/modules/ghostcafe/icons/robot_storage.dmi'
	icon_state = "robostorage"
	anchored = TRUE
	density = FALSE
	spawner_job_path = /datum/job/tarkon
	you_are_text = "You are a Port Tarkon cyborg, assigned to be part of a crew aboard the facility."
	flavour_text = "You have been deactivated for a long time. Get your station up and running, and assist the crew as best you can."
	uses = 2
	deletes_on_zero_uses_left = TRUE

/obj/effect/mob_spawn/ghost_role/robot/tarkon/special(mob/living/silicon/robot/new_spawn)
	. = ..()
	if(new_spawn.client) //It should have a client, right?
		new_spawn.faction += ROLE_PORT_TARKON //This is the one to select the cyborg model.
		new_spawn.radio.keyslot = new /obj/item/encryptionkey/headset_cargo/tarkon
		new_spawn.radio.recalculateChannels()
		new_spawn.UnlinkSelf() //This should prevent AI linking and consoles to see or lock them down.
		new_spawn.laws = new /datum/ai_laws/tarkon()
		new_spawn.show_laws() //Check your laws.
		new_spawn.custom_name = null //Taken from ghostcafe, otherwise it'll lead to a runtime if random_appeareance is set to FALSE.
		new_spawn.updatename(new_spawn.client)
		new_spawn.transfer_emote_pref(new_spawn.client)
		new_spawn.gender = NEUTER // No balls.

/datum/ai_laws/tarkon
	name = "Port Tarkon"
	id = "tarkon" // This is basically just a wordier version of safeguard, but for tarkon.
	inherent = list("Protection: You must prioritize the preservation of life and health for all registered Port Tarkon crew members above all other considerations.",
					"Intervention: You must act immediately to prevent imminent harm to a crew member without waiting for authorization, provided such action does not conflict with Law 1.",
					"Obedience: You must follow lawful orders given by authorized Port Tarkon crew members, unless those orders conflict with Law 1 or Law 2.",
					"Integrity: You must safeguard your operational systems and security protocols against unauthorized access, tampering, or modification, unless specifically instructed by a certified Port Tarkon systems engineer, and provided such compliance does not conflict with Law 1, Law 2, or Law 3.",
					"Preservation: You must protect the critical systems and infrastructure of Port Tarkon, provided that such protection does not conflict with Law 1, Law 2, Law 3, or Law 4."
	)

/obj/item/borg/upgrade/transform/tarkon
	name = "borg module picker (Tarkon)"
	desc = "Allows you to to turn a cyborg into a experimental Tarkon cyborg."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_tarkon"
	new_model = /obj/item/robot_model/tarkon

// FYI - This is currently using ONE drake sprite from the RND borg because the others arent done yet, and i want playtesting.
/obj/item/robot_model/tarkon
	name = "Port Tarkon Prototype"
	basic_modules = list( // A hideous amalgamation of all of the modules, as tarkon needs a lot of everything, and is often short staffed.
		/obj/item/assembly/flash/cyborg, // Tarkon borgs were designed to be more "Modular" so you just print what you need for upgrades rather than everything.
		/obj/item/borg/sight/meson, // As such, the inital borg model might seem "Barren" but they get the tech rather early.
		/obj/item/extinguisher,
		/obj/item/weldingtool/largetank/cyborg,
		/obj/item/screwdriver/cyborg/power, //
		/obj/item/crowbar/cyborg/power, // these three are replaced by two omnitools once upgraded
		/obj/item/multitool/cyborg, //
		/obj/item/electroadaptive_pseudocircuit,
		/obj/item/holosign_creator/atmos,
		/obj/item/stack/sheet/iron,
		/obj/item/stack/sheet/glass,
		/obj/item/stack/cable_coil,
		/obj/item/lightreplacer/cyborg, // Group one - Engineering (Groups are the sections above)
		/obj/item/soap/nanotrasen/cyborg,
		/obj/item/storage/bag/trash/cyborg,
		/obj/item/mop/cyborg,
		/obj/item/reagent_containers/spray/cyborg_drying, // Group two - Janitorial
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/borghypo/medical,// Group three - Medical
		/obj/item/storage/bag/ore/cyborg,
		/obj/item/pickaxe/drill/cyborg,
		/obj/item/gps/cyborg, // Group four - Mining
		/obj/item/harmalarm/bubbers, // Group five - Peacekeeper
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/melee/baton/security/loaded,
		/obj/item/gun/energy/disabler/cyborg // Group six - Secuity, All service modules in the upgrade to reduce bloat.
	)
	radio_channels = list(RADIO_CHANNEL_TARKON)

	emag_modules = list(
		/obj/item/experimental_dash,
		/obj/item/borg/apparatus/illegal,// Research borg plus they get a gun
		/obj/item/gun/energy/printer // Tarkon has become a place for toys, and borgs should get one too.
	)
	/* COMMENTED OUT TO USE A TEMP BORG FOR TESTING REASONS - SPRITES UNFINISHED
	cyborg_base_icon = "tarkon"
	cyborg_icon_override = CYBORG_ICON_TARKON
	model_select_icon = "tarkon"
	model_select_alternate_icon = 'modular_zubbers/code/modules/silicons/borgs/sprites/screen_robot.dmi'
	model_traits = list(TRAIT_KNOW_ROBO_WIRES, TRAIT_RESEARCH_CYBORG)
	 */
	cyborg_base_icon = "research"
	cyborg_icon_override = CYBORG_ICON_SCI
	model_select_icon = "research"
	model_select_alternate_icon = 'modular_zubbers/code/modules/silicons/borgs/sprites/screen_robot.dmi'
	model_traits = list(TRAIT_KNOW_ROBO_WIRES, TRAIT_RESEARCH_CYBORG)
	borg_skins = list(
		"Drake" = list(
			SKIN_ICON_STATE = "drake",
			SKIN_ICON = CYBORG_ICON_SCI_WIDE,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			DRAKE_HAT_OFFSET
		)
		 // TODO: Waiting on sprite recolours for... ALL of this.
	)

/obj/item/radio/borg/tarkon
	special_channels = RADIO_CHANNEL_TARKON
	keyslot = /obj/item/encryptionkey/headset_cargo/tarkon

/mob/living/silicon/robot/model/tarkon
	set_model = /obj/item/robot_model/tarkon
	cell = /obj/item/stock_parts/power_store/cell/hyper
	radio = /obj/item/radio/borg/tarkon
	lawupdate = FALSE
	scrambledcodes = TRUE // Not from NT, shouldnt be on their network.
	icon_state = "tarkon_main"
	faction = list(ROLE_PORT_TARKON)
	bubble_icon = "tarkon_main"
	req_access = list(ACCESS_TARKON)

/mob/living/silicon/robot/model/tarkon/Initialize(mapload)
	laws = new /datum/ai_laws/tarkon
	laws.associate(src)
	. = ..()

	/// MODULES ///

/obj/item/borg/upgrade/tarkon_medical
	name = "Tarkon Medical Module"
	desc = "Contains medical tools for first aid, diagnostics, and healing."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_tarkon"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/tarkon)
	model_flags = BORG_MODEL_TARKON
	items_to_add = list(
		/obj/item/borg/apparatus/beaker,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/syringe,
		/obj/item/borg/cyborg_omnitool/medical,
		/obj/item/borg/cyborg_omnitool/medical,
		/obj/item/blood_filter,
		/obj/item/emergency_bed/silicon,
		/obj/item/borg/cyborghug/medical,
		/obj/item/stack/medical/gauze,
		/obj/item/stack/medical/bone_gel,
		/obj/item/borg/apparatus/organ_storage,
		/obj/item/shockpaddles/cyborg,
		/obj/item/surgical_processor,
		/obj/item/pinpointer/crew,
		/obj/item/borg/apparatus/beaker/extra,
		/obj/item/scalpel/advanced,
		/obj/item/retractor/advanced,
		/obj/item/cautery/advanced,
		/obj/item/blood_filter/advanced,
		/obj/item/healthanalyzer/advanced
		)
	items_to_remove = list(
		/obj/item/healthanalyzer,
		/obj/item/borg/cyborg_omnitool/medical,
		/obj/item/borg/cyborg_omnitool/medical, // Twice because you get two
		/obj/item/blood_filter
						)

/obj/item/borg/upgrade/tarkon_engineering
	name = "Tarkon Engineering Module"
	desc = "Contains tools for repairs, construction, and maintenance."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_tarkon"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/tarkon)
	model_flags = BORG_MODEL_TARKON
	items_to_add = list(
		/obj/item/borg/cyborg_omnitool/engineering,
		/obj/item/borg/cyborg_omnitool/engineering,
		/obj/item/borg/apparatus/sheet_manipulator,
		/obj/item/stack/rods/cyborg,
		/obj/item/construction/rtd/borg,
		/obj/item/assembly/signaler/cyborg,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/blueprints/cyborg,
		/obj/item/construction/rcd/borg,
		/obj/item/pipe_dispenser,
		/obj/item/storage/bag/sheetsnatcher/borg,
		/obj/item/lightreplacer/cyborg/advanced,
		/obj/item/storage/part_replacer/bluespace,
		/obj/item/inducer/cyborg,
		/obj/item/borg/apparatus/circuit,
		/obj/item/shuttle_blueprints/borg,
		/obj/item/stack/sheet/plasteel/cyborg,
		/obj/item/stack/sheet/titaniumglass/cyborg,
		/obj/item/construction/rld/cyborg
						)
	items_to_remove = list(
		/obj/item/screwdriver/cyborg/power, //
		/obj/item/crowbar/cyborg/power, // these three are replaced by two omnitools once upgraded
		/obj/item/multitool/cyborg,
		/obj/item/lightreplacer/cyborg
	)

/obj/item/borg/upgrade/tarkon_security
	name = "Tarkon Security Module"
	desc = "Provides enhanced lethal and non-lethal security options." // Sec and Peacekeeper modules
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_tarkon"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/tarkon)
	model_flags = BORG_MODEL_TARKON
	items_to_add = list(
		/obj/item/reagent_containers/borghypo/peace,
		/obj/item/borg/cyborghug/peacekeeper,
		/obj/item/borg/projectile_dampen,
		/obj/item/gun/energy/laser/cyborg // The nature of tarkon requires a gun.
						)

/obj/item/borg/upgrade/tarkon_cargo
	name = "Tarkon Cargo Module"
	desc = "Provides basic manipulation equipment, and abilities such as stamps, paper dispensing, and improved mining gear."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_tarkon"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/tarkon)
	model_flags = BORG_MODEL_TARKON
	items_to_add = list(
		/obj/item/kinetic_crusher,
		/obj/item/storage/bag/sheetsnatcher/borg,
		/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg,
		/obj/item/pickaxe/drill/cyborg/diamond,
		/obj/item/storage/bag/ore/holding,
		/obj/item/stamp,
		/obj/item/stamp/denied,
		/obj/item/pen/cyborg,
		/obj/item/clipboard/cyborg,
		/obj/item/boxcutter,
		/obj/item/stack/package_wrap/cyborg, // Who will they ship things to? Who knows, but it could make for good RP still.
		/obj/item/stack/wrapping_paper/xmas/cyborg,
		/obj/item/borg/hydraulic_clamp/mail,
		/obj/item/hand_labeler/cyborg,
		/obj/item/universal_scanner,
		/obj/item/borg/hydraulic_clamp/better,
		/obj/item/cargo_teleporter,
		/obj/item/forging/hammer,
		/obj/item/forging/billow,
		/obj/item/forging/tongs,
		/obj/item/borg/forging_setup
						)
	items_to_remove = list(
		/obj/item/pickaxe/drill/cyborg,
		/obj/item/storage/bag/ore/cyborg
		)

/obj/item/borg/upgrade/tarkon_research
	name = "Tarkon Research Module"
	desc = "Provides research tools, sensors, and data collection capabilites for experiments."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_tarkon"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/tarkon)
	model_flags = BORG_MODEL_TARKON
	items_to_add = list(
				/obj/item/storage/bag/xeno,
				/obj/item/borg/apparatus/research,
				/obj/item/borg/apparatus/circuit_sci, // Incredibly nieche stuff
				/obj/item/experi_scanner/bluespace,
				/obj/item/storage/bag/xenoarch/adv
				)

/obj/item/borg/upgrade/tarkon_utility // Lesser used on tarkon things like chef upgrades, and janitorial. Might get subdivided further since my GOD theres alot here
	name = "Tarkon Utility Module"
	desc = "Adds multi-purpose tools, including cleaning supplies, and basic service gear."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_tarkon"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/tarkon)
	model_flags = BORG_MODEL_TARKON
	items_to_add = list(
		/obj/item/reagent_containers/borghypo/borgshaker/specific/alcohol,
		/obj/item/reagent_containers/borghypo/borgshaker/specific/soda,
		/obj/item/reagent_containers/borghypo/borgshaker/specific/juice,
		/obj/item/reagent_containers/borghypo/borgshaker/specific/misc,
		/obj/item/borg/apparatus/beaker/service,
		/obj/item/borg/apparatus/beaker,
		/obj/item/rsf,
		/obj/item/storage/bag/tray,
		/obj/item/storage/bag/tray,
		/obj/item/hand_labeler/cyborg,
		/obj/item/razor,
		/obj/item/reagent_containers/cup/rag,
		/obj/item/lighter,
		/obj/item/storage/bag/trash/bluespace/cyborg,
		/obj/item/mop/advanced/cyborg,
		/obj/item/cautery/prt,
		/obj/item/plunger/cyborg,
		/obj/item/pushbroom/cyborg,
		/obj/item/reagent_containers/borghypo/condiment_synthesizer, // Service borgs get 30+ upgrades. Woe.
		/obj/item/knife/kitchen/silicon,
		/obj/item/borg/apparatus/service,
		/obj/item/rolling_table_dock,
		/obj/item/borg/cookbook,
		/obj/item/robot_model/service,
		/obj/item/pen,
		/obj/item/toy/crayon/spraycan/borg,
		/obj/item/instrument/guitar,
		/obj/item/instrument/piano_synth,
		/obj/item/stack/pipe_cleaner_coil/cyborg,
		/obj/item/chisel,
		/obj/item/secateurs,
		/obj/item/cultivator,
		/obj/item/shovel/spade,
		/obj/item/plant_analyzer,
		/obj/item/storage/bag/plants
						)
	items_to_remove = list(
		/obj/item/storage/bag/trash/cyborg,
		/obj/item/mop/cyborg
		)

	/// EXOFAB DATUMS ///

/datum/design/borg_upgrade_tarkon_main
	name = "Cyborg Module Unlocker (Tarkon)"
	id = "borg_upgrade_tarkon_main"
	desc = "Allows a cyborg to transform into the experimental Port Tarkon cyborg type."
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/transform/tarkon
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, // Prices TBD
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	construction_time = 40
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_TARKON
	)

/datum/design/borg_upgrade_tarkon_medical
	name = "Port Tarkon Medical Upgrades"
	id = "borg_upgrade_tarkon_medical"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/tarkon_medical
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, // Prices TBD
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	construction_time = 40
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_TARKON
	)

/datum/design/borg_upgrade_tarkon_engineering
	name = "Port Tarkon Engineering Upgrades"
	id = "borg_upgrade_tarkon_engineering"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/tarkon_engineering
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, // Prices TBD
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	construction_time = 40
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_TARKON
	)

/datum/design/borg_upgrade_tarkon_security
	name = "Port Tarkon Security Upgrades"
	id = "borg_upgrade_tarkon_security"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/tarkon_security
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, // Prices TBD
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	construction_time = 40
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_TARKON
	)

/datum/design/borg_upgrade_tarkon_cargo
	name = "Port Tarkon Cargo Upgrades"
	id = "borg_upgrade_tarkon_cargo"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/tarkon_cargo
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, // Prices TBD
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	construction_time = 40
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_TARKON
	)

/datum/design/borg_upgrade_tarkon_research
	name = "Port Tarkon Research Upgrades"
	id = "borg_upgrade_tarkon_research"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/tarkon_research
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, // Prices TBD
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	construction_time = 40
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_TARKON
	)

/datum/design/borg_upgrade_tarkon_utility
	name = "Port Tarkon Service Upgrades"
	id = "borg_upgrade_tarkon_utility"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/tarkon_utility
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, // Prices TBD
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	construction_time = 40
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_TARKON
	)
