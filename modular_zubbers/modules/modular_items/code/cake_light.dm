#define FAILURE 0
#define SUCCESS 1
#define ALREADY_LIT 3


/obj/item/food/cake/birthday
	heat = 1000
	light_color = LIGHT_COLOR_FIRE
	light_range = 3
	light_on = FALSE
	var/can_be_extinguished = TRUE

/obj/item/food/cake/birthday/proc/update_brightness()
	update_appearance(UPDATE_ICON)
	if(light_system == STATIC_LIGHT)
		update_light()

/obj/item/food/cake/birthday/proc/turn_off()
	set_light_on(FALSE)
	name = initial(name)
	attack_verb_continuous = initial(attack_verb_continuous)
	attack_verb_simple = initial(attack_verb_simple)
	hitsound = initial(hitsound)
	force = initial(force)
	damtype = initial(damtype)
	update_brightness()

/obj/item/food/cake/birthday/extinguish()
	. = ..()
	if(can_be_extinguished)
		turn_off()

/obj/item/food/cake/birthday/proc/ignition(mob/user)
	if(light_on)
		if(user)
			balloon_alert(user, "already lit!")
		return ALREADY_LIT

	START_PROCESSING(SSobj, src)
	light_on = TRUE
	update_brightness()
	return SUCCESS

/obj/item/food/cake/birthday/fire_act(exposed_temperature, exposed_volume)
	ignition()
	return ..()

/obj/item/food/cake/birthday/proc/try_light_candle(obj/item/fire_starter, mob/user, quiet, silent)
	if(!istype(fire_starter))
		return
	if(!istype(user))
		return

	var/success_msg = fire_starter.ignition_effect(src, user)
	var/ignition_result

	if(success_msg)
		ignition_result = ignition()

	switch(ignition_result)
		if(SUCCESS)
			update_appearance(UPDATE_ICON | UPDATE_NAME)
			if(!quiet && !silent)
				user.visible_message(success_msg)
			return SUCCESS
		if(ALREADY_LIT)
			if(!silent)
				balloon_alert(user, "already lit!")
			return ALREADY_LIT

/obj/item/food/cake/birthday/attackby(obj/item/attacking_item, mob/user, params)
	if(try_light_candle(attacking_item, user, silent = istype(attacking_item, src.type))) // so we don't double balloon alerts when a candle is used to light another candle
		return COMPONENT_CANCEL_ATTACK_CHAIN
	else
		return ..()

// allows lighting an unlit candle from some fire source by left clicking the source with the candle
/obj/item/food/cake/birthday/pre_attack(atom/target, mob/living/user, params)
	if(ismob(target))
		return ..()

	if(try_light_candle(target, user, quiet = TRUE))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	return ..()
