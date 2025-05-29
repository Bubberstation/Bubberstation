/obj/structure/closet/secure_closet/psychology //GS13: Psychologist job equip locker
	name = "psychology locker"
	req_access = list(ACCESS_PSYCH)
	icon_state = "cabinet"

/obj/structure/closet/secure_closet/psychology/PopulateContents()
	. = ..()
	new /obj/item/clothing/under/suit/black(src)
	new /obj/item/clothing/under/suit/black/skirt(src)
	new /obj/item/clothing/shoes/laceup/(src)
	new /obj/item/storage/backpack/medic(src)
	new /obj/item/radio/headset/headset_med(src)
	new /obj/item/clipboard(src)
	new /obj/item/clothing/suit/straight_jacket(src)
	new /obj/item/clothing/ears/earmuffs(src)
	new /obj/item/clothing/mask/muzzle(src)
	new /obj/item/clothing/glasses/sunglasses/blindfold(src)
