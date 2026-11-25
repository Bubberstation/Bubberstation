/datum/design/board/rbmk2_reactor
	name = "RB-MK2 Reactor Board"
	desc = "The circuit board for a RB-MK2 reactor."
	build_path = /obj/item/circuitboard/machine/rbmk2
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/rbmk2_reactor_sniffer
	name = "RB-MK2 Reactor Sniffer"
	desc = "The circuit board for a RB-MK2 reactor sniffer."
	build_path = /obj/item/circuitboard/machine/rbmk2_sniffer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rbmk2_rod
	name = "RB-MK2 Reactor Rod"
	desc = "A specialized rod for use in the RB-MK2 reactor."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT*2)
	construction_time = 100
	build_path = /obj/item/tank/rbmk2_rod
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/techweb_node/energy_manipulation/New(...)
	unlocked_designs += list(
		/datum/design/board/rbmk2_reactor,
		/datum/design/rbmk2_rod,
		/datum/design/board/rbmk2_reactor_sniffer
	)
	. = ..()

/datum/design/rbmk2_upgrade_auto_vent
	name = "RB-MK2 Auto-Vent Upgrade Disk"
	desc = "A disk that allows you to install an upgrade into the RB-MK that automatically controls vent usage to maximize power gain at all temperature setups."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/silver =SHEET_MATERIAL_AMOUNT, /datum/material/titanium =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/rbmk_upgrade/auto_vent
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rbmk2_upgrade_safeties
	name = "RB-MK2 Safeties Optimization Upgrade Disk"
	desc = "A disk that allows you to install an upgrade into the RB-MK that effectively decreases the safeties threshold from 75% to 95%, preventing premature ejectulation."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/gold =SHEET_MATERIAL_AMOUNT, /datum/material/uranium =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/rbmk_upgrade/safeties
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rbmk2_upgrade_overclock
	name = "RB-MK2 Overclock Upgrade Disk"
	desc = "A disk that allows you to install an upgrade into the RB-MK that enables overlocking of the reactor."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/bluespace =SHEET_MATERIAL_AMOUNT, /datum/material/uranium =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/rbmk_upgrade/overclock
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/techweb_node/rbmk_upgrades
	display_name = "RB-MK2 Upgrade Disks"
	description = "An assortment of (possibly illegal) software upgrades that improve(?) the RB-MK2 reactor in some way."
	prerequisite_nodes = list(/datum/techweb_node/energy_manipulation, /datum/techweb_node/applied_bluespace)
	unlocked_designs = list(
		/datum/design/rbmk2_upgrade_overclock,
		/datum/design/rbmk2_upgrade_safeties,
		/datum/design/rbmk2_upgrade_auto_vent
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING)
