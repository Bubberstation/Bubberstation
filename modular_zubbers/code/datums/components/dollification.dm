/// Admin Smite
/datum/smite/dollify
	name = "Dollify"

/datum/smite/dollify/effect(client/user, mob/living/target)
	. = ..()

	if(!iscarbon(target))
		to_chat(user, span_warning("This must be used on a carbon mob."), confidential = TRUE)
		return

	if(!target.client?.prefs?.read_preference(/datum/preference/toggle/erp/transformation)) // Another pref check.
		to_chat(user, span_warning("ERP transformation preferences not enabled."), confidential = TRUE)
		return

	var/mob/living/carbon/carbon_target = target
	to_chat(carbon_target, span_boldbig("You feel the gods subtly smear something slick on you! FUCK!"))
	carbon_target.AddComponent(/datum/component/dollification)

/datum/component/dollification
	/// There are 4 stages. Only progresses to stage 4 (permanent) if the prompt is accepted.
	var/stage = 0
	/// Are the changes finished?
	var/dollified = FALSE
	/// Are they permanent?
	var/uncurable = FALSE

	/// Item handling
	var/obj/item/clothing/mask/muzzle/ring/doll/gag
	var/obj/item/clothing/shoes/fancy_heels/black/doll/heels

	/// Cached random starting point. Purely for flavor.
	var/origin
	/// Transformation descriptions.
	var/list/infection_text
	/// Examine text as the stages progress
	var/examine_text
	/// cached parent mob
	var/mob/living/carbon/human/doll

	/// Handles name changing and saves the original name on Initialize()
	var/old_name
	var/new_name

	COOLDOWN_DECLARE(doll_grace_period)

/datum/component/dollification/Initialize()
	. = ..()
	var/list/orgins = list("hands", "crotch", "cheek", "butt", "thigh", "chest")
	doll = parent
	if(!iscarbon(doll))
		return COMPONENT_INCOMPATIBLE

	if(!doll.client?.prefs?.read_preference(/datum/preference/toggle/erp/transformation)) // Pref Check
		qdel(src)
		return

	/// Changes their name to their job and random number.
	old_name = doll.name
	new_name = generate_name()

	RegisterSignal(doll, COMSIG_ATOM_EXAMINE, PROC_REF(on_doll_examine))
	origin = pick(orgins)
	to_chat(doll, span_purple("<b>You feel something slick smudge across your [origin]; a glossy smear visibly spreading in every direction!</b>"))
	progress_stage()
	uncurable = permanency_prompt()
	START_PROCESSING(SSobj, src)

/datum/component/dollification/Destroy()
	QDEL_NULL(gag)
	QDEL_NULL(heels)
	UnregisterSignal(doll, COMSIG_ATOM_EXAMINE)
	to_chat(doll, span_alert("You feel the rubbery changes halt in their tracks before reverting you back to normal."))
	doll.fully_replace_character_name(new_name, old_name) // Reset their name back.
	STOP_PROCESSING(SSobj, src)
	. = ..()

/datum/component/dollification/process(seconds_per_tick)
	var/probability = 5
	if(doll.stat >= HARD_CRIT) // You shouldn't progress if you're fucked up.
		return

	if(doll.reagents.has_reagent(/datum/reagent/dinitrogen_plasmide, 20) && !uncurable) // The cure
		qdel(src)

	if(!COOLDOWN_FINISHED(src, doll_grace_period)) // Have a little bit of time between stages.
		return

	if(dollified)
		return

	/// Progresses the infestation based on a probability and runs through each stage's transformation descriptions before moving on.
	if(SPT_PROB(probability, seconds_per_tick))
		var/picked_text = pick_n_take(infection_text)
		if(isnull(picked_text))
			progress_stage()
		to_chat(doll, span_purple(picked_text))

/// Doll #4123
/datum/component/dollification/proc/generate_name()
	var/job
	var/number = pick(rand(1000,9999))

	if(isnull(doll.job))
		job = "Standard"
	else
		job = doll.job

	return "[job] Doll #[number]"

/// Examine handler
/datum/component/dollification/proc/on_doll_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(isnull(examine_text) || doll.stat >= HARD_CRIT)
		return
	examine_list += span_purple(examine_text)

