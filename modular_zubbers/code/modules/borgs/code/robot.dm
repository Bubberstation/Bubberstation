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
	if(stat == DEAD || status_flags & GODMODE)
		return
	return ..()

/mob/living/silicon/get_status_tab_items()
	. = ..()
	var/list/law_list = list("Obey these laws:")
	law_list += laws.get_law_list(include_zeroth = TRUE, render_html = FALSE)
	for(var/borg_laws as anything in law_list)
		. +=  borg_laws
