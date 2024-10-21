/*//////////////////////////////////////////
		Mind control functions!
///////////////////////////////////////////
*/

//Preamble

/datum/status_effect/chem/enthrall
	id = "enthrall"
	alert_type = null
	//examine_text TODO
	var/enthrallTally = 1 //Keeps track of the enthralling process
	var/resistanceTally = 0 //Keeps track of the resistance
	var/deltaResist //The total resistance added per resist click

	var/phase = 1 //-1: resisted state, due to be removed.0: sleeper agent, no effects unless triggered 1: initial, 2: 2nd stage - more commands, 3rd: fully enthralled, 4th Mindbroken

	var/status = null //status effects
	var/statusStrength = 0 //strength of status effect

	var/mob/living/master //Enchanter's person
	var/enthrallID //Enchanter's ckey
	var/enthrallGender //Use master or mistress

	var/mental_capacity //Higher it is, lower the cooldown on commands, capacity reduces with resistance.

	var/distancelist = list(2,1.5,1,0.8,0.6,0.5,0.4,0.3,0.2) //Distance multipliers

	var/withdrawal = FALSE //withdrawl
	var/withdrawalTick = 0 //counts how long withdrawl is going on for

	var/list/customTriggers = list() //the list of custom triggers

	var/cooldown = 0 //cooldown on commands
	var/cooldownMsg = TRUE //If cooldown message has been sent
	var/cTriggered = FALSE //If someone is triggered (so they can't trigger themselves with what they say for infinite loops)
	var/resistGrowth = 0 //Resistance accrues over time
	var/DistApart = 1 //Distance between master and owner
	var/tranceTime = 0 //how long trance effects apply on trance status

	var/customEcho	//Custom looping text in owner
	var/customSpan	//Custom spans for looping text

	var/lewd = FALSE // Set on on_apply. Will only be true if both individuals involved have opted in.

/datum/status_effect/chem/enthrall/on_apply()
	var/mob/living/carbon/enthrall_victim = owner
	var/datum/reagent/mkultra/enthrall_chem = locate(/datum/reagent/mkultra) in enthrall_victim.reagents.reagent_list
	if(!enthrall_chem.data["creatorCkey"])
		message_admins("WARNING: FermiChem: No master found in thrall, did you bus in the status? You need to set up the vars manually in the chem if it's not reacted/bussed. Someone set up the reaction/status proc incorrectly if not (Don't use donor blood). Console them with a chemcat plush maybe?")
		stack_trace("No master found in thrall, did you bus in the status? You need to set up the vars manually in the chem if it's not reacted/bussed. Someone set up the reaction/status proc incorrectly if not (Don't use donor blood). Console them with a chemcat plush maybe?")
		owner.remove_status_effect(src)
		return ..()
	enthrallID = enthrall_chem.data["creatorCkey"]
	enthrallGender = enthrall_chem.data["creatorGender"]
	if(enthrall_victim.ckey == enthrallID)
		//owner.remove_status_effect(src)//At the moment, a user can enthrall themselves, toggle this back in if that should be removed.
		to_chat(owner, span_warning("some kind of warning message here"))
		return ..()
	master = get_mob_by_key(enthrallID)
	RegisterSignal(owner, COMSIG_LIVING_RESIST, .proc/owner_resist) //Do resistance calc if resist is pressed#
	RegisterSignal(owner, COMSIG_MOVABLE_HEAR, .proc/owner_hear)
	mental_capacity = 500 - enthrall_victim.get_organ_loss(ORGAN_SLOT_BRAIN)//It's their brain!
	lewd = (owner.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis)) && (master.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))
	var/message = "[(lewd ? "I am a good pet for [enthrallGender]." : "[master] is a really inspirational person!")]"
	enthrall_victim.add_mood_event("enthrall", /datum/mood_event/enthrall, message)
	to_chat(owner, "<span class='[(lewd ?"big velvet":"big warning")]'><b>You feel inexplicably drawn towards [master], their words having a demonstrable effect on you. It seems the closer you are to them, the stronger the effect is. However you aren't fully swayed yet and can resist their effects by repeatedly resisting as much as you can!</b></span>")
	SSblackbox.record_feedback("tally", "fermi_chem", 1, "Enthrall attempts")
	return ..()

