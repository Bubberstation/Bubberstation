/datum/supply_pack/security/armory/wt551
	name = "WT-551 Autorifle Crate"
	desc = "Contains a pair of WT-551 Autorifles pre-loaded with less-lethal rubber-tipped rounds. Additional ammo sold seperately. Backwards-compatible with WT-550 magazines. Nanotrasen reminds you that the other weapon is for a friend, and not for going guns akimbo."
	cost = CARGO_CRATE_VALUE * 10
	contains = list(/obj/item/gun/ballistic/automatic/wt550/security = 3)
	crate_name = "wt-550 autorifle crate"

/datum/supply_pack/security/armory/wt550_ammo_regular
	name = "WT-550/WT-551 Autorifle Ammo Crate (Regular)"
	desc = "Contains 4 magazines with lethal regular rounds for the WT-551."
	cost = CARGO_CRATE_VALUE * 4 //these are printable, price can be lowered safely to 800ish
	contains = list(/obj/item/ammo_box/magazine/wt550m9 = 4)
	crate_name = "wt-550 magazine crate (regular)"

/datum/supply_pack/security/ammo
	contains = list(/obj/item/ammo_box/advanced/s12gauge/bean = 3,
					/obj/item/ammo_box/advanced/s12gauge/rubber = 3,
					/obj/item/ammo_box/c38/trac,
					/obj/item/ammo_box/c38/hotshot,
					/obj/item/ammo_box/c38/iceblox,
				)
	special = FALSE
//This makes the Security ammo crate use the cool advanced ammo boxes instead of the old ones


/datum/supply_pack/security/secmed_technician
	name = "Security Medic Kit Crate - Technician"
	crate_name = "security medic crate"
	desc = "Contains a medical technician kit."
	access = ACCESS_SECURITY
	cost = CARGO_CRATE_VALUE * 7.125
	contains = list(
		/obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked,
	)

/datum/supply_pack/security/secmed_surgical
	name = "Security Medic Kit Crate - Surgical"
	crate_name = "security medic crate"
	desc = "Contains a first responder surgical kit."
	access = ACCESS_SECURITY
	cost = CARGO_CRATE_VALUE * 3.9
	contains = list(
		/obj/item/storage/backpack/duffelbag/deforest_surgical/stocked,
	)

/datum/supply_pack/security/secmed_medical
	name = "Security Medic Kit Crate - Medical"
	crate_name = "security medic crate"
	desc = "Contains a large satchel medical kit."
	access = ACCESS_SECURITY
	cost = CARGO_CRATE_VALUE * 7.125
	contains = list(
		/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked,
	)

/datum/supply_pack/security/plasma_marksman
	name = "Gwiazda Plasma Sharpshooter Single-Pack"
	crate_name = "Gwiadza Plasma Sharpshooter Crate"
	desc = "Contains a Gwiazda Plasma Sharpshooter and one plasma battery for it."
	contains = list(/obj/item/gun/ballistic/automatic/pistol/plasma_marksman = 1,
	/obj/item/ammo_box/magazine/recharge/plasma_battery = 1)
	cost = CARGO_CRATE_VALUE * 10
	access = ACCESS_SECURITY

/datum/supply_pack/security/armory/swat
	desc = "Contains two fullbody sets of tough, fireproof suits designed in a joint \
		effort by IS-ERI and Nanotrasen. Each set contains a suit, helmet, mask, combat belt, a pepperball gun, \
		and gorilla gloves."

/datum/supply_pack/security/armory/swat/New()
	. = ..()
	contains += list(/obj/item/storage/toolbox/guncase/skyrat/pistol/pepperball = 2)

/datum/supply_pack/imports/security
	access = ACCESS_SECURITY
	cost = PAYCHECK_COMMAND
	group = "Security" //figure this out later
	goody = TRUE
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/imports/security/ammo/cell
	name = "MCR Cell"
	contains = list(/obj/item/stock_parts/power_store/cell/microfusion)
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/security/ammo/cell_bulk
	name = "Box of MCR Cells"
	contains = list(/obj/item/storage/box/ammo_box/microfusion/bagless)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/imports/security/ammo/cell_adv
	name = "Advanced MCR Cell"
	contains = list(/obj/item/stock_parts/power_store/cell/microfusion/advanced)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/imports/security/ammo/cell_adv_bulk
	name = "Box of Advanced MCR Cells"
	contains = list(/obj/item/storage/box/ammo_box/microfusion/advanced/bagless)
	cost = PAYCHECK_CREW *3

/datum/supply_pack/imports/security/ammo/cell_blue
	name = "Bluespace MCR Cell"
	contains = list(/obj/item/stock_parts/power_store/cell/microfusion/bluespace)
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/imports/security/ammo/cell_blue_bulk
	name = "Box of Bluespace MCR Cells"
	contains = list(/obj/item/storage/box/ammo_box/microfusion/bluespace/bagless)
	cost = PAYCHECK_CREW * 4

/datum/supply_pack/imports/security/mcr_parts/grip
	name = "MCR Grip"
	contains = list(/obj/item/microfusion_gun_attachment/grip)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/imports/security/mcr_parts/scatter
	name = "MCR Scatter Barrel"
	contains = list(/obj/item/microfusion_gun_attachment/barrel/scatter)
	cost = PAYCHECK_CREW * 4

