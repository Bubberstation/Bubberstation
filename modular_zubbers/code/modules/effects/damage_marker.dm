/obj/effect/overlay/damage_marker
	icon = 'icons/effects/96x160.dmi'
	plane = BALLOON_CHAT_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 64
	var/mob/living/carbon/my_carbon_mob
	var/list/static/colour = list(
		BRUTE = list("clr" = "#FF0000", "str" = list("thwack", "smack", "bang", "crunch")),
		BURN = list("clr" = "#FF9900", "str" = list("sizzle", "smoulder", "fizz", "burst")),
		TOX = list("clr" = "#00FF00", "str" = list("")),
		OXY = list("clr" = "#7777FF", "str" = list("")),

	)
	proc/animate_damage(damage, my_mob, damagetype)
		my_carbon_mob = my_mob
		pixel_z = rand(-8,8)
		pixel_w = rand(-8,8)
		appearance_flags |= (KEEP_TOGETHER|RESET_COLOR|RESET_TRANSFORM)
		my_carbon_mob.vis_contents |= src
		maptext = MAPTEXT_SPESSFONT("<span style=\"color:[colour[damagetype]["clr"]];\">[pick(colour[damagetype]["str"])]!</span>")
		animate(src, pixel_z = rand(-64,64), pixel_w = rand(-64,64), time = 1 SECONDS, easing = BOUNCE_EASING, alpha = 255)
		animate(alpha = 0, time = 0.5 SECONDS)
		QDEL_IN(src, 1.5 SECONDS)
		message_admins(maptext)

