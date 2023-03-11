#define PRICE_CHEAPENERGYGUN_LOW 1.5
#define PRICE_CHEAPENERGYGUN_HIGH 2.5
#define PRICE_MEDIUMENERGYGUN_LOW 3
#define PRICE_MEDIUMENERGYGUN_HIGH 4
#define PRICE_PREMIUMENERGYGUN_LOW 4.5
#define PRICE_PREMIUMENERGYGUN_HIGH 5

#define PRICE_MCRKIT_LOW 1.5
#define PRICE_MCRKIT_HIGH 2

/datum/armament_entry/company_import/microstar
	category = MICROSTAR_ENERGY_NAME
	company_bitflag = CARGO_COMPANY_MICROSTAR
	interest_addition = COMPANY_INTEREST_GAIN_BIG

// Basic lethal/disabler beam weapons, includes the base mcr

/datum/armament_entry/company_import/microstar/basic_energy_weapons
	subcategory = "Basic Energy Weapons"

/datum/armament_entry/company_import/microstar/basic_energy_weapons/disabler
	item_type = /obj/item/gun/energy/disabler
	lower_cost = CARGO_CRATE_VALUE * PRICE_CHEAPENERGYGUN_LOW
	upper_cost = CARGO_CRATE_VALUE * PRICE_CHEAPENERGYGUN_HIGH / 1.5
	stock_mult = 2

/datum/armament_entry/company_import/microstar/basic_energy_weapons/mini_egun
	item_type = /obj/item/gun/energy/e_gun/mini
	lower_cost = CARGO_CRATE_VALUE * PRICE_CHEAPENERGYGUN_LOW / 1.5
	upper_cost = CARGO_CRATE_VALUE * PRICE_CHEAPENERGYGUN_HIGH / 1.5

/datum/armament_entry/company_import/microstar/basic_energy_weapons/sc1
	item_type = /obj/item/gun/energy/laser
	lower_cost = CARGO_CRATE_VALUE * PRICE_CHEAPENERGYGUN_LOW
	upper_cost = CARGO_CRATE_VALUE * PRICE_CHEAPENERGYGUN_HIGH
	stock_mult = 2

/datum/armament_entry/company_import/microstar/basic_energy_weapons/sc2
	item_type = /obj/item/gun/energy/e_gun
	lower_cost = CARGO_CRATE_VALUE * PRICE_MEDIUMENERGYGUN_LOW 
	upper_cost = CARGO_CRATE_VALUE * PRICE_MEDIUMENERGYGUN_HIGH

/datum/armament_entry/company_import/microstar/basic_energy_weapons/basic_mcr
	item_type = /obj/item/gun/microfusion/mcr01
	lower_cost = CARGO_CRATE_VALUE * PRICE_MEDIUMENERGYGUN_LOW 
	upper_cost = CARGO_CRATE_VALUE * PRICE_MEDIUMENERGYGUN_HIGH

// More expensive, unique energy weapons

/datum/armament_entry/company_import/microstar/experimental_energy
	subcategory = "Experimental Energy Weapons"
	interest_required = COMPANY_SOME_INTEREST
	restricted = TRUE

/datum/armament_entry/company_import/microstar/experimental_energy/hellfire
	item_type = /obj/item/gun/energy/laser/hellgun
	lower_cost = CARGO_CRATE_VALUE * PRICE_PREMIUMENERGYGUN_LOW
	upper_cost = CARGO_CRATE_VALUE * PRICE_PREMIUMENERGYGUN_HIGH

/datum/armament_entry/company_import/microstar/experimental_energy/ion_carbine
	item_type = /obj/item/gun/energy/ionrifle/carbine
	lower_cost = CARGO_CRATE_VALUE * PRICE_MEDIUMENERGYGUN_LOW 
	upper_cost = CARGO_CRATE_VALUE * PRICE_MEDIUMENERGYGUN_HIGH

/datum/armament_entry/company_import/microstar/experimental_energy/xray_gun
	item_type = /obj/item/gun/energy/xray
	lower_cost = CARGO_CRATE_VALUE * PRICE_PREMIUMENERGYGUN_LOW
	upper_cost = CARGO_CRATE_VALUE * PRICE_PREMIUMENERGYGUN_HIGH