/datum/status_effect/chem/enthrall/tick()
	var/mob/living/carbon/enthrall_victim = owner

	//chem calculations
	if(!owner.reagents.has_reagent(/datum/reagent/mkultra))
		if (phase < 3 && phase != 0)
			deltaResist += 3//If you've no chem, then you break out quickly
			if(prob(5))
				to_chat(owner, "<span class='notice'><i>Your mind starts to restore some of it's clarity as you feel the effects of the drug wain.</i></span>")
	if (mental_capacity <= 500 || phase == 4)
		if (owner.reagents.has_reagent(/datum/reagent/medicine/mannitol))
			mental_capacity += 5
		if (owner.reagents.has_reagent(/datum/reagent/medicine/neurine))
			mental_capacity += 10

	//mindshield check
	if(HAS_TRAIT(enthrall_victim, TRAIT_MINDSHIELD))//If you manage to enrapture a head, wow, GJ. (resisting gives a bigger bonus with a mindshield) From what I can tell, this isn't possible.
		resistanceTally += 2
		if(prob(10))
			to_chat(owner, "<span class='notice'><i>You feel lucidity returning to your mind as the mindshield buzzes, attempting to return your brain to normal function.</i></span>")
		if(phase == 4)
			mental_capacity += 5

	//phase specific events
	switch(phase)
		if(-1)//fully removed
			enthrall_victim.clear_mood_event("enthrall")
			owner.remove_status_effect(src)
			return
		if(0)// sleeper agent
			if (cooldown > 0)
				cooldown -= 1
			return
		if(1)//Initial enthrallment
			if (enthrallTally > 125)
				phase += 1
				mental_capacity -= resistanceTally//leftover resistance per step is taken away from mental_capacity.
				resistanceTally /= 2
				enthrallTally = 0
				SSblackbox.record_feedback("tally", "fermi_chem", 1, "Enthralled to state 2")
				if(lewd)
					to_chat(owner, "<span class='big velvet'><i>Your conciousness slips, as you sink deeper into trance and servitude.</i></span>")
				else
					to_chat(owner, "<span class='big velvet'><i>Your conciousness slips, as you feel more drawn to following [master].</i></span>")

			else if (resistanceTally > 125)
				phase = -1
				to_chat(owner, "<span class='warning'><i>You break free of the influence in your mind, your thoughts suddenly turning lucid!</i></span>")
				if(DistApart < 10)
					to_chat(master, "<span class='warning'>[(lewd?"Your pet":"Your thrall")] seems to have broken free of your enthrallment!</i></span>")
				SSblackbox.record_feedback("tally", "fermi_chem", 1, "Thralls broken free")
				owner.remove_status_effect(src) //If resisted in phase 1, effect is removed.
			if(prob(10))
				if(lewd)
					to_chat(owner, "<span class='small velvet'><i>[pick("It feels so good to listen to [master].", "You can't keep your eyes off [master].", "[master]'s voice is making you feel so sleepy.",  "You feel so comfortable with [master]", "[master] is so dominant, it feels right to obey them.")].</b></span>")
		if (2) //partially enthralled
			if(enthrallTally > 200)
				phase += 1
				mental_capacity -= resistanceTally//leftover resistance per step is taken away from mental_capacity.
				enthrallTally = 0
				resistanceTally /= 2
				if(lewd)
					to_chat(owner, "<span class='love'><b><i>Your mind gives, eagerly obeying and serving [master].</b></i></span>")
					to_chat(owner, "<span class='big warning'><b>You are now fully enthralled to [master], and eager to follow their commands. However you find that in your intoxicated state you are unable to resort to violence. Equally you are unable to commit suicide, even if ordered to, as you cannot serve your [enthrallGender] in death. </i></span>")//If people start using this as an excuse to be violent I'll just make them all pacifists so it's not OP.
				else
					to_chat(owner, "<span class='big nicegreen'><i>You are unable to put up a resistance any longer, and now are under the influence of [master]. However you find that in your intoxicated state you are unable to resort to violence. Equally you are unable to commit suicide, even if ordered to, as you cannot follow [master] in death. </i></span>")
				to_chat(master, "<span class='notice'><i>Your [(lewd?"pet":"follower")] [owner] appears to have fully fallen under your sway.</i></span>")
				SSblackbox.record_feedback("tally", "fermi_chem", 1, "thralls fully enthralled.")
			else if (resistanceTally > 200)
				enthrallTally *= 0.5
				phase -= 1
				resistanceTally = 0
				resistGrowth = 0
				to_chat(owner, "<span class='notice'><i>You manage to shake some of the effects from your addled mind, however you can still feel yourself drawn towards [master].</i></span>")
			if(lewd && prob(10))
				to_chat(owner, "<span class='velvet'><i>[pick("It feels so good to listen to [enthrallGender].", "You can't keep your eyes off [enthrallGender].", "[enthrallGender]'s voice is making you feel so sleepy.",  "You feel so comfortable with [enthrallGender]", "[enthrallGender] is so dominant, it feels right to obey them.")].</i></span>")
		if (3)//fully entranced
			if ((resistanceTally >= 200 && withdrawalTick >= 150) || (HAS_TRAIT(enthrall_victim, TRAIT_MINDSHIELD) && (resistanceTally >= 100)))
				enthrallTally = 0
				phase -= 1
				resistanceTally = 0
				resistGrowth = 0
				to_chat(owner, "<span class='notice'><i>The separation from [(lewd?"your [enthrallGender]":"[master]")] sparks a small flame of resistance in yourself, as your mind slowly starts to return to normal.</i></span>")
				REMOVE_TRAIT(owner, TRAIT_PACIFISM, "MKUltra")
			if(lewd && prob(1) && !customEcho)
				to_chat(owner, "<span class='love'><i>[pick("I belong to [enthrallGender].", "[enthrallGender] knows whats best for me.", "Obedence is pleasure.",  "I exist to serve [enthrallGender].", "[enthrallGender] is so dominant, it feels right to obey them.")].</i></span>")
		if (4) //mindbroken
			if (mental_capacity >= 499 && (owner.get_organ_loss(ORGAN_SLOT_BRAIN) <=0 || HAS_TRAIT(enthrall_victim, TRAIT_MINDSHIELD)) && !owner.reagents.has_reagent(/datum/reagent/mkultra))
				phase = 2
				mental_capacity = 500
				customTriggers = list()
				to_chat(owner, "<span class='notice'><i>Your mind starts to heal, fixing the damage caused by the massive amounts of chem injected into your system earlier, returning clarity to your mind. Though, you still feel drawn towards [master]'s words...'</i></span>")
				enthrall_victim.set_slurring(0)
				enthrall_victim.set_confusion(0)
				resistGrowth = 0
			else
				if (cooldown > 0)
					cooldown -= (0.8 + (mental_capacity/500))
					cooldownMsg = FALSE
				else if (cooldownMsg == FALSE)
					if(DistApart < 10)
						if(lewd)
							to_chat(master, "<span class='notice'><i>Your pet [owner] appears to have finished internalising your last command.</i></span>")
							cooldownMsg = TRUE
						else
							to_chat(master, "<span class='notice'><i>Your thrall [owner] appears to have finished internalising your last command.</i></span>")
							cooldownMsg = TRUE
				if(get_dist(master, owner) > 10)
					if(prob(10))
						to_chat(owner, "<span class='velvet'><i>You feel [(lewd ?"a deep NEED to return to your [enthrallGender]":"like you have to return to [master]")].</i></span>")
						enthrall_victim.throw_at(get_step_towards(master,owner), 5, 1)
				return//If you break the mind of someone, you can't use status effects on them.


	//distance calculations
	DistApart = get_dist(master, owner)
	switch(DistApart)
		if(0 to 8)//If the enchanter is within range, increase enthrallTally, remove withdrawal subproc and undo withdrawal effects.
			if(phase <= 2)
				enthrallTally += distancelist[get_dist(master, owner)+1]
			if(withdrawalTick > 0)
				withdrawalTick -= 1
			//calming effects
			enthrall_victim.set_hallucinations(0)
			enthrall_victim.set_stutter(0)
			enthrall_victim.set_jitter(0)
			if(owner.get_organ_loss(ORGAN_SLOT_BRAIN) >=20)
				owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -0.2)
			if(withdrawal == TRUE)
				REMOVE_TRAIT(owner, TRAIT_PACIFISM, "MKUltra")
				enthrall_victim.clear_mood_event("EnthMissing1")
				enthrall_victim.clear_mood_event("EnthMissing2")
				enthrall_victim.clear_mood_event("EnthMissing3")
				enthrall_victim.clear_mood_event("EnthMissing4")
				withdrawal = FALSE
		if(9 to INFINITY)//If they're not nearby, enable withdrawl effects.
			withdrawal = TRUE

	//Withdrawal subproc:
	if (withdrawal == TRUE)//Your minions are really REALLY needy.
		switch(withdrawalTick)//denial
			if(5)//To reduce spam
				to_chat(owner, "<span class='big warning'><b>You are unable to complete [(lewd?"your [enthrallGender]":"[master]")]'s orders without their presence, and any commands and objectives given to you prior are not in effect until you are back with them.</b></span>")
				ADD_TRAIT(owner, TRAIT_PACIFISM, "MKUltra") //IMPORTANT
			if(10 to 35)//Gives wiggle room, so you're not SUPER needy
				if(prob(5))
					to_chat(owner, "<span class='notice'><i>You're starting to miss [(lewd?"your [enthrallGender]":"[master]")].</i></span>")
				if(prob(5))
					owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.1)
					to_chat(owner, "<i>[(lewd?"[enthrallGender]":"[master]")] will surely be back soon</i>") //denial
			if(36)
				var/message = "[(lewd?"I feel empty when [enthrallGender]'s not around..":"I miss [master]'s presence")]"
				enthrall_victim.add_mood_event("EnthMissing1", /datum/mood_event/enthrallmissing1, message)
			if(37 to 65)//barganing
				if(prob(10))
					to_chat(owner, "<i>They are coming back, right...?</i>")
					owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.5)
				if(prob(10))
					if(lewd)
						to_chat(owner, "<i>I just need to be a good pet for [enthrallGender], they'll surely return if I'm a good pet.</i>")
					owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1.5)
			if(66)
				enthrall_victim.clear_mood_event("EnthMissing1")
				var/message = "[(lewd?"I feel so lost in this complicated world without [enthrallGender]..":"I have to return to [master]!")]"
				to_chat(owner, "<span class='warning'>You start to feel really angry about how you're not with [(lewd?"your [enthrallGender]":"[master]")]!</span>")
				enthrall_victim.add_mood_event("EnthMissing2", /datum/mood_event/enthrallmissing2, message)
				owner.adjust_stutter(30 SECONDS)
				owner.adjust_jitter(150 SECONDS)
			if(67 to 89) //anger
				if(prob(10))
					addtimer(CALLBACK(enthrall_victim.set_combat_mode(TRUE)), 2)
					addtimer(CALLBACK(enthrall_victim, /mob/proc/click_random_mob), 2)
					if(lewd)
						to_chat(owner, "<span class='warning'>You are overwhelmed with anger at the lack of [enthrallGender]'s presence and suddenly lash out!</span>")
					else
						to_chat(owner, "<span class='warning'>You are overwhelmed with anger and suddenly lash out!</span>")
			if(90)
				enthrall_victim.clear_mood_event("EnthMissing2")
				var/message = "[(lewd?"Where are you [enthrallGender]??!":"I need to find [master]!")]"
				enthrall_victim.add_mood_event("EnthMissing3", /datum/mood_event/enthrallmissing3, message)
				if(lewd)
					to_chat(owner, "<span class='warning'><i>You need to find your [enthrallGender] at all costs, you can't hold yourself back anymore!</i></span>")
				else
					to_chat(owner, "<span class='warning'><i>You need to find [master] at all costs, you can't hold yourself back anymore!</i></span>")
			if(91 to 100)//depression
				if(prob(10))
					enthrall_victim.gain_trauma_type(BRAIN_TRAUMA_MILD)
					owner.adjust_stutter(15 SECONDS)
					owner.adjust_jitter(15 SECONDS)
				else if(prob(25))
					enthrall_victim.adjust_hallucinations(10 SECONDS)
			if(101)
				enthrall_victim.clear_mood_event("EnthMissing3")
				var/message = "[(lewd?"I'm all alone, It's so hard to continute without [enthrallGender]...":"I really need to find [master]!!!")]"
				enthrall_victim.add_mood_event("EnthMissing4", /datum/mood_event/enthrallmissing4, message)
				to_chat(owner, "<span class='warning'><i>You can hardly find the strength to continue without [(lewd?"your [enthrallGender]":"[master]")].</i></span>")
				enthrall_victim.gain_trauma_type(BRAIN_TRAUMA_SEVERE)
			if(102 to 140) //depression 2, revengeance
				if(prob(20))
					owner.Stun(50)
					owner.emote("cry")//does this exist?
					if(lewd)
						to_chat(owner, "<span class='warning'><i>You're unable to hold back your tears, suddenly sobbing as the desire to see your [enthrallGender] oncemore overwhelms you.</i></span>")
					else
						to_chat(owner, "<span class='warning'><i>You are overwheled with withdrawl from [master].</i></span>")
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
					deltaResist += 5
			if(140 to INFINITY) //acceptance
				if(prob(15))
					deltaResist += 5
					owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1)
					if(prob(20))
						if(lewd)
							to_chat(owner, "<i><span class='small green'>Maybe you'll be okay without your [enthrallGender].</i></span>")
						else
							to_chat(owner, "<i><span class='small green'>You feel your mental functions slowly begin to return.</i></span>")
				if(prob(5))
					owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1)
					enthrall_victim.adjust_hallucinations(10 SECONDS)

		withdrawalTick += 0.5//Enough to leave you with a major brain trauma, but not kill you.

	//Status subproc - statuses given to you from your Master
	//currently 3 statuses; antiresist -if you press resist, increases your enthrallment instead, HEAL - which slowly heals the pet, CHARGE - which breifly increases speed, PACIFY - makes pet a pacifist, ANTIRESIST - frustrates resist presses.
	if (status)

		if(status == "Antiresist")
			if (statusStrength < 0)
				status = null
				to_chat(owner, "<span class='notice'><i>Your mind feels able to resist oncemore.</i></span>")
			else
				statusStrength -= 1

		else if(status == "heal")
			if (statusStrength < 0)
				status = null
				to_chat(owner, "<span class='notice'><i>You finish licking your wounds.</i></span>")
			else
				statusStrength -= 1
				owner.heal_overall_damage(1, 1, 0, FALSE, FALSE)
				cooldown += 1 //Cooldown doesn't process till status is done

		else if(status == "charge")
			owner.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/mkultra)
			status = "charged"
			if(lewd)
				to_chat(owner, "<span class='notice'><i>Your [enthrallGender]'s order fills you with a burst of speed!</i></span>")
			else
				to_chat(owner, "<span class='notice'><i>[master]'s command fills you with a burst of speed!</i></span>")

		else if (status == "charged")
			if (statusStrength < 0)
				status = null
				owner.remove_movespeed_modifier(/datum/movespeed_modifier/status_effect/mkultra)
				owner.StaminaKnockdown(50)
				to_chat(owner, "<span class='notice'><i>Your body gives out as the adrenaline in your system runs out.</i></span>")
			else
				statusStrength -= 1
				cooldown += 1 //Cooldown doesn't process till status is done

		else if (status == "pacify")
			var/mob/living/carbon/carbon_owner = owner
			carbon_owner.gain_trauma(/datum/brain_trauma/severe/pacifism)
			status = null

			//Truth serum?
			//adrenals?

	//customEcho
	if(customEcho && withdrawal == FALSE && lewd)
		if(prob(2))
			if(!customSpan) //just in case!
				customSpan = "notice"
			to_chat(owner, "<span class='[customSpan]'><i>[customEcho].</i></span>")

	//final tidying
	resistanceTally  += deltaResist
	deltaResist = 0
	if(cTriggered >= 0)
		cTriggered -= 1
	if (cooldown > 0)
		cooldown -= (0.8 + (mental_capacity/500))
		cooldownMsg = FALSE
	else if (cooldownMsg == FALSE)
		if(DistApart < 10)
			if(lewd)
				to_chat(master, "<span class='notice'><i>Your pet [owner] appears to have finished internalising your last command.</i></span>")
			else
				to_chat(master, "<span class='notice'><i>Your thrall [owner] appears to have finished internalising your last command.</i></span>")
		cooldownMsg = TRUE
		cooldown = 0
	if (tranceTime > 0 && tranceTime != 51) //custom trances only last 50 ticks.
		tranceTime -= 1
	else if (tranceTime == 0) //remove trance after.
		enthrall_victim.cure_trauma_type(/datum/brain_trauma/hypnosis, TRAUMA_RESILIENCE_SURGERY)
		enthrall_victim.remove_status_effect(/datum/status_effect/trance)
		tranceTime = 51
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
	to_chat(owner, "<span class='big redtext'><i>You're now free of [master]'s influence, and fully independent!'</i></span>")
	UnregisterSignal(owner, COMSIG_GLOB_LIVING_SAY_SPECIAL)
	return ..()

