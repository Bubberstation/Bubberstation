
/obj/structure/cursedfatfountain
	name = "Strange fountain"
	desc = "An odd fountain, sparking with foreign magic."
	icon =  'GainStation13/icons/obj/cursed_fountain.dmi'
	icon_state = "full"
	anchored = TRUE
	density = TRUE
	var/curse_given = 0

/mob/living
	var/cursed_fat = 0 //decides whether the user is cursed at all (also makes for a fun admin switch)
	var/fattening_steps_left = 0 //decides on the lenght of the curse

/obj/structure/cursedfatfountain/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(curse_given == 1)
		to_chat(user, "<span class='notice'>The fountain has dried up.</span>")
		icon_state = "empty"
		return
	if (ishuman(user) && user.has_dna())
		user.cursed_fat = 1
		user.fattening_steps_left += 2000
		icon_state = "empty"
		to_chat(user, "<span class='notice'>The glittering orange liquid disappears instantly as you touch it. You feel a strange, warm sensation inside, growing stronger the more you move...</span>")
		curse_given = 1

// /obj/structure/cursedfatfountain/update_icon()
// 	if(last_process + time_between_uses > world.time)
// 		icon_state = "full"
// 	else
// 		icon_state = "empty"

/mob/living/carbon/Move(NewLoc, direct)
	. = ..()
	if(cursed_fat == 1)
		fattening_steps_left -= 1
		adjust_fatness(20, FATTENING_TYPE_MAGIC)

	if(fattening_steps_left <= 0)
		cursed_fat = 0