/datum/supply_pack/imports/security/mcr_parts/scope
	name = "MCR Scope Attachment"
	contains = list(/obj/item/microfusion_gun_attachment/scope)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/imports/security/mcr_parts/rail
	name = "MCR Rail Attachment"
	contains = list(/obj/item/microfusion_gun_attachment/rail)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/imports/security/mcr_parts/heatsink
	name = "MCR Heatsink"
	contains = list(/obj/item/microfusion_gun_attachment/heatsink)
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/imports/security/mcr_parts/lance
	name = "MCR Lance Modification"
	contains = list(/obj/item/microfusion_gun_attachment/barrel/lance)
	cost = PAYCHECK_CREW * 4

/datum/supply_pack/imports/security/mcr_parts/emitter_enhanced
	name = "Enhanced MCR Emitter"
	contains = list(/obj/item/microfusion_phase_emitter/enhanced)
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/imports/security/mcr_parts/emitter_advanced
	name = "Advanced MCR Emitter"
	contains = list(/obj/item/microfusion_phase_emitter/advanced)
	cost = PAYCHECK_CREW * 5

/datum/supply_pack/imports/security/mcr_parts/emitter_bspace
	name = "Bluespace MCR Emitter"
	contains = list(/obj/item/microfusion_phase_emitter/bluespace)
	cost = PAYCHECK_CREW * 7

/datum/supply_pack/imports/security/mcr_parts/stabilize
	name = "MCR Cell Stabilizer"
	contains = list(/obj/item/microfusion_cell_attachment/stabiliser)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/imports/security/mcr_parts/overcapacity
	name = "MCR Cell Overcapacity Attachment"
	contains = list(/obj/item/microfusion_cell_attachment/overcapacity)
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/imports/security/mcr_parts/selfcharge
	name = "MCR Cell Self-Charging Attachment"
	contains = list(/obj/item/microfusion_cell_attachment/selfcharging)
	cost = PAYCHECK_CREW * 5

/datum/supply_pack/imports/security/mcr_parts/kit
	goody = FALSE
	cost = PAYCHECK_CREW * 1.5

/datum/supply_pack/imports/security/mcr_parts/kit/hellfire
	name = "MCR Hellfire Kit"
	contains = list(/obj/item/storage/briefcase/secure/white/mcr_loadout/hellfire)

/datum/supply_pack/imports/security/mcr_parts/kit/scatter
	name = "MCR Scatter Kit"
	contains = list(/obj/item/storage/briefcase/secure/white/mcr_loadout/scatter)

/datum/supply_pack/imports/security/mcr_parts/kit/lance
	name = "MCR Lance Kit"
	contains = list(/obj/item/storage/briefcase/secure/white/mcr_loadout/lance)

/datum/supply_pack/imports/security/mcr_parts/kit/repeater
	name = "MCR Repeater Kit"
	contains = list(/obj/item/storage/briefcase/secure/white/mcr_loadout/repeater)

/datum/supply_pack/imports/security/mcr_parts/kit/suppressor
	name = "MCR Suppressor Kit"
	contains = list(/obj/item/storage/briefcase/secure/white/mcr_loadout/tacticool)

/datum/supply_pack/imports/security/mcr_parts/kit/enhanced
	name = "MCR Enhanced Parts Kit"
	contains = list(/obj/item/storage/briefcase/secure/white/mcr_parts/enhanced)

/datum/supply_pack/imports/security/mcr_parts/kit/advanced
	name = "MCR Advanced Parts Kit"
	contains = list(/obj/item/storage/briefcase/secure/white/mcr_parts/)
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/imports/security/mcr_parts/kit/bluespace
	name = "MCR Bluespace Parts Kit"
	contains = list(/obj/item/storage/briefcase/secure/white/mcr_parts/bluespace)
	cost = PAYCHECK_CREW * 5.5
/datum/supply_pack/security/armory/mechthermal
	access = FALSE
	access_any = list(ACCESS_SECURITY, ACCESS_ROBOTICS)
	access_view = FALSE

/datum/supply_pack/security/pepperballguns
	name = "Pepperball Gun Crate"
	desc = "Contains three pepperball guns, a non-lethal weapon that fires pepper-filled projectiles."
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/pepperball = 3)
	access = ACCESS_SECURITY

/datum/supply_pack/security/Tasers
	name = "Taser Crate"
	desc = "Contains three hybrid tasers, a non-lethal weapon that fires electric projectiles and features a secondary disabler."
	cost = CARGO_CRATE_VALUE * 5.5
	contains = list(/obj/item/gun/energy/e_gun/advtaser = 3)
	access = ACCESS_SECURITY

/datum/supply_pack/security/laser
	cost = CARGO_CRATE_VALUE * 7

/datum/supply_pack/security/armory/energy
	desc = "Contains three energy guns, capable of firing both nonlethal and lethal \
		blasts of light."
	cost = CARGO_CRATE_VALUE * 7
	contains = list(/obj/item/gun/energy/e_gun = 3)

/datum/supply_pack/security/armory/laser_carbine
	cost = CARGO_CRATE_VALUE * 7

/datum/supply_pack/security/combine
	name = "Civil Protection Uniforms"
	desc = "Extra supplies we got from some weird old guy in a blue suit. Contains six uniforms, \
		vests, boots, gloves and helmets."
	cost = 1116
	contraband = TRUE
	contains = list(/obj/item/clothing/head/helmet/metrocophelmet = 6,
					/obj/item/clothing/suit/armor/vest/alt/sec/metrocop = 6,
					/obj/item/clothing/under/rank/security/metrocop = 6,
					/obj/item/clothing/gloves/color/black/security/metrocop = 6,
					/obj/item/clothing/shoes/jackboots/combine = 6,
					/obj/item/trash/can = 3,
				)
	crate_name = "benefactor supply crate"
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE
