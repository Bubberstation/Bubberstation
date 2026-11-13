/datum/supply_pack/company_import/akh_frontier
	subcategory = "Akh Frontier"

/datum/supply_pack/company_import/akh_frontier/basic
	cost = PAYCHECK_COMMAND

/datum/supply_pack/company_import/akh_frontier/basic/omni_drill
	item_type = /obj/item/screwdriver/omni_drill
	cost = PAYCHECK_CREW * 5

/datum/supply_pack/company_import/akh_frontier/basic/arc_welder
	item_type = /obj/item/weldingtool/electric/arc_welder
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/company_import/akh_frontier/basic/prybar
	item_type = /obj/item/crowbar/large/colony_prybar
	cost = PAYCHECK_CREW * 5

/datum/supply_pack/company_import/akh_frontier/basic/multitool
	item_type = /obj/item/multitool/colony
	cost = PAYCHECK_COMMAND

/datum/supply_pack/company_import/akh_frontier/basic/compact_drill
	item_type = /obj/item/pickaxe/drill/compact
	cost = PAYCHECK_CREW * 5

/datum/supply_pack/company_import/akh_frontier/deployables_fab/rapid_construction_fabricator
	item_type = /obj/item/flatpacked_machine
	name = "Rapid Construction Fabricator (RCF)"
	desc = "Contains one flat-packed rapid construction fabricator, with a charged cell to get it running anywhere. Cannot be deployed on station."
	cost = CARGO_CRATE_VALUE * 30

/datum/supply_pack/company_import/akh_frontier/deployables_fab/foodricator
	item_type = /obj/item/flatpacked_machine/organics_ration_printer
	desc = "Contains one flat-packed organics ration printer, cannot be deployed on station."
	cost = CARGO_CRATE_VALUE * 2

/datum/supply_pack/company_import/akh_frontier/appliances
	cost = PAYCHECK_COMMAND

/datum/supply_pack/company_import/akh_frontier/appliances/charger
	item_type = /obj/item/wallframe/cell_charger_multi
	cost = PAYCHECK_CREW

/datum/supply_pack/company_import/akh_frontier/appliances/water_synth
	item_type = /obj/item/flatpacked_machine/water_synth
	desc = "Contains one flat-packed water synthesizer, cannot be deployed on station."

/datum/supply_pack/company_import/akh_frontier/appliances/hydro_synth
	item_type = /obj/item/flatpacked_machine/hydro_synth
	desc = "Contains one flat-packed hydroponics synthesizer, cannot be deployed on station."

/datum/supply_pack/company_import/akh_frontier/appliances/sustenance_dispenser
	item_type = /obj/item/flatpacked_machine/sustenance_machine
	cost = PAYCHECK_COMMAND * 2
	desc = "Contains one flat-packed sustenance dispenser, cannot be deployed on station."

/datum/supply_pack/company_import/akh_frontier/deployables_misc
	cost = PAYCHECK_COMMAND

/datum/supply_pack/company_import/akh_frontier/deployables_misc/arc_furnace
	item_type = /obj/item/flatpacked_machine/arc_furnace
	desc = "Contains one flat-packed arc furnace, cannot be deployed on station."

/datum/supply_pack/company_import/akh_frontier/deployables_misc/thermomachine
	item_type = /obj/item/flatpacked_machine/thermomachine
	desc = "Contains one flat-packed thermomachine, cannot be deployed on station."

/datum/supply_pack/company_import/akh_frontier/deployables_misc/co2_cracker
	item_type = /obj/item/flatpacked_machine/co2_cracker
	desc = "Contains one flat-packed CO2 cracker, cannot be deployed on station."

/datum/supply_pack/company_import/akh_frontier/deployables_misc/recycler
	item_type = /obj/item/flatpacked_machine/recycler
	desc = "Contains one flat-packed recycler, cannot be deployed on station."

/datum/supply_pack/company_import/akh_frontier/deployables
	cost = PAYCHECK_COMMAND

/datum/supply_pack/company_import/akh_frontier/deployables/solar
	item_type = /obj/item/flatpacked_machine/solar
	cost = PAYCHECK_CREW
	desc = "Contains one flat-packed solar panel, cannot be deployed on station."

/datum/supply_pack/company_import/akh_frontier/deployables/solar_tracker
	item_type = /obj/item/flatpacked_machine/solar_tracker
	desc = "Contains one flat-packed solar tracker, cannot be deployed on station."
	cost = PAYCHECK_CREW

/datum/supply_pack/company_import/akh_frontier/deployables/station_battery
	item_type = /obj/item/flatpacked_machine/station_battery
	desc = "Contains one flat-packed station battery, cannot be deployed on station."

/datum/supply_pack/company_import/akh_frontier/deployables/big_station_battery
	item_type = /obj/item/flatpacked_machine/large_station_battery
	desc = "Contains one flat-packed large station battery, cannot be deployed on station."

/datum/supply_pack/company_import/akh_frontier/deployables/solids_generator
	item_type = /obj/item/flatpacked_machine/fuel_generator
	desc = "Contains one flat-packed fuel generator, cannot be deployed on station."

/datum/supply_pack/company_import/akh_frontier/deployables/rtg
	item_type = /obj/item/flatpacked_machine/rtg
	desc = "Contains one flat-packed RTG, cannot be deployed on station."