/// Infection stage handling for item spawning.
/datum/component/dollification/proc/progress_stage()
	stage++

	switch(stage)
		if(2)
			if(doll.get_item_by_slot(ITEM_SLOT_FEET))
				doll.dropItemToGround(doll.shoes, TRUE)
			heels = new(doll.loc)
			ADD_TRAIT(heels, TRAIT_NODROP, TRAIT_DOLLIFICATION)
			doll.equip_to_slot_if_possible(heels, ITEM_SLOT_FEET, TRUE, TRUE, TRUE)

		if(3)
			if(doll.get_item_by_slot(ITEM_SLOT_MASK))
				doll.dropItemToGround(doll.wear_mask, TRUE)

			gag = new(doll.loc)
			ADD_TRAIT(gag, TRAIT_NODROP, TRAIT_DOLLIFICATION)
			doll.equip_to_slot_if_possible(gag, ITEM_SLOT_MASK, TRUE, TRUE, TRUE)
		if(4)
			finalize_doll()

	generate_stage_flavour()
	COOLDOWN_START(src, doll_grace_period, 10 SECONDS)

/// Ask them if they want this to be permanent.
/datum/component/dollification/proc/permanency_prompt()
	var/action
	action = tgui_alert(doll, "Warning: This is unrevertable in character unless you use OOC Safe Word", "Permanent Dollification?", list("No", "Yes"))
	if(action == "No")
		return FALSE
	if(action == "Yes")
		return TRUE

/// Handle the final stages and change your name.
/datum/component/dollification/proc/finalize_doll()
	dollified = TRUE
	doll.fully_replace_character_name(old_name, new_name)
	if(uncurable)
		to_chat(doll, span_purple("<b>You can feel your entire body succumbing to its fate. The glossy sheen not just soaking through your flesh, but muscle and bone. <b>Fuck</b>, You're stuck like this... and it feels permanent.</b>"))
		STOP_PROCESSING(SSobj, src) // Not needed anymore!
	else
		to_chat(doll, span_purple("<b>The changes have finished and you're now settling into your new roll. Perhaps there's a way to escape?</b>"))

// Handles all descriptions and long transformation text in its own seperate proc.
/datum/component/dollification/proc/generate_stage_flavour()
	switch(stage)
		if(1)
			examine_text = "There is a festing splotch of smoothness slowly encompassing their [origin]"
			infection_text = list(
							"You feel the elastic oozing into your [origin]. Into the muscle itself.",
							"Your [origin] is tingling as the slick, cool smear fully encompasses it.",
							"It's feeling tight around your [origin], as a million lines of tension slowly sculpt away imperfection",
							"A pleasant tingling crawls through your body.")
		if(2)
			to_chat(doll, span_purple("<b>Wait are those heels? Sheets of obsidian black spontaniously wrap around and attach to both your feet.</b>"))
			examine_text = "The rubbery sheen continues to spread, overtaking more and more of their body."
			infection_text = list(
							"You're becoming more rubbery as time goes on, and it's feeling really good.",
							"You're starting to walk in a seductive saunter. You just can't seem to keep your hips straight!",
							"Your heeled feet clack on the hard station floor. Each click a little shockwave tingling up your rubberized legs.",
							"The creeping elastic yearns to assimilate your flesh. You're becoming more <b>thing</b> than person as the long seconds tick by.")
		if(3)
			to_chat(doll, span_purple("<b>Oooawwhh? Tension floods through your lips, forcing them into a signature O, The elastic has finally crept over the rest of your head.</b>"))
			examine_text = "A rubbery sheen coats their entire body."
			infection_text = list(
							"You try to flex your jaw and close your mouth. It only gapes wider...",
							"Lubrication fills your open mouth and begins to leak out.",
							"Your mouth is tingling as the rubbery materal begins spreading inwards.",
							"You're feeling more and more rewired- trained- alert to any sudden demands.",
							"Your name is slipping from you like sand. <b>Shit</b>, what-t was it again? [new_name]? No- it's [old_name], right?")
		if(4)
			examine_text = "Every movement is a subtle squrk: a walking, talking, breathing doll!"
