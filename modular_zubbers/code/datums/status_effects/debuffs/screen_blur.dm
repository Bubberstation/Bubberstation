/datum/status_effect/eye_blur/on_creation(mob/living/new_owner, duration = 10 SECONDS)
	. = ..()
	src.duration = min(src.duration, 30 SECONDS)
