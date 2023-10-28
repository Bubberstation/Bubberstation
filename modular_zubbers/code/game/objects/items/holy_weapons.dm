/obj/item/nullrod/papal_staff
	name = "papal staff"
	desc = "A staff used by traditional bishops and popes."
	icon = 'modular_zubbers/icons/obj/items_and_weapons.dmi'
	icon_state = "papal_staff"
	inhand_icon_state = "papal_staff"
	belt_icon_state = "baguette"
	worn_icon_state = "baguette"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("smacks", "strucks", "cracks", "beats", "purifies")
	attack_verb_simple = list("smack", "struck", "crack", "beat", "purify")

/obj/item/clothing/head/mitre
	name = "papal mitre"
	desc = "A traditional headdress, worn by bishops and popes in traditional Christianity"
	icon = 'modular_zubbers/icons/mob/clothing/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/32x48_head.dmi'
	icon_state = "mitre"

/obj/item/clothing/suit/chaplainsuit/armor/papal
	name = "papal robe"
	desc = "A short cape over a cassock, worn by bishops and popes in traditional Christianity"
	icon = 'modular_zubbers/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits.dmi'
	icon_state = "papalrobe"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/storage/box/holy/papal
	name = "Papal Kit"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/papal

/obj/item/storage/box/holy/papal/PopulateContents()
	new /obj/item/clothing/head/mitre(src)
	new /obj/item/clothing/suit/chaplainsuit/armor/papal(src)
