/datum/latejoin_menu/ui_data(mob/user)
	. = ..()
	if(SSticker.mode && istype(SSticker.mode,/datum/game_mode/dynamic/))
		var/datum/game_mode/dynamic/mode = SSticker.mode
		var/threat_level
		var/threat_color
		var/threat_color_shadow
		if(!mode.shown_threat) //Possibly not generated.
			if(threat_level == 0) //Actually generated but actually greenshift.
				threat_level = "White Dwarf"
				threat_color = "white"
				threat_color_shadow = "0px 0px 4px black"
			else //Not generated.
				threat_level = "Unknown..."
				threat_color = "grey"
				threat_color_shadow = "0px 0px 4px black"
		else
			switch(mode.shown_threat)
				if(1 to 19)
					threat_level = "Blue Star"
					threat_color = "cyan" //*GASP* IMPOSTER
					threat_color_shadow = "0px 0px 4px white"
				if(20 to 39)
					threat_level = "Yellow Star"
					threat_color = "yellow"
					threat_color_shadow = "0px 0px 4px orange"
				if(40 to 65)
					threat_level = "Orange Star"
					threat_color = "orange"
					threat_color_shadow = "0px 0px 4px orange"
				if(66 to 79)
					threat_level = "Red Star"
					threat_color = "red"
					threat_color_shadow = "0px 0px 4px red"
				if(80 to 99)
					threat_level = "Black Orbit"
					threat_color = "black"
					threat_color_shadow = "0px 0px 6px white"
				if(100)
					threat_level = "Midnight Sun"
					threat_color = "purple"
					threat_color_shadow = "0px 0px 4px black"
		.["threat_level"] = list(
			"name" = threat_level,
			"color" = threat_color,
			"color_shadow" = threat_color_shadow
		)
