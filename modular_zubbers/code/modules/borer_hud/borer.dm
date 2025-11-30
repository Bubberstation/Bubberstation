/mob/living/basic/cortical_borer
	hud_type = /datum/hud/borer
///Hud type with targetting dol and a nutrition bar
/datum/hud/borer/New(mob/living/owner)
	. = ..()
	var/atom/movable/screen/using

	action_intent = new /atom/movable/screen/combattoggle/flashy()
	action_intent.hud = src
	action_intent.icon = ui_style
	action_intent.screen_loc = ui_combat_toggle
	static_inventory += action_intent

	using = new /atom/movable/screen/language_menu()
	using.icon = ui_style
	using.hud = src
	using.update_appearance()
	static_inventory += using

	using = new /atom/movable/screen/navigate
	using.hud = src
	static_inventory += using

	healthdoll = new /atom/movable/screen/healthdoll/living()
	healthdoll.hud = src
	infodisplay += healthdoll

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
	if(hud_used?.action_intent)
		hud_used.action_intent.maptext = MAPTEXT(string)
		hud_used.action_intent.maptext_height = 400
		hud_used.action_intent.maptext_width = 400
		hud_used.action_intent.maptext_y = 64
		hud_used.action_intent.maptext_x = -64


