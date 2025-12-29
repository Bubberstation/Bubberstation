/turf/open/moving
	name = "Matrix"
	desc = "You probably shouldn't see this"
	icon = 'modular_zvents/icons/turf/trainturf.dmi'
	turf_flags = NO_RUST | IS_SOLID | NOJAUNT
	gender = PLURAL
	tiled_turf = TRUE
	planetary_atmos = TRUE
	rust_resistance = RUST_RESISTANCE_ABSOLUTE

	// Двигаемся ли мы прямо сейчас (синхронизировано контроллером)
	VAR_FINAL/moving = FALSE
	// Направление симуляции движения фона (WEST = поезд "едет" EAST)
	VAR_FINAL/movement_direction = WEST
	// Префиксы для icon_state (анимация турфа)
	var/moving_prefix = "moving"
	var/still_prefix = "still"

	// Скорость движения фона (px/сек) — регулируй для реализма (100-300); override глобальной если нужно
	var/speed = 200
	VAR_PRIVATE/processing_content = FALSE

/turf/open/moving/Initialize(mapload)
	. = ..()
	SStrain_controller.register(src)

/turf/open/moving/Destroy()
	SStrain_controller.unregister(src)
	return ..()

/turf/open/moving/Melt()
	to_be_destroyed = FALSE
	return src

/turf/open/moving/singularity_act()
	return

/turf/open/moving/TerraformTurf(path, new_baseturf, flags)
	return

/turf/open/moving/ex_act(severity, target)
	return

/turf/open/moving/Enter(atom/movable/mover)
	. = ..()
	if(!moving)
		return
	if(QDELETED(mover) || isobserver(mover) || mover.flags_1 & NO_TURF_MOVEMENT)
		return
	SStrain_controller.queue_process(src)

/turf/open/moving/proc/check_process(register = TRUE)
	if(!length(contents))
		return FALSE
	for(var/atom/movable/AM in contents)
		if(QDELETED(AM) || isobserver(AM) || AM.flags_1 & NO_TURF_MOVEMENT)
			continue
		if(register)
			SStrain_controller.queue_process(src)
		return TRUE
	return FALSE

/turf/open/moving/proc/process_contents(seconds_per_tick)
	if(!moving || !length(contents) || processing_content)
		return
	processing_content = TRUE
	for(var/atom/movable/AM as anything in contents)
		if(QDELETED(AM) || isobserver(AM) || AM.flags_1 & NO_TURF_MOVEMENT)
			continue
		move_object(AM)
	processing_content = FALSE
	if(!check_process(register = FALSE))
		SStrain_controller.unqueue_process(src)

/turf/open/moving/proc/move_object(atom/movable/object)
	var/turf/current = object.loc
	var/turf/target = get_step(current, movement_direction)
	if(!target || isclosedturf(target))
		if(isliving(object) && !HAS_TRAIT(object, TRAIT_GODMODE))
			var/mob/living/L = object
			L.adjust_brute_loss(50)
			L.throw_at(get_step(current, movement_direction), 1, 2)
			if(L.stat == DEAD)
				L.gib()
		else
			qdel(object)
	else
		ASYNC
			object.Move(target)

/turf/open/moving/update_appearance(updates)
	. = ..()
	var/prefix = moving ? moving_prefix : still_prefix
	icon_state = "[base_icon_state]_[prefix]"


/turf/open/moving/snow
	name = "Snow"
	desc = "It looks cold"
	icon_state = "snow_still"
	base_icon_state = "snow"

	slowdown = 2

/turf/open/moving/rails
	name = "Rails"
	desc = "It's better not to stand in the way of a train."

	slowdown = 2

/turf/open/moving/rails/l1
	icon_state = "rails_left_1_still"
	base_icon_state = "rails_left_1"

/turf/open/moving/rails/l2
	icon_state = "rails_left_2_still"
	base_icon_state = "rails_left_2"

/turf/open/moving/rails/l3
	icon_state = "rails_left_3_still"
	base_icon_state = "rails_left_3"

/turf/open/moving/rails/l4
	icon_state = "rails_left_4_still"
	base_icon_state = "rails_left_4"

/turf/open/moving/rails/l5
	icon_state = "rails_left_5_still"
	base_icon_state = "rails_left_5"

/turf/open/moving/rails/l6
	icon_state = "rails_left_6_still"
	base_icon_state = "rails_left_6"

/turf/open/moving/rails/l7
	icon_state = "rails_left_7_still"
	base_icon_state = "rails_left_7"

/turf/open/moving/rails/l8
	icon_state = "rails_left_8_still"
	base_icon_state = "rails_left_8"

/turf/open/moving/rails/l9
	icon_state = "rails_left_9_still"
	base_icon_state = "rails_left_9"

/turf/open/moving/rails/l10
	icon_state = "rails_left_10_still"
	base_icon_state = "rails_left_10"

/turf/open/moving/rails/l11
	icon_state = "rails_left_11_still"
	base_icon_state = "rails_left_11"

/turf/open/moving/rails/l12
	icon_state = "rails_left_12_still"
	base_icon_state = "rails_left_12"

/turf/open/moving/rails/l13
	icon_state = "rails_left_13_still"
	base_icon_state = "rails_left_13"


/turf/open/moving/rails/r1
	icon_state = "rails_right_1_still"
	base_icon_state = "rails_right_1"

/turf/open/moving/rails/r2
	icon_state = "rails_right_2_still"
	base_icon_state = "rails_right_2"

/turf/open/moving/rails/r3
	icon_state = "rails_right_3_still"
	base_icon_state = "rails_right_3"

/turf/open/moving/rails/r4
	icon_state = "rails_right_4_still"
	base_icon_state = "rails_right_4"

/turf/open/moving/rails/r5
	icon_state = "rails_right_5_still"
	base_icon_state = "rails_right_5"

/turf/open/moving/rails/r6
	icon_state = "rails_right_6_still"
	base_icon_state = "rails_right_6"

/turf/open/moving/rails/r7
	icon_state = "rails_right_7_still"
	base_icon_state = "rails_right_7"

/turf/open/moving/rails/r8
	icon_state = "rails_right_8_still"
	base_icon_state = "rails_right_8"

/turf/open/moving/rails/r9
	icon_state = "rails_right_9_still"
	base_icon_state = "rails_right_9"

/turf/open/moving/rails/r10
	icon_state = "rails_right_10_still"
	base_icon_state = "rails_right_10"

/turf/open/moving/rails/r11
	icon_state = "rails_right_11_still"
	base_icon_state = "rails_right_11"

/turf/open/moving/rails/r12
	icon_state = "rails_right_12_still"
	base_icon_state = "rails_right_12"

/turf/open/moving/rails/r13
	icon_state = "rails_right_13_still"
	base_icon_state = "rails_right_13"


/turf/open/indestructible/train_platform
	name = "Platform"
	desc = "Railway station platform."
	icon = 'modular_zvents/icons/turf/trainturf.dmi'
	icon_state = "platform_middle_still"

/turf/open/indestructible/train_platform/bottom
	icon_state = "platform_bottom_still"

/turf/open/indestructible/train_platform/top
	icon_state = "platform_top_still"
