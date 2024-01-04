/obj/item/modular_computer/pda/synth
	max_capacity = 64 // Overrides skyrat. Original: 32 //This is why I dislike Skyrat: Random balance change because ???

/obj/item/modular_computer/pda/synth/get_header_data()
	var/list/data = ..()
	var/obj/item/organ/internal/brain/synth/brain_loc = loc
	// Battery level is now according to the synth charge
	if(istype(brain_loc))
		var/charge_level = (brain_loc.owner.nutrition / NUTRITION_LEVEL_ALMOST_FULL) * 100
		switch(charge_level)
			if(80 to 110)
				data["PC_batteryicon"] = "batt_100.gif"
			if(60 to 80)
				data["PC_batteryicon"] = "batt_80.gif"
			if(40 to 60)
				data["PC_batteryicon"] = "batt_60.gif"
			if(20 to 40)
				data["PC_batteryicon"] = "batt_40.gif"
			if(5 to 20)
				data["PC_batteryicon"] = "batt_20.gif"
			else
				data["PC_batteryicon"] = "batt_5.gif"
		data["PC_batterypercent"] = "[round(charge_level)]%"
	return data
