/datum/supply_pack/imports_medical
	access = NONE
	cost = PAYCHECK_LOWER
	group = "Medical" //figure this out later
	goody = TRUE
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/imports_medical/first_aid_kit_civil
	name = "Civil Defense First Aid Kit"
	contains = list(/obj/item/storage/medkit/civil_defense/stocked)
	cost = PAYCHECK_COMMAND * 2.5

/datum/supply_pack/imports_medical/first_aid_kit_comfort
	name = "Comfort First Aid Kit"
	contains = list(/obj/item/storage/medkit/civil_defense/comfort/stocked)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/imports_medical/first_aid_kit_frontier
	name = "Frontier First Aid Kit"
	contains = list(/obj/item/storage/medkit/frontier/stocked)
	cost = PAYCHECK_COMMAND * 3.5

/datum/supply_pack/imports_medical/first_aid_kit_combat_surgeon
	name = "Combat Surgeon First Aid Kit"
	contains = list(/obj/item/storage/medkit/combat_surgeon/stocked)
	cost = PAYCHECK_COMMAND * 3.5

/datum/supply_pack/imports_medical/first_aid_kit_robotics
	name = "Robotic Repair Kit"
	contains = list(/obj/item/storage/medkit/robotic_repair/stocked)
	cost = PAYCHECK_COMMAND * 3.5

/datum/supply_pack/imports_medical/first_aid_kit_premium_robotics
	name = "Premium Robotic Repair Kit"
	contains = list(/obj/item/storage/medkit/robotic_repair/preemo/stocked)
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/imports_medical/first_aid_kit_responder
	name = "First Responder Aid Kit"
	contains = list(/obj/item/storage/backpack/duffelbag/deforest_surgical/stocked)
	cost = PAYCHECK_COMMAND * 10.5

/datum/supply_pack/imports_medical/first_aid_kit_orange
	name = "Orange First Aid Kit" //check this later
	contains = list(/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked)
	cost = PAYCHECK_COMMAND * 9.5

/datum/supply_pack/imports_medical/first_aid_kit_technician
	name = "Technician First Aid Kit"
	contains = list(/obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked)
	cost = PAYCHECK_COMMAND * 11.75

/datum/supply_pack/imports_medical/coagulant
	name = "Coagulant"
	contains = list(/obj/item/stack/medical/suture/coagulant)

/datum/supply_pack/imports_medical/ointment_red_sun
	name = "Red Sun Ointment"
	contains = list(/obj/item/stack/medical/ointment/red_sun)

/datum/supply_pack/imports_medical/gauze_sterile
	name = "Sterile Gauze"
	contains = list(/obj/item/stack/medical/gauze/sterilized)

/datum/supply_pack/imports_medical/suture
	name = "Sutures"
	contains = list(/obj/item/stack/medical/suture)

/datum/supply_pack/imports_medical/ointment
	name = "Ointment"
	contains = list(/obj/item/stack/medical/ointment)

/datum/supply_pack/imports_medical/mesh
	name = "Regenerative Mesh"
	contains = list(/obj/item/stack/medical/mesh)

/datum/supply_pack/imports_medical/bandaid
	name = "Band-Aids"
	contains = list(/obj/item/storage/box/bandages)
	cost = PAYCHECK_CREW * 1.5

/datum/supply_pack/imports_medical/amollin
	name = "Amollin Painkillers"
	contains = list(/obj/item/storage/pill_bottle/painkiller)
	cost = PAYCHECK_CREW

/datum/supply_pack/imports_medical/synth_patch
	name = "Synth Repair Patch"
	contains = list(/obj/item/reagent_containers/applicator/pill/robotic_patch/synth_repair)
	cost = PAYCHECK_CREW

