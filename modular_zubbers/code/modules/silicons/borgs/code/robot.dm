// Define for in hand sprite
/mob/living/silicon/robot
	//TODO: real holding sprites these are just place holders for the time
	held_lh = 'icons/mob/inhands/pai_item_lh.dmi'
	held_rh = 'icons/mob/inhands/pai_item_rh.dmi'
	held_state = "cat"

//Cyborgs that are being held should act almost as how the AI behaves when carded.
/mob/living/silicon/robot/mob_pickup(mob/living/user)
	drop_all_held_items()
	toggle_headlamp(TRUE)
	return ..()

/mob/living/silicon/robot/mob_try_pickup(mob/living/user, instant=FALSE)
	if(stat == DEAD || HAS_TRAIT(src, TRAIT_GODMODE))
		return
	return ..()
