
/obj/structure/cursedfatfountain
	name = "Strange fountain"
	desc = "An odd fountain, sparking with foreign magic."
	icon =  'modular_gs/icons/obj/cursed_fountain.dmi'
	icon_state = "full"
	anchored = TRUE
	density = TRUE
	var/curse_given = FALSE

/mob/living/carbon/human
	var/cursed_fat = 0 //decides whether the user is cursed at all (also makes for a fun admin switch)
	var/fattening_steps_left = 0 //decides on the lenght of the curse

/obj/structure/cursedfatfountain/attack_hand(mob/living/user)
	. = ..()
	var/mob/living/carbon/human/toucher = user
	if(. || !istype(toucher))
		return

	if(curse_given)
		to_chat(user, "<span class='notice'>The fountain has dried up.</span>")
		icon_state = "empty"
		return

	// Put a pref check here please.

	toucher.cursed_fat = TRUE
	toucher.fattening_steps_left += 2000
	icon_state = "empty"
	to_chat(toucher, "<span class='notice'>The glittering orange liquid disappears instantly as you touch it. You feel a strange, warm sensation inside, growing stronger the more you move...</span>")
	curse_given = TRUE

// /obj/structure/cursedfatfountain/update_icon()
// 	if(last_process + time_between_uses > world.time)
// 		icon_state = "full"
// 	else
// 		icon_state = "empty"

/mob/living/carbon/human/Move(NewLoc, direct)
	. = ..()
	if(!cursed_fat)
		return .

	fattening_steps_left -= 1
	adjust_fatness(20, FATTENING_TYPE_MAGIC)

	if(fattening_steps_left <= 0)
		cursed_fat = FALSE

	return .