/datum/supply_pack/imports_medical/subdermal_splint
	name = "Subdermal Splint"
	contains = list(/obj/item/stack/medical/wound_recovery)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports_medical/rapid_coagulant
	name = "Rapid Coagulant"
	contains = list(/obj/item/stack/medical/wound_recovery/rapid_coagulant)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports_medical/robofoam
	name = "Robofoam" ///check later
	contains = list(/obj/item/stack/medical/wound_recovery/robofoam)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports_medical/super_robofoam
	name = "Super Robofoam"//check later
	contains = list(/obj/item/stack/medical/wound_recovery/robofoam_super)
	cost = PAYCHECK_COMMAND * 4


/datum/supply_pack/imports_medical/medpen
	cost = PAYCHECK_LOWER * 3

/datum/supply_pack/imports_medical/medpen/occuisate
	name = "Occuisate Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate)

/datum/supply_pack/imports_medical/medpen/morpital
	name = "Morpital Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate)

/datum/supply_pack/imports_medical/medpen/lipital
	name = "Lipital Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/lipital)

/datum/supply_pack/imports_medical/medpen/meridine
	name = "Meridine Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/meridine)

/datum/supply_pack/imports_medical/medpen/calopine
	name = "Calopine Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/calopine)

/datum/supply_pack/imports_medical/medpen/coagulants
	name = "Coagulant Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants)

/datum/supply_pack/imports_medical/medpen/lepoturi
	name = "Lepoturi Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi)

/datum/supply_pack/imports_medical/medpen/psifinil
	name = "Psifinil Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/psifinil)

/datum/supply_pack/imports_medical/medpen/halobinin
	name = "Halobinin Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin)

/datum/supply_pack/imports_medical/medpen/robosolder
	name = "Synth Liquid Solder Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/robot_liquid_solder)

/datum/supply_pack/imports_medical/medpen/robocleaner
	name = "Synth System Cleaner Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner)

/datum/supply_pack/imports_medical/medpen/pentibinin
	name = "Pentibinin Medpen"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin)
	contraband = TRUE

// Autoinjectors for fighting
/datum/supply_pack/imports_medical/combat_medpen
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports_medical/combat_medpen/adrenaline
	name = "Adrenaline Autoinjector"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline)

/datum/supply_pack/imports_medical/combat_medpen/synephrine
	name = "Synephrine Autoinjector"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/synephrine)

/datum/supply_pack/imports_medical/combat_medpen/krotozine
	name = "Krotozine Autoinjector"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/krotozine)

/datum/supply_pack/imports_medical/combat_medpen/aranepaine
	name = "Aranepaine Autoinjector"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/aranepaine)
	contraband = TRUE

/datum/supply_pack/imports_medical/combat_medpen/synalvipitol
	name = "Synalvipitol Autoinjector"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/synalvipitol)
	contraband = TRUE

/datum/supply_pack/imports_medical/combat_medpen/twitch
	name = "Twitch Autoinjector" //check this later
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/twitch)
	cost = PAYCHECK_COMMAND * 3
	contraband = TRUE

/datum/supply_pack/imports_medical/combat_medpen/demoneye
	name = "Demoneye Autoinjector"
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/demoneye)
	cost = PAYCHECK_COMMAND * 3
	contraband = TRUE

/datum/supply_pack/imports_medical/treatment_zone_projector
	name = "Medical Treatment Zone Projector"
	contains = list(/obj/item/holosign_creator/medical/treatment_zone)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports_medical/health_analyzer
	name = "Health Analyzer"
	contains = list(/obj/item/healthanalyzer)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports_medical/defibrillator
	name = "Defibrilator"
	contains = list(/obj/item/defibrillator/loaded)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports_medical/loaded_belt_defib
	name = "Belt Defibrilator"
	contains = list(/obj/item/defibrillator/compact/loaded)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports_medical/surgical_tools
	name = "Filled Surgical Tray"
	contains = list(/obj/item/surgery_tray/full)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports_medical/health_analyzer_advanced
	name = "Advanced Health Analyzer"
	contains = list(/obj/item/healthanalyzer/advanced)
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/imports_medical/defibrillator_penlite
	name = "Penlite Defibrilator Mount"
	contains = list(/obj/item/wallframe/defib_mount/charging)
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/deforest/equipment/penlite_defib_mount
	item_type = /obj/item/wallframe/defib_mount/charging
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/deforest/equipment/advanced_scalpel
	item_type = /obj/item/scalpel/advanced
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/deforest/equipment/advanced_retractor
	item_type = /obj/item/retractor/advanced
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/deforest/equipment/advanced_cautery
	item_type = /obj/item/cautery/advanced
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/deforest/equipment/advanced_blood_filter
	item_type = /obj/item/blood_filter/advanced
	cost = PAYCHECK_COMMAND * 9

