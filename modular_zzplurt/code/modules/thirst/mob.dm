/mob
	var/water_level = THIRST_LEVEL_START_MIN
	var/in_thirst_update  = FALSE

/mob/proc/adjust_thirst(change, max = THIRST_LEVEL_THRESHOLD)
	if(HAS_TRAIT(src, TRAIT_NOTHIRST))
		return
	water_level = clamp(water_level + change, 0, max)
	if (!in_thirst_update)  // check update
		in_thirst_update = TRUE
		hud_used?.thirst?.update_appearance()
		in_thirst_update = FALSE

/mob/living/adjust_thirst(change, max)
	. = ..()
	if (!in_thirst_update)  // check update
		in_thirst_update = TRUE
		mob_mood?.HandleThirst()
		in_thirst_update = FALSE

/mob/proc/set_thirst(change)
	if(HAS_TRAIT(src, TRAIT_NOTHIRST))
		return
	water_level = max(0, change)
	if (!in_thirst_update)  // check update
		in_thirst_update = TRUE
		hud_used?.thirst?.update_appearance()
		in_thirst_update = FALSE

/mob/living/set_thirst(change, max)
	. = ..()
	if (!in_thirst_update)  // check update
		in_thirst_update = TRUE
		mob_mood?.HandleThirst()
		in_thirst_update = FALSE
