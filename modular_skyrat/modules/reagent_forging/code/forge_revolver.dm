// COMSIG_ATOM_WAS_ATTACKED check out this signal's implementation

/obj/item/gun/ballistic/revolver/handcrafted_single_action
	name = "\improper handcrafted revolver"
	desc = "A traditional-style cowboy revolver. It's single-action, so the hammer must be cocked back to cycle the round."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	icon_state = "revolver_preview"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/handcrafted_single_action
	fire_sound_volume = 90
	bolt_type = BOLT_TYPE_NO_BOLT
	semi_auto = FALSE
	mag_display = FALSE
	bolt_wording = "hammer"
	///below stats should match or exceed the murphy's
	throwforce = 19
	force = 10

	//is the hammer primed (ready to fire) or released (safe)?
	var/hammer_is_primed = FALSE
	var/hammer_pull_speed_onehanded = 7 DECISECONDS
	var/static/holster_misfire_chance = 70

/obj/item/gun/ballistic/revolver/handcrafted_single_action/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 2 DECISECONDS) //have this for hammer fanning
	AddComponent(/datum/component/reagent_imbued/weapon)
	AddComponent(/datum/component/forge_smithable, \
		FORGING_WEAPON_REFORGING_MAX_QUALITY, \
		TRUE, \
		FORGING_WEAPON_REFORGING_MAX_PERFECT_HITS, \
		FORGING_WEAPON_REFORGING_MAX_BAD_HITS, \
		FORGING_WEAPON_REFORGING_AVERAGE_WAIT, \
		CALLBACK(src, TYPE_PROC_REF(/obj/item/gun/ballistic/revolver/handcrafted_single_action, quench_item)))

	RegisterSignal(src, COMSIG_MOVABLE_THROW_LANDED, PROC_REF(try_throw_misfire))

///Can't be toggled safety -- you need to manage the hammer
/obj/item/gun/ballistic/revolver/handcrafted_single_action/give_gun_safeties()
	return

///go my snowflake code for handling the revolver's hammer!!!
/obj/item/gun/ballistic/revolver/handcrafted_single_action/rack(mob/user = null)
	if(DOING_INTERACTION(user, DOAFTER_REVOLVER_HAMMER_COCK))
		return

	if(!hammer_is_primed)
		var/obj/item/bodypart/other_hand = user.has_hand_for_held_index(user.get_inactive_hand_index()) //
		if(user.get_inactive_held_item() || !other_hand)
			if(!do_after(user, hammer_pull_speed_onehanded, src, timed_action_flags = IGNORE_USER_LOC_CHANGE, interaction_key = DOAFTER_REVOLVER_HAMMER_COCK, hidden = TRUE ))
				return
		hammer_is_primed = TRUE

		balloon_alert(user, "cocked the hammer")
		if(!istype(magazine,/obj/item/ammo_box/magazine/internal/cylinder))
			stack_trace("[usr] has a magazine that isn't a revolver cylinder!")
		var/obj/item/ammo_box/magazine/internal/cylinder/my_cylinder = magazine
		my_cylinder.rotate()
	else
		hammer_is_primed = FALSE
		balloon_alert(user, "decocked the hammer")
	update_appearance()

/obj/item/gun/ballistic/revolver/handcrafted_single_action/try_fire_gun(atom/target, mob/living/user, params, show_message)
	if(hammer_is_primed)
		return ..()
	else
		if(show_message)
			balloon_alert(user, "hammer isn't cocked!")
		return FALSE

////////////////////////// SMITHING AND SMITH REPAIRING ///////////////////////////////////////
/obj/item/gun/ballistic/revolver/handcrafted_single_action/quench_item(datum/reagents/dunk_reagents, dunk_object, mob/living/user)
	var/datum/component/forge_smithable/smith_component = GetComponent(/datum/component/forge_smithable)
	if(!isnull(smith_component))
		smith_component.reset()
		apply_smithing_bonuses(smith_component.get_completion_ratio(), smith_component.get_perfect_ratio())
/obj/item/gun/ballistic/revolver/handcrafted_single_action/passive_cool_item()
	var/datum/component/forge_smithable/smith_component = GetComponent(/datum/component/forge_smithable)
	if(!isnull(smith_component))
		smith_component.reset()
		apply_smithing_bonuses(smith_component.get_completion_ratio(), smith_component.get_perfect_ratio(), TRUE)
