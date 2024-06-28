/obj/machinery/light //Light tubes.
	max_integrity = 150

/obj/machinery/light/small //Light bulbs.
	max_integrity = 110

/obj/machinery/light/floor //Floor lights.
	max_integrity = 175

/obj/machinery/light/ex_act(severity, target)

	. = ..() //Returns false if unaffected.

	if(!. || QDELETED(src) || constant_flickering)
		return

	switch(severity)
		if(EXPLODE_HEAVY)
			start_flickering() //Permanent flicker (fixed via multitool).
		if(EXPLODE_LIGHT)
			flicker(rand(3 SECONDS, 5 SECONDS)) //Temp flicker (automatic fix).
