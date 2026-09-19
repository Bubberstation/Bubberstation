/obj/effect/overlay/damage_marker
	icon = 'icons/effects/96x160.dmi'
	plane = GAME_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 0

	var/mob/living/carbon/owner_mob

	var/static/list/damage_display = list(
		BRUTE = list("colour" = "#FF0000", "words" = list("thwack", "smack", "bang", "crunch")),
		BURN  = list("colour" = "#FF9900", "words" = list("sizzle", "smoulder", "fizz", "burst")),
		TOX   = list("colour" = "#00FF00", "words" = list("queasy", "nauseous", "woozy", "sick")),
		OXY   = list("colour" = "#7777FF", "words" = list("gasp", "choke", "wheeze", "faint")),
	)

	var/static/list/splat = list("splatter1", "splatter2", "splatter3", "splatter4")


/obj/effect/overlay/damage_marker/proc/animate_damage(damage, mob/living/carbon/target, damagetype)
	if(!istype(target))
		return
	var/list/display = damage_display[damagetype]
	if(!display)
		return

	owner_mob = target
	pixel_z = rand(-8, 8)
	pixel_w = rand(-8, 8)
	appearance_flags |= (KEEP_TOGETHER | RESET_COLOR | RESET_TRANSFORM)
	owner_mob.vis_contents |= src

	var/scale = ROUND_UP(clamp(damage / 18, 1, 2))

	if(scale == 2)
		var/image/blood = image('icons/effects/blood.dmi', icon_state = pick(splat))
		blood.alpha = 120
		blood.color = damage_display[damagetype]["colour"]
		blood.filters = outline_filter(1, "#000000")
		blood.layer = src.layer - 1
		overlays += blood

//	var/word = pick(display["words"])
	maptext = MAPTEXT_SPESSFONT("<span style='color:[display["colour"]];'>[ROUND_UP(damage)]</span>")

	animate(src, pixel_z = rand(clamp(-32, -64), clamp(32, 64)), pixel_w = rand(clamp(-32, -64), clamp(32, 64)), time = 1 SECONDS, easing = BOUNCE_EASING, alpha = 200)
	animate(alpha = 0, time = 0.5 SECONDS)
	QDEL_IN(src, 1.5 SECONDS)

/mob/living/carbon/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_USER_PRE_ITEM_ATTACK, PROC_REF(try_sweep_weapon))

/mob/living/carbon/proc/try_sweep_weapon(mob/living/source, mob/living/target, obj/item/used_weapon)
	SIGNAL_HANDLER
	if (isliving(target))
		return COMPONENT_CANCEL_ATTACK_CHAIN
	ASYNC
		var/obj/effect/overlay/sweep/sweep = new()
		sweep.item = used_weapon


/obj/effect/overlay/sweep
	icon = 'icons/effects/96x160.dmi'
	plane = GAME_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 64
	var/obj/item
	var/mob/living/carbon/owner_mob


/obj/effect/overlay/sweep

/obj/effect/overlay/sweep/proc/animate_sweep(mob/living/carbon/target)

	if(!istype(target))
		return

	icon = item.icon
	icon_state = item.icon_state
	owner_mob = target
	appearance_flags |= (KEEP_TOGETHER | RESET_COLOR | RESET_TRANSFORM)
	owner_mob.vis_contents |= src
	switch(owner_mob.dir)
		if (NORTH)
			animate(src, pixel_z = 32, time = 1 SECONDS, easing = BOUNCE_EASING, alpha = 255)
			animate(alpha = 0, time = 0.5 SECONDS)
		if (SOUTH)
			animate(src, pixel_z = -32, time = 1 SECONDS, easing = BOUNCE_EASING, alpha = 255)
			animate(alpha = 0, time = 0.5 SECONDS)
		if (EAST)
			animate(src, pixel_w = 64, time = 1 SECONDS, easing = BOUNCE_EASING, alpha = 255)
			animate(alpha = 0, time = 0.5 SECONDS)
		if (WEST)
			animate(src, pixel_w = -64, time = 1 SECONDS, easing = BOUNCE_EASING, alpha = 255)
			animate(alpha = 0, time = 0.5 SECONDS)
//	var/word = pick(display["words"])

	animate(src, pixel_z = rand(-64,64), pixel_w = rand(-64,64), time = 1 SECONDS, easing = BOUNCE_EASING, alpha = 255)
	animate(alpha = 0, time = 0.5 SECONDS)
	QDEL_IN(src, 1.5 SECONDS)
