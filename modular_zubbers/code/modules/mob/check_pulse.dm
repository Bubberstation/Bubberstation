/mob/verb/check_pulse(atom/atomic as mob in view())
	set name = "Check Pulse"
	set category = "Object"

	DEFAULT_QUEUE_OR_CALL_VERB(VERB_CALLBACK(src, PROC_REF(_check_pulse), atomic))


/mob/proc/_check_pulse(mob/atomic)
	if(client && !((atomic in view(client.view, src)) && client in orange(1, atomic)))
		return FALSE
	balloon_alert(client.mob, "checking pulse...")
	if(do_after(client.mob, 4 SECONDS, atomic))
		if(isliving(client.mob))
			to_chat(atomic, span_danger("You feel [client.mob] grasp you and pause for a moment..."))
		if(atomic.stat == DEAD || HAS_TRAIT(atomic, TRAIT_NOBREATH) || HAS_TRAIT(atomic, TRAIT_NOBLOOD))
			balloon_alert(client.mob, "no pulse!")
			return TRUE
		if(atomic.stat == HARD_CRIT)
			balloon_alert(client.mob, "weak pulse!")
			return TRUE
		if(atomic.stat == SOFT_CRIT)
			balloon_alert(client.mob, "erratic pulse!")
			return TRUE

		balloon_alert(client.mob, "stable pulse")
		return TRUE

