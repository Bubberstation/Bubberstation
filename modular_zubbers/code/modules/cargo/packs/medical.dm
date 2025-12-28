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
/datum/supply_pack/imports/medical
	access = NONE
	group = "Medical" //figure this out later
	goody = TRUE
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/imports/medical/first_aid_kit_civil
	name = "Civil Defense First Aid Kit"
	contains = list(/obj/item/storage/medkit/civil_defense/stocked)
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/imports/medical/first_aid_kit_comfort
	name = "Comfort First Aid Kit"
	contains = list(/obj/item/storage/medkit/civil_defense/comfort/stocked)
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/imports/medical/first_aid_kit_frontier
	name = "Frontier First Aid Kit"
	contains = list(/obj/item/storage/medkit/frontier/stocked)
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/imports/medical/first_aid_kit_combat_surgeon
	name = "Combat Surgeon First Aid Kit"
	contains = list(/obj/item/storage/medkit/combat_surgeon/stocked)
	cost = PAYCHECK_COMMAND * 10.7

/datum/supply_pack/imports/medical/first_aid_kit_robotics
	name = "Robotic Repair Kit"
	contains = list(/obj/item/storage/medkit/robotic_repair/stocked)
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/imports/medical/first_aid_kit_premium_robotics
	name = "Premium Robotic Repair Kit"
	contains = list(/obj/item/storage/medkit/robotic_repair/preemo/stocked)
	cost = PAYCHECK_COMMAND * 15

/datum/supply_pack/imports/medical/first_aid_kit_responder
	name = "First Responder Aid Kit"
	contains = list(/obj/item/storage/backpack/duffelbag/deforest_surgical/stocked)
	cost = PAYCHECK_COMMAND * 14

/datum/supply_pack/imports/medical/first_aid_kit_orange
	name = "Orange First Aid Kit" //check this later
	contains = list(/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked)
	cost = PAYCHECK_COMMAND * 24.2

/datum/supply_pack/imports/medical/first_aid_kit_technician
	name = "Technician First Aid Kit"
	contains = list(/obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked)
	cost = PAYCHECK_COMMAND * 24.2

/datum/supply_pack/imports/medical/coagulant
	name = "Coagulant"
	contains = list(/obj/item/stack/medical/suture/coagulant)
	cost = PAYCHECK_CREW * 1.8

/datum/supply_pack/imports/medical/ointment_red_sun
	name = "Red Sun Ointment"
	contains = list(/obj/item/stack/medical/ointment/red_sun)
	cost = PAYCHECK_CREW * 0.75

/datum/supply_pack/imports/medical/gauze_sterile
	name = "Sterile Gauze"
	contains = list(/obj/item/stack/medical/gauze/sterilized)
	cost = PAYCHECK_CREW * 1.8

/datum/supply_pack/imports/medical/suture
	name = "Sutures"
	contains = list(/obj/item/stack/medical/suture)
	cost = PAYCHECK_CREW * 1.4

/datum/supply_pack/imports/medical/ointment
	name = "Ointment"
	contains = list(/obj/item/stack/medical/ointment)
	cost = PAYCHECK_CREW * 1.4

/datum/supply_pack/imports/medical/mesh
	name = "Regenerative Mesh"
	contains = list(/obj/item/stack/medical/mesh)
	cost = PAYCHECK_CREW * 1.4

/datum/supply_pack/imports/medical/bandaid
	name = "Band-Aids"
	contains = list(/obj/item/storage/box/bandages)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/imports/medical/amollin
	name = "Amollin Painkillers"
	contains = list(/obj/item/storage/pill_bottle/painkiller)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/imports/medical/synth_patch
	name = "Synth Repair Patch"
	contains = list(/obj/item/reagent_containers/applicator/pill/robotic_patch/synth_repair)
	cost = PAYCHECK_CREW * 0.75

/datum/supply_pack/imports/medical/subdermal_splint
	name = "Subdermal Splint"
	contains = list(/obj/item/stack/medical/wound_recovery)
	cost = PAYCHECK_CREW * 6.5

