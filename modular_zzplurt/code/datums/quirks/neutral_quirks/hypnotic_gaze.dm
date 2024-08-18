#define HYPNOEYES_COOLDOWN_NORMAL 3 SECONDS
#define HYPNOEYES_COOLDOWN_BRAINWASH 30 SECONDS

/datum/quirk/Hypnotic_gaze
	name = "Hypnotic Gaze"
	desc = "Be it through mysterious patterns, flickering colors, or some genetic oddity, prolonged eye contact with you will place the viewer into a highly-suggestible hypnotic trance."
	value = 0
	mob_trait = TRAIT_HYPNOTIC_GAZE
	gain_text = span_notice("Your eyes glimmer hypnotically...")
	lose_text = span_notice("Your eyes return to normal.")
	medical_record_text = "Prolonged exposure to Patient's eyes exhibits soporific effects."

/datum/quirk/Hypnotic_gaze/add()
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Add quirk ability action datum
	var/datum/action/cooldown/hypnotize/act_hypno = new
	act_hypno.Grant(quirk_mob)

	// Add examine text
	RegisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine_holder))

/datum/quirk/Hypnotic_gaze/remove()
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove quirk ability action datum
	var/datum/action/cooldown/hypnotize/act_hypno = locate() in quirk_mob.actions
	act_hypno.Remove(quirk_mob)

	// Remove examine text
	UnregisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE)

// Quirk examine text
/datum/quirk/Hypnotic_gaze/proc/on_examine_holder(atom/examine_target, mob/living/carbon/human/examiner, list/examine_list)
	examine_list += "[quirk_holder.p_their(TRUE)] eyes glimmer with an entrancing power..."

//
// Actions
//

/datum/action/cooldown/hypnotize
	name = "Hypnotize"
	desc = "Stare deeply into someone's eyes, drawing them into a hypnotic slumber."
	button_icon_state = "Hypno_eye"
	button_icon = 'modular_splurt/icons/mob/actions/lewd_actions/lewd_icons.dmi'
	background_icon_state = "bg_alien"
	transparent_when_unavailable = TRUE
	cooldown_time = HYPNOEYES_COOLDOWN_NORMAL

	// Should this create a brainwashed victim?
	// Enabled by using Mesmer Eyes with the quirk
	var/mode_brainwash = FALSE

	// Terminology used
	var/term_hypno = "hypnotize"
	var/term_suggest = "suggestion"

/datum/action/cooldown/hypnotize/IsAvailable(feedback)
	. = ..()

	// Check parent return
	if(!.)
		return FALSE

	// Check for carbon owner
	if(!iscarbon(owner))
		// Warn user and return
		to_chat(owner, span_warning("You shouldn't have this ability!"))
		return FALSE

	// Define action owner
	var/mob/living/carbon/human/action_owner = owner

	// Check if owner has eye protection
	if(action_owner.get_eye_protection())
		// Warn the user, then return
		to_chat(action_owner, span_warning("Your eyes need to be visible for this ability to work."))
		return FALSE

	// Define owner's eyes
	var/obj/item/organ/internal/eyes/owner_eyes = owner.get_organ_slot(ORGAN_SLOT_EYES)

	// Check if eyes exist
	if(!istype(owner_eyes))
		// Warn the user, then return
		to_chat(action_owner, span_warning("You need eyes to use this ability!"))
		return FALSE

	// Check if owner is blind
	if(action_owner.has_status_effect(/datum/status_effect/grouped/blindness))
		// Warn the user, then return
		to_chat(action_owner, span_warning("Your blind [owner_eyes] are of no use."))
		return FALSE

	// All checks passed
	return TRUE

/datum/action/cooldown/hypnotize/proc/set_brainwash(set_to = FALSE)
	// Check if state will change
	if(mode_brainwash == set_to)
		// Do nothing
		return

	// Set new variable
	mode_brainwash = set_to

	// Define toggle message
	var/toggle_message = "experiences an error?"

	// Define log message type
	var/log_message_type = "somehow screwed up"

	// Check if brainwashing
	if(mode_brainwash)
		// Set ability text
		name = "Brainwash"
		desc = "Stare deeply into someone's eyes, and force them to become your loyal slave."

		// Set cooldown time
		cooldown_time = HYPNOEYES_COOLDOWN_BRAINWASH

		// Set terminology
		term_hypno = "brainwash"
		term_suggest = "command"

		// Set message suffix
		toggle_message = "suddenly feels more intense!"

		// Set log message type
		log_message_type = "GAINED"

	// Not brainwashing
	else
		// Set ability text
		name = "Hypnotize"
		desc = "Stare deeply into someone's eyes, drawing them into a hypnotic slumber."

		// Set cooldown time
		cooldown_time = HYPNOEYES_COOLDOWN_NORMAL

		// Set terminology
		term_hypno = "hypnotize"
		term_suggest = "suggestion"

		// Set message suffix
		toggle_message = "fades back to normal levels..."

		// Set log message type
		log_message_type = "LOST"

	// Update buttons
	owner.update_action_buttons()

	// Reset cooldown time
	StartCooldown()

	// Alert user
	to_chat(owner, span_mind_control("Your hypnotic power [toggle_message] You'll need time to adjust before using it again."))

	// Log interaction
	log_admin("[key_name(owner)] [log_message_type] hypnotic brainwashing powers.")