/datum/armament_entry/company_import/deforest/equipment/medigun_upgrade
	item_type = /obj/item/device/custom_kit/medigun_fastcharge
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/deforest/equipment/hypospray_upgrade
	item_type = /obj/item/device/custom_kit/deluxe_hypo2
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/deforest/equipment/advanced_hypospray
	item_type = /obj/item/hypospray/mkii/piercing
	cost = PAYCHECK_COMMAND * 7

/datum/armament_entry/company_import/deforest/equipment/afad
	item_type = /obj/item/gun/medbeam/afad
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/deforest/equipment/medstation
	item_type = /obj/item/wallframe/frontier_medstation
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/deforest/equipment/medhud
	item_type = /obj/item/clothing/glasses/hud/health
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/deforest/equipment/medhud_night
	item_type = /obj/item/clothing/glasses/hud/health/night
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/deforest/equipment/medhud_night_sci
	item_type = /obj/item/clothing/glasses/hud/health/night/science
	cost = PAYCHECK_COMMAND * 6

/datum/armament_entry/company_import/deforest/equipment/hypospray_case
	item_type = /obj/item/storage/hypospraykit
	cost = PAYCHECK_LOWER * 2

/datum/armament_entry/company_import/deforest/equipment/hypospray
	item_type = /obj/item/hypospray/mkii
	cost = PAYCHECK_LOWER * 2

// Cybernetics and other things that go inside you

/datum/armament_entry/company_import/deforest/implant
	subcategory = "Cybernetics"

/datum/armament_entry/company_import/deforest/implant/surgery
	item_type = /obj/item/organ/cyberimp/arm/toolkit/surgery
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/deforest/implant/toolset
	item_type = /obj/item/organ/cyberimp/arm/toolkit/toolset
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/deforest/implant/botany
	item_type = /obj/item/organ/cyberimp/arm/toolkit/botany
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/deforest/implant/janitor
	item_type = /obj/item/organ/cyberimp/arm/toolkit/janitor
	cost = PAYCHECK_COMMAND * 5

// Modsuit Modules from the medical category, here instead of in Nakamura because nobody buys from this company

/datum/armament_entry/company_import/deforest/medical_modules
	subcategory = "MOD Medical Modules"
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/deforest/medical_modules/injector
	name = "MOD injector module"
	item_type = /obj/item/mod/module/injector

/datum/armament_entry/company_import/deforest/medical_modules/organizer
	name = "MOD organizer module"
	item_type = /obj/item/mod/module/organizer

/datum/armament_entry/company_import/deforest/medical_modules/patient_transport
	name = "MOD patient transport module"
	item_type = /obj/item/mod/module/criminalcapture/patienttransport

/datum/armament_entry/company_import/deforest/medical_modules/thread_ripper
	name = "MOD thread ripper module"
	item_type = /obj/item/mod/module/thread_ripper

/datum/armament_entry/company_import/deforest/medical_modules/surgical_processor
	name = "MOD surgical processor module"
	item_type = /obj/item/mod/module/surgical_processor

/datum/armament_entry/company_import/deforest/medical_modules/defibrillator
	name = "MOD defibrillator module"
	item_type = /obj/item/mod/module/defibrillator

