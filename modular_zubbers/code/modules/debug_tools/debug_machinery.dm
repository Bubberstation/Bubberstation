/obj/machinery/vending/tool/super
	name = "You (best) tool"
	desc = "Architector tools for free!"
	max_integrity = 99999
	products = list(
		/obj/item/crowbar/freeman/ultimate = 999,
		/obj/item/clothing/suit/space/hev_suit = 999,
		/obj/item/clothing/head/helmet/space/hev_suit = 999,
		/obj/item/gun/ballistic/automatic/pistol = 999,
		/obj/item/gun/ballistic/shotgun/automatic/combat/compact = 999,
		/obj/item/gun/ballistic/revolver = 999,
	)
	premium = list(
		/obj/item/clothing/glasses/debug/architector_glasses = 999,
		/obj/item/physic_manipulation_tool/advanced = 999,
		/obj/item/phystool = 999,
	)
	extra_price = PAYCHECK_ZERO
	default_price = PAYCHECK_ZERO
	resistance_flags = INDESTRUCTIBLE
	allow_custom = FALSE

/obj/machinery/vending/tool/super/screwdriver_act(mob/living/user, obj/item/attack_item)
	return FALSE