/datum/status_effect/chem/enthrall/proc/owner_hear(datum/source, list/hearing_args)
	if(lewd == FALSE)
		return
	if (cTriggered > 0)
		return
	var/mob/living/carbon/C = owner
	var/raw_message = lowertext(hearing_args[HEARING_RAW_MESSAGE])
	for (var/trigger in customTriggers)
		var/cached_trigger = lowertext(trigger)
		if (findtext(raw_message, cached_trigger))//if trigger1 is the message
			cTriggered = 5 //Stops triggerparties and as a result, stops servercrashes.

			//Speak (Forces player to talk)
			if (lowertext(customTriggers[trigger][1]) == "speak")//trigger2
				var/saytext = "Your mouth moves on it's own before you can even catch it."
				addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, C, "<span class='notice'><i>[saytext]</i></span>"), 5)
				addtimer(CALLBACK(C, /atom/movable/proc/say, "[customTriggers[trigger][2]]"), 5)


			//Echo (repeats message!) allows customisation, but won't display var calls! Defaults to hypnophrase.
			else if (lowertext(customTriggers[trigger][1]) == "echo")//trigger2
				addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, C, "<span class='velvet'><i>[customTriggers[trigger][2]]</i></span>"), 5)
				//(to_chat(owner, "<span class='hypnophrase'><i>[customTriggers[trigger][2]]</i></span>"))//trigger3

			//Shocking truth!
			else if (lowertext(customTriggers[trigger]) == "shock")
				if (lewd && ishuman(C))
					var/mob/living/carbon/human/H = C
					H.adjust_arousal(5)
				C.adjust_jitter(10 SECONDS)
				C.adjust_stutter(5 SECONDS)
				C.StaminaKnockdown(60)
				C.Stun(60)
				to_chat(owner, "<span class='warning'><i>Your muscles seize up, then start spasming wildy!</i></span>")

			//kneel (knockdown)
			else if (lowertext(customTriggers[trigger]) == "kneel")//as close to kneeling as you can get, I suppose.
				to_chat(owner, "<span class='notice'><i>You drop to the ground unsurreptitiously.</i></span>")
				C.toggle_resting()

			//strip (some) clothes
			else if (lowertext(customTriggers[trigger]) == "strip")//This wasn't meant to just be a lewd thing oops.
				var/mob/living/carbon/human/o = owner
				var/items = o.get_contents()
				for(var/obj/item/W in items)
					if(W == o.w_uniform || W == o.wear_suit)
						o.dropItemToGround(W, TRUE)
				to_chat(owner,"<span class='notice'><i>You feel compelled to strip your clothes.</i></span>")

			//trance
			else if (lowertext(customTriggers[trigger]) == "trance")//Maaaybe too strong. Weakened it, only lasts 50 ticks.
				var/mob/living/carbon/human/o = owner
				o.apply_status_effect(/datum/status_effect/trance, 200, TRUE)
				tranceTime = 50

	return

