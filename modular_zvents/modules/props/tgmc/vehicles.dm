/obj/structure/prop/vehicle/tank
	name = "Tank"
	desc = "The massive battle tank, this one seems in perfect conditions."
	icon = 'modular_zvents/icons/structures/props/tgmc/campaign_bigger.dmi'
	icon_state = "tank"
	density = TRUE
	opacity = TRUE
	pressure_resistance = 8
	max_integrity = 2500
	layer = BELOW_OBJ_LAYER
	flags_ricochet = RICOCHET_SHINY
	receive_ricochet_chance_mod = 0.6
	pass_flags_self = PASSSTRUCTURE

	pixel_x =  -90

/obj/structure/prop/vehicle/tank/broken
	name = "Tank wreckage"
	desc = "The massive remains of a battle tank, something tore it to pieces."
	icon_state = "tank_broken"
