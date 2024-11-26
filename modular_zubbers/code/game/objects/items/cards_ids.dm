//Cosmetic ID cards that use cardboard to make them useless as actual IDs, while still looking vaguely like one.
/obj/item/card/cardboard/unioncard
	name = "union membership card"
	desc = "Considered contraband on Nanotrasen-aligned stations, this card proclaims the wearer's membership to the Worker's Union."
	icon = 'modular_zubbers/icons/obj/card.dmi'
	icon_state = "union"
	inhand_icon_state = "union"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/idcards_righthand.dmi'


/obj/item/card/cardboard/korvenbank
	name = "korven bank card"
	desc = "An old, blank bank card with an inactive account, belonging to the Korve Central Bank."
	icon = 'modular_zubbers/icons/obj/card.dmi'
	icon_state = "korven_bank"
	inhand_icon_state = "korven"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/idcards_righthand.dmi'

/obj/item/card/id/advanced/centcom/station
	name = "\improper CentCom ID"
	desc = "An ID straight from Central Command."
	icon_state = "card_centcom"
	assigned_icon_state = "assigned_centcom"
	registered_name = JOB_CENTCOM
	registered_age = null
	trim = /datum/id_trim/centcom
	wildcard_slots = WILDCARD_LIMIT_SILVER
