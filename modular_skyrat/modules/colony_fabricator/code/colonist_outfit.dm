/// Akhter Company Frontier Equipment orange, for the colonist ID
#define FRONTIER_ORANGE "#D15B1B"

// A toolbelt of the colony tools, for colonists and anyone testing them

/obj/item/storage/belt/utility/full/colonist
	preload = FALSE

/obj/item/storage/belt/utility/full/colonist/PopulateContents()
	new /obj/item/screwdriver/omni_drill(src)
	new /obj/item/crowbar/large/colony_prybar(src)
	new /obj/item/weldingtool/electric/arc_welder(src)
	new /obj/item/multitool/colony(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/t_scanner(src)
	new /obj/item/analyzer(src)

/datum/id_trim/colonist
	assignment = "Colonist"
	trim_state = "trim_stationengineer"
	department_color = FRONTIER_ORANGE
	subdepartment_color = FRONTIER_ORANGE
	access = list(
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINE_EQUIP,
		ACCESS_ENGINEERING,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_MINING,
		ACCESS_MINING,
	)

/obj/item/card/id/advanced/colonist
	name = "colonist ID"
	trim = /datum/id_trim/colonist

// A colonist with enough gear to survive a new world

/datum/outfit/colonist
	name = "Colonist (Frontier)"
	uniform = /obj/item/clothing/under/frontier_colonist
	suit = /obj/item/clothing/suit/frontier_colonist_flak
	gloves = /obj/item/clothing/gloves/frontier_colonist
	shoes = /obj/item/clothing/shoes/jackboots/frontier_colonist
	mask = /obj/item/clothing/mask/gas/atmos/frontier_colonist
	head = /obj/item/clothing/head/utility/hardhat/welding
	glasses = /obj/item/clothing/glasses/meson
	neck = /obj/item/clothing/neck/cloak/colonial
	ears = /obj/item/radio/headset/headset_frontier_colonist
	belt = /obj/item/storage/belt/utility/full/colonist
	back = /obj/item/mod/control/pre_equipped/frontier_colonist
	id = /obj/item/card/id/advanced/colonist
	id_trim = /datum/id_trim/colonist
	l_pocket = /obj/item/knife/combat/survival
	r_pocket = /obj/item/flashlight
	r_hand = /obj/item/gun/ballistic/rifle/boltaction
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/storage/medkit/frontier/stocked = 1,
		/obj/item/storage/box/colonial_rations = 1,
		/obj/item/ammo_box/speedloader/strilka310/surplus = 2,
		/obj/item/stack/sheet/iron/fifty = 1,
		/obj/item/stack/sheet/glass/fifty = 1,
		/obj/item/stock_parts/power_store/cell/high = 1,
		/obj/item/gps = 1,
	)

/datum/outfit/colonist/post_equip(mob/living/carbon/human/equipped, visuals_only = FALSE)
	. = ..()
	if(visuals_only)
		return
	var/obj/item/card/id/card = equipped.wear_id
	if(istype(card))
		card.registered_name = equipped.real_name
		card.update_label()
		card.update_icon()

#undef FRONTIER_ORANGE
