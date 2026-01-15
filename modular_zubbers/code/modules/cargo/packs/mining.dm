/datum/supply_pack/imports/mining
	access = NONE
	cost = PAYCHECK_LOWER
	group = "Mining" //figure this out later
	order_flags = ORDER_GOODY
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/imports/mining/biogenerator
	name = "Biogenerator"
	contains = list(/obj/item/flatpacked_machine/organics_printer)
	cost = CARGO_CRATE_VALUE * 3

/datum/supply_pack/imports/mining/ore_thumper
	name = "Ore Thumper"
	contains = list(/obj/item/flatpacked_machine/ore_thumper)
	cost = CARGO_CRATE_VALUE * 5

/datum/supply_pack/imports/mining/gps_beacon
	name = "GPS Beacon"
	contains = list(/obj/item/flatpacked_machine/gps_beacon)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports/mining/equipment/wearable/seva_mask
	name = "SEVA Gas Mask"
	contains = list(/obj/item/clothing/mask/gas/seva)
	cost = PAYCHECK_CREW * 1.5

/datum/supply_pack/imports/mining/equipment/wearable/seva_suit
	name = "SEVA Suit"
	contains = list(/obj/item/clothing/suit/hooded/seva)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports/mining/equipment/wearable/sensors_cuffs
	name = "Kheiral Cuffs"
	contains = list(/obj/item/kheiral_cuffs)
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/imports/mining/equipment/hand_equipment/
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/mining/equipment/hand_equipment/drill
	name = "Mining Drill"
	contains = list(/obj/item/pickaxe/drill)

/datum/supply_pack/imports/mining/equipment/hand_equipment/resonator
	name = "Resonator"
	contains = list(/obj/item/resonator)

/datum/supply_pack/imports/mining/equipment/hand_equipment/pka
	name = "Proto-Kinetic Accelerator"
	contains = list(/obj/item/gun/energy/recharge/kinetic_accelerator)

/datum/supply_pack/imports/mining/equipment/hand_equipment/cutter
	name = "Plasma Cutter"
	contains = list(/obj/item/gun/energy/plasmacutter)

/datum/supply_pack/imports/mining/equipment/hand_equipment/diamond_drill
	name = "Diamond-Tipped Mining Drill"
	contains = list(/obj/item/pickaxe/drill/diamonddrill)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports/mining/equipment/hand_equipment/advanced_cutter
	name = "Advanced Plasma Cutter"
	contains = list(/obj/item/gun/energy/plasmacutter/adv)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/imports/mining/equipment/hand_equipment/super_resonator
	name = "Advanced Resonator"
	contains = list(/obj/item/resonator/upgraded)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/imports/mining/equipment/hand_equipment/jackhammer
	name = "Sonic Jackhammer"
	contains = list(/obj/item/pickaxe/drill/jackhammer)
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/imports/mining/equipment/sensing
	name = ""
	contains = list(/obj/item/)
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/imports/mining/equipment/sensing/mesons
	name = "Meson Goggles"
	contains = list(/obj/item/clothing/glasses/meson)
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/mining/equipment/sensing/autoscanner
	name = "Ore Scanner"
	contains = list(/obj/item/t_scanner/adv_mining_scanner/lesser)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports/mining/equipment/sensing/super_autoscanner
	name = "Advanced Ore Scanner"
	contains = list(/obj/item/t_scanner/adv_mining_scanner)

/datum/supply_pack/imports/mining/equipment/sensing/nvg_mesons
	name = "Night-Vision Meson Goggles"
	contains = list(/obj/item/clothing/glasses/meson/night)

/datum/supply_pack/imports/mining/equipment/mecha
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/imports/mining/equipment/mecha/scanner
	name = "Exosuit Ore Scanner"
	contains = list(/obj/item/mecha_parts/mecha_equipment/mining_scanner)
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/mining/equipment/mecha/drill
	name = "Exosuit Mining Drill"
	contains = list(/obj/item/mecha_parts/mecha_equipment/drill)
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/mining/equipment/mecha/pka
	name = "Exosuit PKA"
	contains = list(/obj/item/mecha_parts/mecha_equipment/weapon/energy/mecha_kineticgun)

/datum/supply_pack/imports/mining/equipment/mecha/diamond_drill
	name = "Exosuit Diamond-Tipped Drill"
	contains = list(/obj/item/mecha_parts/mecha_equipment/drill/diamonddrill)

/datum/supply_pack/imports/mining/equipment/mecha/cutter
	name = "Exosuit Plasma Cutter"
	contains = list(/obj/item/mecha_parts/mecha_equipment/weapon/energy/plasma)
