/obj/machinery/door/puzzle/keycard/rnd
	name = "R&D Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has purple markings on it."
	puzzle_id = "tarkon1"

/obj/machinery/door/puzzle/keycard/engi
	name = "Engineering Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has orange markings on it."
	puzzle_id = "tarkon2"

/obj/machinery/door/puzzle/keycard/med
	name = "Medical Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has blue markings on it."
	puzzle_id = "tarkon3"

/obj/machinery/door/puzzle/keycard/vault
	name = "Vault Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has black markings on it."
	puzzle_id = "tarkon4"

/obj/item/keycard/tarkon_rnd
	name = "Research keycard"
	desc = "Tarkon industries secure storage lock key."
	color = "#a03aaf"
	puzzle_id = "tarkon1"

/obj/item/keycard/tarkon_engi
	name = "Engineering keycard"
	desc = "Tarkon industries secure storage lock key."
	color = "#f05812"
	puzzle_id = "tarkon2"

/obj/item/keycard/tarkon_med
	name = "Medical keycard"
	desc = "Tarkon industries secure storage lock key."
	color = "#33d4ff"
	puzzle_id = "tarkon3"

/obj/item/keycard/tarkon_vault
	name = "Vault keycard"
	desc = "Tarkon industries secure storage lock key."
	color = "#303030"
	puzzle_id = "tarkon4"

/mob/living/basic/alien/drone/tarkon
	basic_mob_flags = DEL_ON_DEATH
	var/static/list/death_loot = list(/obj/effect/decal/cleanable/xenoblood)
	AddElement(/datum/element/death_drops, death_loot)