/datum/supply_pack/imports/medical/rapid_coagulant
	name = "Rapid Coagulant"
	contains = list(/obj/item/stack/medical/wound_recovery/rapid_coagulant)
	cost = PAYCHECK_CREW * 6.5

/datum/supply_pack/imports/medical/robofoam
	name = "Robofoam" ///check later
	contains = list(/obj/item/stack/medical/wound_recovery/robofoam)
	cost = PAYCHECK_CREW * 6.5

/datum/supply_pack/imports/medical/super_robofoam
	name = "Super Robofoam"//check later
	contains = list(/obj/item/stack/medical/wound_recovery/robofoam_super)
	cost = PAYCHECK_CREW * 7


/datum/supply_pack/imports/medical/medpen
	cost = PAYCHECK_CREW * 2.4

/datum/supply_pack/imports/medical/medpen/occuisate
	name = "Occuisate Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate)

/datum/supply_pack/imports/medical/medpen/morpital
	name = "Morpital Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate)

/datum/supply_pack/imports/medical/medpen/lipital
	name = "Lipital Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/lipital)

/datum/supply_pack/imports/medical/medpen/meridine
	name = "Meridine Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/meridine)

/datum/supply_pack/imports/medical/medpen/calopine
	name = "Calopine Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/calopine)

/datum/supply_pack/imports/medical/medpen/coagulants
	name = "Coagulant Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants)

/datum/supply_pack/imports/medical/medpen/lepoturi
	name = "Lepoturi Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi)

/datum/supply_pack/imports/medical/medpen/psifinil
	name = "Psifinil Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/psifinil)

/datum/supply_pack/imports/medical/medpen/halobinin
	name = "Halobinin Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin)

/datum/supply_pack/imports/medical/medpen/robosolder
	name = "Synth Liquid Solder Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/robot_liquid_solder)

/datum/supply_pack/imports/medical/medpen/robocleaner
	name = "Synth System Cleaner Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner)

/datum/supply_pack/imports/medical/medpen/pentibinin
	name = "Pentibinin Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin)
	contraband = TRUE

// Autoinjectors for fighting
/datum/supply_pack/imports/medical/combat_medpen
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports/medical/combat_medpen/adrenaline
	name = "Adrenaline Autoinjector"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline)

/datum/supply_pack/imports/medical/combat_medpen/synephrine
	name = "Synephrine Autoinjector"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/synephrine)

/datum/supply_pack/imports/medical/combat_medpen/krotozine
	name = "Krotozine Autoinjector"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/krotozine)

/datum/supply_pack/imports/medical/combat_medpen/aranepaine
	name = "Aranepaine Autoinjector"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/aranepaine)
	contraband = TRUE

/datum/supply_pack/imports/medical/combat_medpen/synalvipitol
	name = "Synalvipitol Autoinjector"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/synalvipitol)
	contraband = TRUE

/datum/supply_pack/imports/medical/combat_medpen/twitch
	name = "Twitch Autoinjector" //check this later
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/twitch)
	cost = PAYCHECK_COMMAND * 3
	contraband = TRUE

/datum/supply_pack/imports/medical/combat_medpen/demoneye
	name = "Demoneye Autoinjector"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/demoneye)
	cost = PAYCHECK_COMMAND * 3
	contraband = TRUE

/datum/supply_pack/imports/medical/treatment_zone_projector
	name = "Medical Treatment Zone Projector"
	contains = list(/obj/item/holosign_creator/medical/treatment_zone)
	cost = PAYCHECK_COMMAND * 0.25

/datum/supply_pack/imports/medical/health_analyzer
	name = "Health Analyzer"
	contains = list(/obj/item/healthanalyzer)
	cost = PAYCHECK_COMMAND * 1.4

/datum/supply_pack/imports/medical/defibrillator
	name = "Defibrilator"
	contains = list(/obj/item/defibrillator/loaded)
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/imports/medical/loaded_belt_defib
	name = "Belt Defibrilator"
	contains = list(/obj/item/defibrillator/compact/loaded)
	cost = PAYCHECK_COMMAND * 9

