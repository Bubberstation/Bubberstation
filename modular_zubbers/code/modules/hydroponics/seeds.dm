/obj/item/seeds/adjust_potency(adjustamt)
	if(potency == -1)
		return
	if(instability < 50)
		return ..()
	var/new_maximum = MAX_PLANT_POTENCY * (1 + instability/100)
	potency = clamp(potency + adjustamt, 0, instability_maximum)
