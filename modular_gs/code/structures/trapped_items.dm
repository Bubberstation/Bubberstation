/obj/structure/fat_mirror
	name = "mirror" //Exact same text. Good luck.
	desc = "Mirror mirror on the wall, who's the most robust of them all?"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "mirror"
	density = FALSE
	anchored = TRUE
	/// Does the item delete itself after being "used?"
	var/single_use = TRUE

/obj/structure/fat_mirror/attack_hand(mob/user)
	. = ..()
	if(.)
		return

	var/mob/living/carbon/looker = user
	if(!istype(looker) || !Adjacent(looker))
		return

	make_fat(looker)
	return TRUE

/obj/structure/fat_mirror/proc/make_fat(mob/living/carbon/looker)
	if(!istype(looker) || !looker.check_weight_prefs(FATTENING_TYPE_MAGIC))
		return FALSE

	var/fat_to_add = looker.fatness_until_next_level()
	if(!fat_to_add)
		fat_to_add = FATNESS_LEVEL_BLOB // If someone is a blob, just add the amount of fatness needed to be a blob in the first place.

	fat_to_add += 25 // a little buffer so they don't instantly burn it off.
	looker.adjust_fatness(fat_to_add, FATTENING_TYPE_MAGIC, TRUE)
	to_chat(looker, span_warning("Taking a look in the mirror, you look fatter than you remeber being."))

	if(single_use)
		visible_message(span_warning("[src] shatters into pieces."))
		qdel(src)