/datum/supply_pack/imports/medical/surgical_tools
	name = "Filled Surgical Tray"
	contains = list(/obj/item/surgery_tray/full)
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/imports/medical/health_analyzer_advanced
	name = "Advanced Health Analyzer"
	contains = list(/obj/item/healthanalyzer/advanced)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/imports/medical/defibrillator_penlite
	name = "Penlite Defibrilator Mount"
	contains = list(/obj/item/wallframe/defib_mount/charging)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/medical/advanced_scalpel
	name = "Advanced Scalpel"
	contains = list(/obj/item/scalpel/advanced)
	cost = PAYCHECK_COMMAND * 10.25

/datum/supply_pack/imports/medical/advanced_retractor
	name = "Advanced Retractor"
	contains = list(/obj/item/retractor/advanced)
	cost = PAYCHECK_COMMAND * 9

/datum/supply_pack/imports/medical/advanced_cautery
	name = "Advanced Cautery"
	contains = list(/obj/item/cautery/advanced)
	cost = PAYCHECK_COMMAND * 9

/datum/supply_pack/imports/medical/advanced_blood_filter
	name = "Advanced Blood Filter"
	contains = list(/obj/item/blood_filter/advanced)
	cost = PAYCHECK_COMMAND * 9

/datum/supply_pack/imports/medical/medigun_upgrade
	name = "Fast-Charge Medigun Upgrade"
	contains = list(/obj/item/device/custom_kit/medigun_fastcharge)
	cost = PAYCHECK_COMMAND * 12

/datum/supply_pack/imports/medical/hypospray_upgrade
	name = "Hypospray Upgrade"
	contains = list(/obj/item/device/custom_kit/deluxe_hypo2)
	cost = PAYCHECK_COMMAND * 4.5

/datum/supply_pack/imports/medical/advanced_hypospray
	name = "Advanced Hypospray"
	contains = list(/obj/item/hypospray/mkii/piercing)
	cost = PAYCHECK_COMMAND * 7

/datum/supply_pack/imports/medical/afad
	name = "AFAD Medbeam" //check this later
	contains = list(/obj/item/gun/medbeam/afad)
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/imports/medical/medstation
	name = "Wallmounted Medstation"
	contains = list(/obj/item/wallframe/frontier_medstation)
	cost = PAYCHECK_COMMAND * 12

/datum/supply_pack/imports/medical/medhud
	name = "Medical HUD"
	contains = list(/obj/item/clothing/glasses/hud/health)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/medical/medhud_night
	name = "Night-Vision Medical HUD"
	contains = list(/obj/item/clothing/glasses/hud/health/night)
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/imports/medical/medhud_night_sci
	name = "Night-Vision Reagent Medical HUD"
	contains = list(/obj/item/clothing/glasses/hud/health/night/science)
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/imports/medical/hypospray_case
	name = "Hypospray Kit"
	contains = list(/obj/item/storage/hypospraykit)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/medical/hypospray
	name = "MkII Hypospray"
	contains = list(/obj/item/hypospray/mkii)
	cost = PAYCHECK_COMMAND * 4

// Cybernetics and other things that go inside you

/datum/supply_pack/imports/medical/implant
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/imports/medical/implant/surgery
	name = "Surgery Toolset Implant"
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/surgery)

/datum/supply_pack/imports/medical/implant/toolset
	name = "Engineering Toolset Implant"
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/toolset)

/datum/supply_pack/imports/medical/implant/botany
	name = "Botany Toolset Implant"
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/botany)

/datum/supply_pack/imports/medical/implant/janitor
	name = "Janitor Toolset Implant"
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/janitor)

/datum/supply_pack/imports/medical/implant/paperwork
	name = "Janitor Toolset Implant"
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/paperwork)
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/imports/medical/medpod
	name = "Medical Pod Capsule"
	contains = list(/obj/item/survivalcapsule/medical)
	cost = PAYCHECK_COMMAND * 40

/datum/supply_pack/imports/medical/chempod
	name = "Chemistry Pod Capsule"
	contains = list(/obj/item/survivalcapsule/chemistry)
	cost = PAYCHECK_COMMAND * 20
