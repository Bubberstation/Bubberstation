/mob/living/basic/heretic_summon/stalker
	melee_damage_lower = 25
	melee_damage_upper = 25
	maxHealth = 200
	health = 200
	speed = 0.2

	//melee damage we do on our first attack whilst disguised
	var/disguise_melee_damage_lower = 30
	var/disguise_melee_damage_upper = 30

	//armour pen on our first attack whilst disguised
	var/disguise_armour_penetration = 70

	//cooldown on our disguise ability after we strike
	var/disguise_attack_cooldown = 25 SECONDS



/mob/living/basic/heretic_summon/stalker/examine(mob/user)

	if(!HAS_TRAIT(src, TRAIT_DISGUISED))
		return ..()

	if(get_dist(user, src) <= 3) // The form won't hold up to close inspection.
		. += span_warning("It doesn't look quite right...")

// disguised stalkers will be untracked by non-sentient mobs wanting to kill them. I think.
/mob/living/basic/heretic_summon/stalker/can_track(mob/living/user)
	if(!HAS_TRAIT(src, TRAIT_DISGUISED))
		return FALSE
	return ..()

/mob/living/basic/heretic_summon/stalker/proc/on_disguise(mob/living/basic/user, atom/movable/target)
	SIGNAL_HANDLER

	//buff our speed, and our damage + armourpen (for one strike)
	add_movespeed_modifier(/datum/movespeed_modifier/stalker_disguise_speedup, update = TRUE)

	melee_damage_lower = disguise_melee_damage_lower
	melee_damage_upper = disguise_melee_damage_upper
	if(isbasicmob(src))
		armour_penetration = disguise_armour_penetration

	//add some flavour
	visible_message(
		span_warning("[src] suddenly twists and changes shape, becoming a copy of [target]!"),
		span_notice("You twist your body and assume the form of [target]."),
	)

/// Do some more logic for the stalker when we undisguise through the action.
/mob/living/basic/heretic_summon/stalker/proc/on_undisguise()
	SIGNAL_HANDLER

	//return everything back to undisguised stats
	remove_movespeed_modifier(/datum/movespeed_modifier/stalker_disguise_speedup, update = TRUE)

	melee_damage_lower = initial(melee_damage_lower)
	melee_damage_upper = initial(melee_damage_upper)
	if(isbasicmob(src))
		armour_penetration = initial(armour_penetration)

	//more flavour
	visible_message(
		span_warning("[src] suddenly collapses in on itself, dissolving into a pile of flesh and limbs!"),
		span_notice("You reform to your normal body."),
	)

/mob/living/basic/heretic_summon/stalker/proc/post_disguise_attack()
	SIGNAL_HANDLER
	if(HAS_TRAIT(src, TRAIT_DISGUISED))
		var/datum/action/cooldown/mob_cooldown/assume_form/stalker_disguise = locate() in src.actions
		if(stalker_disguise)
			//sheds our disguise, and sets the cooldown to 25 seconds
			stalker_disguise.reset_appearances()
			stalker_disguise.next_use_time += disguise_attack_cooldown
			update_mob_action_buttons()
			balloon_alert(src, "Assassination!")
			//also do some funky visuals
			new /obj/effect/temp_visual/cleave(get_turf(src))
			new /obj/effect/decal/cleanable/blood(get_turf(src))
	return
