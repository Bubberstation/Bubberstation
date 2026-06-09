#define ENTHRALL_BROKEN -1
#define SLEEPER_AGENT 0
#define ENTHRALL_IN_PROGRESS 1
#define PARTIALLY_ENTHRALLED 2
#define FULLY_ENTHRALLED 3
#define OVERDOSE_ENTHRALLED 4

/datum/status_effect/mkultra
	id = "mkultra"
	alert_type = null
	tick_interval = 1 SECONDS
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
	alert_type = /atom/movable/screen/alert/status_effect/mkultra
	/// If this status effect bypasses mindshields
	var/mindshield_bypass = FALSE
	/// If this is permanent, innate, and inescapable
	var/permanent = FALSE
	/// The progress of the enthrallment
	var/progress
	/// Bonus progress
	var/bonus_progress
	/// Resistance added per resist action. Subtracted from progress
	var/delta_resist = 0
	/// Resistance modifier determined by phase
	var/resist_modifer
	/// If the holder is withdrawing from the effects
	var/withdrawl = FALSE
	/// Phase of the enthrallment
	var/phase = ENTHRALL_IN_PROGRESS
	/// Overdose?
	var/overdose = FALSE
	/// ERP pref
	var/lewd = FALSE
	/// The mob this is receptive to.
	var/mob/living/enchanter
	/// Command datums
	var/list/commands = list()
	/// If MKUltra is in a dormant state.
	var/dormant = FALSE

/** MKUltra
 *  * enchanter - The mob in which MKUltra responds to.
 *  * mindshield - If this status effect bypasses mindshields
 *  * progress_override - What progress it should be initally set as
 * 	* permanent - If this is an innate, full, and inescapable version
 */

/datum/status_effect/mkultra/on_creation(mob/living/new_owner, mob/enchanter, mindshield = FALSE, progrogress_override = 50, permanent = FALSE)
	. = ..()
	src.progress = progrogress_override
	src.enchanter = enchanter
	src.mindshield_bypass = mindshield
	src.permanent = permanent

	if(!istype(enchanter, /mob/living) || isnull(enchanter))
		qdel(src)
		return FALSE

	if(!mindshield_bypass && HAS_TRAIT(owner, TRAIT_MINDSHIELD))
		qdel(src)
		return FALSE

	for(var/datum/mkultra_command/command as anything in GLOB.mkultra_commands)
		commands += new command

	if(isnull(enchanter.get_organ_slot(ORGAN_SLOT_VOICE)) && iscarbon(enchanter))
		var/obj/item/organ/vocal_cords/velvet/chords = new
		chords.Insert(enchanter)
		to_chat(enchanter, span_notice("You feel your voice tingle as your tone drops into a more sultry, seductive tone."))
	else if(issilicon(enchanter))
		if(isnull(locate(/datum/action/item_action/organ_action/velvet) in enchanter.actions))
			var/datum/action/item_action/organ_action/velvet/action
			action = new
			action.Grant(enchanter)
			to_chat(enchanter, span_notice("You feel your vocal processors drop to a more sultry, seductive tone."))

/datum/status_effect/mkultra/on_remove()
	for(var/datum/mkultra_command/command in commands)
		command.on_destroy(src, owner, enchanter)
	enchanter = null

