/obj/item/clothing/suit/chaplainsuit/armor/templar/hospitaller
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/chaplain.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/chaplain.dmi'
	desc = "Protect the weak and defenceless, live by honor and glory, and fight for the welfare of all!"
	icon_state = "knight_hospitaller"
	unique_reskin = null

/obj/item/clothing/suit/chaplainsuit/armor/templar/hospitaller/no_armor
	armor_type = /datum/armor/none

//
/obj/item/clothing/suit/goner
	name = "trencher coat"
	desc = "A generic trench coat of the boring wars. This one have purple, corporate insignias."
	icon = 'modular_zzplurt/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_zzplurt/icons/mob/clothing/suit.dmi'
	worn_icon_digi = 'modular_zzplurt/icons/mob/clothing/suit_digi.dmi'
	icon_state = "goner_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	armor_type = /datum/armor/suit_armor/goner

/datum/armor/suit_armor/goner
	melee = 25
	bullet = 10
	laser = 25
	energy = 10
	bomb = 5
	bio = 5
	fire = 50
	acid = 45
	wound = 10

/obj/item/clothing/suit/goner/Initialize(mapload)
	. = ..()
	allowed = GLOB.detective_vest_allowed + typecacheof(/obj/item/toy)

/obj/item/clothing/suit/goner/fake
	name = "trencher coat replica"
	desc = "A 90% replica of No Man's Land-type coat."
	armor_type = /datum/armor/none

//
/obj/item/clothing/suit/goner/red
	name = "red trencher coat"
	desc = "A trench coat of the boring wars. This one have red insignias."
	icon_state = "goner_suit_r"

/obj/item/clothing/suit/goner/green
	name = "green trencher coat"
	desc = "A trench coat of the boring wars. This one have green insignias."
	icon_state = "goner_suit_g"

/obj/item/clothing/suit/goner/blue
	name = "blue trencher coat"
	desc = "A trench coat of the boring wars. This one have blue insignias."
	icon_state = "goner_suit_b"

/obj/item/clothing/suit/goner/yellow
	name = "yellow trencher coat"
	desc = "A trench coat of the boring wars. This one have yellow insignias."
	icon_state = "goner_suit_y"
