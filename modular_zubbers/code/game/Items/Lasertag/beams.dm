/obj/projectile/beam/lasertag
	name = "laser tag beam"
	icon_state = "omnilaser"
	hitsound = null
	damage = 0
	damage_type = STAMINA
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE
	var/lasertag_team = "neutral"

/obj/projectile/beam/lasertag/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/M = target
		var/datum/component/lasertag/comp = M?.GetComponent(/datum/component/lasertag)
		if(comp)
			if(lasertag_team != comp.team_color)
				M.adjustStaminaLoss(34)

/obj/projectile/beam/lasertag/redtag
	icon_state = "laser"
	lasertag_team = "red"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = COLOR_SOFT_RED
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/projectile/beam/lasertag/redtag/hitscan
	icon_state = null
	hitscan = TRUE

/obj/projectile/beam/lasertag/bluetag
	icon_state = "bluelaser"
	lasertag_team = "blue"
	tracer_type = /obj/effect/projectile/tracer/laser/blue
	muzzle_type = /obj/effect/projectile/muzzle/laser/blue
	impact_type = /obj/effect/projectile/impact/laser/blue

/obj/projectile/beam/lasertag/bluetag/hitscan
	icon_state = null
	hitscan = TRUE
