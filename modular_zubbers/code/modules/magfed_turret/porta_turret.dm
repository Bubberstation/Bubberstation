/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/cerberus
	name = "\improper T.I.B.S \"Cerberus\" Guardian Turret"
	desc = "A heavy-protection turret used in the Tarkon Industries Blackrust Salvage group to protect its workers in hazardous conditions."
	integrity_failure = 0
	max_integrity = 200
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "cerberus_off"
	base_icon_state = "cerberus"
	faction = list(FACTION_TARKON, FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/hoplite
	name = "\improper Tarkon Industries \"Hoplite\" Point-Defense Turret"
	desc = "A protection turret used by Tarkon Industries for civilian installation protection."
	max_integrity = 120
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "hoplite_off"
	base_icon_state = "hoplite"
	shot_delay = 15 //1.5 seconds
	faction = list(FACTION_TARKON, FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite/pre_filled