/datum/status_effect/chem/enthrall/proc/owner_resist()
	var/mob/living/carbon/enthrall_victim = owner
	to_chat(owner, "<span class='notice'><i>You attempt to fight against [master]'s influence!</i></span>")

	//Able to resist checks
	if (status == "Sleeper" || phase == 0)
		return
	else if (phase == 4)
		if(lewd)
			to_chat(owner, "<span class='warning'><i>Your mind is too far gone to even entertain the thought of resisting. Unless you can fix the brain damage, you won't be able to break free of your [enthrallGender]'s control.</i></span>")
		else
			to_chat(owner, "<span class='warning'><i>Your brain is too overwhelmed with from the high volume of chemicals in your system, rendering you unable to resist, unless you can fix the brain damage.</i></span>")
		return
	else if (phase == 3 && withdrawal == FALSE)
		if(lewd)
			to_chat(owner, "<span class='hypnophrase'><i>The presence of your [enthrallGender] fully captures the horizon of your mind, removing any thoughts of resistance. If you get split up from them, then you might be able to entertain the idea of resisting.</i></span>")
		else
			to_chat(owner, "<span class='hypnophrase'><i>You are unable to resist [master] in your current state. If you get split up from them, then you might be able to resist.</i></span>")
		return
	else if (status == "Antiresist")//If ordered to not resist; resisting while ordered to not makes it last longer, and increases the rate in which you are enthralled.
		if (statusStrength > 0)
			if(lewd)
				to_chat(owner, "<span class='warning'><i>The order from your [enthrallGender] to give in is conflicting with your attempt to resist, drawing you deeper into trance! You'll have to wait a bit before attemping again, lest your attempts become frustrated again.</i></span>")
			else
				to_chat(owner, "<span class='warning'><i>The order from your [master] to give in is conflicting with your attempt to resist. You'll have to wait a bit before attemping again, lest your attempts become frustrated again.</i></span>")
			statusStrength += 1
			enthrallTally += 1
			return
		else
			status = null

	//base resistance
	if (deltaResist != 0)//So you can't spam it, you get one deltaResistance per tick.
		deltaResist += 0.1 //Though I commend your spamming efforts.
		return
	else
		deltaResist = 1.8 + resistGrowth
		resistGrowth += 0.05

	//distance modifer
	switch(DistApart)
		if(0)
			deltaResist *= 0.8
		if(1 to 8)//If they're far away, increase resistance.
			deltaResist *= (1+(DistApart/10))
		if(9 to INFINITY)//If
			deltaResist *= 2


	if(prob(5))
		enthrall_victim.emote("me",1,"squints, shaking their head for a moment.")//shows that you're trying to resist sometimes
		deltaResist *= 1.5

	//chemical resistance, brain and annaphros are the key to undoing, but the subject has to to be willing to resist.
	if (owner.reagents.has_reagent(/datum/reagent/medicine/mannitol))
		deltaResist *= 1.25
	if (owner.reagents.has_reagent(/datum/reagent/medicine/neurine))
		deltaResist *= 1.5
	//Antag resistance
	//cultists are already brainwashed by their god
	if(IS_CULTIST(owner))
		deltaResist *= 1.3
	else if (IS_CLOCK(owner))
		deltaResist *= 1.3
	//antags should be able to resist, so they can do their other objectives. This chem does frustrate them, but they've all the tools to break free when an oportunity presents itself.
	else if (owner.mind.assigned_role in GLOB.antagonists)
		deltaResist *= 1.2

	//role resistance
	//Chaplains are already brainwashed by their god
	if(owner.mind.assigned_role == "Chaplain")
		deltaResist *= 1.2
	//Chemists should be familiar with drug effects
	if(owner.mind.assigned_role == "Chemist")
		deltaResist *= 1.2

	//Happiness resistance
	//Your Thralls are like pets, you need to keep them happy.
	if(owner.nutrition < 300)
		deltaResist += (300-owner.nutrition)/6
	if(owner.health < 100)//Harming your thrall will make them rebel harder.
		deltaResist *= ((120-owner.health)/100)+1
	//if(owner.mood.mood) //datum/component/mood TO ADD in FERMICHEM 2
	//Add cold/hot, oxygen, sanity, happiness? (happiness might be moot, since the mood effects are so strong)
	//Mental health could play a role too in the other direction

	//If you've a collar, you get a sense of pride
	if(istype(enthrall_victim.wear_neck, /obj/item/clothing/neck/petcollar))
		deltaResist *= 0.5
	if(HAS_TRAIT(enthrall_victim, TRAIT_MINDSHIELD))
		deltaResist += 5//even faster!

	return
