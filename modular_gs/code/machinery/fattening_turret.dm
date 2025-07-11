
/obj/machinery/porta_turret/fattening
	name = "Fatoray Turret"
	installation = null
	always_up = 1
	use_power = NO_POWER_USE
	has_cover = 0
	scan_range = 9
	req_access = list(ACCESS_SYNDICATE)
	lethal_projectile = /obj/projectile/beam/fattening
	lethal_projectile_sound = 'sound/items/weapons/laser.ogg'
	icon_state = "turretCover"
	base_icon_state = "standard"
	faction = list(ROLE_SYNDICATE)
	desc = "A laser turret with calorite focusing lens."

/obj/machinery/porta_turret/fattening/heavy
	name = "Heavy Fatoray Turret"
	lethal_projectile = /obj/projectile/beam/fattening/cannon
	shot_delay = 30

/obj/machinery/porta_turret/fattening/setup()
	return

/obj/machinery/porta_turret/fattening/assess_perp(mob/living/carbon/human/perp)
	return 10 //fattening turrets shoot everything except the syndicate
