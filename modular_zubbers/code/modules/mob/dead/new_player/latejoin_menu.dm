/datum/latejoin_menu/ui_data(mob/user)
	. = ..()
	if(SSticker.mode && istype(SSticker.mode,/datum/game_mode/dynamic/))
		var/datum/game_mode/dynamic/mode = SSticker.mode
		var/threat_level
		var/threat_color
		if(!mode.shown_threat) //Possibly not generated.
			if(threat_level == 0) //Actually generated but actually greenshift.
				threat_level = "White Dwarf ([mode.shown_threat])"
				threat_color = "white"
			else //Not generated.
				threat_level = "Unknown..."
				threat_color = "grey"
		else
			switch(mode.shown_threat)
				if(1 to 19)
					threat_level = "Blue Star ([mode.shown_threat])"
					threat_color = "blue"
				if(20 to 39)
					threat_level = "Yellow Star ([mode.shown_threat])"
					threat_color = "yellow"
				if(40 to 65)
					threat_level = "Orange Star ([mode.shown_threat])"
					threat_color = "orange"
				if(66 to 79)
					threat_level = "Red Star ([mode.shown_threat])"
					threat_color = "red"
				if(80 to 99)
					threat_level = "Black Orbit ([mode.shown_threat])"
					threat_color = "black"
				if(100)
					threat_level = "Midnight Sun ([mode.shown_threat])"
					threat_color = "purple"
		.["threat_level"] = list("name" = threat_level,"color" = threat_color)
