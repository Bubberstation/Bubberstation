/obj/structure/bibberblub
	icon = 'modular_zubbers/icons/bibberblub/bibberblub.dmi'
	max_integrity = 50

/obj/structure/bibberblub/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/effects/blob/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/items/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(loc, 'sound/items/tools/welder.ogg', 100, TRUE)

/obj/structure/bibberblub/slimy_floor
	name = "Slimy Floor"
	desc = "The floor here is covered in thick goop!"
	icon_state = "Floor"
	density = FALSE
	layer = ABOVE_OPEN_TURF_LAYER
	plane = FLOOR_PLANE
