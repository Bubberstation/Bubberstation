/mob/living/basic/cortical_borer
	hud_type = /datum/hud/borer

///Hud type with targetting doll and a nutrition bar
/datum/hud/borer/initialize_screen_objects()
	. = ..()
	add_screen_object(/atom/movable/screen/combattoggle/flashy, HUD_MOB_INTENTS, HUD_GROUP_INFO, ui_style, ui_basic_combat_toggle)
	add_screen_object(/atom/movable/screen/language_menu, HUD_MOB_LANGUAGE_MENU, HUD_GROUP_STATIC, ui_style)
	add_screen_object(/atom/movable/screen/navigate, HUD_MOB_NAVIGATE_MENU)
	add_screen_object(/atom/movable/screen/healthdoll/living, HUD_MOB_HEALTHDOLL, HUD_GROUP_INFO)

/mob/living/basic/cortical_borer/Life(seconds_per_tick, times_fired)
	. = ..()
	update_health_hud() // it literally won't otherwise.

/mob/living/basic/cortical_borer/update_health_hud()
	. = ..()

	var/string = ""
	string += "Your health: [health] / [maxHealth] \n"
	string += "CHEM: [chemical_storage] / [max_chemical_storage] | [chemical_evolution ? chemical_evolution : null] \n"
	if(stat_evolution)
		string += "STAT AVAIL: [stat_evolution] \n"
	if(human_host)
		var/brute = "<span style=color:red>[human_host.get_brute_loss()]</span>" // Limbs
		var/burn = "<span style=color:white>[human_host.get_fire_loss()]</span>" // Limbs
		var/tox = "<span style=color:green>[human_host.toxloss]</span>"
		var/oxy = "<span style=color:blue>[human_host.oxyloss]</span>"
		var/blood = "<span style=color:magenta>[human_host.blood_volume]</span>"
		string += "[brute] | [burn] | [tox] | [oxy] | [blood]u"
	var/atom/movable/screen/combattoggle/action_intent = hud_used?.screen_objects[HUD_MOB_INTENTS]
	if(action_intent)
		action_intent.maptext = MAPTEXT(string)
		action_intent.maptext_height = 400
		action_intent.maptext_width = 400
		action_intent.maptext_y = 64
		action_intent.maptext_x = -64


