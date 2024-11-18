#define ENTHRALL_BROKEN -1
#define SLEEPER_AGENT 0
#define ENTHRALL_IN_PROGRESS 1
#define PARTIALLY_ENTHRALLED 2
#define FULLY_ENTHRALLED 3
#define OVERDOSE_ENTHRALLED 4

/*//////////////////////////////////////////
		Mind control functions!
///////////////////////////////////////////
*/

//Preamble

/datum/status_effect/chem/enthrall
	id = "enthrall"
	alert_type = null
	tick_interval = 4 SECONDS
	//examine_text TODO
	/// Keeps track of the enthralling process
	var/enthrall_tally = 1
	/// Keeps track of the resistance
	var/resistance_tally = 0
	/// Total resistance added per resist click
	var/delta_resist = 0
	/// Current phase of the enthrallment process
	var/phase = ENTHRALL_IN_PROGRESS
	/// Status effects
	var/status = null
	/// Strength of status effect
	var/status_strength = 0
	/// Enchanter's person
	var/mob/living/enthrall_mob
	/// Enchanter's ckey
	var/enthrall_ckey
	/// Use master or mistress
	var/enthrall_gender
	/// Higher it is, lower the cooldown on commands, capacity reduces with resistance.
	var/mental_capacity
	/// Distance multipliers
	var/distance_multiplier = list(2,1.5,1,0.8,0.6,0.5,0.4,0.3,0.2)

	var/withdrawl_active = FALSE
	/// Counts how long withdrawl is going on for
	var/withdrawl_progress = 0

	var/list/custom_triggers = list()
	/// Cooldown on commands
	var/cooldown = 0
	/// If cooldown message has been sent
	var/cooldown_sent = TRUE
	/// If someone is triggered (so they can't trigger themselves with what they say for infinite loops)
	var/trigger_cached = FALSE
	/// delta_resist added per resist action
	var/resist_modifier = 0
	/// Distance between enthrall and thrall
	var/distance_apart = 1
	/// how long trance effects apply on trance status
	var/trance_time = 0
	/// Custom looping text in owner
	var/custom_echo
	/// Custom spans for looping text
	var/custom_span
	/// Set on on_apply. Will only be true if both individuals involved have opted in.
	var/lewd = FALSE

/datum/status_effect/chem/enthrall/on_apply()
	var/mob/living/carbon/enthrall_victim = owner
	if(HAS_TRAIT(enthrall_victim, TRAIT_PET_SKILLCHIP))
		var/obj/item/organ/internal/brain/neopet_brain = enthrall_victim.get_organ_slot(ORGAN_SLOT_BRAIN)
		for(var/obj/item/skillchip/mkiiultra/neopet_chip in neopet_brain?.skillchips)
			if(istype(neopet_chip) && neopet_chip.active)
				enthrall_ckey = neopet_chip.enthrall_ckey
				enthrall_gender = neopet_chip.enthrall_gender
				enthrall_mob = get_mob_by_key(enthrall_ckey)
				lewd = TRUE
		if(isnull(enthrall_mob))
			stack_trace("A thrall has an MKUltra skillchip activated but the skillchip has no enthrall mob linked. This should never happen!")
			owner.remove_status_effect(src)
			return ..()
	else
		var/datum/reagent/mkultra/enthrall_chem = locate(/datum/reagent/mkultra) in enthrall_victim.reagents.reagent_list
		if(!enthrall_chem.data["enthrall_ckey"])
			message_admins("WARNING: FermiChem: No enthrall_mob found in thrall, did you bus in the status? You need to set up the vars manually in the chem if it's not reacted/bussed. Someone set up the reaction/status proc incorrectly if not (Don't use donor blood). Console them with a chemcat plush maybe?")
			stack_trace("No enthrall_mob found in thrall, did you bus in the status? You need to set up the vars manually in the chem if it's not reacted/bussed. Someone set up the reaction/status proc incorrectly if not (Don't use donor blood). Console them with a chemcat plush maybe?")
			owner.remove_status_effect(src)
			return ..()
		enthrall_ckey = enthrall_chem.data["enthrall_ckey"]
		enthrall_gender = enthrall_chem.data["enthrall_gender"]
		if(enthrall_victim.ckey == enthrall_ckey)
			//owner.remove_status_effect(src)//At the moment, a user can enthrall themselves, toggle this back in if that should be removed.
			to_chat(owner, span_warning("You hear a code reviewer screaming into the void: \"I DON'T KNOW WHAT ENTHRALL.DM:93 IS SUPPOSED TO DO!"))
			return ..()
		enthrall_mob = get_mob_by_key(enthrall_ckey)
		lewd = (owner.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis)) && (enthrall_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))

	RegisterSignal(owner, COMSIG_LIVING_RESIST, .proc/owner_resist) //Do resistance calc if resist is pressed#
	RegisterSignal(owner, COMSIG_MOVABLE_HEAR, .proc/owner_hear)
	mental_capacity = 500 - enthrall_victim.get_organ_loss(ORGAN_SLOT_BRAIN)//It's their brain!
	var/message = "[(lewd ? "I am a good pet for [enthrall_gender]." : "[enthrall_mob] is a really inspirational person!")]"
	enthrall_victim.add_mood_event("enthrall", /datum/mood_event/enthrall, message)
	to_chat(owner, span_userdanger("You feel inexplicably drawn towards [enthrall_mob], their words having a demonstrable effect on you. It seems the closer you are to them, the stronger the effect is. However you aren't fully swayed yet and can resist their effects by repeatedly resisting as much as you can!"))
	SSblackbox.record_feedback("tally", "fermi_chem", 1, "Enthrall attempts")
	return ..()

