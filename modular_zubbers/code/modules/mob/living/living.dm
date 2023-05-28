/mob/living/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/status_indicator)

/mob/living/resist_grab(moving_resist)
	. = TRUE
	if(pulledby.grab_state || body_position == LYING_DOWN || HAS_TRAIT(src, TRAIT_GRABWEAKNESS) || staminaloss > STAMINA_THRESHOLD_HARD_RESIST)
		var/altered_grab_state = pulledby.grab_state
		if(resting || HAS_TRAIT(src, TRAIT_GRABWEAKNESS) && pulledby.grab_state < GRAB_KILL) //If resting, resisting out of a grab is equivalent to 1 grab state higher. won't make the grab state exceed the normal max, however
			altered_grab_state++
		if(staminaloss > STAMINA_THRESHOLD_HARD_RESIST)
			altered_grab_state++
		var/mob/living/M = pulledby
		if(M.staminaloss > STAMINA_THRESHOLD_HARD_RESIST)
			altered_grab_state--
		var/resist_chance = BASE_GRAB_RESIST_CHANCE /// see defines/combat.dm, this should be baseline 60%
		if(HAS_TRAIT(src, TRAIT_OVERSIZED))
			resist_chance += OVERSIZED_GRAB_RESIST_BONUS
		if(HAS_TRAIT(pulledby, TRAIT_OVERSIZED))
			resist_chance -= OVERSIZED_GRAB_RESIST_BONUS
		resist_chance = (resist_chance/altered_grab_state) ///Resist chance divided by the value imparted by your grab state. It isn't until you reach neckgrab that you gain a penalty to escaping a grab.
		if(prob(resist_chance))
			visible_message(span_danger("[src] breaks free of [pulledby]'s grip!"), \
							span_danger("You break free of [pulledby]'s grip!"), null, null, pulledby)
			to_chat(pulledby, span_warning("[src] breaks free of your grip!"))
			log_combat(pulledby, src, "broke grab")
			pulledby.stop_pulling()
			return FALSE
		else
			adjustStaminaLoss(rand(15,20))//failure to escape still imparts a pretty serious penalty
			visible_message("<span class='danger'>[src] struggles as they fail to break free of [pulledby]'s grip!</span>", \
							"<span class='warning'>You struggle as you fail to break free of [pulledby]'s grip!</span>", null, null, pulledby)
			to_chat(pulledby, "<span class='danger'>[src] struggles as they fail to break free of your grip!</span>")
		if(moving_resist && client) //we resisted by trying to move
			client.move_delay = world.time + 4 SECONDS
	else
		pulledby.stop_pulling()
		return FALSE
