/datum/mod_theme/responsory/ancient_milsim
	armor_type = /datum/armor/armor_sf_hardened

/obj/item/mod/control/pre_equipped/responsory/milsim
	theme = /datum/mod_theme/responsory/ancient_milsim
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null

/obj/item/mod/control/pre_equipped/responsory/milsim/mechanic
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/medhud,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/medhud,
	)
	insignia_type = /obj/item/mod/module/insignia/milsim_mechanic
	additional_modules = /obj/item/mod/module/dispenser/ancient_milsim/mechanic

/obj/item/mod/control/pre_equipped/responsory/milsim/trapper
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/thermal,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/thermal,
	)
	insignia_type = /obj/item/mod/module/insignia/milsim_trapper
	additional_modules = /obj/item/mod/module/dispenser/ancient_milsim/trapper

/obj/item/mod/control/pre_equipped/responsory/milsim/marksman
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/visor/night,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/visor/night,
	)
	insignia_type = /obj/item/mod/module/insignia/milsim_marksman
	additional_modules = /obj/item/mod/module/dispenser/ancient_milsim/marksman

/obj/item/mod/control/pre_equipped/responsory/milsim/medic
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/medhud,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/medhud,
	)
	insignia_type = /obj/item/mod/module/insignia/milsim_medic
	additional_modules = /obj/item/mod/module/dispenser/ancient_milsim/medic

/obj/item/mod/control/pre_equipped/responsory/milsim/sentinel
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/visor/night,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/visor/night,
	)
	insignia_type = /obj/item/mod/module/insignia/milsim_sentinel
	additional_modules = /obj/item/mod/module/dispenser/ancient_milsim/sentinel

/obj/item/mod/control/pre_equipped/responsory/milsim/trooper
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/visor/night,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/visor/night,
	)
	insignia_type = /obj/item/mod/module/insignia/milsim_trooper
	additional_modules = /obj/item/mod/module/dispenser/ancient_milsim/trooper

/obj/item/mod/module/dispenser/ancient_milsim
	removable = FALSE
	var/first_use = TRUE
	var/new_dispense_type = /obj/item/food/burger/tofu
	var/new_cooldown_time = 2 SECONDS

/obj/item/mod/module/dispenser/ancient_milsim/on_use()
	. = ..()
	if(first_use)
		first_use = FALSE
		cooldown_time = new_cooldown_time
		dispense_type = new_dispense_type

/obj/item/mod/module/dispenser/ancient_milsim/mechanic
	name = "MOD alien tools-cable dispenser module"
	desc = "This module can create set of advanced tools and additional cable coils at the user's liking."
	dispense_type = /obj/item/storage/belt/military/abductor/full
	cooldown_time = 5 SECONDS
	new_dispense_type = /obj/item/stack/cable_coil
	new_cooldown_time = 15 SECONDS

/obj/item/mod/module/dispenser/ancient_milsim/trapper
	name = "MOD chameleon projector-stealth landmines dispenser module"
	desc = "This module can create a chameleon projector and additional stealth landmines at the user's liking."
	dispense_type = /obj/item/chameleon
	cooldown_time = 10 SECONDS
	new_dispense_type = /obj/item/minespawner/ancient_milsim
	new_cooldown_time = 10 SECONDS

/obj/item/mod/module/dispenser/ancient_milsim/marksman
	name = "MOD barricade box-throwing knives dispenser module"
	desc = "This module can create a box of barricades and additional throwing knives at the user's liking."
	dispense_type = /obj/item/storage/barricade
	cooldown_time = 15 SECONDS
	new_dispense_type = /obj/item/knife/combat/marksman
	new_cooldown_time = 5 SECONDS

/obj/item/mod/module/dispenser/ancient_milsim/medic
	name = "MOD custom hypospray-hypospray vials dispenser module"
	desc = "This module can create a single combat hypospray and additional cartridges at the user's liking."
	dispense_type = /obj/item/hypospray/mkii/deluxe/cmo/combat/ancient_milsim
	cooldown_time = 5 SECONDS
	new_dispense_type = /obj/item/reagent_containers/cup/vial/large/ancient_milsim
	new_cooldown_time = 15 SECONDS

/obj/item/hypospray/mkii/deluxe/cmo/combat/ancient_milsim
	start_vial = /obj/item/reagent_containers/cup/vial/large/ancient_milsim

/obj/item/reagent_containers/cup/vial/large/ancient_milsim
	name = "All-Heal-Virtual"
	icon_state = "hypoviallarge-buff"
	list_reagents = list(
		/datum/reagent/medicine/muscle_stimulant = 15,
		/datum/reagent/medicine/regen_jelly = 30,
		/datum/reagent/iron = 25,
		/datum/reagent/medicine/coagulant = 15,
		/datum/reagent/medicine/c2/penthrite = 15,
	)

/obj/item/mod/module/dispenser/ancient_milsim/sentinel
	name = "MOD stationary machinegun-machinegun ammo box module"
	desc = "This module can create a single disassembled heavy machinegun and additional ammo boxes at the user's liking."
	dispense_type = /obj/item/mounted_machine_gun_folded
	cooldown_time = 15 SECONDS
	new_dispense_type = /obj/item/ammo_box/magazine/mmg_box
	new_cooldown_time = 15 SECONDS

/obj/item/mod/module/dispenser/ancient_milsim/trooper
	name = "MOD Sol rifle-Sol rifle magazine dispenser module"
	desc = "This module can create a single .40 Sol caliber assault rifle and additional magazines at the user's liking."
	dispense_type = /obj/item/gun/ballistic/automatic/sol_rifle/evil
	cooldown_time = 25 SECONDS
	new_dispense_type = /obj/item/ammo_box/magazine/c40sol_rifle/standard
	new_cooldown_time = 15 SECONDS

/obj/item/mod/module/insignia/milsim_mechanic
	color = "#ff7300"

/obj/item/mod/module/insignia/milsim_trapper
	color = "#372297"

/obj/item/mod/module/insignia/milsim_marksman
	color = "#a01d1d"

/obj/item/mod/module/insignia/milsim_medic
	color = "#2fdab4"

/obj/item/mod/module/insignia/milsim_saboteur
	color = "#1eff00"

/obj/item/mod/module/insignia/milsim_sentinel
	color = "#b536c0"

/obj/item/mod/module/insignia/milsim_trooper
	color = "#7e7e7e"