/datum/status_effect/mkultra/tick(seconds_between_ticks)
	if(permanent)
		progress = 400
	/// Checks ERP hypno prefs for both players. Is done every tick to account for players updating their prefs.
	var/hypno_owner = owner.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis)
	var/hypno_enchanter = enchanter.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis)

	lewd = hypno_owner && hypno_enchanter ? TRUE : FALSE

	if(dormant)
		return FALSE

	/// Sends a tick to any commands that process
	for(var/datum/mkultra_command/command in commands)
		if(command.processing)
			command.tick(src, owner, enchanter)

	switch(progress)
		if(-INFINITY to 0)
			if(phase != ENTHRALL_BROKEN)
				to_chat(owner, span_warning("Your mind drifts back to normal as you escape the insidious yank of [enchanter]."))
			phase = ENTHRALL_BROKEN
			owner.remove_status_effect(/datum/status_effect/mkultra)
		if(1 to 49)
			if(phase != SLEEPER_AGENT)
				if(lewd)
					to_chat(owner, span_userlove("Your obediance to [get_gender()] begins to wane! It's a throbbing longing."))
				else
					to_chat(owner, span_warning("You feel yourself regaining some of your clarity."))
			phase = SLEEPER_AGENT
		if(50 to 149)
			if(phase != ENTHRALL_IN_PROGRESS)
				if(lewd)
					to_chat(owner, span_userlove("The thought of [get_gender()] is becoming intoxicating..."))
				else
					to_chat(owner, span_warning("Your mind begins to slip towards servitude, following [enchanter]."))
			phase = ENTHRALL_IN_PROGRESS
		if(150 to 300)
			if(phase != PARTIALLY_ENTHRALLED)
				if(lewd)
					to_chat(owner, span_userlove("Your mind is stumbling around the addicting concept of [enchanter]. You are hyper fixating on [get_gender()]'s words"))
				else
					to_chat(owner, span_warning("Your mind wanes. It's getting harder to resist! It's becoming easier to listen to [enchanter],"))
			phase = PARTIALLY_ENTHRALLED
		if(301 to INFINITY)
			if(phase != FULLY_ENTHRALLED)
				to_chat(owner, span_warning("You finally <b>slip</b>. One mental trip and you're unable to resist [enchanter]."))
			if(prob(10) && lewd)
				to_chat(owner, span_userlove(pick("It feels good to listen to [get_gender()]...", "You can't keep your mind off [enchanter]", "[get_gender()]'s words feel so nice.", "It feels natural when you're around [enchanter].")))
			phase = FULLY_ENTHRALLED

	if(progress <= 400)
		progress += 1 + bonus_progress
	progress -= delta_resist
	delta_resist = 0
	message_admins(progress)
	return

/datum/status_effect/mkultra/proc/resist()
	if(permanent)
		return
	/// One per tick
	if(delta_resist != 0)
		return
	delta_resist = 4

	/// Distance calculations and zeroing resistance on full enthrallment
	if(phase == FULLY_ENTHRALLED && get_dist(owner, enchanter) <= 8)
		delta_resist *= 0
		if(prob(30))
			to_chat(owner, span_warning("You're unable to break [enchanter] grasp on your mind!"))
		return

	if(prob(5))
		owner.visible_message(span_warning("[owner] shakes their head!"))
	else
		to_chat(owner, span_notice("You struggle against the mental assault overtaking your mind!"))

	if(owner.reagents.has_reagent(/datum/reagent/medicine/mannitol))
		delta_resist *= 1.25
	if(owner.reagents.has_reagent(/datum/reagent/medicine/neurine))
		delta_resist *= 1.5
	if(IS_CULTIST(owner) || IS_CLOCK(owner))
		delta_resist *= 1.3
	if((owner.mind.assigned_role in GLOB.antagonists) || owner.mind.assigned_role == "Chaplain" || owner.mind.assigned_role == "Chemist")
		delta_resist *= 1.2
	if(owner.nutrition < NUTRITION_LEVEL_HUNGRY)
		delta_resist *= ((NUTRITION_LEVEL_HUNGRY - owner.nutrition) / NUTRITION_LEVEL_HUNGRY) + 1
	if(owner.health < 70) // If you're beneath 70 health, higher resistance.
		delta_resist *= ((90 - owner.health) / 100) + 1
	var/mob/living/carbon/human/victim = owner
	if(victim.wear_neck?.kink_collar)
		delta_resist *= 0.5

/datum/status_effect/mkultra/proc/get_gender()
	switch(enchanter.gender)
		if("male")
			return "master"
		if("female")
			return "mistress"
	return "owner"

/// Listens for certain regex and triggers its proper command
/datum/status_effect/mkultra/proc/listener(mob/source, message)
	for(var/datum/mkultra_command/command in commands)
		if(findtext(message, command.trigger))
			if(command.execute(src, owner, source, message))
				return TRUE
			return FALSE
	return TRUE

/atom/movable/screen/alert/status_effect/mkultra
	icon = 'modular_zubbers/icons/obj/vocal_cords.dmi'
	icon_state = "velvet_chords"
	name = "MKUltra"
	desc = "You are under the mind warping effects of MKUltra!"

/atom/movable/screen/alert/status_effect/mkultra/Click(location, control, params)
	. = ..()
	if(isnull(attached_effect))
		attached_effect = owner.has_status_effect(/datum/status_effect/mkultra)
	var/datum/status_effect/mkultra/status = attached_effect
	status.resist()

#undef ENTHRALL_BROKEN
#undef SLEEPER_AGENT
#undef ENTHRALL_IN_PROGRESS
#undef PARTIALLY_ENTHRALLED
#undef FULLY_ENTHRALLED
#undef OVERDOSE_ENTHRALLED
