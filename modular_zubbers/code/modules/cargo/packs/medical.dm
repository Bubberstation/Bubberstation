/datum/supply_pack/medical
	auto_name = TRUE

/datum/supply_pack/medical/kinetics
	name = "Kinetic Prosthetic Limbs Crate"
	desc = "Contains two sets of four kinetic prosthetic limbs to provide a \
		simpler alternative to advanced prosthetics."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/bodypart/arm/left/kinetic = 2,
		/obj/item/bodypart/arm/right/kinetic = 2,
		/obj/item/bodypart/leg/left/kinetic = 2,
		/obj/item/bodypart/leg/right/kinetic = 2,
	)
	crate_name = "kinetics crate"
	crate_type = /obj/structure/closet/crate/medical
	auto_name = FALSE

/datum/supply_pack/medical/first_aid_kit_civil
	contains = list(/obj/item/storage/medkit/civil_defense/stocked)
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/medical/first_aid_kit_comfort
	contains = list(/obj/item/storage/medkit/civil_defense/comfort/stocked)
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/medical/first_aid_kit_frontier
	contains = list(/obj/item/storage/medkit/frontier/stocked)
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/medical/first_aid_kit_combat_surgeon
	contains = list(/obj/item/storage/medkit/combat_surgeon/stocked)
	cost = PAYCHECK_COMMAND * 10.7

/datum/supply_pack/medical/first_aid_kit_robotics
	contains = list(/obj/item/storage/medkit/robotic_repair/stocked)
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/medical/first_aid_kit_premium_robotics
	contains = list(/obj/item/storage/medkit/robotic_repair/preemo/stocked)
	cost = PAYCHECK_COMMAND * 15

/datum/supply_pack/medical/first_aid_kit_responder
	contains = list(/obj/item/storage/backpack/duffelbag/deforest_surgical/stocked)
	cost = PAYCHECK_COMMAND * 14

/datum/supply_pack/medical/first_aid_kit_orange
	contains = list(/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked)
	cost = PAYCHECK_COMMAND * 24.2

/datum/supply_pack/medical/first_aid_kit_technician
	contains = list(/obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked)
	cost = PAYCHECK_COMMAND * 24.2

/datum/supply_pack/medical/coagulant
	contains = list(/obj/item/stack/medical/suture/coagulant)
	cost = PAYCHECK_CREW * 1.8

/datum/supply_pack/medical/ointment_red_sun
	contains = list(/obj/item/stack/medical/ointment/red_sun)
	cost = PAYCHECK_CREW * 0.75

/datum/supply_pack/medical/gauze_sterile
	contains = list(/obj/item/stack/medical/gauze/sterilized)
	cost = PAYCHECK_CREW * 1.8

/datum/supply_pack/medical/suture
	contains = list(/obj/item/stack/medical/suture)
	cost = PAYCHECK_CREW * 1.4

/datum/supply_pack/medical/ointment
	contains = list(/obj/item/stack/medical/ointment)
	cost = PAYCHECK_CREW * 1.4

/datum/supply_pack/medical/mesh
	contains = list(/obj/item/stack/medical/mesh)
	cost = PAYCHECK_CREW * 1.4

/datum/supply_pack/medical/bandaid
	contains = list(/obj/item/storage/box/bandages)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/medical/amollin
	contains = list(/obj/item/storage/pill_bottle/painkiller)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/medical/synth_patch
	contains = list(/obj/item/reagent_containers/applicator/pill/robotic_patch/synth_repair)
	cost = PAYCHECK_CREW * 0.75

/datum/supply_pack/medical/subdermal_splint
	contains = list(/obj/item/stack/medical/wound_recovery)
	cost = PAYCHECK_CREW * 6.5

/datum/supply_pack/medical/rapid_coagulant
	contains = list(/obj/item/stack/medical/wound_recovery/rapid_coagulant)
	cost = PAYCHECK_CREW * 6.5

/datum/supply_pack/medical/robofoam
	contains = list(/obj/item/stack/medical/wound_recovery/robofoam)
	cost = PAYCHECK_CREW * 6.5

/datum/supply_pack/medical/super_robofoam
	contains = list(/obj/item/stack/medical/wound_recovery/robofoam_super)
	cost = PAYCHECK_CREW * 7


/datum/supply_pack/medical/medpen
	cost = PAYCHECK_CREW * 2.4

/datum/supply_pack/medical/medpen/occuisate
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate)

/datum/supply_pack/medical/medpen/morpital
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate)

/datum/supply_pack/medical/medpen/lipital
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/lipital)

/datum/supply_pack/medical/medpen/meridine
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/meridine)

/datum/supply_pack/medical/medpen/calopine
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/calopine)

