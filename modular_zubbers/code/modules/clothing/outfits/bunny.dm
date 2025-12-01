/datum/outfit/bunny_waiter
	name = "Bunny Waiter"
	uniform = /obj/item/clothing/under/costume/playbunny/greyscale
	back = /obj/item/storage/backpack/satchel
	box = /obj/item/storage/box/survival
	suit = /obj/item/clothing/suit/jacket/tailcoat
	gloves = /obj/item/clothing/gloves/color/white
	shoes = /obj/item/clothing/shoes/high_heels
	head = /obj/item/clothing/head/playbunnyears
	neck = /obj/item/clothing/neck/tie/bunnytie/tied
	ears = /obj/item/radio/headset/headset_srv
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/job/bartender
	r_pocket = /obj/item/rag
	l_pocket = /obj/item/toy/cards/deck
	l_hand = /obj/item/storage/bag/tray
	undershirt = "Nude"

/datum/outfit/bunny_waiter/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/W = H.wear_id
	W.registered_name = H.real_name
	W.update_label()
	W.update_icon()
	return ..()
