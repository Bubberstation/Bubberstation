/datum/supply_pack/company_import/deforest
	desc = "Contains one DeForest medical import item."
	subcategory = "DeForest Medical"
	crate_name = "DeForest supply package"

/datum/supply_pack/company_import/deforest/New()
	. = ..()
	if(!item_type)
		return
	contains = list(item_type)
	var/obj/item/template_item = new item_type
	if(name == initial(name))
		name = "[template_item.name] Single-Pack"
	if(desc == initial(desc))
		desc = "Contains one [template_item.name]."
	qdel(template_item)

/datum/supply_pack/company_import/deforest/first_aid_kit
	cost = PAYCHECK_COMMAND * 2.5

/datum/supply_pack/company_import/deforest/first_aid_kit/civil_defense
	item_type = /obj/item/storage/medkit/civil_defense/stocked
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/company_import/deforest/first_aid_kit/comfort
	item_type = /obj/item/storage/medkit/civil_defense/comfort/stocked
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/company_import/deforest/first_aid_kit/frontier
	item_type = /obj/item/storage/medkit/frontier/stocked
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/company_import/deforest/first_aid_kit/combat_surgeon
	item_type = /obj/item/storage/medkit/combat_surgeon/stocked
	cost = PAYCHECK_COMMAND * 10.7

/datum/supply_pack/company_import/deforest/first_aid_kit/robo_repair
	item_type = /obj/item/storage/medkit/robotic_repair/stocked
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/company_import/deforest/first_aid_kit/robo_repair_super
	item_type = /obj/item/storage/medkit/robotic_repair/preemo/stocked
	cost = PAYCHECK_COMMAND * 15

/datum/supply_pack/company_import/deforest/first_aid_kit/first_responder
	item_type = /obj/item/storage/backpack/duffelbag/deforest_surgical/stocked
	cost = PAYCHECK_COMMAND * 14

/datum/supply_pack/company_import/deforest/first_aid_kit/orange_satchel
	item_type = /obj/item/storage/backpack/duffelbag/deforest_medkit/stocked
	cost = PAYCHECK_COMMAND * 24.2

/datum/supply_pack/company_import/deforest/first_aid_kit/technician_satchel
	item_type = /obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked
	cost = PAYCHECK_COMMAND * 24.2

/datum/supply_pack/company_import/deforest/first_aid
	cost = PAYCHECK_LOWER

/datum/supply_pack/company_import/deforest/first_aid/coagulant
	item_type = /obj/item/stack/medical/suture/coagulant
	cost = PAYCHECK_CREW * 1.8

/datum/supply_pack/company_import/deforest/first_aid/red_sun
	item_type = /obj/item/stack/medical/ointment/red_sun
	cost = PAYCHECK_CREW * 0.75

/datum/supply_pack/company_import/deforest/first_aid/sterile_gauze
	item_type = /obj/item/stack/medical/gauze/sterilized
	cost = PAYCHECK_CREW * 1.8

/datum/supply_pack/company_import/deforest/first_aid/suture
	item_type = /obj/item/stack/medical/suture
	cost = PAYCHECK_CREW * 1.4

/datum/supply_pack/company_import/deforest/first_aid/ointment
	item_type = /obj/item/stack/medical/ointment
	cost = PAYCHECK_CREW * 1.4

/datum/supply_pack/company_import/deforest/first_aid/mesh
	item_type = /obj/item/stack/medical/mesh
	cost = PAYCHECK_CREW * 1.4

/datum/supply_pack/company_import/deforest/first_aid/bandaid
	item_type = /obj/item/storage/box/bandages
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/company_import/deforest/first_aid/amollin
	item_type = /obj/item/storage/pill_bottle/painkiller
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/company_import/deforest/first_aid/robo_patch
	item_type = /obj/item/reagent_containers/applicator/pill/robotic_patch/synth_repair
	cost = PAYCHECK_CREW * 0.75

