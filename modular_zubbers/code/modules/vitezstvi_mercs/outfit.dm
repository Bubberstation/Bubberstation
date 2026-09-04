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

/datum/outfit/vitezstvi_merc
	name = "Vítězství Arms SRT Contractor"
	head = /obj/item/clothing/head/helmet/space/beret/vitezstvi
	glasses = /obj/item/clothing/glasses/hud/medsechud
	mask = /obj/item/clothing/mask/gas/sechailer
	ears = /obj/item/radio/headset/vitezstvi
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
		/obj/item/ammo_box/speedloader/c357 = 1,
		/obj/item/reagent_containers/cup/glass/flask/vitezstvi = 1,
	)
	l_pocket = /obj/item/storage/fancy/cigarettes/cigpack_robust
	r_pocket = /obj/item/lighter
	id = /obj/item/card/id/advanced/centcom/ert/nri/vitezstvi
	id_trim = /datum/id_trim/nri/vitezstvi
	implants = list(/obj/item/implant/mindshield)

/// Literal rather than a region lookup, which can come up empty depending on init order.
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
	var/obj/item/organ/liver/cybernetic/tier3/iron_liver = new()
	iron_liver.Insert(user, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	user.reagents.add_reagent(/datum/reagent/consumable/ethanol/vodka, 15)

/// Syncs the worn ID's registered name to the contractor's assigned codename. The
/// trim carries the access, so this only touches the name, and runs again after
/// spawn because preference application can swap the card out from under the outfit.
/proc/stamp_contractor_id(mob/living/carbon/human/user)
	if(!istype(user))
		return
	var/obj/item/card/id/id_card = user.wear_id?.GetID()
	if(isnull(id_card))
		id_card = user.get_idcard(hand_first = FALSE)
	if(isnull(id_card))
		return
	if(user.real_name)
		id_card.registered_name = user.real_name
	id_card.update_label()

/obj/item/storage/belt/military/nri/soldier/vitezstvi/PopulateContents()
	new /obj/item/knife/combat(src)
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/ammo_box/speedloader/c357(src)
	new /obj/item/ammo_box/speedloader/c357(src)

/obj/item/reagent_containers/cup/glass/flask/vitezstvi
	name = "contractor's flask"
	desc = "Standard issue, including the Vodka."
	icon_state = "flask"
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 60)