/datum/supply_pack/medical/medpen/coagulants
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants)

/datum/supply_pack/medical/medpen/lepoturi
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi)

/datum/supply_pack/medical/medpen/psifinil
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/psifinil)

/datum/supply_pack/medical/medpen/halobinin
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin)

/datum/supply_pack/medical/medpen/robosolder
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/robot_liquid_solder)

/datum/supply_pack/medical/medpen/robocleaner
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner)

/datum/supply_pack/medical/medpen/pentibinin
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin)
	order_flags = ORDER_CONTRABAND

// Autoinjectors for fighting
/datum/supply_pack/medical/combat_medpen
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/medical/combat_medpen/adrenaline
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline)

/datum/supply_pack/medical/combat_medpen/synephrine
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/synephrine)

/datum/supply_pack/medical/combat_medpen/krotozine
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/krotozine)

/datum/supply_pack/medical/combat_medpen/aranepaine
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/aranepaine)
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/medical/combat_medpen/synalvipitol
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/synalvipitol)
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/medical/combat_medpen/twitch
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/twitch)
	cost = PAYCHECK_COMMAND * 3
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/medical/combat_medpen/demoneye
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/demoneye)
	cost = PAYCHECK_COMMAND * 3
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/medical/treatment_zone_projector
	contains = list(/obj/item/holosign_creator/medical/treatment_zone)
	cost = PAYCHECK_COMMAND * 0.25

/datum/supply_pack/medical/health_analyzer
	contains = list(/obj/item/healthanalyzer)
	cost = PAYCHECK_COMMAND * 1.4

/datum/supply_pack/medical/defibrillator
	contains = list(/obj/item/defibrillator/loaded)
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/medical/loaded_belt_defib
	contains = list(/obj/item/defibrillator/compact/loaded)
	cost = PAYCHECK_COMMAND * 9

/datum/supply_pack/medical/surgical_tools
	contains = list(/obj/item/surgery_tray/full)
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/medical/health_analyzer_advanced
	contains = list(/obj/item/healthanalyzer/advanced)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/medical/defibrillator_penlite
	contains = list(/obj/item/wallframe/defib_mount/charging)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/medical/advanced_scalpel
	contains = list(/obj/item/scalpel/advanced)
	cost = PAYCHECK_COMMAND * 10.25

/datum/supply_pack/medical/advanced_retractor
	contains = list(/obj/item/retractor/advanced)
	cost = PAYCHECK_COMMAND * 9

/datum/supply_pack/medical/advanced_cautery
	contains = list(/obj/item/cautery/advanced)
	cost = PAYCHECK_COMMAND * 9

/datum/supply_pack/medical/advanced_blood_filter
	contains = list(/obj/item/blood_filter/advanced)
	cost = PAYCHECK_COMMAND * 9

/datum/supply_pack/medical/medigun_upgrade
	contains = list(/obj/item/device/custom_kit/medigun_fastcharge)
	cost = PAYCHECK_COMMAND * 12

/datum/supply_pack/medical/hypospray_upgrade
	contains = list(/obj/item/device/custom_kit/deluxe_hypo2)
	cost = PAYCHECK_COMMAND * 4.5

/datum/supply_pack/medical/advanced_hypospray
	contains = list(/obj/item/hypospray/mkii/piercing)
	cost = PAYCHECK_COMMAND * 7

/datum/supply_pack/medical/afad
	contains = list(/obj/item/gun/medbeam/afad)
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/medical/medstation
	contains = list(/obj/item/wallframe/frontier_medstation)
	cost = PAYCHECK_COMMAND * 12

/datum/supply_pack/medical/medhud
	contains = list(/obj/item/clothing/glasses/hud/health)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/medical/medhud_night
	contains = list(/obj/item/clothing/glasses/hud/health/night)
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/medical/medhud_night_sci
	contains = list(/obj/item/clothing/glasses/hud/health/night/science)
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/medical/hypospray_case
	contains = list(/obj/item/storage/hypospraykit)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/medical/hypospray
	contains = list(/obj/item/hypospray/mkii)
	cost = PAYCHECK_COMMAND * 4

// Cybernetics and other things that go inside you

/datum/supply_pack/medical/implant
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/medical/implant/surgery
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/surgery)

/datum/supply_pack/medical/implant/toolset
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/toolset)

/datum/supply_pack/medical/implant/botany
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/botany)

/datum/supply_pack/medical/implant/janitor
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/janitor)

/datum/supply_pack/medical/medpod
	contains = list(/obj/item/survivalcapsule/medical)
	cost = PAYCHECK_COMMAND * 40

/datum/supply_pack/medical/chempod
	contains = list(/obj/item/survivalcapsule/chemistry)
	cost = PAYCHECK_COMMAND * 20