/datum/status_effect/chem/enthrall/tick(seconds_between_ticks)
	var/mob/living/carbon/enthrall_victim = owner

	//chem calculations
	if(!owner.reagents.has_reagent(/datum/reagent/mkultra) && !HAS_TRAIT(enthrall_victim, TRAIT_PET_SKILLCHIP))
		if(phase < FULLY_ENTHRALLED && phase != SLEEPER_AGENT)
			delta_resist += 2 //If you've no chem, then you break out quickly
			if(prob(5))
				to_chat(owner, span_notice("Your mind starts to restore some of it's clarity as you feel the effects of the drug wain."))
	if(mental_capacity <= 500 || phase == OVERDOSE_ENTHRALLED)
		if(owner.reagents.has_reagent(/datum/reagent/medicine/mannitol))
			mental_capacity += 5
		if(owner.reagents.has_reagent(/datum/reagent/medicine/neurine))
			mental_capacity += 10

	//mindshield check
	if(HAS_TRAIT(enthrall_victim, TRAIT_MINDSHIELD))//If you manage to enrapture a head, wow, GJ. (resisting gives a bigger bonus with a mindshield) From what I can tell, this isn't possible.
		resistance_tally += 2
		if(prob(10))
			to_chat(owner, span_warning("You feel lucidity returning to your mind as the mindshield buzzes, attempting to return your brain to normal function."))
		if(phase == OVERDOSE_ENTHRALLED)
			mental_capacity += 5

	//skillchip check
	if(HAS_TRAIT(enthrall_victim, TRAIT_PET_SKILLCHIP) && (phase == ENTHRALL_IN_PROGRESS || phase == PARTIALLY_ENTHRALLED))
		enthrall_tally += 1

	//phase specific events
	switch(phase)
		if(ENTHRALL_BROKEN) //fully removed
			enthrall_victim.clear_mood_event("enthrall")
			owner.remove_status_effect(src)
			return
		if(SLEEPER_AGENT)
			if(cooldown > 0)
				cooldown -= 1
			return
		if(ENTHRALL_IN_PROGRESS)
			if(enthrall_tally >= 48)
				phase = PARTIALLY_ENTHRALLED
				mental_capacity -= resistance_tally //leftover resistance per step is taken away from mental_capacity.
				resistance_tally /= 2
				enthrall_tally = 0
				SSblackbox.record_feedback("tally", "fermi_chem", 1, "Enthralled to state 2")
				if(lewd)
					to_chat(owner, span_velvet_notice("Your conciousness slips, as you sink deeper into trance and servitude."))
				else
					to_chat(owner, span_velvet_notice("Your conciousness slips, as you feel more drawn to following [enthrall_mob]."))

			else if(resistance_tally >= 48)
				phase = ENTHRALL_BROKEN
				to_chat(owner, span_warning("You break free of the influence in your mind, your thoughts suddenly turning lucid!"))
				if(distance_apart < 10)
					to_chat(enthrall_mob, span_warning("[(lewd?"Your pet":"Your thrall")] seems to have broken free of your enthrallment!"))
				SSblackbox.record_feedback("tally", "fermi_chem", 1, "Thralls broken free")
				owner.remove_status_effect(src) //If resisted in phase 1, effect is removed.
			if(prob(10))
				if(lewd)
					to_chat(owner, span_velvet("[pick("It feels so good to listen to [enthrall_mob].", "You can't keep your eyes off [enthrall_mob].", "[enthrall_mob]'s voice is making you feel so sleepy.",  "You feel so comfortable with [enthrall_mob]", "[enthrall_mob] is so dominant, it feels right to obey them.")]."))
		if(PARTIALLY_ENTHRALLED)
			if(enthrall_tally >= 96)
				phase = FULLY_ENTHRALLED
				mental_capacity -= resistance_tally//leftover resistance per step is taken away from mental_capacity.
				enthrall_tally = 0
				resistance_tally /= 2
				if(lewd)
					to_chat(owner, span_userlove("Your mind gives, eagerly obeying and serving [enthrall_mob]."))
					to_chat(owner, span_userlove("You are now fully enthralled to [enthrall_mob], and eager to follow their commands. However you find that in your intoxicated state you are unable to resort to violence. Equally you are unable to commit suicide, even if ordered to, as you cannot serve your [enthrall_gender] in death.")) //If people start using this as an excuse to be violent I'll just make them all pacifists so it's not OP.
				else
					to_chat(owner, span_userdanger("You are unable to put up a resistance any longer, and now are under the influence of [enthrall_mob]. However you find that in your intoxicated state you are unable to resort to violence. Equally you are unable to commit suicide, even if ordered to, as you cannot follow [enthrall_mob] in death."))
				to_chat(enthrall_mob, span_notice("Your [(lewd?"pet":"follower")] [owner] appears to have fully fallen under your sway."))
				SSblackbox.record_feedback("tally", "fermi_chem", 1, "thralls fully enthralled.")
			else if(resistance_tally >= 96)
				enthrall_tally *= 0.5
				phase = ENTHRALL_IN_PROGRESS
				resistance_tally = 0
				resist_modifier = 0
				to_chat(owner, span_notice("You manage to shake some of the effects from your addled mind, however you can still feel yourself drawn towards [enthrall_mob]."))
			if(lewd && prob(10))
				to_chat(owner, span_velvet("[pick("It feels so good to listen to [enthrall_gender].", "You can't keep your eyes off [enthrall_gender].", "[enthrall_gender]'s voice is making you feel so sleepy.",  "You feel so comfortable with [enthrall_gender]", "[enthrall_gender] is so dominant, it feels right to obey them.")]."))
		if(FULLY_ENTHRALLED)
			if((resistance_tally >= 96 && withdrawl_progress >= 72) || (HAS_TRAIT(enthrall_victim, TRAIT_MINDSHIELD) && (resistance_tally >= 48)))
				enthrall_tally = 0
				phase = PARTIALLY_ENTHRALLED
				resistance_tally = 0
				resist_modifier = 0
				to_chat(owner, span_notice("The separation from [(lewd?"your [enthrall_gender]":"[enthrall_mob]")] sparks a small flame of resistance in yourself, as your mind slowly starts to return to normal."))
				REMOVE_TRAIT(owner, TRAIT_PACIFISM, "MKUltra")
			if(lewd && prob(1) && !custom_echo)
				to_chat(owner, span_userlove("[pick("I belong to [enthrall_gender].", "[enthrall_gender] knows whats best for me.", "Obedence is pleasure.",  "I exist to serve [enthrall_gender].", "[enthrall_gender] is so dominant, it feels right to obey them.")]."))
		if(OVERDOSE_ENTHRALLED) //mindbroken
			if(mental_capacity >= 499 && (owner.get_organ_loss(ORGAN_SLOT_BRAIN) <= 0 || HAS_TRAIT(enthrall_victim, TRAIT_MINDSHIELD)) && !owner.reagents.has_reagent(/datum/reagent/mkultra))
				phase = PARTIALLY_ENTHRALLED
				mental_capacity = 500
				custom_triggers = list()
				to_chat(owner, span_notice("Your mind starts to heal, fixing the damage caused by the massive amounts of chem injected into your system earlier, returning clarity to your mind. Though, you still feel drawn towards [enthrall_mob]'s words...'"))
				enthrall_victim.set_slurring(0)
				enthrall_victim.set_confusion(0)
				resist_modifier = 0
			else
				if(cooldown > 0)
					cooldown -= (0.8 + (mental_capacity / 500))
					cooldown_sent = FALSE
				else if(cooldown_sent == FALSE)
					if(distance_apart < 10)
						if(lewd)
							to_chat(enthrall_mob, span_notice("Your pet [owner] appears to have finished internalising your last command."))
							cooldown_sent = TRUE
						else
							to_chat(enthrall_mob, span_notice("Your thrall [owner] appears to have finished internalising your last command."))
							cooldown_sent = TRUE
				if(get_dist(enthrall_mob, owner) > 10)
					if(prob(10))
						to_chat(owner, span_velvet_notice("You feel [(lewd?"a deep NEED to return to your [enthrall_gender]":"like you have to return to [enthrall_mob]")]."))
						enthrall_victim.throw_at(get_step_towards(enthrall_mob,owner), 5, 1)
				return//If you break the mind of someone, you can't use status effects on them.


	//distance calculations
	distance_apart = get_dist(enthrall_mob, owner)
	switch(distance_apart)
		if(0 to 8)//If the enchanter is within range, increase enthrall_tally, remove withdrawl_active subproc and undo withdrawl_active effects.
			if(phase <= PARTIALLY_ENTHRALLED)
				// Collars speed up the enthralment process.
				if(enthrall_victim.wear_neck?.kink_collar == TRUE)
					enthrall_tally += round(distance_multiplier[get_dist(enthrall_mob, owner) + 1] * 1.5, 0.1)
				else
					enthrall_tally += round(distance_multiplier[get_dist(enthrall_mob, owner) + 1], 0.1)
			if(withdrawl_progress > 0)
				withdrawl_progress -= 2
			//calming effects
			enthrall_victim.set_hallucinations(0)
			enthrall_victim.set_stutter(0)
			enthrall_victim.set_jitter(0)
			if(owner.get_organ_loss(ORGAN_SLOT_BRAIN) >= 20)
				owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -0.2)
			if(withdrawl_active == TRUE)
				REMOVE_TRAIT(owner, TRAIT_PACIFISM, "MKUltra")
				enthrall_victim.clear_mood_event("EnthMissing1")
				enthrall_victim.clear_mood_event("EnthMissing2")
				enthrall_victim.clear_mood_event("EnthMissing3")
				enthrall_victim.clear_mood_event("EnthMissing4")
				withdrawl_active = FALSE
		if(9 to INFINITY)//If they're not nearby, enable withdrawl effects.
			withdrawl_active = TRUE

	//withdrawl_active subproc:
	if(withdrawl_active == TRUE)//Your minions are really REALLY needy.
		switch(withdrawl_progress)//denial
			if(4) // 00:20 - To reduce spam
				to_chat(owner, span_userdanger("You are unable to complete [(lewd?"your [enthrall_gender]":"[enthrall_mob]")]'s orders without their presence, and any commands and objectives given to you prior are not in effect until you are back with them."))
				ADD_TRAIT(owner, TRAIT_PACIFISM, "MKUltra") //IMPORTANT
			if(16 to 47) // 01:00-3:00 - Gives wiggle room, so you're not SUPER needy
				if(prob(5))
					to_chat(owner, span_notice("You're starting to miss [(lewd?"your [enthrall_gender]":"[enthrall_mob]")]."))
				if(prob(5))
					owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.1)
					to_chat(owner, span_userlove("[(lewd?"[enthrall_gender]":"[enthrall_mob]")] will surely be back soon!>")) //denial
			if(48) // 03:00 - You can now try and break away
				var/message = "[(lewd?"I feel empty when [enthrall_gender]'s not around..":"I miss [enthrall_mob]'s presence")]"
				enthrall_victim.add_mood_event("EnthMissing1", /datum/mood_event/enthrallmissing1, message)
			if(49 to 71) // 03:00-05:00 - barganing
				if(prob(10))
					to_chat(owner, span_userlove("They are coming back, right...?"))
					owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.5)
				if(prob(10))
					if(lewd)
						to_chat(owner, span_userlove("I just need to be a good pet for [enthrall_gender], they'll surely return if I'm a good pet."))
					owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1.5)
			if(72) // 05:00
				enthrall_victim.clear_mood_event("EnthMissing1")
				var/message = "[(lewd?"I feel so lost in this complicated world without [enthrall_gender]..":"I have to return to [enthrall_mob]!")]"
				to_chat(owner, span_warning("You start to feel really angry about how you're not with [(lewd?"your [enthrall_gender]":"[enthrall_mob]")]!"))
				enthrall_victim.add_mood_event("EnthMissing2", /datum/mood_event/enthrallmissing2, message)
				owner.adjust_stutter(30 SECONDS)
				owner.adjust_jitter(150 SECONDS)
			if(73 to 95) // 05:00-7:00 - anger
				if(prob(10))
					addtimer(CALLBACK(enthrall_victim.set_combat_mode(TRUE)), 2)
					addtimer(CALLBACK(enthrall_victim, /mob/proc/click_random_mob), 2)
					if(lewd)
						to_chat(owner, span_warning("You are overwhelmed with anger at the lack of [enthrall_gender]'s presence and suddenly lash out!"))
					else
						to_chat(owner, span_warning("You are overwhelmed with anger and suddenly lash out!"))
			if(96) // 07:00
				enthrall_victim.clear_mood_event("EnthMissing2")
				var/message = "[(lewd?"Where are you [enthrall_gender]??!":"I need to find [enthrall_mob]!")]"
				enthrall_victim.add_mood_event("EnthMissing3", /datum/mood_event/enthrallmissing3, message)
				if(lewd)
					to_chat(owner, span_warning("You need to find your [enthrall_gender] at all costs, you can't hold yourself back anymore!"))
				else
					to_chat(owner, span_warning("You need to find [enthrall_mob] at all costs, you can't hold yourself back anymore!"))
			if(97 to 119) // 07:00-09:00 - depression
				if(prob(10))
					enthrall_victim.gain_trauma_type(BRAIN_TRAUMA_MILD)
					owner.adjust_stutter(15 SECONDS)
					owner.adjust_jitter(15 SECONDS)
				else if(prob(25))
					enthrall_victim.adjust_hallucinations(10 SECONDS)
			if(120)
				enthrall_victim.clear_mood_event("EnthMissing3")
				var/message = "[(lewd?"I'm all alone, It's so hard to continute without [enthrall_gender]...":"I really need to find [enthrall_mob]!!!")]"
				enthrall_victim.add_mood_event("EnthMissing4", /datum/mood_event/enthrallmissing4, message)
				to_chat(owner, span_warning("You can hardly find the strength to continue without [(lewd?"your [enthrall_gender]":"[enthrall_mob]")]."))
				enthrall_victim.gain_trauma_type(BRAIN_TRAUMA_SEVERE)
			if(121 to 143) // 09:00-11:00 - depression 2, revengeance
				if(prob(20))
					owner.Stun(50)
					owner.emote("cry")//does this exist?
					if(lewd)
						to_chat(owner, span_warning("You're unable to hold back your tears, suddenly sobbing as the desire to see your [enthrall_gender] oncemore overwhelms you."))
					else
						to_chat(owner, span_warning("You are overwheled with withdrawl from [enthrall_mob]."))
					owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1)
					owner.adjust_stutter(15 SECONDS)
					owner.adjust_jitter(15 SECONDS)
					if(prob(10))//2% chance
						switch(rand(1,5))//Now let's see what hopefully-not-important part of the brain we cut off
							if(1 to 3)
								enthrall_victim.gain_trauma_type(BRAIN_TRAUMA_MILD)
							if(4)
								enthrall_victim.gain_trauma_type(BRAIN_TRAUMA_SEVERE)
							if(5)//0.4% chance
								enthrall_victim.gain_trauma_type(BRAIN_TRAUMA_SPECIAL)
				if(prob(5))
					delta_resist += 5
			if(144 to INFINITY) // 11:00+ - acceptance
				if(prob(15))
					delta_resist += 5
					owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1)
					if(prob(20))
						if(lewd)
							to_chat(owner, span_boldnicegreen("Maybe you'll be okay without your [enthrall_gender]."))
						else
							to_chat(owner, span_boldnicegreen("You feel your mental functions slowly begin to return."))
				if(prob(5))
					owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1)
					enthrall_victim.adjust_hallucinations(10 SECONDS)

		withdrawl_progress += 1 //Enough to leave you with a major brain trauma, but not kill you.

	//Status subproc - statuses given to you from your enthrall_mob
	//currently 3 statuses; antiresist -if you press resist, increases your enthrallment instead, HEAL - which slowly heals the pet, CHARGE - which breifly increases speed, PACIFY - makes pet a pacifist, ANTIRESIST - frustrates resist presses.
	if(status)
		if(status == "Antiresist")
			if(status_strength < 0)
				status = null
				to_chat(owner, span_notice("Your mind feels able to resist oncemore."))
			else
				status_strength -= 1

		else if(status == "heal")
			if(status_strength < 0)
				status = null
				to_chat(owner, span_notice("You finish licking your wounds."))
			else
				status_strength -= 1
				owner.heal_overall_damage(4, 4, 0, FALSE, FALSE)
				cooldown += 1 //Cooldown doesn't process till status is done

		else if(status == "charge")
			owner.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/mkultra)
			status = "charged"
			if(lewd)
				to_chat(owner, span_hear("Your [enthrall_gender]'s order fills you with a burst of speed!"))
			else
				to_chat(owner, span_hear("[enthrall_mob]'s command fills you with a burst of speed!"))

		else if(status == "charged")
			if(status_strength < 0)
				status = null
				owner.remove_movespeed_modifier(/datum/movespeed_modifier/status_effect/mkultra)
				owner.StaminaKnockdown(50)
				to_chat(owner, span_warning("Your body gives out as the adrenaline in your system runs out."))
			else
				status_strength -= 1
				cooldown += 1 //Cooldown doesn't process till status is done

		else if(status == "pacify")
			var/mob/living/carbon/carbon_owner = owner
			carbon_owner.gain_trauma(/datum/brain_trauma/severe/pacifism)
			status = null

			//Truth serum?
			//adrenals?

	//custom_echo
	if(custom_echo && withdrawl_active == FALSE && lewd)
		if(prob(2))
			if(!custom_span) //just in case!
				custom_span = "hear"
			to_chat(owner, "<span class='[custom_span]'>[custom_echo].</span>")

	//final tidying
	resistance_tally  += delta_resist
	delta_resist = 0
	if(trigger_cached >= 0)
		trigger_cached -= 1
	if(cooldown > 0)
		cooldown -= (0.8 + (mental_capacity / 500))
		cooldown_sent = FALSE
	else if(cooldown_sent == FALSE)
		if(distance_apart < 10)
			if(lewd)
				to_chat(enthrall_mob, span_hear("Your pet [owner] appears to have finished internalising your last command."))
			else
				to_chat(enthrall_mob, span_hear("Your thrall [owner] appears to have finished internalising your last command."))
		cooldown_sent = TRUE
		cooldown = 0
	if(trance_time > 0 && trance_time != 25) //custom trances only last 24 ticks.
		trance_time -= 1
	else if(trance_time == 0) //remove trance after.
		enthrall_victim.cure_trauma_type(/datum/brain_trauma/hypnosis, TRAUMA_RESILIENCE_SURGERY)
		enthrall_victim.remove_status_effect(/datum/status_effect/trance)
		trance_time = 25
	//..()

