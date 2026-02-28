/obj/projectile/meat_ball
	name = "Meat ball"
	icon_state = "mini_leaper"
	speed = 0.5
	range = 16
	layer = LARGE_MOB_LAYER
	var/mob_type

/obj/projectile/meat_ball/on_hit(atom/target, blocked, pierce_hit)
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.visible_message(span_danger("[living_target] is splattered with blood!"), span_userdanger("You're splattered with blood!"))
		living_target.add_blood_DNA(list("Non-human DNA" = random_human_blood_type()))
		living_target.Knockdown(2 SECONDS)
	for(var/turf/blood_turf in view(src, 1))
		new /obj/effect/decal/cleanable/blood(blood_turf)
	playsound(get_turf(src), 'sound/effects/splat.ogg', 50, TRUE, extrarange = SILENCED_SOUND_EXTRARANGE)
	new mob_type(get_turf(src))
	. = ..()


/datum/action/cooldown/mob_cooldown/throw_spider
	name = "Throw meat spider ball"
	button_icon_state = "berserk_mode"
	cooldown_time = 6 SECONDS
	shared_cooldown = NONE

	var/mob_type = /mob/living/basic/khara_mutant/flesh_spider/weaker

/datum/action/cooldown/mob_cooldown/throw_spider/Activate(atom/target)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(launch_thing), target)

/datum/action/cooldown/mob_cooldown/throw_spider/proc/launch_thing(atom/target)
	new /obj/effect/temp_visual/telegraphing/boss_hit(get_turf(target))
	sleep(1 SECONDS)
	var/obj/projectile/meat_ball/ball = new /obj/projectile/meat_ball(owner.loc)
	ball.mob_type = mob_type
	ball.aim_projectile(target, owner)
	playsound(get_turf(owner), 'sound/effects/splat.ogg', 30, TRUE, extrarange = SILENCED_SOUND_EXTRARANGE)
	INVOKE_ASYNC(ball, TYPE_PROC_REF(/obj/projectile, fire))

#define RUMBLE_RADIUS 3
#define RUMBLE_WARNING_TIME (1.5 SECONDS)
#define RUMBLE_KNOCKDOWN_TIME (3 SECONDS)
#define RUMBLE_THROW_SPEED 1.5

/datum/action/cooldown/mob_cooldown/rumble
	name = "Rumble Earth"
	desc = "Violently shake the ground around you, knocking down and repelling nearby creatures."
	button_icon_state = "berserk_mode"
	cooldown_time = 8 SECONDS
	click_to_activate = FALSE
	shared_cooldown = NONE

	var/radius = RUMBLE_RADIUS


/datum/action/cooldown/mob_cooldown/rumble/Activate(atom/target)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(run_rumbling))

/datum/action/cooldown/mob_cooldown/rumble/proc/run_rumbling()
	owner.visible_message(
		span_danger("[owner] slams [owner.p_their()] limbs into the ground!"),
		span_userdanger("You slam the ground with tremendous force!")
	)

	playsound(owner, 'sound/effects/bang.ogg', 60, TRUE, frequency = 0.9, extrarange = SILENCED_SOUND_EXTRARANGE)
	var/turf/center = get_turf(owner)
	for(var/turf/T in range(radius, center))
		if(get_dist(center, T) > radius)
			continue
		new /obj/effect/temp_visual/telegraphing/boss_hit(T)
	sleep(RUMBLE_WARNING_TIME)

	rumble_wave(center)

/datum/action/cooldown/mob_cooldown/rumble/proc/rumble_wave(turf/epicenter)
	var/static/list/ripple_sounds = list(
		'sound/effects/bang.ogg',
	)

	var/max_wave_radius = radius + 2
	var/list/affected_mobs = list()

	for(var/current_radius in 1 to max_wave_radius)
		sleep(1.5 + (current_radius * 0.8))
		var/list/ring_turfs = list()
		for(var/turf/T in range(current_radius, epicenter))
			if(get_dist(epicenter, T) == current_radius)
				ring_turfs += T
		if(!length(ring_turfs))
			continue
		for(var/turf/T in ring_turfs)
			animate(T, pixel_x = rand(-3,3), pixel_y = rand(-3,3), time = 3, loop = 2, easing = JUMP_EASING)
			animate(pixel_x = 0, pixel_y = 0, time = 4)
		CHECK_TICK
		var/volume = clamp(90 - (current_radius * 12), 30, 90)
		playsound(epicenter, pick(ripple_sounds), volume, TRUE, frequency = 0.7 + (current_radius * 0.04))
		for(var/mob/living/L in range(current_radius + 1, epicenter))
			if(L in affected_mobs)
				continue
			if(L == owner)
				continue
			if(L.incorporeal_move)
				continue
			var/dist = get_dist(epicenter, L)
			if(dist < current_radius - 1 || dist > current_radius + 1.5)
				continue

			affected_mobs += L

			var/strength = clamp((max_wave_radius - dist + 1), 1, max_wave_radius)
			L.apply_damage(5 + strength * 2.5, BRUTE, BODY_ZONE_CHEST, wound_bonus = CANT_WOUND)
			L.Knockdown(2 SECONDS + strength * 1.2)
			L.Paralyze(0.4 SECONDS)

			if(!L.anchored)
				var/dir = get_dir(epicenter, L)
				if(!dir) dir = pick(GLOB.cardinals)

				var/throw_dist = clamp(strength, 1, 5)
				var/turf/target_turf = get_ranged_target_turf(L, dir, throw_dist)
				L.throw_at(target_turf, throw_dist, 1.6, src, spin = FALSE)
		CHECK_TICK
		for(var/mob/M in range(7, epicenter))
			if(current_radius <= 3)
				shake_camera(M, 4, 1.5 + (current_radius * 0.4))
			else
				shake_camera(M, 3, 1)