/datum/action/cooldown/hypnotize/Activate()
	// Define action owner
	var/mob/living/carbon/human/action_owner = owner

	// Define target
	var/grab_target = action_owner.pulling

	// Check for target
	if(!grab_target)
		// Warn the user, then return
		to_chat(action_owner, span_warning("You need to grab someone first!"))
		return

	// Check for cyborg
	if(iscyborg(grab_target))
		// Warn the user, then return
		to_chat(action_owner, span_warning("You can't [term_hypno] a cyborg!"))
		return

	// Check for alien
	// Taken from eyedropper check
	/*
	if(isalien(grab_target))
		// Warn the user, then return
		to_chat(action_owner, span_warning("[grab_target] doesn\'t seem to have any eyes!"))
		return
	*/

	// Check for carbon human target
	if(!ishuman(grab_target))
		// Warn the user, then return
		to_chat(action_owner, span_warning("That's not a valid creature!"))
		return

	// Check if target is alive
	if(!isliving(grab_target))
		// Warn the user, then return
		to_chat(action_owner, span_warning("You can't [term_hypno] the dead!"))
		return

	// Check for aggressive grab
	if(action_owner.grab_state < GRAB_AGGRESSIVE)
		// Warn the user, then return
		to_chat(action_owner, span_warning("You need a stronger grip before trying to [term_hypno] [grab_target]!"))
		return

	// Define target
	var/mob/living/carbon/human/action_target = grab_target

	// Check if target has a mind
	if(!action_target.mind)
		// Warn the user, then return
		to_chat(action_owner, span_warning("[grab_target] doesn't have a compatible mind!"))
		return

	/* Unused: Replaced by get_eye_protection
	// Check if target's eyes are obscured
	// ... by headwear
	if((action_target.head && action_target.head.flags_cover & HEADCOVERSEYES))
		// Warn the user, then return
		to_chat(action_owner, span_warning("[action_target]'s eyes are obscured by [action_target.head]."))
		return

	// ... by a mask
	else if((action_target.wear_mask && action_target.wear_mask.flags_cover & MASKCOVERSEYES))
		// Warn the user, then return
		to_chat(action_owner, span_warning("[action_target]'s eyes are obscured by [action_target.wear_mask]."))
		return

	// ... by glasses
	else if((action_target.glasses && action_target.glasses.flags_cover & GLASSESCOVERSEYES))
		// Warn the user, then return
		to_chat(action_owner, span_warning("[action_target]'s eyes are obscured by [action_target.glasses]."))
		return
	*/

	// Check if target has eye protection
	if(action_target.get_eye_protection())
		// Warn the user, then return
		to_chat(action_owner, span_warning("You have difficulty focusing on [action_target]'s eyes due to some form of protection, and are left unable to [term_hypno] them."))
		to_chat(action_target, span_notice("[action_owner] stares intensely at you, but stops after a moment."))
		return

	// Check if target is blind
	if(action_owner.has_status_effect(/datum/status_effect/grouped/blindness))
		// Warn the user, then return
		to_chat(action_owner, span_warning("You stare deeply into [action_target]'s eyes, but see nothing but emptiness."))
		return

	// Check for anti-magic
	// This does not include TRAIT_HOLY
	if(action_target.can_block_magic())
		// Warn the users, then return
		to_chat(action_owner, span_warning("You stare deeply into [action_target]'s eyes. They stare back at you as if nothing had happened."))
		to_chat(action_target, span_notice("[action_owner] stares intensely into your eyes for a moment. You sense nothing out of the ordinary from them."))
		return

	// Check client pref for hypno
	if(action_target.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy)) //TODO: Add the correct pref for hypno
		// Warn the users, then return
		to_chat(action_owner, span_warning("You sense that [action_target] would rather not be hypnotized, and decide to respect their wishes."))
		to_chat(action_target, span_notice("[action_owner] stares into your eyes with a strange conviction, but turns away after a moment."))
		return

	// Check for mindshield implant
	if(HAS_TRAIT(action_target, TRAIT_MINDSHIELD))
		// Warn the users, then return
		to_chat(action_owner, span_warning("You stare deeply into [action_target]'s eyes, but hear a faint buzzing from [action_target.p_their()] head. It seems something is interfering."))
		to_chat(action_target, span_notice("[action_owner] stares intensely into your eyes for a moment, before a buzzing sound emits from your head."))
		return

	// Check for sleep immunity
	// This is required for SetSleeping to trigger
	if(HAS_TRAIT(action_target, TRAIT_SLEEPIMMUNE))
		// Warn the users, then return
		to_chat(action_owner, span_warning("You stare deeply into [action_target]'s eyes, and see nothing but unrelenting energy. You won't be able to subdue [action_target.p_them()] in this state!"))
		to_chat(action_target, span_notice("[action_owner] stares intensely into your eyes, but sees something unusual about you..."))
		return

	// Check for sleep
	if(action_target.IsSleeping())
		// Warn the user, then return
		to_chat(action_owner, span_warning("You can't [term_hypno] [action_target] whilst [action_target.p_theyre()] asleep!"))
		return

	// Check for combat mode
	if(action_target.combat_focus)
		// Warn the users, then return
		to_chat(action_owner, span_warning("[action_target] is acting too defensively! You'll need [action_target.p_them()] to lower [action_target.p_their()] guard first!"))
		to_chat(action_target, span_notice("[action_owner] tries to stare into your eyes, but can't get a read on you."))
		return

	// Display chat messages
	to_chat(action_owner, span_notice("You stare deeply into [action_target]'s eyes..."))
	to_chat(action_target, span_warning("[action_owner] stares intensely into your eyes..."))

	// Try to perform action timer
	if(!do_after(action_owner, 5 SECONDS, action_target))
		// Action timer was interrupted
		// Warn the user, then return
		to_chat(action_owner, span_warning("You lose concentration on [action_target], and fail to [term_hypno] [action_target.p_them()]!"))
		to_chat(action_target, span_notice("[action_owner]'s gaze is broken prematurely, freeing you from any potential effects."))
		return

	// Define blank response
	var/input_consent

	// Check for non-consensual setting
	if(action_target.client?.prefs.read_preference(/datum/preference/choiced/erp_status_nc) != "Yes")
		// Non-consensual is NOT enabled
		// Define warning suffix
		var/warning_target = (mode_brainwash ? "You will become a brainwashed victim, and be required to follow all orders given. [action_owner] accepts all responsibility for antagonistic orders." : "These are only suggestions, and you may disobey cases that strongly violate your character.")

		// Prompt target for consent response
		input_consent = alert(action_target, "Will you fall into a hypnotic stupor? This will allow [action_owner] to issue hypnotic [term_suggest]s. [warning_target]", "Hypnosis", "Yes", "No")

	// When consent is denied
	if(input_consent == "No")
		// Warn the users, then return
		to_chat(action_owner, span_warning("[action_target]'s attention breaks, despite the attempt to [term_hypno] [action_target.p_them()]! [action_target.p_they()] clearly don't want this!"))
		to_chat(action_target, span_notice("Your concentration breaks as you realize you have no interest in following [action_owner]'s words!"))
		return

	// Display local message
	action_target.visible_message(span_warning("[action_target] falls into a deep slumber!"), span_danger("Your eyelids gently shut as you fall into a deep slumber. All you can hear is [action_owner]'s voice as you commit to following all of their [term_suggest]s."))

	// Set sleeping
	action_target.SetSleeping(2 MINUTES)

	// Set drowsiness
	action_target.set_drowsiness(max(action_target.get_timed_status_effect_duration(/datum/status_effect/drowsiness), 40))

	// Define warning suffix
	var/warning_owner = (mode_brainwash ? "You are responsible for any antagonistic actions they take as a result of the brainwashing." : "This is only a suggestion, and [action_target.p_they()] may disobey if it violates [action_target.p_their()] character.")

	// Prompt action owner for response
	var/input_suggestion = input("What would you like to suggest [action_target] do? Leave blank to release [action_target.p_them()] instead. [warning_owner]", "Hypnotic [term_suggest]", null, null)

	// Check if input text exists
	if(!input_suggestion)
		// Alert user of no input
		to_chat(action_owner, "You decide not to give [action_target] a [term_suggest].")

		// Remove sleep, then return
		action_target.SetSleeping(0)
		return

	// Sanitize input text
	input_suggestion = sanitize(input_suggestion)

	// Check if brainwash mode
	if(mode_brainwash)
		// Create brainwash objective
		brainwash(action_target, input_suggestion)

	// Not in brainwash mode
	else
		// Display message to target
		to_chat(action_target, span_mind_control("...[input_suggestion]..."))

	// Start cooldown
	StartCooldown()

	// Display message to action owner
	to_chat(action_owner, "You whisper your [term_suggest] in a smooth calming voice to [action_target]")

	// Play a sound effect
	playsound(action_target, 'sound/magic/domain.ogg', 20, 1)

	// Display local message
	action_target.visible_message(span_warning("[action_target] wakes up from their deep slumber!"), span_danger("Your eyelids gently open as you see [action_owner]'s face staring back at you."))

	// Remove sleep, then return
	action_target.SetSleeping(0)
	return

#undef HYPNOEYES_COOLDOWN_NORMAL
#undef HYPNOEYES_COOLDOWN_BRAINWASH
