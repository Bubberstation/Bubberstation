/datum/supply_pack/mining
	auto_name = TRUE

/datum/supply_pack/mining
	access = NONE
	cost = PAYCHECK_LOWER
	group = "Mining" //figure this out later
	order_flags = ORDER_GOODY
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/mining/biogenerator
	contains = list(/obj/item/flatpacked_machine/organics_printer)
	cost = CARGO_CRATE_VALUE * 3

/datum/supply_pack/mining/ore_thumper
	contains = list(/obj/item/flatpacked_machine/ore_thumper)
	cost = CARGO_CRATE_VALUE * 5

/datum/supply_pack/mining/gps_beacon
	contains = list(/obj/item/flatpacked_machine/gps_beacon)
	cost = PAYCHECK_LOWER

/datum/supply_pack/mining/equipment/wearable/seva_mask
	contains = list(/obj/item/clothing/mask/gas/seva)
	cost = PAYCHECK_CREW * 1.5

/datum/supply_pack/mining/equipment/wearable/seva_suit
	contains = list(/obj/item/clothing/suit/hooded/seva)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/mining/equipment/wearable/sensors_cuffs
	contains = list(/obj/item/kheiral_cuffs)
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/mining/equipment/hand_equipment/
	cost = PAYCHECK_COMMAND

/datum/supply_pack/mining/equipment/hand_equipment/drill
	contains = list(/obj/item/pickaxe/drill)

/datum/supply_pack/mining/equipment/hand_equipment/resonator
	contains = list(/obj/item/resonator)

/datum/supply_pack/mining/equipment/hand_equipment/pka
	contains = list(/obj/item/gun/energy/recharge/kinetic_accelerator)

/datum/supply_pack/mining/equipment/hand_equipment/cutter
	contains = list(/obj/item/gun/energy/plasmacutter)

/datum/supply_pack/mining/equipment/hand_equipment/diamond_drill
	contains = list(/obj/item/pickaxe/drill/diamonddrill)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/mining/equipment/hand_equipment/advanced_cutter
	contains = list(/obj/item/gun/energy/plasmacutter/adv)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/mining/equipment/hand_equipment/super_resonator
	contains = list(/obj/item/resonator/upgraded)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/mining/equipment/hand_equipment/jackhammer
	contains = list(/obj/item/pickaxe/drill/jackhammer)
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/mining/equipment/sensing
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/mining/equipment/sensing/mesons
	contains = list(/obj/item/clothing/glasses/meson)
	cost = PAYCHECK_CREW

/datum/supply_pack/mining/equipment/sensing/autoscanner
	contains = list(/obj/item/t_scanner/adv_mining_scanner/lesser)
	cost = PAYCHECK_LOWER

/datum/supply_pack/mining/equipment/sensing/super_autoscanner
	contains = list(/obj/item/t_scanner/adv_mining_scanner)

/datum/supply_pack/mining/equipment/sensing/nvg_mesons
	contains = list(/obj/item/clothing/glasses/meson/night)

/datum/supply_pack/mining/equipment/mecha
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/mining/equipment/mecha/scanner
	contains = list(/obj/item/mecha_parts/mecha_equipment/mining_scanner)
	cost = PAYCHECK_CREW

/datum/supply_pack/mining/equipment/mecha/drill
	contains = list(/obj/item/mecha_parts/mecha_equipment/drill)
	cost = PAYCHECK_CREW

/datum/supply_pack/mining/equipment/mecha/pka
	contains = list(/obj/item/mecha_parts/mecha_equipment/weapon/energy/mecha_kineticgun)

/datum/supply_pack/mining/equipment/mecha/diamond_drill
	contains = list(/obj/item/mecha_parts/mecha_equipment/drill/diamonddrill)

/datum/supply_pack/mining/equipment/mecha/cutter
	contains = list(/obj/item/mecha_parts/mecha_equipment/weapon/energy/plasma)
