/datum/latejoin_menu/ui_data(mob/user)
	. = ..()
	if(SSticker?.mode?.threat_level)
		var/threat_level = SSticker?.mode?.threat_level
		var/color_mod = threat_level * 2.55
		.["threat_level"] = list("name" = "[threat_level]%","color" = rgb(color_mod*2.55,(color_mod-100)*2.55,0))
