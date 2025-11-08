/proc/get_alive_station_crew(ignore_erp = TRUE, ignore_afk = TRUE, only_crew = TRUE, sort = TRUE)
	var/to_check = GLOB.alive_player_list.Copy()

	if(!length(to_check))
		return list()
	var/list/to_return = null

	for(var/mob/living/living in to_check)
		if(!living.mind)
			continue
		if(!is_station_level(living.z))
			continue
		if(ignore_erp && engaged_role_play_check(living))
			continue
		if(ignore_afk && living?.client)
			if(living.client.is_afk())
				continue
		if(only_crew && !living.mind?.assigned_role)
			continue
		LAZYADD(to_return, living)

	if(sort)
		for(var/i = 0 to rand(1, 3))
			shuffle(to_return)

	return to_return



// color: Target HSL or hex color for the space lighting (e.g., "#9932CC" for purple)
// fade_in: If TRUE, fade from normal to the color; if FALSE, instantly set to color
// fade_out: If TRUE, fade back to normal after fade_in completes; if FALSE, leave at color
// duration_step: Time per fade step in seconds (default 8 for smooth transition over ~40s)
/proc/change_space_color(color, fade_in = TRUE, fade_out = TRUE, duration_step = 8)
	set waitfor = FALSE

	// Define normal starlight values
	var/start_color = GLOB.base_starlight_color
	var/start_range = GLOB.starlight_range
	var/start_power = GLOB.starlight_power

	// Prepare target values for the custom color
	var/target_color = color
	if(!target_color)
		target_color = GLOB.base_starlight_color
	var/target_range = GLOB.starlight_range * 1.75
	var/target_power = GLOB.starlight_power * 0.6

	// If fade_in is FALSE, instantly set to target
	if (!fade_in)
		set_starlight(target_color, target_range, target_power)

	// Perform fade-in if requested
	if (fade_in)
		for (var/i in 1 to 5)
			var/walked_color = hsl_gradient(i / 5, 0, start_color, 1, target_color)
			var/walked_range = LERP(start_range, target_range, i / 5)
			var/walked_power = LERP(start_power, target_power, i / 5)
			set_starlight(walked_color, walked_range, walked_power)
			sleep(duration_step SECONDS)

	// Perform fade-out back to normal if requested
	if (fade_out)
		for (var/i in 1 to 5)
			var/walked_color = hsl_gradient(i / 5, 0, target_color, 1, start_color)
			var/walked_range = LERP(target_range, start_range, i / 5)
			var/walked_power = LERP(target_power, start_power, i / 5)
			set_starlight(walked_color, walked_range, walked_power)
			sleep(duration_step SECONDS)

	// Ensure final normal state
	set_starlight(target_color, start_range, start_power)