/datum/armament_entry/company_import/microstar/experimental_energy/tesla_cannon
	item_type = /obj/item/gun/energy/tesla_cannon
	lower_cost = CARGO_CRATE_VALUE * PRICE_MEDIUMENERGYGUN_LOW 
	upper_cost = CARGO_CRATE_VALUE * PRICE_MEDIUMENERGYGUN_HIGH

// Preset 'loadout' kits built around a barrel attachment

/datum/armament_entry/company_import/microstar/mcr_attachments
	subcategory = "Microfusion Attachment Kits"
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/microstar/mcr_attachments/hellfire
	name = "microfusion hellfire kit"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_loadout/hellfire
	lower_cost = CARGO_CRATE_VALUE * PRICE_MCRKIT_LOW
	upper_cost = CARGO_CRATE_VALUE * PRICE_MCRKIT_HIGH
	stock_mult = 2

/datum/armament_entry/company_import/microstar/mcr_attachments/scatter
	name = "microfusion scatter kit"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_loadout/scatter
	lower_cost = CARGO_CRATE_VALUE * PRICE_MCRKIT_LOW
	upper_cost = CARGO_CRATE_VALUE * PRICE_MCRKIT_HIGH
	stock_mult = 2

/datum/armament_entry/company_import/microstar/mcr_attachments/lance
	name = "microfusion lance kit"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_loadout/lance
	lower_cost = CARGO_CRATE_VALUE * PRICE_MCRKIT_LOW
	upper_cost = CARGO_CRATE_VALUE * PRICE_MCRKIT_HIGH
	stock_mult = 2

/datum/armament_entry/company_import/microstar/mcr_attachments/repeater
	name = "microfusion repeater kit"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_loadout/repeater
	lower_cost = CARGO_CRATE_VALUE * PRICE_MCRKIT_LOW
	upper_cost = CARGO_CRATE_VALUE * PRICE_MCRKIT_HIGH
	stock_mult = 2

/datum/armament_entry/company_import/microstar/mcr_attachments/tacticool
	name = "microfusion suppressor kit"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_loadout/tacticool
	lower_cost = CARGO_CRATE_VALUE * PRICE_MCRKIT_LOW
	upper_cost = CARGO_CRATE_VALUE * PRICE_MCRKIT_HIGH
	stock_mult = 2

// Improved phase emitters, cells, and cell attachments

/datum/armament_entry/company_import/microstar/mcr_upgrades
	subcategory = "Microfusion Attachment Kits"
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/microstar/mcr_upgrades/stabilizer
	item_type = /obj/item/microfusion_cell_attachment/stabiliser
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE
	stock_mult = 3

/datum/armament_entry/company_import/microstar/mcr_upgrades/enhanced_part_kit
	name = "microfusion enhanced parts"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_parts/enhanced
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 3
	stock_mult = 3

/datum/armament_entry/company_import/microstar/mcr_upgrades/capacity_booster
	item_type = /obj/item/microfusion_cell_attachment/overcapacity
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 1.5
	interest_required = COMPANY_SOME_INTEREST
	stock_mult = 3

/datum/armament_entry/company_import/microstar/mcr_upgrades/advanced_part_kit
	name = "microfusion advanced parts"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_parts/advanced
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 5.5
	interest_required = COMPANY_SOME_INTEREST
	stock_mult = 3

/datum/armament_entry/company_import/microstar/mcr_upgrades/selfcharge
	item_type = /obj/item/microfusion_cell_attachment/selfcharging
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 4
	interest_required = COMPANY_HIGH_INTEREST
	stock_mult = 3

/datum/armament_entry/company_import/microstar/mcr_upgrades/bluespace_part_kit
	name = "microfusion bluespace parts"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_parts/bluespace
	lower_cost = CARGO_CRATE_VALUE * 5.5
	upper_cost = CARGO_CRATE_VALUE * 7
	interest_required = COMPANY_HIGH_INTEREST
	stock_mult = 3

#undef PRICE_CHEAPENERGYGUN_LOW
#undef PRICE_CHEAPENERGYGUN_HIGH
#undef PRICE_MEDIUMENERGYGUN_LOW
#undef PRICE_MEDIUMENERGYGUN_HIGH
#undef PRICE_PREMIUMENERGYGUN_LOW
#undef PRICE_PREMIUMENERGYGUN_HIGH

#undef PRICE_MCRKIT_LOW
#undef PRICE_MCRKIT_HIGH