/obj/item/gun/ballistic/revolver/handcrafted_single_action/apply_smithing_bonuses(completion_ratio, perfect_ratio, force_incomplete_penalty = FALSE)
	var/new_force_penalty = 0
	if(completion_ratio < 1 || force_incomplete_penalty)
		new_force_penalty = initial(force) * (1.0 - lerp(MIN_INCOMPLETE_DAMAGE_MULT, MAX_INCOMPLETE_DAMAGE_MULT, completion_ratio))
	force += completion_force_penalty
	force -= new_force_penalty
	completion_force_penalty = new_force_penalty

	update_integrity(max(round(lerp(0, max_integrity, completion_ratio)), atom_integrity))

	var/new_perfect_force_bonus = max(perfect_forging_bonus, clamp(perfect_ratio * MAX_PERFECT_FORCE_BONUS, 0, MAX_PERFECT_FORCE_BONUS))
	force += max(0, new_perfect_force_bonus - perfect_forging_bonus)
	perfect_forging_bonus = new_perfect_force_bonus

////////////////////////// MISFIRE WHEN SHOVED OR ATTACKED ///////////////////////////////////////

/obj/item/gun/ballistic/revolver/handcrafted_single_action/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	hammer_is_primed = FALSE
	. = ..()

/obj/item/gun/ballistic/revolver/handcrafted_single_action/equipped(mob/user, slot, initial)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_WAS_ATTACKED = PROC_REF(try_attack_misfire),
		COMSIG_CARBON_HELP_ACT = PROC_REF(try_hug_misfire),
		COMSIG_LIVING_Z_IMPACT = PROC_REF(try_fall_misfire),
		)
	if(slot != ITEM_SLOT_HANDS)
		AddComponent(/datum/component/connect_inventory, user, connections, allowed_slots = ALL ^ ITEM_SLOT_HANDS)

/obj/item/gun/ballistic/revolver/handcrafted_single_action/dropped(mob/user, silent)
	. = ..()
	qdel(GetComponent(/datum/component/connect_inventory))


/obj/item/gun/ballistic/revolver/handcrafted_single_action/proc/try_attack_misfire(mob/victim, mob/attacker, attack_flags)
	SIGNAL_HANDLER
	if(attack_flags & ATTACKER_SHOVING && prob(50))
		if(holster_misfire(victim, attacker) == TRUE)
			user.visible_message(span_warning("[victim]'s [src] goes off from [attacker]'s attack!"),
				span_danger("Your primed [src] triggers from [attacker]'s strike! "), ignored_mobs = victim)


/obj/item/gun/ballistic/revolver/handcrafted_single_action/proc/try_hug_misfire(mob/living/source)
	SIGNAL_HANDLER
	if(prob(3))
		if(holster_misfire(victim, attacker) == TRUE)
			user.visible_message(span_warning("[victim]'s [src] goes off from [attacker]'s hug!"),
				span_danger("Your primed [src] triggers from [attacker]'s hug! "), ignored_mobs = victim)


/obj/item/gun/ballistic/revolver/handcrafted_single_action/proc/try_fall_misfire(datum/source, levels, turf/fell_on)
	SIGNAL_HANDLER
	if(prob(70))
		if(holster_misfire(victim, attacker) == TRUE)
			user.visible_message(span_warning("[victim]'s [src] goes off from [attacker]'s hug!"),
				span_danger("Your primed [src] triggers from the sharp fall! "), ignored_mobs = victim)

/obj/item/gun/ballistic/revolver/handcrafted_single_action/proc/holster_misfire(mob/victim, mob/attacker)
	return try_fire_gun(victim, attacker, null, FALSE)

/obj/item/gun/ballistic/revolver/handcrafted_single_action/proc/try_throw_misfire(datum/source, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER
	//todo: gun fires in random direction if it's thrown
	//if(prob(100))
	return

////////////////////////////////////// MISC RELATED STUFF //////////////////////////////////////

/obj/item/ammo_box/magazine/internal/cylinder/handcrafted_single_action
	name = "handcrafted revolver cylinder"
	ammo_type = /obj/item/ammo_casing/c38
	caliber = CALIBER_38
	max_ammo = 6

///get round doesn't spin the cylinder; cocking the hammer (from rack()) must be used to spin the cylinder
/obj/item/ammo_box/magazine/internal/cylinder/handcrafted_single_action/get_round()
	var/casing = stored_ammo[1]
	if (ispath(casing))
		casing = new casing(src)
		stored_ammo[1] = casing
	return casing

/obj/item/ammo_box/magazine/internal/cylinder/handcrafted_single_action/spin()
	. = ..()