#undef RUMBLE_RADIUS
#undef RUMBLE_WARNING_TIME
#undef RUMBLE_KNOCKDOWN_TIME
#undef RUMBLE_THROW_SPEED

/datum/action/cooldown/mob_cooldown/aoe_slash
	name = "Rending Slash"
	desc = "Unleash a violent area-of-effect slash in front of you, cutting through flesh and matter."
	background_icon_state = "bg_alien"
	cooldown_time = 7 SECONDS
	shared_cooldown = NONE

	var/damage = 50
	var/obj_damage_mult = 4
	var/wound_bonus = 30
	var/armour_penetration = 50
	var/slash_color = "#ff3333"
	var/attack_sound = 'modular_zvents/sounds/mobs/slash_attack_sound.ogg'
	var/attack_cd = CLICK_CD_MELEE
	var/range = 1


/datum/action/cooldown/mob_cooldown/aoe_slash/Activate(atom/target)
	if(!target || get_dist(target, owner) > 1)
		owner.balloon_alert(owner, "To far!")
		return FALSE
	var/turf/target_turf = get_turf(target)
	if(isclosedturf(target_turf))
		return
	. = ..()

	owner.visible_message(
		span_danger("[owner] performs a ferocious sweeping slash!"),
		span_userdanger("You unleash a devastating area slash!")
	)
	new /obj/effect/temp_visual/telegraphing/boss_hit(get_turf(target_turf))
	addtimer(CALLBACK(src, PROC_REF(do_slash), target_turf), 1 SECONDS)
	return TRUE


/datum/action/cooldown/mob_cooldown/aoe_slash/proc/do_slash(turf/target)
	owner.do_attack_animation(target, ATTACK_EFFECT_SLASH)
	new /obj/effect/temp_visual/huge_slash(target, target, world.icon_size / 2, world.icon_size / 2, slash_color)

	playsound(target, attack_sound, 50, vary = TRUE)

	perform_aoe_slash(target)
	owner.changeNext_move(attack_cd)


/datum/action/cooldown/mob_cooldown/aoe_slash/proc/perform_aoe_slash(turf/epicenter)
	var/list/affected = list()
	for(var/turf/T in range(range - 1, epicenter))
		if(get_dist(owner, T) > range)
			continue

		for(var/atom/A in T.contents)
			if(A in affected)
				continue

			if(isliving(A))
				var/mob/living/L = A
				if(L == owner)
					continue

				L.apply_damage(
					damage,
					BRUTE,
					owner.zone_selected,
					wound_bonus = wound_bonus,
					sharpness = SHARP_EDGED,
					attacking_item = src
				)

				log_combat(owner, L, "aoe slashed", src)
				affected += L

			else if(A.uses_integrity)
				A.take_damage(
					damage * obj_damage_mult,
					BRUTE,
					MELEE,
					TRUE,
					src,
					armour_penetration
				)


/obj/effect/temp_visual/huge_slash
	icon_state = "highfreq_slash"
	alpha = 170
	duration = 0.5 SECONDS
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE

/obj/effect/temp_visual/huge_slash/Initialize(mapload, atom/target, x_slashed, y_slashed, slash_color)
	. = ..()
	if(!target)
		return
	var/matrix/new_transform = matrix()
	new_transform.Turn(rand(1, 360))
	var/datum/decompose_matrix/decomp = target.transform.decompose()
	new_transform.Translate((x_slashed - ICON_SIZE_X/2) * decomp.scale_x, (y_slashed - ICON_SIZE_Y/2) * decomp.scale_y)


	new_transform.Turn(decomp.rotation)
	new_transform.Translate(decomp.shift_x, decomp.shift_y)
	new_transform.Translate(target.pixel_x, target.pixel_y)
	transform = new_transform

	var/matrix/scaled_transform = new_transform + matrix(new_transform.a, new_transform.b, 0, new_transform.d, new_transform.e, 0)
	scaled_transform.Scale(2, 2)
	animate(src, duration*0.5, color = slash_color, transform = scaled_transform, alpha = 255)

/datum/action/cooldown/mob_cooldown/boss_charge/weak
	max_range = 6
	charge_delay = 1 SECONDS
