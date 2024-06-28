/obj/machinery/light/ex_act(severity, target)
	. = ..() //Returns false if unaffected.
	if(. && QDELETED(src) && !constant_flickering)
		if(EXPLODE_HEAVY)
			start_flickering() //Permanent flicker (fixed via multitool).
		if(EXPLODE_LIGHT)
			flicker(rand(3 SECONDS, 5 SECONDS)) //Temp flicker (automatic fix).
