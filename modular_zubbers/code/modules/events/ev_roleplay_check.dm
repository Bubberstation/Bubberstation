/// list of dorms areas for doing event checks
GLOBAL_LIST_EMPTY(dorms_areas)

/area/station/commons/dorms/New()
	. = ..()
	GLOB.dorms_areas += src

/datum/weather/proc/enhanced_roleplay_filter(list/affectareas)
	return affectareas

/datum/weather/rad_storm/enhanced_roleplay_filter(list/affectareas)
	var/list/filtered_areas = affectareas
	for(var/area/engaged_roleplay_area as anything in GLOB.dorms_areas)
		for(var/mob/living/carbon/human/roleplayer in engaged_roleplay_area.contents)
			if(engaged_role_play_check(player = roleplayer, station = FALSE, dorms = TRUE))
				LAZYREMOVE(filtered_areas, engaged_roleplay_area)
				break
	return filtered_areas

/datum/weather/rad_storm/send_alert(alert_msg, alert_sfx)
	for(var/area/impacted_area as anything in impacted_areas)
		for(var/mob/living/player in impacted_area.contents)
			if(!can_get_alert(player))
				continue
			if(alert_msg)
				to_chat(player, alert_msg)
			if(alert_sfx)
				SEND_SOUND(player, sound(alert_sfx))
