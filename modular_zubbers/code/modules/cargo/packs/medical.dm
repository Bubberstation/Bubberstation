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

/datum/supply_pack/goody/medical
	group = "Medical"
	access_view = ACCESS_MEDICAL

/datum/supply_pack/medical/first_aid_kit_civil
	contains = list(/obj/item/storage/medkit/civil_defense/stocked)
	cost = CARGO_CRATE_VALUE * 2.5
	auto_name = TRUE

/datum/supply_pack/medical/first_aid_kit_comfort
	contains = list(/obj/item/storage/medkit/civil_defense/comfort/stocked)
	cost = CARGO_CRATE_VALUE * 4
	auto_name = TRUE

/datum/supply_pack/medical/first_aid_kit_frontier
	contains = list(/obj/item/storage/medkit/frontier/stocked)
	cost = CARGO_CRATE_VALUE * 4
	auto_name = TRUE

/datum/supply_pack/medical/first_aid_kit_robotics
	contains = list(/obj/item/storage/medkit/robotic_repair/stocked)
	cost = CARGO_CRATE_VALUE * 4
	auto_name = TRUE

/datum/supply_pack/medical/first_aid_kit_premium_robotics
	contains = list(/obj/item/storage/medkit/robotic_repair/preemo/stocked)
	cost = CARGO_CRATE_VALUE * 7.5
	auto_name = TRUE

/datum/supply_pack/goody/medical/super_robofoam
	contains = list(/obj/item/stack/medical/wound_recovery/robofoam_super)
	cost = PAYCHECK_CREW * 7
	auto_name = TRUE

/datum/supply_pack/goody/medical/medpen
	cost = PAYCHECK_CREW * 2.4

/datum/supply_pack/goody/medical/medpen/robosolder
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/robot_liquid_solder)
	auto_name = TRUE

/datum/supply_pack/goody/medical/medpen/robocleaner
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner)
	auto_name = TRUE

/datum/supply_pack/goody/medical/hypospray
	contains = list(/obj/item/hypospray/mkii)
	cost = PAYCHECK_COMMAND * 5
	auto_name = TRUE

/datum/supply_pack/goody/medical/hypospray_upgrade
	contains = list(/obj/item/device/custom_kit/deluxe_hypo2)
	cost = PAYCHECK_COMMAND * 4.5
	auto_name = TRUE

/datum/supply_pack/goody/medical/advanced_hypospray
	contains = list(/obj/item/hypospray/mkii/piercing)
	cost = PAYCHECK_COMMAND * 7
	auto_name = TRUE

/datum/supply_pack/medical/medstation
	contains = list(/obj/item/wallframe/frontier_medstation)
	cost = CARGO_CRATE_VALUE * 6
	auto_name = TRUE

/datum/supply_pack/medical/surgery_tray
	contains = list(/obj/item/surgery_tray/full)
	cost = CARGO_CRATE_VALUE * 3
	auto_name = TRUE

/datum/supply_pack/medical/advanced_tools
	name = "Advanced Tools Crate"
	desc = "Is Science slacking? Is your chemistry department lacking? Order an advanced tools crate today."
	contains = list(
		/obj/item/cautery/advanced,
		/obj/item/scalpel/advanced,
		/obj/item/retractor/advanced,
		/obj/item/blood_filter/advanced,
		/obj/item/healthanalyzer/advanced,
	)
	cost = CARGO_CRATE_VALUE * 12.5

/datum/supply_pack/goody/medical/medhud_night_sci
	contains = list(/obj/item/clothing/glasses/hud/health/night/science)
	cost = PAYCHECK_COMMAND * 5
	auto_name = TRUE

// Cybernetics and other things that go inside you

/datum/supply_pack/goody/medical/implant
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/goody/medical/implant/surgery
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/surgery)
	auto_name = TRUE

/datum/supply_pack/goody/medical/implant/toolset
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/toolset)
	auto_name = TRUE

/datum/supply_pack/goody/medical/implant/botany
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/botany)
	auto_name = TRUE

/datum/supply_pack/goody/medical/implant/janitor
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/janitor)
	auto_name = TRUE

/datum/supply_pack/goody/medical/implant/paperwork
	name = "Paperwork Implant Set Single-Pack"
	desc = "A goody case containing an implant, which can be surgically implanted to effectivize crewmembers at paperwork. Warranty void if exposed to electromagnetic pulses."
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/paperwork)

/datum/supply_pack/goody/medical/medpod
	contains = list(/obj/item/survivalcapsule/medical)
	cost = PAYCHECK_COMMAND * 40
	auto_name = TRUE

/datum/supply_pack/goody/medical/chempod
	contains = list(/obj/item/survivalcapsule/chemistry)
	cost = PAYCHECK_COMMAND * 20
	auto_name = TRUE
