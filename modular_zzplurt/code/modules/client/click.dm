/mob/living/carbon/human
	var/_last_next_move = 0

/mob/living/carbon/human/ClickOn(atom/A, params)
	if(world.time <= next_click)
		return
	_last_next_move = next_move
	return ..()

/mob/living/carbon/human/UnarmedAttack(atom/attack_target, proximity_flag, list/modifiers)
	if(isliving(attack_target))
		switch(combat_mode)
			if(INTENT_DISARM)
				modifiers -= LEFT_CLICK
				modifiers[RIGHT_CLICK] = TRUE
			if(INTENT_GRAB)
				//CtrlClickOn checks for next_move.. which ClickOn has just set right before calling this.
				next_move = _last_next_move
				CtrlClickOn(attack_target)
				return
	return ..()
