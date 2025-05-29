/datum/component/fattening_door
	var/fatten = FALSE // whether player will be fattened
	var/fat_to_add = 2 // fatness per tick stunned

/datum/component/fattening_door/Initialize()
	if(!istype(parent, /obj/structure/mineral_door)) // if the attached object isn't a door, return incompatible!
		return COMPONENT_INCOMPATIBLE
	
	RegisterSignal(parent, list(COMSIG_MOVABLE_CROSSED),PROC_REF(Fatten))

/datum/component/fattening_door/proc/Fatten() //GS13
	var/stuck_delay = 0
	var/turf/T = get_turf(parent)

	for(var/mob/living/carbon/M in T)
		var/vis_message_self = ""
		var/vis_message_others = ""
		// determine if mob should get stuck and be fattened
		if(M.fatness >= FATNESS_LEVEL_FAT)
			if(!M.AmountFatStunned())
				fatten = TRUE
				stuck_delay = 5
				vis_message_self = "You feel your sides briefly brush against the doorway!"
				vis_message_others = "[M]'s sides briefly brush against the doorway."
				
				// Scales depending on this switch.
				switch(M.fatness)
					if(FATNESS_LEVEL_BARELYMOBILE to INFINITY)
						stuck_delay = 120
						vis_message_self = "You feel yourself get stuck in the doorway!"
						vis_message_others = "[M] gets stuck in the doorway!"
					if((FATNESS_LEVEL_FATTER+1) to FATNESS_LEVEL_MORBIDLY_OBESE)
						stuck_delay = 50
						vis_message_self ="You feel your sides barely squeeze through the doorway!"
						vis_message_others = "[M] barely squeezes through the doorway!"
					if((FATNESS_LEVEL_FAT+1) to FATNESS_LEVEL_FATTER)
						stuck_delay = 15
						vis_message_self = "You feel your sides smush against the doorway!."
						vis_message_others = "[M]'s sides briefly smush against the doorway."
		
		// Apply the fatstun
		if(fatten)
			M.visible_message("<span class='boldnotice'>[vis_message_others]</span>", "<span class='boldwarning'>[vis_message_self]</span>")
			M.FatStun(stuck_delay, fatAmount = fat_to_add) // DOOR STUCK
