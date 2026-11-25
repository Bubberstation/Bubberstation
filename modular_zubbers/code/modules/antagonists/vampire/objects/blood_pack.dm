/obj/item/reagent_containers/blood/attack(mob/living/victim, mob/living/attacker, list/modifiers, list/attack_modifiers)
	if(!can_drink(victim, attacker))
		return

	var/to_feed = reagents.total_volume
	if(victim != attacker)
		if(!do_after(attacker, 5 SECONDS, victim))
			return
		attacker.visible_message(
			span_notice("[attacker] forces [victim] to drink from \the [src]."),
			span_notice("You put \the [src] up to [victim]'s mouth.")
		)
		reagents.trans_to(victim, to_feed, transferred_by = attacker, methods = INGEST)
		playsound(victim, 'sound/items/drink.ogg', vol = 30, vary = TRUE)
		return TRUE

	attacker.visible_message(
		span_notice("[victim] puts \the [src] up to [victim.p_their()] mouth."),
		span_notice("You put \the [src] up to your mouth.")
	)

	if(!do_after(victim, 5 SECONDS, victim, timed_action_flags = IGNORE_USER_LOC_CHANGE, extra_checks = CALLBACK(src, PROC_REF(can_drink), victim, attacker)))
		return

	victim.visible_message(
		span_notice("[victim] sucks the contents out of \the [src]!"),
		span_notice("You feed from \the [src].")
	)
	reagents.trans_to(victim, to_feed, transferred_by = attacker, methods = INGEST)
	playsound(victim, 'sound/items/drink.ogg', vol = 30, vary = TRUE)
	return TRUE

/obj/item/reagent_containers/blood/proc/can_drink(mob/living/victim, mob/living/attacker)
	if(!canconsume(victim, attacker))
		return FALSE
	if(!reagents?.total_volume)
		to_chat(victim, span_warning("[src] is empty!"))
		return FALSE
	return TRUE
