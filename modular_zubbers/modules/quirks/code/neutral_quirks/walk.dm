/datum/quirk/waddle
	name = "Waddle"
	desc = "Your movements always had a bit more of a waddle to them."
	medical_record_text = "Subject appears to be terrible at dancing."
	value = 0
	icon = FA_ICON_WIND
	gain_text = span_notice("You feel like walking silly")
	lose_text = span_notice("You no longer feel like walking silly")
	quirk_flags = QUIRK_HUMAN_ONLY
	mail_goodies = list(/obj/item/food/grown/banana)

/datum/quirk/waddle/add(client/client_source)
	. = ..()
	quirk_holder.AddElement(/datum/element/waddling)

/datum/quirk/waddle/remove()
	. = ..()
	quirk_holder.RemoveElement(/datum/element/waddling)

/datum/quirk/bhop
	name = "Bunny Hop"
	desc = "You bounce up and down while walking, with light hops to your step."
	medical_record_text = "Subject exhibits bunny-like walking behavior."
	value = 0
	icon = FA_ICON_WALKING
	gain_text = span_notice("You feel a hop in your step.")
	lose_text = span_notice("Your steps find purchase on the ground again.")
	quirk_flags = QUIRK_HUMAN_ONLY
	mail_goodies = list(/obj/item/food/grown/carrot)

//The bunny hop quirk literally just adds the bhop element
/datum/quirk/bhop/add(client/client_source)
	. = ..()
	quirk_holder.AddElement(/datum/element/waddling/bhop)

/datum/quirk/bhop/remove()
	. = ..()
	quirk_holder.RemoveElement(/datum/element/waddling/bhop)

/datum/element/waddling/bhop

/datum/element/waddling/bhop/Attach(datum/target)
	. = ..()
	if(!ismovable(target))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_MOVABLE_MOVED, PROC_REF(Waddle), override = TRUE)

/datum/element/waddling/bhop/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_MOVABLE_MOVED)

//Checks for whether a mob can waddle
/datum/element/waddling/bhop/Waddle(atom/movable/bunny, atom/oldloc, direction, forced)
	if(forced || CHECK_MOVE_LOOP_FLAGS(bunny, MOVEMENT_LOOP_OUTSIDE_CONTROL))
		return
	if(isliving(bunny))
		var/mob/living/living_bunny = bunny
		if (living_bunny.incapacitated() || living_bunny.body_position == LYING_DOWN)
			return
	waddling_animation(bunny)

//Animates the bunny hop
/datum/element/waddling/bhop/waddling_animation(atom/movable/bunny)
	if(HAS_TRAIT(bunny, TRAIT_MOVE_FLYING))
		return
	else
		animate(bunny, pixel_y = bunny.pixel_y + 4, time = 2, easing = EASE_OUT)
		animate(pixel_y = initial(bunny.pixel_y), time = 0, easing = EASE_IN)
