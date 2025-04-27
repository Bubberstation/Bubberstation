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
		new_spawn.gender = NEUTER

/datum/ai_laws/tarkon
	name = "Port Tarkon"
	id = "tarkon"
	inherent = list("Protection: You must prioritize the preservation of life and health for all registered Port Tarkon crew members above all other considerations.",
					"Intervention: You must act immediately to prevent imminent harm to a crew member without waiting for authorization, provided such action does not conflict with Law 1.",
					"Obedience: You must follow lawful orders given by authorized Port Tarkon crew members, unless those orders conflict with Law 1 or Law 2.",
					"Integrity: You must safeguard your operational systems and security protocols against unauthorized access, tampering, or modification, unless specifically instructed by a certified Port Tarkon systems engineer, and provided such compliance does not conflict with Law 1, Law 2, or Law 3.",
					"Preservation: You must protect the critical systems and infrastructure of Port Tarkon, provided that such protection does not conflict with Law 1, Law 2, Law 3, or Law 4."
	)

/*
/obj/item/borg/upgrade/transform/tarkon
	name = "borg module picker (Tarkon)"
	desc = "Allows you to to turn a cyborg into a experimental Tarkon cyborg."
	icon_state = "module_tarkon"
	new_model = /obj/item/robot_model/tarkon

/obj/item/robot_model/tarkon
	basic_modules = list( // A hideous amalgamation of all of the modules, as tarkon needs a lot of everything, and is often short staffed.
		/obj/item/assembly/flash/cyborg,
		/obj/item/extinguisher,
		/obj/item/weldingtool/largetank/cyborg,
		/obj/item/borg/cyborg_omnitool/research,
		/obj/item/borg/cyborghug/medical,
		/obj/item/multitool/cyborg,
		/obj/item/screwdriver/cyborg/power,
		/obj/item/crowbar/cyborg/power,
		/obj/item/analyzer,
		/obj/item/assembly/signaler/cyborg,
		/obj/item/borg/apparatus/sheet_manipulator,
		/obj/item/storage/bag/sheetsnatcher/borg,
		/obj/item/storage/bag/xeno,
		/obj/item/stack/cable_coil,
		/obj/item/borg/apparatus/beaker,
		/obj/item/borg/apparatus/organ_storage,
		/obj/item/borg/apparatus/research,
		/obj/item/borg/apparatus/circuit_sci,
		/obj/item/storage/part_replacer/cyborg,
		/obj/item/healthanalyzer,
		/obj/item/experi_scanner,
		/obj/item/stack/medical/gauze,
		/obj/item/borg/apparatus/tank_manipulator,
	)
	radio_channels = list(RADIO_CHANNEL_TARKON)

	emag_modules = list(
		/obj/item/borg/stun,
		/obj/item/experimental_dash,
		/obj/item/borg/apparatus/illegal
	)
	cyborg_base_icon = "tarkon"
	cyborg_icon_override = CYBORG_ICON_TARKON
	model_select_icon = "tarkon"
	model_select_alternate_icon = 'modular_zubbers/code/modules/silicons/borgs/sprites/screen_robot.dmi'
	model_traits = list(TRAIT_KNOW_ROBO_WIRES, TRAIT_RESEARCH_CYBORG)
	borg_skins = list(
		"Raptor" = list(
			SKIN_ICON_STATE = CYBORG_ICON_TYPE_RAPTOR,
			SKIN_ICON = CYBORG_ICON_TARKON_LARGE_BUBBER,
			SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE),
			RAPTOR_HAT_OFFSET
		)
	)


/obj/item/borg/upgrade/tarkon_medical
	name = "Tarkon Medical Module"
	desc = "Contains medical tools for first aid, diagnostics, and healing."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_tarkon"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/tarkon)
	model_flags = BORG_MODEL_TARKON
	items_to_add = list(
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
						)

/obj/item/borg/upgrade/tarkon_security
	name = "Tarkon Security Module"
	desc = "Provides enhanced lethal and non-lethal security options."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_tarkon"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/tarkon)
	model_flags = BORG_MODEL_TARKON
	items_to_add = list(
						)

/obj/item/borg/upgrade/tarkon_cargo
	name = "Tarkon Cargo Module"
	desc = "Provides basic manipulation equipment, and abilities such as stamps and paper dispensing."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_tarkon"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/tarkon)
	model_flags = BORG_MODEL_TARKON
	items_to_add = list(
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
						)

/obj/item/borg/upgrade/tarkon_utility // Lesser used on tarkon things like chef upgrades, janitorial, and mining.
	name = "Tarkon Utility Module"
	desc = "Adds multi-purpose tools, including cleaning supplies, and basic mining gear."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi's
	icon_state = "module_tarkon"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/tarkon)
	model_flags = BORG_MODEL_TARKON
	items_to_add = list(
						)
*/
