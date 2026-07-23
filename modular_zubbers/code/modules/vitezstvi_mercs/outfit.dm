/obj/item/clothing/head/helmet/space/beret/vitezstvi
	name = "contractor's beret"
	desc = "An armoured olive beret with a gold Vítězství Arms pin. The plating is sewn between two layers of felt, which is either clever or a war crime depending on who you ask."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/helmet/space/beret"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#397F3F#FFCE5B"

/obj/item/card/id/advanced/centcom/ert/nri/vitezstvi
	name = "contractor's ID card"
	desc = "An ID straight from the Pan-Slavic Commonwealth. Or was it the NRI?"
	registered_name = "Vítězství Arms Contractor"
	trim = /datum/id_trim/nri/vitezstvi

/obj/item/card/id/advanced/centcom/ert/nri/vitezstvi/GetAccess()
	// Doors and consoles read GetAccess(), not the raw access list, so granting it here
	// makes contractor access independent of trim application and spawn ordering.
	return ..() | vitezstvi_contractor_access()

/datum/outfit/vitezstvi_merc
	name = "Vítězství Arms SRT Contractor"
	head = /obj/item/clothing/head/helmet/space/beret/vitezstvi
	glasses = /obj/item/clothing/glasses/hud/medsechud/sunglasses
	ears = /obj/item/radio/headset/vitezstvi
	mask = null
	neck = null
	uniform = /obj/item/clothing/under/costume/nri/captain
	suit = /obj/item/clothing/suit/armor/vest/marine
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/combat
	belt = /obj/item/storage/belt/military/nri/soldier/vitezstvi
	back = /obj/item/mod/control/pre_equipped/frontline/ert/vitezstvi
	suit_store = /obj/item/gun/ballistic/revolver/mateba
	backpack_contents = list(
		/obj/item/storage/box/nri_survival_pack = 1,
		/obj/item/storage/medkit/emergency = 1,
		/obj/item/ammo_box/speedloader/c357 = 2,
		/obj/item/reagent_containers/cup/glass/bottle/vodka = 2,
	)
	l_pocket = /obj/item/ammo_box/speedloader/c357
	r_pocket = /obj/item/ammo_box/speedloader/c357
	id = /obj/item/card/id/advanced/centcom/ert/nri/vitezstvi
	id_trim = /datum/id_trim/nri/vitezstvi

/// Everything a contractor ID carries. A literal list rather than a region lookup, so
/// it cannot come up empty depending on subsystem init order.
/proc/vitezstvi_contractor_access()
	return list(
		ACCESS_MERC,
		ACCESS_SECURITY,
		ACCESS_BRIG,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_ARMORY,
		ACCESS_WEAPONS,
		ACCESS_COURT,
		ACCESS_DETECTIVE,
		ACCESS_COMMAND,
		ACCESS_KEYCARD_AUTH,
		ACCESS_KITCHEN,
		ACCESS_MEDICAL,
		ACCESS_ENGINEERING,
		ACCESS_ATMOSPHERICS,
		ACCESS_CARGO,
		ACCESS_MAINT_TUNNELS,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_EVA,
		ACCESS_MORGUE,
	)

/datum/id_trim/nri/vitezstvi
	assignment = "Vítězství Arms Contractor"
	department_color = COLOR_OLIVE_GREEN
	subdepartment_color = COLOR_GOLD
	sechud_icon_state = "hudvitezstvi"

/datum/id_trim/nri/vitezstvi/New()
	. = ..()
	access |= vitezstvi_contractor_access()

/datum/outfit/vitezstvi_merc/post_equip(mob/living/carbon/human/user, visuals_only = FALSE)
	. = ..()
	if(visuals_only)
		return
	stamp_contractor_id(user)
	var/obj/item/implant/mindshield/loyalty = new()
	loyalty.implant(user, null, silent = TRUE, force = TRUE)
	var/obj/item/organ/liver/cybernetic/tier3/iron_liver = new()
	iron_liver.Insert(user, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	user.reagents.add_reagent(/datum/reagent/consumable/ethanol/vodka, 15)

/// Force the contractor's access and name onto whatever ID they are actually wearing.
/// Called from the outfit and again after the spawner finishes, because preference
/// application can hand the mob a fresh card after the outfit is done with it.
/proc/stamp_contractor_id(mob/living/carbon/human/user)
	if(!istype(user))
		return
	var/obj/item/card/id/id_card = user.wear_id?.GetID()
	if(!id_card)
		id_card = user.get_idcard(hand_first = FALSE)
	if(!id_card)
		return
	id_card.access |= vitezstvi_contractor_access()
	if(user.real_name)
		id_card.registered_name = user.real_name
	id_card.assignment = "Vítězství Arms Contractor"
	id_card.update_label()

/obj/item/storage/belt/military/nri/soldier/vitezstvi/PopulateContents()
	new /obj/item/knife/combat(src)
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/ammo_box/speedloader/c357(src)
	new /obj/item/ammo_box/speedloader/c357(src)
