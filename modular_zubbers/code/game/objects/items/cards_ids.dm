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

//Port Tarkon ID Cards

/obj/item/card/id/advanced/tarkon
	name = "Tarkon deck access pass"
	desc = "A dust-collected visitors pass, A small tagline reading \"Port Tarkon, The first step to Civilian Partnership in Space Homesteading\"."
	icon = 'modular_skyrat/modules/tarkon/icons/misc/card.dmi'
	icon_state = "tarkon"
	trim = /datum/id_trim/away/tarkon
	assigned_icon_state = "assigned_tarkon"

/obj/item/card/id/advanced/tarkon/cargo
	name = "P-T cargo hauler's access card"
	desc = "An access card designated for \"cargo's finest\". You're also a part time space miner, when cargonia is quiet."
	trim = /datum/id_trim/away/tarkon/cargo

/obj/item/card/id/advanced/tarkon/sec
	name = "P-T resident deputy's access card"
	desc = "An access card designated for \"security members\". Everyone wants your guns, partner. Yee-haw."
	trim = /datum/id_trim/away/tarkon/sec

/obj/item/card/id/advanced/tarkon/service
	name = "P-T service techs access card"
	desc = "An access card designated for \"the stations` support\". Cook, clean, and keep everyone on the crew happy."
	trim = /datum/id_trim/away/tarkon/service

/obj/item/card/id/advanced/tarkon/med
	name = "P-T trauma medic's access card"
	desc = "An access card designated for \"medical staff\". You provide the medic bags."
	trim = /datum/id_trim/away/tarkon/med

/obj/item/card/id/advanced/tarkon/engi
	name = "P-T maintenance engineer's access card"
	desc = "An access card designated for \"engineering staff\". You're going to be the one everyone points at to fix stuff, lets be honest."
	trim = /datum/id_trim/away/tarkon/eng

/obj/item/card/id/advanced/tarkon/sci
	name = "P-T field researcher's access card"
	desc = "An access card designated for \"the science team\". You are forgotten basically immediately when it comes to the lab."
	trim = /datum/id_trim/away/tarkon/sci

/obj/item/card/id/away/tarkonrobo
	name = "Tarkon Robotics Card"
	desc = "An access card designed to access robot's access ports, provided by Tarkon Industries."
	icon = 'modular_skyrat/modules/tarkon/icons/misc/card.dmi'
	icon_state = "robotics"
	trim = /datum/id_trim/away/tarkon/robo

/obj/item/card/id/advanced/tarkon/ensign
	name = "Tarkon ensign's access card"
	desc = "An access card designated for \"Tarkon ensign\". No one has to listen to you... But you're the closest there is for command around here."
	trim = /datum/id_trim/away/tarkon/ensign

/obj/item/card/id/advanced/tarkon/director
	name = "Tarkon port director's access card"
	desc = "An access card designated for \"Tarkon's Port Director\". Its no longer hesitation, only consideration."
	trim = /datum/id_trim/away/tarkon/director

/obj/item/card/id/departmental_budget/tarkon
	department_ID = ACCOUNT_TAR
	department_name = ACCOUNT_TAR_NAME
	icon_state = "car_budget" // looks close enough
