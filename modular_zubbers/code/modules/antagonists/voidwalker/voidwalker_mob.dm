/mob/living/basic/voidwalker/take_them(mob/living/victim)

	//Make the victim dark and husk them.
	victim.reagents?.add_reagent(/datum/reagent/colorful_reagent/powder/black, 5)
	victim.become_husk(BURN)

	//Visual Effects.
	victim.flash_act(5 SECONDS, override_blindness_check = TRUE, visual = TRUE, type = /atom/movable/screen/fullscreen/flash/black)
	new /obj/effect/temp_visual/circle_wave/unsettle(get_turf(victim))

	//Teleport to a nearby area.
	var/turf/desired_turf = get_safe_lucky_player_turf(areas_to_exclude = list(get_area(src)))
	if(!desired_turf) //Failsafe.
		desired_turf = get_safe_random_station_turf()
	if(!desired_turf) //Do nothing as a failsafe for a failsafe.
		return
	victim.forceMove(desired_turf)

	//Paint the area they teleport to black.
	var/list/valid_turfs = range(4,desired_turf)
	var/datum/dimension_theme/chosen_theme = SSmaterials.dimensional_themes[/datum/dimension_theme/space]
	chosen_theme.apply_theme_to_list_of_turfs(valid_turfs)

	return TRUE
