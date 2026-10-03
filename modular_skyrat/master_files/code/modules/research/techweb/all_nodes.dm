
// NEW NODES

/datum/techweb_node/adv_vision
	display_name = "Combat Cybernetic Eyes"
	description = "Military grade combat implants to improve vision."
	prerequisite_nodes = list(/datum/techweb_node/cyber/combat_implants, /datum/techweb_node/alien/surgery)
	unlocked_designs = list(
		/datum/design/cyberimp_thermals,
		/datum/design/cyberimp_xray,
		/datum/design/cyberimp_thermals/moth,
		/datum/design/cyberimp_xray/moth,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/borg_shapeshifter
	display_name = "Illegal Cyborg Addition"
	description = "Some sort of experimental tool that was once used by an rival company."
	prerequisite_nodes = list(/datum/techweb_node/syndicate_basic)
	unlocked_designs = list(/datum/design/borg_shapeshifter_module)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/ayy_cyber_implants
	display_name = "Alien Cybernetic Implants"
	description = "The best in cybernetic implants."
	prerequisite_nodes = list(/datum/techweb_node/alien/surgery, /datum/techweb_node/alien/engi)
	unlocked_designs = list(
		/datum/design/cyberimp_surgical/alien,
		/datum/design/cyberimp_toolset/alien,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
/datum/techweb_node/android_chassis
	display_name = "Android Technology"
	description = "Shiny parts for your shiny friends!"
	prerequisite_nodes = list(/datum/techweb_node/robotics)
	unlocked_designs = list(
		/datum/design/synth_head,
		/datum/design/synth_chest,
		/datum/design/synth_l_arm,
		/datum/design/synth_r_arm,
		/datum/design/synth_l_leg,
		/datum/design/synth_r_leg,
		/datum/design/synth_l_d_leg,
		/datum/design/synth_r_d_leg,
	)

/datum/techweb_node/android_organs
	display_name = "Android Organs"
	description = "Internal Mechanisms for Synthetics and IPC's."
	prerequisite_nodes = list(/datum/techweb_node/robotics)
	unlocked_designs = list(
		/datum/design/synth_eyes,
		/datum/design/synth_tongue,
		/datum/design/synth_liver,
		/datum/design/synth_heatsink,
		/datum/design/synth_stomach,
		/datum/design/synth_ears,
		/datum/design/synth_heart,
	)

// MODULAR ADDITIONS AND REMOVALS

//Base Nodes
/datum/techweb_node/atmos/New()
	unlocked_designs += list(
		/datum/design/vox_gas_filter,
	)
	return ..()

/datum/techweb_node/construction/New()
	unlocked_designs += list(
		/datum/design/polarizer,
		/datum/design/rcd_loaded,
		/datum/design/rcd_ammo,
		/datum/design/rtd_loaded,
		/datum/design/welding_mask,
		/datum/design/magboots,
		/datum/design/board/flatpacker,
	)
	return ..()

/datum/techweb_node/office_equip/New()
	unlocked_designs += list(
		/datum/design/board/gbp_machine,
		/datum/design/plastic_hair_tie,
		/datum/design/umbrella,
	)
	return ..()

/datum/techweb_node/augmentation/New()
	unlocked_designs += list(
		/datum/design/affection_module,
		/datum/design/borg_upgrade_artistic,
	)
	return ..()

/datum/techweb_node/medbay_equip/New()
	unlocked_designs += list(
		/datum/design/hospital_gown,
		/datum/design/breath_machine,
		/datum/design/smartdartgun,
	)
	return ..()

/////////////////////////Biotech/////////////////////////

/datum/techweb_node/medbay_equip_adv/New()
	unlocked_designs += list(
		/datum/design/monkey_helmet,
		/datum/design/medicell/brute2,
		/datum/design/medicell/burn2,
		/datum/design/medicell/toxin2,
		/datum/design/medicell/oxy2,
		/datum/design/medicell/utility/relocation,
		/datum/design/medicell/utility/temp,
		/datum/design/medicell/utility/body,
		/datum/design/medicell/utility/clot,
	)
	return ..()

/////////////////////////EMP tech/////////////////////////

/datum/techweb_node/energy_manipulation/New()
	unlocked_designs += list(
		/datum/design/medicell/utility/gown,
		/datum/design/medicell/utility/bed,
		/datum/design/tray_goggles_prescription,
	)
	return ..()

////////////////////////Computer tech////////////////////////

/datum/techweb_node/hud/New()
	unlocked_designs += list(
		/datum/design/health_hud_prescription,
		/datum/design/security_hud_prescription,
		/datum/design/diagnostic_hud_prescription,
		/datum/design/science_hud_prescription,
		/datum/design/health_hud_aviator,
		/datum/design/security_hud_aviator,
		/datum/design/diagnostic_hud_aviator,
		/datum/design/meson_hud_aviator,
		/datum/design/science_hud_aviator,
		/datum/design/health_hud_projector,
		/datum/design/security_hud_projector,
		/datum/design/diagnostic_hud_projector,
		/datum/design/meson_hud_projector,
		/datum/design/science_hud_projector,
		/datum/design/civilian_hud,
		/datum/design/nifsoft_money_sense,
		/datum/design/nif_hud_kit,
		/datum/design/nifsoft_hud/science,
		/datum/design/nifsoft_hud/meson,
		/datum/design/nifsoft_hud/medical,
		/datum/design/nifsoft_hud/security,
		/datum/design/nifsoft_hud/diagnostic,
		/datum/design/nifsoft_hud/cargo,
		/datum/design/permit_hud,
	)

	unlocked_designs -= list(
		/datum/design/cyberimp_medical_hud,
		/datum/design/cyberimp_diagnostic_hud,
		/datum/design/cyberimp_security_hud,
	)
	return ..()

////////////////////////Medical////////////////////////

/datum/techweb_node/medbay_equip/New()
	unlocked_designs += list(
		/datum/design/board/self_actualization_device,
	)
	return ..()

/datum/techweb_node/cyber/cyber_organs/New()
	unlocked_designs += list(
		/datum/design/cybernetic_tongue,
		/datum/design/cybernetic_tongue/lizard,
	)
	return ..()

/datum/techweb_node/chem_synthesis/New()
	unlocked_designs += list(
		/datum/design/plumbing_eng,
	)
	return ..()

// Modularly removes x-ray and thermals from here, it's in adv_vision instead
/datum/techweb_node/cyber/cyber_organs_adv/New()
	unlocked_designs -= list(
		/datum/design/cyberimp_thermals,
		/datum/design/cyberimp_xray,
		/datum/design/cyberimp_thermals/moth,
		/datum/design/cyberimp_xray/moth,
	)
	return ..()

////////////////////////Tools////////////////////////

/datum/techweb_node/hydroponics/New()
	unlocked_designs += list(
		/datum/design/medicell/utility/salve,
	)
	return ..()

/datum/techweb_node/sec_equip/New()
	unlocked_designs += list(
		/datum/design/nifsoft_remover,
	)
	return ..()

/////////////////////////weaponry tech/////////////////////////


/datum/techweb_node/electric_weapons/New()
	unlocked_designs += list(
		/datum/design/medigun_speedkit,
	)
	return ..()

////////////////////////Alien technology////////////////////////

/datum/techweb_node/alien_surgery/New()
	unlocked_designs += list(
		/datum/design/medicell/brute3,
		/datum/design/medicell/burn3,
		/datum/design/medicell/oxy3,
		/datum/design/surgical_processor,
		/datum/design/medicell/toxin3,
	)
	return ..()

/////////////////////////engineering tech/////////////////////////

/datum/techweb_node/fusion/New()
	unlocked_designs += list(
		/datum/design/engine_goggles_prescription,
	)
	return ..()

/datum/techweb_node/exp_tools/New()
	unlocked_designs += list(
		/datum/design/board/cell_charger_multi,
		/datum/design/board/megacell_charger,
	)

	unlocked_designs -= list(
		/datum/design/rcd_loaded,
		/datum/design/rcd_ammo,
		/datum/design/rtd_loaded,
		/datum/design/welding_mask,
		/datum/design/magboots,
		/datum/design/board/flatpacker,
	)
	return ..()

/datum/techweb_node/mining/New()
	unlocked_designs += list(
		/datum/design/mesons_prescription,
	)
	return ..()

/////////////////////////robotics tech/////////////////////////
/datum/techweb_node/robotics/New()
	unlocked_designs += list(
		/datum/design/borg_snack_dispenser,
		/datum/design/mini_soulcatcher,
	)
	return ..()

/datum/techweb_node/passive_implants/New()
	unlocked_designs += list(
		/datum/design/soulcatcher_device,
		/datum/design/rsd_interface,
	)
	return ..()

/datum/techweb_node/borg_utility/New()
	unlocked_designs += list(
		/datum/design/borg_upgrade_clamp,
		/datum/design/borg_upgrade_cargo_tele,
		/datum/design/borg_upgrade_forging,
	)
	return ..()

/datum/techweb_node/borg_engi/New()
	unlocked_designs += list(
		/datum/design/advanced_materials
	)
	return ..()

/datum/techweb_node/borg_medical/New()
	unlocked_designs += list(
		/datum/design/borg_upgrade_surgicaltools,
	)
	unlocked_designs -= list(
		/datum/design/borg_upgrade_pinpointer,
	)
	return ..()
