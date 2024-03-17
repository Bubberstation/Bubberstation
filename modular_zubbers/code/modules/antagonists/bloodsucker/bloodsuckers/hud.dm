/// 1 tile down
#define UI_BLOOD_DISPLAY "WEST:6,CENTER-1:0"
/// 2 tiles down
#define UI_VAMPRANK_DISPLAY "WEST:6,CENTER-2:-5"
/// 6 pixels to the right, zero tiles & 5 pixels DOWN.
#define UI_SUNLIGHT_DISPLAY "WEST:6,CENTER-0:0"

///Maptext define for Bloodsucker HUDs
#define FORMAT_BLOODSUCKER_HUD_TEXT(valuecolor, value) MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='[valuecolor]'>[round(value,1)]</font></div>")
///Maptext define for Bloodsucker Sunlight HUDs
#define FORMAT_BLOODSUCKER_SUNLIGHT_TEXT(valuecolor, value) MAPTEXT("<div align='center' valign='bottom' style='position:relative; top:0px; left:6px'><font color='[valuecolor]'>[value]</font></div>")

/atom/movable/screen/bloodsucker
	icon = 'modular_zubbers/icons/mob/actions/bloodsucker.dmi'

/atom/movable/screen/bloodsucker/blood_counter
	name = "Blood Consumed"
	icon_state = "blood_display"
	screen_loc = UI_BLOOD_DISPLAY

/atom/movable/screen/bloodsucker/blood_counter/proc/update_blood_hud(blood_volume)
	maptext = FORMAT_BLOODSUCKER_HUD_TEXT(hud_text_color(), blood_volume)

/atom/movable/screen/bloodsucker/rank_counter
	name = "Bloodsucker Rank"
	icon_state = "rank"
	screen_loc = UI_VAMPRANK_DISPLAY

/atom/movable/screen/bloodsucker/rank_counter/proc/update_rank_hud(level = 0, unspent_level = 0, blood_volume = 0)
	if(unspent_level > 0)
		icon_state = "[initial(icon_state)]_up"
	else
		icon_state = initial(icon_state)
	maptext = FORMAT_BLOODSUCKER_HUD_TEXT(hud_text_color(), level)

/atom/movable/screen/bloodsucker/sunlight_counter
	name = "Solar Flare Timer"
	icon_state = "sunlight"
	screen_loc = UI_SUNLIGHT_DISPLAY

/atom/movable/screen/bloodsucker/sunlight_counter/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	update_sol_hud()
	START_PROCESSING(SSsunlight, src)

/atom/movable/screen/bloodsucker/sunlight_counter/Destroy()
	STOP_PROCESSING(SSsunlight, src)
	. = ..()

/atom/movable/screen/bloodsucker/sunlight_counter/proc/update_sol_hud()
	var/valuecolor = hud_text_color()
	if(!SSsunlight)
		return
	if(SSsunlight.sunlight_active)
		valuecolor = "#FF5555"
		icon_state = "[initial(icon_state)]_day"
	else
		switch(round(SSsunlight.time_til_cycle, 1))
			if(0 to 30)
				icon_state = "[initial(icon_state)]_30"
				valuecolor = "#FFCCCC"
			if(31 to 60)
				icon_state = "[initial(icon_state)]_60"
				valuecolor = "#FFE6CC"
			if(61 to 90)
				icon_state = "[initial(icon_state)]_90"
				valuecolor = "#FFFFCC"
			else
				icon_state = "[initial(icon_state)]_night"
				valuecolor = "#FFFFFF"
	maptext = FORMAT_BLOODSUCKER_SUNLIGHT_TEXT( \
		valuecolor, \
		(SSsunlight.time_til_cycle >= 60) ? "[round(SSsunlight.time_til_cycle / 60, 1)] m" : "[round(SSsunlight.time_til_cycle, 1)] s" \
	)

/atom/movable/screen/bloodsucker/sunlight_counter/process(seconds_per_tick)
	update_sol_hud()

/atom/movable/screen/bloodsucker/proc/hud_text_color(blood_volume)
	return blood_volume > BLOOD_VOLUME_SAFE ? "#FFDDDD" : "#FFAAAA"

/// Updated every time blood is changed by either
/datum/antagonist/bloodsucker/proc/update_blood_hud()
	blood_display?.update_blood_hud(bloodsucker_blood_volume)

/datum/antagonist/bloodsucker/proc/update_rank_hud()
	vamprank_display?.update_rank_hud(bloodsucker_level, bloodsucker_level_unspent, bloodsucker_blood_volume)

/// 1 tile down
#undef UI_BLOOD_DISPLAY
/// 2 tiles down
#undef UI_VAMPRANK_DISPLAY
/// 6 pixels to the right, zero tiles & 5 pixels DOWN.
#undef UI_SUNLIGHT_DISPLAY

///Maptext define for Bloodsucker HUDs
#undef FORMAT_BLOODSUCKER_HUD_TEXT
///Maptext define for Bloodsucker Sunlight HUDs
#undef FORMAT_BLOODSUCKER_SUNLIGHT_TEXT