//Remove all stuff
/datum/status_effect/chem/enthrall/on_remove()
	var/mob/living/carbon/enthrall_victim = owner
	enthrall_victim.mind.remove_antag_datum(/datum/antagonist/brainwashed)
	enthrall_victim.clear_mood_event("enthrall")
	enthrall_victim.clear_mood_event("enthrallpraise")
	enthrall_victim.clear_mood_event("enthrallscold")
	enthrall_victim.clear_mood_event("EnthMissing1")
	enthrall_victim.clear_mood_event("EnthMissing2")
	enthrall_victim.clear_mood_event("EnthMissing3")
	enthrall_victim.clear_mood_event("EnthMissing4")
	UnregisterSignal(enthrall_victim, COMSIG_LIVING_RESIST)
	UnregisterSignal(owner, COMSIG_MOVABLE_HEAR)
	REMOVE_TRAIT(owner, TRAIT_PACIFISM, "MKUltra")
	to_chat(owner, span_userdanger("You're now free of [enthrall_mob]'s influence, and fully independent!'"))
	UnregisterSignal(owner, COMSIG_GLOB_LIVING_SAY_SPECIAL)
	return ..()

/datum/status_effect/chem/enthrall/proc/owner_hear(datum/source, list/hearing_args)
	if(lewd == FALSE)
		return
	if(trigger_cached > 0)
		return
	var/mob/living/carbon/enthralled_mob = owner
	var/raw_message = lowertext(hearing_args[HEARING_RAW_MESSAGE])
	for(var/trigger in custom_triggers)
		var/cached_trigger = lowertext(trigger)
		if(findtext(raw_message, cached_trigger))//if trigger1 is the message
			trigger_cached = 5 //Stops triggerparties and as a result, stops servercrashes.

			//Speak (Forces player to talk)
			if(lowertext(custom_triggers[trigger][1]) == "speak")//trigger2
				var/saytext = "Your mouth moves on it's own before you can even catch it."
				addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, enthralled_mob, span_hear(saytext)), 5)
				addtimer(CALLBACK(enthralled_mob, /atom/movable/proc/say, "[custom_triggers[trigger][2]]"), 5)


			//Echo (repeats message!) allows customisation, but won't display var calls! Defaults to hypnophrase.
			else if(lowertext(custom_triggers[trigger][1]) == "echo")//trigger2
				addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, enthralled_mob, span_velvet("[custom_triggers[trigger][2]]")), 5)
				//(to_chat(owner, "<span class='hypnophrase'><i>[custom_triggers[trigger][2]]</i></span>"))//trigger3

			//Shocking truth!
			else if(lowertext(custom_triggers[trigger]) == "shock")
				if(lewd && ishuman(enthralled_mob))
					var/mob/living/carbon/human/human_mob = enthralled_mob
					human_mob.adjust_arousal(5)
				enthralled_mob.adjust_jitter(10 SECONDS)
				enthralled_mob.adjust_stutter(5 SECONDS)
				enthralled_mob.StaminaKnockdown(60)
				enthralled_mob.Stun(60)
				to_chat(owner, span_warning("Your muscles seize up, then start spasming wildy!"))

			//kneel (knockdown)
			else if(lowertext(custom_triggers[trigger]) == "kneel")//as close to kneeling as you can get, I suppose.
				to_chat(owner, span_hear("You drop to the ground unsurreptitiously."))
				enthralled_mob.toggle_resting()

			//strip (some) clothes
			else if(lowertext(custom_triggers[trigger]) == "strip")//This wasn't meant to just be a lewd thing oops.
				var/mob/living/carbon/human/human_mob = owner
				var/items = human_mob.get_contents()
				for(var/obj/item/storage_item in items)
					if(storage_item == human_mob.w_uniform || storage_item == human_mob.wear_suit)
						human_mob.dropItemToGround(storage_item, TRUE)
				to_chat(owner, span_hear("You feel compelled to strip your clothes."))

			//trance
			else if(lowertext(custom_triggers[trigger]) == "trance")//Maaaybe too strong. Weakened it, only lasts 50 ticks.
				var/mob/living/carbon/human/human_mob = owner
				human_mob.apply_status_effect(/datum/status_effect/trance, 200, TRUE)
				trance_time = 50

	return