/datum/supply_pack/company_import/deforest/first_aid/subdermal_splint
	item_type = /obj/item/stack/medical/wound_recovery
	cost = PAYCHECK_CREW * 6.5

/datum/supply_pack/company_import/deforest/first_aid/rapid_coagulant
	item_type = /obj/item/stack/medical/wound_recovery/rapid_coagulant
	cost = PAYCHECK_CREW * 6.5

/datum/supply_pack/company_import/deforest/first_aid/robofoam
	item_type = /obj/item/stack/medical/wound_recovery/robofoam
	cost = PAYCHECK_CREW * 6.5

/datum/supply_pack/company_import/deforest/first_aid/super_robofoam
	item_type = /obj/item/stack/medical/wound_recovery/robofoam_super
	cost = PAYCHECK_CREW * 7

/datum/supply_pack/company_import/deforest/medpens
	cost = PAYCHECK_CREW * 2.4

/datum/supply_pack/company_import/deforest/medpens/occuisate
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/occuisate

/datum/supply_pack/company_import/deforest/medpens/morpital
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/morpital

/datum/supply_pack/company_import/deforest/medpens/lipital
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/lipital

/datum/supply_pack/company_import/deforest/medpens/meridine
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/meridine

/datum/supply_pack/company_import/deforest/medpens/calopine
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/calopine

/datum/supply_pack/company_import/deforest/medpens/coagulants
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/coagulants

/datum/supply_pack/company_import/deforest/medpens/lepoturi
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi

/datum/supply_pack/company_import/deforest/medpens/psifinil
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/psifinil

/datum/supply_pack/company_import/deforest/medpens/halobinin
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/halobinin

/datum/supply_pack/company_import/deforest/medpens/robo_solder
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/robot_liquid_solder

/datum/supply_pack/company_import/deforest/medpens/robo_cleaner
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner

/datum/supply_pack/company_import/deforest/medpens/pentibinin
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/company_import/deforest/medpens_stim
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/company_import/deforest/medpens_stim/adrenaline
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline

/datum/supply_pack/company_import/deforest/medpens_stim/synephrine
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/synephrine

/datum/supply_pack/company_import/deforest/medpens_stim/krotozine
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/krotozine

/datum/supply_pack/company_import/deforest/medpens_stim/aranepaine
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/aranepaine
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/company_import/deforest/medpens_stim/synalvipitol
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/synalvipitol
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/company_import/deforest/medpens_stim/twitch
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/twitch
	cost = PAYCHECK_COMMAND * 3
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/company_import/deforest/medpens_stim/demoneye
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/demoneye
	cost = PAYCHECK_COMMAND * 3
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/company_import/deforest/equipment
	cost = PAYCHECK_LOWER

/datum/supply_pack/company_import/deforest/equipment/treatment_zone_projector
	item_type = /obj/item/holosign_creator/medical/treatment_zone
	cost = PAYCHECK_COMMAND * 0.25

/datum/supply_pack/company_import/deforest/equipment/health_analyzer
	item_type = /obj/item/healthanalyzer
	cost = PAYCHECK_COMMAND * 1.4

/datum/supply_pack/company_import/deforest/equipment/loaded_defib
	item_type = /obj/item/defibrillator/loaded
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/company_import/deforest/equipment/loaded_belt_defib
	item_type = /obj/item/defibrillator/compact/loaded
	cost = PAYCHECK_COMMAND * 9

/datum/supply_pack/company_import/deforest/equipment/surgical_tools
	item_type = /obj/item/surgery_tray/full
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/company_import/deforest/equipment/advanced_health_analyer
	item_type = /obj/item/healthanalyzer/advanced
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/company_import/deforest/equipment/penlite_defib_mount
	item_type = /obj/item/wallframe/defib_mount/charging
	cost = PAYCHECK_COMMAND

/datum/supply_pack/company_import/deforest/equipment/advanced_scalpel
	item_type = /obj/item/scalpel/advanced
	cost = PAYCHECK_COMMAND * 10.25

