/datum/species/xeno

/datum/species/xeno/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load)
	. = ..()
	var/datum/action/innate/reconstitute_form/reconstitute_form = new(human_who_gained_species) //shit ahh var name
	var/datum/action/cooldown/sonar_ping/sonar_ping = new(human_who_gained_species)
	reconstitute_form.Grant(human_who_gained_species)
	sonar_ping.Grant(human_who_gained_species)

	human_who_gained_species.add_movespeed_modifier(/datum/movespeed_modifier/xenochimera)

/datum/species/xeno/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	var/datum/action/innate/reconstitute_form/reconstitute_form = locate() in C.actions // (for the record, "C" isnt better)
	qdel(reconstitute_form)

	C.remove_movespeed_modifier(/datum/movespeed_modifier/xenochimera)



/datum/movespeed_modifier/xenochimera
	multiplicative_slowdown = -0.1


#define ACTION_STATE_STANDBY 0
#define ACTION_STATE_REGENERATING 1
#define ACTION_STATE_HATCH 2

/datum/action/innate/reconstitute_form
	name = "Reconstitute Form"
	button_icon = 'modular_zzplurt/icons/hud/actions.dmi'
	button_icon_state = "stasis"
	var/action_state = ACTION_STATE_STANDBY
	var/revive_timer = 0
	COOLDOWN_DECLARE(revive_cd)

/datum/action/innate/reconstitute_form/Trigger(trigger_flags)
	if(!..())
		return FALSE

	var/mob/living/carbon/human/owner = src.owner
	switch(action_state)
		if(ACTION_STATE_STANDBY)
			if(!COOLDOWN_FINISHED(src, revive_cd))
				to_chat(owner, "You can't use that ability again so soon!")
				return FALSE

			var/time = min(15 MINUTES, (2 MINUTES + 13 MINUTES / (1 + owner.nutrition / 100))) //weird vore formula, mildly cleaned up
			var/alert = "Are you sure you want to completely reconstruct your form? This process can take up to fifteen minutes, depending on how hungry you are, and you will be unable to move."

			if(owner.stat == DEAD)
				alert = "Are you sure you want to regenerate your corpse? This process can take up to thirty minutes."
			else if(owner.health >= owner.maxHealth)
				alert = "Are you sure you want to regenerate? As you are uninjured this will only take thirty seconds and match your appearance to your character slot."
				time = 30 SECONDS

			if(tgui_alert(owner, alert, "Confirm Regeneration", list("Yes", "No")) != "Yes")
				return FALSE

			to_chat(owner, "You begin to reconstruct your form. You will not be able to move during this time. It should take aproximately [round(time)] seconds.")
			owner.Stun(INFINITY, TRUE)

			revive_timer = addtimer(CALLBACK(src, PROC_REF(ready_revive)), time, TIMER_UNIQUE | TIMER_STOPPABLE)
			if(owner.stat == DEAD)
				RegisterSignal(owner, COMSIG_LIVING_REVIVE, PROC_REF(on_revive))

			action_state = ACTION_STATE_REGENERATING
			button_icon_state = "regenerating"
			build_all_button_icons()
			return TRUE

		if(ACTION_STATE_REGENERATING)
			to_chat(owner, span_warning("You are already reconstructing, wait [DisplayTimeText(COOLDOWN_TIMELEFT(src, revive_cd))] for the reconstruction to finish!"))
			return FALSE

		if(ACTION_STATE_HATCH)
			var/alert = "Are you sure you want to hatch right now? This will be very obvious to anyone in view."
			if(tgui_alert(owner, alert, "Confirm Regeneration", list("Yes", "No")) != "Yes")
				return FALSE

			var/revived = owner.stat == DEAD
			var/result_nutrition = owner.nutrition * 0.9

			to_chat(owner, span_notice("Your new body awakens, bursting free from your old skin."))
			owner.revive(HEAL_ALL) //i mean

			if(!revived || owner.health < owner.maxHealth)
				result_nutrition = owner.nutrition * 0.5
				for(var/obj/item/wielded in owner)
					owner.dropItemToGround(wielded, force = TRUE, silent = TRUE)

				new /obj/effect/gibspawner/human(get_turf(owner), owner)
				owner.visible_message(span_danger("<p><font size=4>The lifeless husk of [owner] bursts open, revealing a new, intact copy in the pool of viscera.</font></p>")) //Bloody hell...

			owner.nutrition = result_nutrition
			COOLDOWN_START(src, revive_cd, 10 MINUTES)

			var/post_revive_message = revived ? "The former corpse staggers to its feet, all its former wounds having vanished..." : "[owner] rises to [owner.p_their()] feet."

			owner.visible_message(post_revive_message)

			action_state = ACTION_STATE_STANDBY
			button_icon_state = "stasis"
			build_all_button_icons()
			COOLDOWN_START(src, revive_cd, 10 MINUTES)
			return TRUE

/datum/action/innate/reconstitute_form/proc/on_revive(mob/living/source, full_heal_flags)
	SIGNAL_HANDLER

	if(revive_timer)
		deltimer(revive_timer)
		revive_timer = 0

	to_chat(owner, span_notice("Your body has recovered from its ordeal, ready to regenerate itself again."))
	UnregisterSignal(owner, COMSIG_LIVING_REVIVE)
	action_state = ACTION_STATE_STANDBY

/datum/action/innate/reconstitute_form/proc/ready_revive()
	to_chat(owner, span_notice("Consciousness begins to stir as your new body awakens, ready to hatch."))

	revive_timer = 0
	action_state = ACTION_STATE_HATCH
	button_icon_state = "hatch_ready"
	build_all_button_icons()



#undef ACTION_STATE_STANDBY
#undef ACTION_STATE_REGENERATING
#undef ACTION_STATE_HATCH