/datum/status_effect/chem/enthrall/proc/owner_resist()
	var/mob/living/carbon/enthrall_victim = owner
	to_chat(owner, span_hear("You attempt to fight against [enthrall_mob]'s influence!"))

	//Able to resist checks
	if(status == "Sleeper" || phase == SLEEPER_AGENT)
		return
	else if(phase == OVERDOSE_ENTHRALLED)
		if(lewd)
			to_chat(owner, span_warning("Your mind is too far gone to even entertain the thought of resisting. Unless you can fix the brain damage, you won't be able to break free of your [enthrall_gender]'s control."))
		else
			to_chat(owner, span_warning("Your brain is too overwhelmed with from the high volume of chemicals in your system, rendering you unable to resist, unless you can fix the brain damage."))
		return
	else if(phase == FULLY_ENTHRALLED && withdrawl_active == FALSE)
		if(lewd)
			to_chat(owner, span_hypnophrase("The presence of your [enthrall_gender] fully captures the horizon of your mind, removing any thoughts of resistance. If you get split up from them, then you might be able to entertain the idea of resisting."))
		else
			to_chat(owner, span_hypnophrase("You are unable to resist [enthrall_mob] in your current state. If you get split up from them, then you might be able to resist."))
		return
	else if(status == "Antiresist")//If ordered to not resist; resisting while ordered to not makes it last longer, and increases the rate in which you are enthralled.
		if(status_strength > 0)
			if(lewd)
				to_chat(owner, span_warning("The order from your [enthrall_gender] to give in is conflicting with your attempt to resist, drawing you deeper into trance! You'll have to wait a bit before attemping again, lest your attempts become frustrated again."))
			else
				to_chat(owner, span_warning("The order from your [enthrall_mob] to give in is conflicting with your attempt to resist. You'll have to wait a bit before attemping again, lest your attempts become frustrated again."))
			status_strength += 1
			enthrall_tally += 1
			return
		else
			status = null

	//base resistance
	if(delta_resist != 0)//So you can't spam it, you get one delta_resistance per tick.
		delta_resist += 0.1 //Though I commend your spamming efforts.
		return
	else
		delta_resist = 1.8 + resist_modifier
		resist_modifier += 0.05

	//distance modifer
	switch(distance_apart)
		if(0)
			delta_resist *= 0.8
		if(1 to 8)//If they're far away, increase resistance.
			delta_resist *= (1+(distance_apart/10))
		if(9 to INFINITY)//If
			delta_resist *= 2


	if(prob(5))
		enthrall_victim.emote("me", 1, "squints, shaking their head for a moment.")//shows that you're trying to resist sometimes
		delta_resist *= 1.5

	//chemical resistance, brain and annaphros are the key to undoing, but the subject has to to be willing to resist.
	if(owner.reagents.has_reagent(/datum/reagent/medicine/mannitol))
		delta_resist *= 1.25
	if(owner.reagents.has_reagent(/datum/reagent/medicine/neurine))
		delta_resist *= 1.5
	//Antag resistance
	//cultists are already brainwashed by their god
	if(IS_CULTIST(owner))
		delta_resist *= 1.3
	else if(IS_CLOCK(owner))
		delta_resist *= 1.3
	//antags should be able to resist, so they can do their other objectives. This chem does frustrate them, but they've all the tools to break free when an oportunity presents itself.
	else if(owner.mind.assigned_role in GLOB.antagonists)
		delta_resist *= 1.2

	//role resistance
	//Chaplains are already brainwashed by their god
	if(owner.mind.assigned_role == "Chaplain")
		delta_resist *= 1.2
	//Chemists should be familiar with drug effects
	if(owner.mind.assigned_role == "Chemist")
		delta_resist *= 1.2

	//Happiness resistance
	//Your Thralls are like pets, you need to keep them happy.
	if(owner.nutrition < 300)
		delta_resist += (300 - owner.nutrition) / 6
	if(owner.health < 100)//Harming your thrall will make them rebel harder.
		delta_resist *= ((120 - owner.health) / 100) + 1
	//if(owner.mood.mood) //datum/component/mood TO ADD in FERMICHEM 2
	//Add cold/hot, oxygen, sanity, happiness? (happiness might be moot, since the mood effects are so strong)
	//Mental health could play a role too in the other direction

	//If you've a collar, you get a sense of pride
	if(enthrall_victim.wear_neck?.kink_collar == TRUE)
		delta_resist *= 0.5
	if(HAS_TRAIT(enthrall_victim, TRAIT_MINDSHIELD))
		delta_resist += 5//even faster!

	return

#undef ENTHRALL_BROKEN
#undef SLEEPER_AGENT
#undef ENTHRALL_IN_PROGRESS
#undef PARTIALLY_ENTHRALLED
#undef FULLY_ENTHRALLED
#undef OVERDOSE_ENTHRALLED