/datum/supply_pack/company_import/deforest/equipment/advanced_retractor
	item_type = /obj/item/retractor/advanced
	cost = PAYCHECK_COMMAND * 9

/datum/supply_pack/company_import/deforest/equipment/advanced_cautery
	item_type = /obj/item/cautery/advanced
	cost = PAYCHECK_COMMAND * 9

/datum/supply_pack/company_import/deforest/equipment/advanced_blood_filter
	item_type = /obj/item/blood_filter/advanced
	cost = PAYCHECK_COMMAND * 9

/datum/supply_pack/company_import/deforest/equipment/medigun_upgrade
	item_type = /obj/item/device/custom_kit/medigun_fastcharge
	cost = PAYCHECK_COMMAND * 12

/datum/supply_pack/company_import/deforest/equipment/hypospray_upgrade
	item_type = /obj/item/device/custom_kit/deluxe_hypo2
	cost = PAYCHECK_COMMAND * 4.5

/datum/supply_pack/company_import/deforest/equipment/advanced_hypospray
	item_type = /obj/item/hypospray/mkii/piercing
	cost = PAYCHECK_COMMAND * 7

/datum/supply_pack/company_import/deforest/equipment/afad
	item_type = /obj/item/gun/medbeam/afad
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/company_import/deforest/equipment/medstation
	item_type = /obj/item/wallframe/frontier_medstation
	cost = PAYCHECK_COMMAND * 12

/datum/supply_pack/company_import/deforest/equipment/medhud
	item_type = /obj/item/clothing/glasses/hud/health
	cost = PAYCHECK_COMMAND

/datum/supply_pack/company_import/deforest/equipment/medhud_night
	item_type = /obj/item/clothing/glasses/hud/health/night
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/company_import/deforest/equipment/medhud_night_sci
	item_type = /obj/item/clothing/glasses/hud/health/night/science
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/company_import/deforest/equipment/hypospray_case
	item_type = /obj/item/storage/hypospraykit
	cost = PAYCHECK_COMMAND

/datum/supply_pack/company_import/deforest/equipment/hypospray
	item_type = /obj/item/hypospray/mkii
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/company_import/deforest/implant
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/company_import/deforest/implant/surgery
	item_type = /obj/item/organ/cyberimp/arm/toolkit/surgery

/datum/supply_pack/company_import/deforest/implant/toolset
	item_type = /obj/item/organ/cyberimp/arm/toolkit/toolset

/datum/supply_pack/company_import/deforest/implant/botany
	item_type = /obj/item/organ/cyberimp/arm/toolkit/botany

/datum/supply_pack/company_import/deforest/implant/janitor
	item_type = /obj/item/organ/cyberimp/arm/toolkit/janitor

/datum/supply_pack/company_import/deforest/implant/paperwork
	item_type = /obj/item/organ/cyberimp/arm/toolkit/paperwork

/datum/supply_pack/company_import/deforest/medical_modules
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/company_import/deforest/medical_modules/injector
	name = "MOD injector module"
	item_type = /obj/item/mod/module/injector

/datum/supply_pack/company_import/deforest/medical_modules/organizer
	name = "MOD organizer module"
	item_type = /obj/item/mod/module/organizer

/datum/supply_pack/company_import/deforest/medical_modules/patient_transport
	name = "MOD patient transport module"
	item_type = /obj/item/mod/module/criminalcapture/patienttransport

/datum/supply_pack/company_import/deforest/medical_modules/thread_ripper
	name = "MOD thread ripper module"
	item_type = /obj/item/mod/module/thread_ripper

/datum/supply_pack/company_import/deforest/medical_modules/surgical_processor
	name = "MOD surgical processor module"
	item_type = /obj/item/mod/module/surgical_processor

/datum/supply_pack/company_import/deforest/medical_modules/defibrillator
	name = "MOD defibrillator module"
	item_type = /obj/item/mod/module/defibrillator
