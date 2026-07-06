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

/obj/item/card/id/advanced/lizardgas
	name = "Lizard Gas Employee Card"
	desc = "A rainbow ID card, promoting fun in a 'business proper' sense!"
	icon_state = "card_rainbow"
	trim = /datum/id_trim/away/lizardgas
	wildcard_slots = WILDCARD_LIMIT_GREY

/// Experimental faction budget cards, essentially budget cards you can withdraw from, intended for ghost roles.
/obj/item/card/id/faction_budget
	name = "departmental card (ERROR)"
	desc = "Provides access to the departmental budget."
	icon_state = "budgetcard"
	var/department_ID = ACCOUNT_CIV
	var/department_name = ACCOUNT_CIV_NAME
	registered_age = null

/obj/item/card/id/faction_budget/Initialize(mapload)
	. = ..()
	var/datum/bank_account/department_account = SSeconomy.get_dep_account(department_ID)
	if(department_account)
		set_account(department_account)
		name = "departmental card ([department_name])"
		desc = "Provides access to the [department_name]."
	SSeconomy.dep_cards += src

/obj/item/card/id/faction_budget/Destroy()
	SSeconomy.dep_cards -= src
	return ..()

/obj/item/card/id/faction_budget/update_label()
	return
