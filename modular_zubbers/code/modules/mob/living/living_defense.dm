/mob/living/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	. = ..()
	if(. != BULLET_ACT_HIT)
		return .
	if(!hitting_projectile.is_hostile_projectile())
		return BULLET_ACT_HIT
	if(hitting_projectile.eyeblur)
		adjust_eye_blur_up_to(hitting_projectile.eyeblur, 20 SECONDS)
