/* Needs fixing
/datum/quirk/bloodfledge
	name = "Bloodsucker Fledgling"
	desc = "You are a fledgling belonging to ancient Bloodsucker bloodline. While the blessing has yet to fully convert you, some things have changed. Only blood will sate your hungers, and holy energies will cause your flesh to char. <b>This is NOT an antagonist role!</b>"
	value = 2
	medical_record_text = "Patient exhibits onset symptoms of a sanguine curse."
	mob_trait = TRAIT_BLOODFLEDGE
	gain_text = span_notice("You feel a sanguine thirst.")
	lose_text = span_notice("You feel the sanguine thirst fade away.")

/datum/quirk/bloodfledge/add()
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Add quirk traits
	ADD_TRAIT(quirk_mob,TRAIT_NOHUNGER,ROUNDSTART_TRAIT)
	//ADD_TRAIT(quirk_mob,TRAIT_NOTHIRST,ROUNDSTART_TRAIT) //No thirst stuff yet

	// Set skin tone, if possible
	if(HAS_TRAIT(quirk_mob, TRAIT_USES_SKINTONES) && !(quirk_mob.skin_tone != initial(quirk_mob.skin_tone)))
		quirk_mob.skin_tone = "albino"
		quirk_mob.dna.update_ui_block(DNA_SKIN_TONE_BLOCK)

	// Add quirk language
	quirk_mob.grant_language(/datum/language/vampiric, ALL, LANGUAGE_MIND)

	// Register examine text
	RegisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE, PROC_REF(quirk_examine_bloodfledge))

/datum/quirk/bloodfledge/post_add()
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Define and grant ability Bite
	var/datum/action/cooldown/bloodfledge/bite/act_bite = new
	act_bite.Grant(quirk_mob)

	// Check for synthetic
	// Robotic mobs have technical issues with adjusting damage
	if(quirk_mob.mob_biotypes & MOB_ROBOTIC)
		// Warn user
		to_chat(quirk_mob, span_warning("As a synthetic lifeform, your components are only able to grant limited sanguine abilities! Regeneration and revival are not possible."))

	// User is not synthetic
	else
		// Define and grant ability Revive
		var/datum/action/cooldown/bloodfledge/revive/act_revive = new
		act_revive.Grant(quirk_mob)

/datum/quirk/bloodfledge/on_process()
	// Processing is currently only used for coffin healing
	// This is started and stopped by a proc in crates.dm

	// Define potential coffin
	var/quirk_coffin = quirk_holder.loc

	// Check if the current area is a coffin
	if(istype(quirk_coffin, /obj/structure/closet/crate/coffin))
		// Define quirk mob
		var/mob/living/carbon/human/quirk_mob = quirk_holder

		// Quirk mob must be injured
		if(quirk_mob.health >= quirk_mob.maxHealth)
			// Warn user
			to_chat(quirk_mob, span_notice("[quirk_coffin] does nothing more to help you, as your body is fully mended."))

			// Stop processing and return
			STOP_PROCESSING(SSquirks, src)
			return

		// Nutrition (blood) level must be above STARVING
		if(quirk_mob.nutrition <= NUTRITION_LEVEL_STARVING)
			// Warn user
			to_chat(quirk_mob, span_warning("[quirk_coffin] requires blood to operate, which you are currently lacking. Your connection to the other-world fades once again."))

			// Stop processing and return
			STOP_PROCESSING(SSquirks, src)
			return

		// Define initial health
		var/health_start = quirk_mob.health

		// Heal brute and burn
		// Accounts for robotic limbs
		quirk_mob.heal_overall_damage(2,2)
		// Heal oxygen
		quirk_mob.adjustOxyLoss(-2)
		// Heal clone
		//quirk_mob.adjustCloneLoss(-2) //not implemented yet

		// Check for slime race
		// NOT a slime
		if(!isslimeperson(quirk_mob))
			// Heal toxin
			quirk_mob.adjustToxLoss(-2)
		// IS a slime
		else
			// Grant toxin (heals slimes)
			quirk_mob.adjustToxLoss(2)

		// Update health
		quirk_mob.updatehealth()

		// Determine healed amount
		var/health_restored = quirk_mob.health - health_start

		// Remove nutrition (blood) as compensation for healing
		// Amount is equal to 50% of healing done
		quirk_mob.adjust_nutrition(health_restored*-1)

	// User is not in a coffin
	// This should not occur without teleportation
	else
		// Warn user
		to_chat(quirk_holder, span_warning("Your connection to the other-world is broken upon leaving the [quirk_coffin]!"))

		// Stop processing
		STOP_PROCESSING(SSquirks, src)

/datum/quirk/bloodfledge/remove()
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove quirk traits
	REMOVE_TRAIT(quirk_mob, TRAIT_NOHUNGER, ROUNDSTART_TRAIT)
	//REMOVE_TRAIT(quirk_mob, TRAIT_NOTHIRST, ROUNDSTART_TRAIT)

	// Remove quirk ability action datums
	var/datum/action/cooldown/bloodfledge/bite/act_bite = locate() in quirk_mob.actions
	var/datum/action/cooldown/bloodfledge/revive/act_revive = locate() in quirk_mob.actions
	act_bite.Remove(quirk_mob)
	act_revive.Remove(quirk_mob)

	// Remove quirk language
	quirk_mob.remove_language(/datum/language/vampiric, ALL, LANGUAGE_MIND)

	// Unregister examine text
	UnregisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE)

/datum/quirk/bloodfledge/on_spawn()
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Create vampire ID card
	var/obj/item/card/id/vampire/id_vampire = new /obj/item/card/id/vampire(get_turf(quirk_holder))

	// Update card information
	id_vampire.registered_name = quirk_mob.real_name
	id_vampire.update_label(addtext(id_vampire.registered_name, "'s Bloodfledge"))

	// Determine banking ID information
	for(var/bank_account in SSeconomy.bank_accounts_by_id)
		// Define current iteration's account
		var/datum/bank_account/account = SSeconomy.bank_accounts_by_id[bank_account]

		// Check for match
		if(account.account_id == quirk_mob.account_id)
			// Add to cards list
			account.bank_cards += src

			// Assign account
			id_vampire.registered_account = account

			// Stop searching
			break

	// Try to add ID to backpack
	var/id_in_bag = quirk_mob.equip_to_slot_if_possible(id_vampire, ITEM_SLOT_BACKPACK) || FALSE

	// Text for where the item was sent
	var/id_location = (id_in_bag ? "in your backpack" : "at your feet" )

	// Alert user in chat
	// This should not post_add, because the ID is added by on_spawn
	to_chat(quirk_holder, span_boldnotice("There is a bloodfledge's ID card [id_location], linked to your station account. It functions as a spare ID, but lacks job access."))

/datum/quirk/bloodfledge/proc/quirk_examine_bloodfledge(atom/examine_target, mob/living/carbon/human/examiner, list/examine_list)
	SIGNAL_HANDLER

	// Check if human examiner exists
	if(!istype(examiner))
		return

	// Check if examiner is dumb
	if(HAS_TRAIT(examiner, TRAIT_DUMB))
		// Return with no effects
		return

	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Define hunger texts
	var/examine_hunger_public
	var/examine_hunger_secret

	// Check hunger levels
	switch(quirk_mob.nutrition)
		// Hungry
		if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_HUNGRY)
			examine_hunger_secret = "[quirk_holder.p_they(TRUE)] [quirk_holder.p_are()] blood starved!"
			examine_hunger_public = "[quirk_holder.p_they(TRUE)] seem[quirk_holder.p_s()] on edge from something."

		// Starving
		if(0 to NUTRITION_LEVEL_STARVING)
			examine_hunger_secret = "[quirk_holder.p_they(TRUE)] [quirk_holder.p_are()] in dire need of blood!"
			examine_hunger_public = "[quirk_holder.p_they(TRUE)] [quirk_holder.p_are()] radiating an aura of frenzied hunger!"

		// Invalid hunger
		else
			// Return with no message
			return

	// Check if examiner shares the quirk
	if(isbloodfledge(examiner))
		// Add detection text
		examine_list += span_info("[quirk_holder.p_their(TRUE)] hunger makes it easy to identify [quirk_holder.p_them()] as a fellow Bloodsucker Fledgling!")

		// Add hunger text
		examine_list += span_warning(examine_hunger_secret)

	// Check if public hunger text exists
	else
		// Add hunger text
		examine_list += span_warning(examine_hunger_public)

// Basic action preset
/datum/action/cooldown/bloodfledge
	name = "Broken Bloodfledge Ability"
	desc = "You shouldn't be seeing this!"
	button_icon_state = "power_torpor"
	background_icon_state = "vamp_power_off"
	buttontooltipstyle = "cult"
	icon_icon = 'icons/mob/actions/bloodsucker.dmi'
	button_icon = 'icons/mob/actions/bloodsucker.dmi'
	transparent_when_unavailable = TRUE

// Basic can-use check
/datum/action/cooldown/bloodfledge/IsAvailable(feedback)
	. = ..()

	// Check parent return
	if(!.)
		return FALSE

	// Check for carbon owner
	if(!iscarbon(owner))
		// Warn user and return
		to_chat(owner, span_warning("You shouldn't have this ability!"))
		return FALSE

	// Check vampire ability mob proc
	if(!owner.allow_vampiric_ability(silent = FALSE))
		return FALSE

	// Action can be used
	return TRUE

// Action: Bite
/datum/action/cooldown/bloodfledge/bite
	name = "Fledgling Bite"
	desc = "Sink your vampiric fangs into the person you are grabbing, and attempt to drink their blood."
	button_icon_state = "power_feed"
	cooldown_time = BLOODFLEDGE_COOLDOWN_BITE
	var/time_interact = 30

	// Reagent holder, used to change reaction type
	var/datum/reagents/blood_bank

/datum/action/cooldown/bloodfledge/bite/Grant()
	. = ..()

	// Check for voracious
	if(HAS_TRAIT(owner, TRAIT_VORACIOUS))
		// Make times twice as fast
		cooldown_time *= 0.5
		time_interact*= 0.5

	// Create reagent holder
	blood_bank = new(BLOODFLEDGE_BANK_CAPACITY)

/datum/action/cooldown/bloodfledge/bite/Activate()
	// Define action owner
	var/mob/living/carbon/action_owner = owner

	// Check for any grabbed target
	if(!action_owner.pulling)
		// Warn the user, then return
		to_chat(action_owner, span_warning("You need a victim first!"))
		return

	// Limit maximum nutrition
	if(action_owner.nutrition >= NUTRITION_LEVEL_FAT)
		// Warn the user, then return
		to_chat(action_owner, span_notice("You are too full to drain any more."))
		return

	// Limit maximum potential nutrition
	if(action_owner.nutrition + BLOODFLEDGE_DRAIN_NUM >= NUTRITION_LEVEL_FAT)
		// Warn the user, then return
		to_chat(action_owner, span_notice("You would become too full by draining any more blood."))
		return

	// Check for muzzle
	if(action_owner.is_muzzled())
		// Warn the user, then return
		to_chat(action_owner, span_notice("You can't bite things while muzzled!"))
		return

	// Check for covered mouth
	if(action_owner.is_mouth_covered())
		// Warn the user, then return
		to_chat(action_owner, span_notice("You can't bite things with your mouth covered!"))
		return

	// Define pulled target
	var/pull_target = action_owner.pulling

	// Define bite target
	var/mob/living/carbon/human/bite_target

	// Define if action owner is dumb
	var/action_owner_dumb = HAS_TRAIT(action_owner, TRAIT_DUMB)

	// Check if the target is carbon
	if(iscarbon(pull_target))
		// Set the bite target
		bite_target = pull_target

	// Or cocooned carbon
	else if(istype(pull_target,/obj/structure/arachnid/cocoon))
		// Define if cocoon has a valid target
		// This cannot use pull_target
		var/possible_cocoon_target = locate(/mob/living/carbon/human) in action_owner.pulling.contents

		// Check defined cocoon target
		if(possible_cocoon_target)
			// Set the bite target
			bite_target = possible_cocoon_target

	// Or a blood tomato
	else if(istype(pull_target,/obj/item/reagent_containers/food/snacks/grown/tomato/blood))
		// Set message based on dumbness
		var/message_tomato_suffix = (action_owner_dumb ? ", and absorb it\'s delicious vegan-friendly blood!" : "! It's not very nutritious.")
		// Warn the user, then return
		to_chat(action_owner, span_danger("You plunge your fangs into [pull_target][message_tomato_suffix]"))
		return

		// This doesn't actually interact with the item

	// Or none of the above
	else
		// Set message based on dumbness
		var/message_invalid_target = (action_owner_dumb ? "You bite at [pull_target], but nothing seems to happen" : "You can't drain blood from [pull_target]!")
		// Warn the user, then return
		to_chat(action_owner, span_warning(message_invalid_target))
		return

	// Define selected zone
	var/target_zone = action_owner.zone_selected

	// Check if target can be penetrated
	// Bypass pierce immunity so feedback can be provided later
	if(!bite_target.can_inject(action_owner, FALSE, target_zone, FALSE, TRUE))
		// Warn the user, then return
		to_chat(action_owner, span_warning("There\'s no exposed flesh or thin material in that region of [bite_target]'s body. You're unable to bite them!"))
		return

	// Check targeted body part
	var/obj/item/bodypart/bite_bodypart = bite_target.get_bodypart(target_zone)

	// Define zone name
	var/target_zone_name = "flesh"

	// Define if target zone has special effects
	var/target_zone_effects = FALSE

	// Define if zone should be checked
	// Uses dismember check to determine if it can be missing
	// Missing limbs are assumed to be dismembered
	var/target_zone_check = bite_bodypart?.can_dismember() || TRUE

	// Set zone name based on region
	// Also checks for some protections
	switch(target_zone)
		if(BODY_ZONE_HEAD)
			target_zone_name = "neck"

		if(BODY_ZONE_CHEST)
			target_zone_name = "shoulder"

		if(BODY_ZONE_L_ARM)
			target_zone_name = "left arm"

		if(BODY_ZONE_R_ARM)
			target_zone_name = "right arm"

		if(BODY_ZONE_L_LEG)
			target_zone_name = "left thigh"

		if(BODY_ZONE_R_LEG)
			target_zone_name = "right thigh"

		if(BODY_ZONE_PRECISE_EYES)
			// Check if eyes exist and are exposed
			if(!bite_target.has_eyes() == HAS_EXPOSED_GENITAL)
				// Warn user and return
				to_chat(action_owner, span_warning("You can't find [bite_target]'s eyes to bite them!"))
				return

			// Set region data normally
			target_zone_name = "eyes"
			target_zone_check = FALSE
			target_zone_effects = TRUE

		if(BODY_ZONE_PRECISE_MOUTH)
			// Check if mouth exists and is exposed
			if(!(bite_target.has_mouth() && bite_target.mouth_is_free()))
				to_chat(action_owner, span_warning("You can't find [bite_target]'s lips to bite them!"))
				return

			// Set region data normally
			target_zone_name = "lips"
			target_zone_check = FALSE
			target_zone_effects = TRUE

		if(BODY_ZONE_PRECISE_GROIN)
			target_zone_name = "groin"
			target_zone_check = FALSE

		if(BODY_ZONE_PRECISE_L_HAND)
			target_zone_name = "left wrist"

		if(BODY_ZONE_PRECISE_R_HAND)
			target_zone_name = "right wrist"

		if(BODY_ZONE_PRECISE_L_FOOT)
			target_zone_name = "left ankle"

		if(BODY_ZONE_PRECISE_R_FOOT)
			target_zone_name = "right ankle"

	// Check if target should be checked
	if(target_zone_check)
		// Check if bodypart exists
		if(!bite_bodypart)
			// Warn user and return
			to_chat(action_owner, span_warning("[bite_target] doesn't have a [target_zone_name] for you to bite!"))
			return

		// Check if bodypart is organic
		if(!bite_bodypart.is_organic_limb())
			// Display local message
			action_owner.visible_message(span_danger("[action_owner] tries to bite [bite_target]'s [target_zone_name], but is unable to penetrate the mechanical prosthetic!"), span_warning("You attempt to bite [bite_target]'s [target_zone_name], but can't penetrate the mechanical prosthetic!"))

			// Warn user
			to_chat(bite_target, span_warning("[action_owner] tries to bite your [target_zone_name], but is unable to penetrate the mechanical prosthetic!"))

			// Play metal hit sound
			playsound(bite_target, "sound/effects/clang[pick(1,2)].ogg", 30, 1, -2)

			// Start cooldown early to prevent spam
			StartCooldown()

			// Return without further effects
			return

	// Check for anti-magic
	if(bite_target.anti_magic_check(FALSE, TRUE, FALSE, 0))
		// Check for a dumb user
		if(action_owner_dumb)
			// Display local message
			action_owner.visible_message(span_danger("[action_owner] tries to bite [bite_target]'s [target_zone_name], but bursts into flames just as [action_owner.p_they()] come[action_owner.p_s()] into contact with [bite_target.p_them()]!"), span_userdanger("Surges of pain course through your body as you attempt to bite [bite_target]! What were you thinking?"))

			// Warn target
			to_chat(bite_target, span_warning("[action_owner] tries to bite you, but bursts into flames just as [action_owner.p_they()] come[action_owner.p_s()] into contact with you!"))

			// Stop grabbing
			action_owner.stop_pulling()

			// Ignite action owner
			action_owner.adjust_fire_stacks(2)
			action_owner.IgniteMob()

			// Return with no further effects
			return

		// Warn the user and target, then return
		to_chat(bite_target, span_warning("[action_owner] tries to bite your [target_zone_name], but stops before touching you!"))
		to_chat(action_owner, span_warning("[bite_target] is blessed! You stop just in time to avoid catching fire."))
		return

	// Check for garlic necklace or garlic in the bloodstream
	if(!blood_sucking_checks(bite_target, TRUE, TRUE))
		// Check for a dumb user
		if(action_owner_dumb)
			// Display local message
			action_owner.visible_message(span_danger("[action_owner] tries to bite [bite_target]'s [target_zone_name], but immediately recoils in disgust upon touching [bite_target.p_them()]!"), span_userdanger("An intense wave of disgust washes over your body as you attempt to bite [bite_target]! What were you thinking?"))

			// Warn target
			to_chat(bite_target, span_warning("[action_owner] tries to bite your [target_zone_name], but recoils in disgust just as [action_owner.p_they()] come[action_owner.p_s()] into contact with you!"))

			// Stop grabbing
			action_owner.stop_pulling()

			// Add disgust
			action_owner.adjust_disgust(10)

			// Vomit
			action_owner.vomit()

			// Return with no further effects
			return

		// Warn the user and target, then return
		to_chat(bite_target, span_warning("[action_owner] leans in to bite your [target_zone_name], but is warded off by your Allium Sativum!"))
		to_chat(action_owner, span_warning("You sense that [bite_target] is protected by Allium Sativum, and refrain from biting [bite_target.p_them()]."))
		return

	// Define bite target's blood volume
	var/target_blood_volume = bite_target.blood_volume

	// Check for sufficient blood volume
	if(target_blood_volume < BLOODFLEDGE_DRAIN_NUM)
		// Warn the user, then return
		to_chat(action_owner, span_warning("There's not enough blood in [bite_target]!"))
		return

	// Check if total blood would become too low
	if((target_blood_volume - BLOODFLEDGE_DRAIN_NUM) <= BLOOD_VOLUME_OKAY)
		// Check for a dumb user
		if(action_owner_dumb)
			// Warn the user, but allow
			to_chat(action_owner, span_warning("You pay no attention to [bite_target]'s blood volume, and bite [bite_target.p_their()] [target_zone_name] without hesitation."))

		// Check for aggressive grab
		else if(action_owner.grab_state < GRAB_AGGRESSIVE)
			// Warn the user, then return
			to_chat(action_owner, span_warning("You sense that [bite_target] is running low on blood. You'll need a tighter grip on [bite_target.p_them()] to continue."))
			return

		// Check for pacifist
		else if(HAS_TRAIT(action_owner, TRAIT_PACIFISM))
			// Warn the user, then return
			to_chat(action_owner, span_warning("You can't drain any more blood from [bite_target] without hurting [bite_target.p_them()]!"))
			return

	// Check for pierce immunity
	if(HAS_TRAIT(bite_target, TRAIT_PIERCEIMMUNE))
		// Display local chat message
		action_owner.visible_message(span_danger("[action_owner] tries to bite down on [bite_target]'s [target_zone_name], but can't seem to pierce [bite_target.p_them()]!"), span_danger("You try to bite down on [bite_target]'s [target_zone_name], but are completely unable to pierce [bite_target.p_them()]!"))

		// Warn bite target
		to_chat(bite_target, span_userdanger("[action_owner] tries to bite your [target_zone_name], but is unable to piece you!"))

		// Return without further effects
		return

	// Check for target zone special effects
	if(target_zone_effects)
		// Check if biting eyes or mouth
		if((target_zone == BODY_ZONE_PRECISE_EYES) || (target_zone == BODY_ZONE_PRECISE_MOUTH))
			// Check if biting target with proto-type face
			// Snout type is a string that cannot use subtype search
			if(findtext(bite_target.dna?.features["mam_snouts"], "Synthetic Lizard"))
				// Display local chat message
				action_owner.visible_message(span_notice("[action_owner]'s fangs clank harmlessly against [bite_target]'s face screen!"), span_notice("Your fangs clank harmlessly against [bite_target]'s face screen!"))

				// Play glass tap sound
				playsound(bite_target, 'sound/effects/Glasshit.ogg', 30, 1, -2)

				// Start cooldown early to prevent spam
				StartCooldown()

				// Return without further effects
				return

		// Check for strange bite regions
		switch(target_zone)
			// Zone is eyes
			if(BODY_ZONE_PRECISE_EYES)
				// Define target's eyes
				var/obj/item/organ/eyes/target_eyes = bite_target.getorganslot(ORGAN_SLOT_EYES)

				// Check if eyes exist
				if(target_eyes)
					// Display warning
					to_chat(bite_target, span_userdanger("Your [target_eyes] rupture in pain as [action_owner]'s fangs pierce their surface!"))

					// Blur vision
					bite_target.blur_eyes(10)

					// Add organ damage
					target_eyes.applyOrganDamage(20)

			// Zone is mouth
			if(BODY_ZONE_PRECISE_MOUTH)
				// Cause temporary stuttering
				bite_target.stuttering = 10

	// Display local chat message
	action_owner.visible_message(span_danger("[action_owner] bites down on [bite_target]'s [target_zone_name]!"), span_danger("You bite down on [bite_target]'s [target_zone_name]!"))

	// Play a bite sound effect
	playsound(action_owner, 'sound/weapons/bite.ogg', 30, 1, -2)

	// Check if bite target species has blood
	if(NOBLOOD in bite_target.dna?.species?.species_traits)
		// Warn the user and target
		to_chat(bite_target, span_warning("[action_owner] bit your [target_zone_name] in an attempt to drain your blood, but couldn't find any!"))
		to_chat(action_owner, span_warning("[bite_target] doesn't have any blood to drink!"))

		// Start cooldown early to prevent sound spam
		StartCooldown()

		// Return without effects
		return

	// Warn bite target
	to_chat(bite_target, span_userdanger("[action_owner] has bitten your [target_zone_name], and is trying to drain your blood!"))

	// Try to perform action timer
	if(!do_after(action_owner, time_interact, target = bite_target))
		// When failing
		// Display a local chat message
		action_owner.visible_message(span_danger("[action_owner]'s fangs are prematurely torn from [bite_target]'s [target_zone_name], spilling some of [bite_target.p_their()] blood!"), span_danger("Your fangs are prematurely torn from [bite_target]'s [target_zone_name], spilling some of [bite_target.p_their()] blood!"))

		// Bite target "drops" 20% of the blood
		// This creates large blood splatter
		bite_target.bleed((BLOODFLEDGE_DRAIN_NUM*0.2), FALSE)

		// Play splatter sound
		playsound(get_turf(target), 'sound/effects/splat.ogg', 40, 1)

		// Check for masochism
		if(!HAS_TRAIT(bite_target, TRAIT_MASO))
			// Force bite_target to play the scream emote
			bite_target.emote("scream")

		// Log the biting action failure
		log_combat(action_owner,bite_target,"bloodfledge bitten (interrupted)")

		// Add target's blood to quirk holder and themselves
		bite_target.add_mob_blood(bite_target)
		action_owner.add_mob_blood(bite_target)

		// Check if body part is valid for bleeding
		// This reuses the dismember-able check
		if(target_zone_check)
			// Cause minor bleeding
			bite_bodypart.generic_bleedstacks += 2

			// Apply minor damage
			bite_bodypart.receive_damage(brute = rand(4,8), sharpness = SHARP_POINTY)

		// Start cooldown early
		// This is to prevent bite interrupt spam
		StartCooldown()

		// Return
		return
	else
		// Variable for species with non-blood blood volumes
		var/blood_valid = TRUE

		// Variable for gaining blood volume
		var/blood_transfer = FALSE

		// Name of blood volume to be taken
		// Action owner assumes blood until after drinking
		var/blood_name = "blood"

		// Check if target has exotic blood
		if(bite_target.dna?.species?.exotic_bloodtype)
			// Define blood types for owner and target
			var/blood_type_owner = action_owner.dna?.species?.exotic_bloodtype
			var/blood_type_target = bite_target.dna?.species?.exotic_bloodtype

			// Define if blood types match
			var/blood_type_match = (blood_type_owner == blood_type_target ? TRUE : FALSE)

			// Check if types matched
			if(blood_type_match)
				// Add positive mood
				SEND_SIGNAL(action_owner, COMSIG_ADD_MOOD_EVENT, "bloodfledge_drank_exotic_match", /datum/mood_event/drank_exotic_matched)

			// Switch for target's blood type
			switch(blood_type_target)
				// Synth blood
				if("S")
					// Mark blood as invalid
					blood_valid = FALSE

					// Set blood type name
					blood_name = "coolant"

					// Check if blood types match
					if(blood_type_match)
						// Allow transferring blood from this
						blood_transfer = TRUE

					// Blood types do not match
					else
						// Warn the user
						to_chat(action_owner, span_warning("That didn't taste like blood at all..."))

						// Add disgust
						action_owner.adjust_disgust(2)

						// Cause negative mood
						SEND_SIGNAL(action_owner, COMSIG_ADD_MOOD_EVENT, "bloodfledge_drank_synth", /datum/mood_event/drankblood_synth)

				// Slime blood
				if("GEL")
					// Mark blood as invalid
					blood_valid = FALSE

					// Allow transferring blood from this
					blood_transfer = TRUE

					// Set blood type name
					blood_name = "slime"

					// Check if blood types match
					if(!blood_type_match)
						// Cause negative mood
						SEND_SIGNAL(action_owner, COMSIG_ADD_MOOD_EVENT, "bloodfledge_drank_slime", /datum/mood_event/drankblood_slime)

				// Bug blood
				if("BUG")
					// Set blood type name
					blood_name = "hemolymph"

					// Check if blood types match
					if(!blood_type_match)
						// Mark blood as invalid
						blood_valid = FALSE

						// Cause negative mood
						SEND_SIGNAL(action_owner, COMSIG_ADD_MOOD_EVENT, "bloodfledge_drank_insect", /datum/mood_event/drankblood_insect)

				// Xenomorph blood
				if("X*")
					// Set blood type name
					blood_name = "xeno blood"

					// Check if blood types match
					if(!blood_type_match)
						// Mark blood as invalid
						blood_valid = FALSE

						// Cause negative mood
						SEND_SIGNAL(action_owner, COMSIG_ADD_MOOD_EVENT, "bloodfledge_drank_xeno", /datum/mood_event/drankblood_xeno)

				// Lizard blood
				if("L")
					// Set blood type name
					blood_name = "reptilian blood"

		// End of exotic blood checks

		// Define user's remaining capacity to absorb blood
		var/blood_volume_difference = BLOOD_VOLUME_MAXIMUM - action_owner.blood_volume
		var/drained_blood = min(target_blood_volume, BLOODFLEDGE_DRAIN_NUM, blood_volume_difference)

		// Transfer reagents from target to action owner
		// Limited to a maximum 10% of bite amount (default 10u)
		bite_target.reagents.trans_to(action_owner, (drained_blood*0.1))

		// Alert the bite target and local user of success
		// Yes, this is AFTER the message for non-valid blood
		to_chat(bite_target, span_danger("[action_owner] has taken some of your [blood_name]!"))
		to_chat(action_owner, span_notice("You've drained some of [bite_target]'s [blood_name]!"))

		// Check if action owner received valid (nourishing) blood
		if(blood_valid)
			// Add blood reagent to reagent holder
			blood_bank.add_reagent(/datum/reagent/blood/, drained_blood, bite_target.get_blood_data())

			// Set reaction type to INGEST
			blood_bank.reaction(action_owner, INGEST)

			// Transfer reagent to action owner
			blood_bank.trans_to(action_owner, drained_blood)

			// Remove all reagents
			blood_bank.remove_all()

		// Check if blood transfer should occur
		else if(blood_transfer)
			// Check if action holder's blood volume limit was exceeded
			if(action_owner.blood_volume >= BLOOD_VOLUME_MAXIMUM)
				// Warn user
				to_chat(action_owner, span_warning("You body cannot integrate any more [blood_name]. The remainder will be lost."))

			// Blood volume limit was not exceeded
			else
				// Alert user
				to_chat(action_owner, span_notice("You body integrates the [blood_name] directly, instead of processing it into nutrition."))

			// Transfer blood directly
			bite_target.transfer_blood_to(action_owner, drained_blood, TRUE)

			// Set drain amount to none
			// This prevents double removal
			drained_blood = 0

		// Valid blood was not received
		// No direct blood transfer occurred
		else
			// Warn user of failure
			to_chat(action_owner, span_warning("Your body cannot process the [blood_name] into nourishment!"))

		// Remove blood from bite target
		bite_target.blood_volume = clamp(target_blood_volume - drained_blood, 0, BLOOD_VOLUME_MAXIMUM)

		// Play a heartbeat sound effect
		// This was changed to match bloodsucker
		playsound(action_owner, 'sound/effects/singlebeat.ogg', 30, 1, -2)

		// Log the biting action success
		log_combat(action_owner,bite_target,"bloodfledge bitten (successfully), transferring [blood_name]")

		// Mood events
		// Check if bite target is dead or undead
		if((bite_target.stat >= DEAD) || (bite_target.mob_biotypes & MOB_UNDEAD))
			// Warn the user
			to_chat(action_owner, span_warning("The rotten [blood_name] tasted foul."))

			// Add disgust
			action_owner.adjust_disgust(2)

			// Cause negative mood
			SEND_SIGNAL(action_owner, COMSIG_ADD_MOOD_EVENT, "bloodfledge_drank_dead", /datum/mood_event/drankblood_dead)

		// Check if bite target's blood has been depleted
		if(!bite_target.blood_volume)
			// Warn the user
			to_chat(action_owner, span_warning("You've depleted [bite_target]'s [blood_name] supply!"))

			// Cause negative mood
			SEND_SIGNAL(action_owner, COMSIG_ADD_MOOD_EVENT, "bloodfledge_drank_killed", /datum/mood_event/drankkilled)

		// Check if bite target has cursed blood
		if(HAS_TRAIT(bite_target, TRAIT_CURSED_BLOOD))
			// Check action owner for cursed blood
			var/owner_cursed = HAS_TRAIT(action_owner, TRAIT_CURSED_BLOOD)

			// Set chat message based on action owner's trait status
			var/warn_message = (owner_cursed ? "You taste the unholy touch of a familiar curse in [bite_target]\'s blood." : "You experience a sensation of intense dread just after drinking from [bite_target]. Something about their blood feels... wrong.")

			// Alert user in chat
			to_chat(action_owner, span_notice(warn_message))

			// Set mood type based on curse status
			var/mood_type = (owner_cursed ? /datum/mood_event/drank_cursed_good : /datum/mood_event/drank_cursed_bad)

			// Cause mood event
			SEND_SIGNAL(action_owner, COMSIG_ADD_MOOD_EVENT, "bloodfledge_drank_cursed_blood", mood_type)

		// Start cooldown
		StartCooldown()

// Action: Revive
/datum/action/cooldown/bloodfledge/revive
	name = "Fledgling Revive"
	desc = "Expend all of your remaining energy to escape death."
	button_icon_state = "power_strength"
	cooldown_time = BLOODFLEDGE_COOLDOWN_REVIVE

/datum/action/cooldown/bloodfledge/revive/Activate()
	// Define mob
	var/mob/living/carbon/human/action_owner = owner

	// Early check for being dead
	// Users are most likely to click this while alive
	if(action_owner.stat != DEAD)
		// Warn user in chat
		to_chat(action_owner, "You can't use this ability while alive!")

		// Return
		return

	// Define failure message
	var/revive_failed

	// Condition: Mob isn't in a closed coffin
	// if(!istype(action_owner.loc, /obj/structure/closet/crate/coffin))
	// 	revive_failed += "\n- You need to be in a closed coffin!"

	// Condition: Insufficient nutrition (blood)
	if(action_owner.nutrition <= NUTRITION_LEVEL_STARVING)
		revive_failed += "\n- You don't have enough blood left!"

	/*
	 * Removed to buff revivals
	 *
	// Condition: Can be revived
	// This is used by revive(), and must be checked here to prevent false feedback
	if(!action_owner.can_be_revived())
		revive_failed += "\n- Your body is too weak to sustain life!"

	// Condition: Damage limit, brute
	if(action_owner.getBruteLoss() >= MAX_REVIVE_BRUTE_DAMAGE)
		revive_failed += "\n- Your body is too battered!"

	// Condition: Damage limit, burn
	if(action_owner.getFireLoss() >= MAX_REVIVE_FIRE_DAMAGE)
		revive_failed += "\n- Your body is too badly burned!"
	*/

	// Condition: Suicide
	if(action_owner.suiciding)
		revive_failed += "\n- You chose this path."

	// Condition: No revivals
	if(HAS_TRAIT(action_owner, TRAIT_NOCLONE))
		revive_failed += "\n- You only had one chance."

	// Condition: Demonic contract
	if(action_owner.hellbound)
		revive_failed += "\n- The soul pact must be honored."

	// Check for failure
	if(revive_failed)
		// Set combined message
		revive_failed = span_warning("You can't revive right now because: [revive_failed]")

		// Alert user in chat of failure
		to_chat(action_owner, revive_failed)

		// Return
		return

	// Check if health is too low to use revive()
	if(action_owner.health <= HEALTH_THRESHOLD_DEAD)
		// Set health high enough to revive
		// Based on defib.dm

		// Define damage values
		var/damage_brute = action_owner.getBruteLoss()
		var/damage_burn = action_owner.getFireLoss()
		var/damage_tox = action_owner.getToxLoss()
		var/damage_oxy = action_owner.getOxyLoss()
		var/damage_clone = action_owner.getCloneLoss()
		var/damage_brain = action_owner.getOrganLoss(ORGAN_SLOT_BRAIN)

		// Define total damage
		var/damage_total = damage_brute + damage_burn + damage_tox + damage_oxy + damage_brain + damage_clone

		// Define to prevent redundant math
		var/health_half_crit = action_owner.health - HALFWAYCRITDEATH

		// Adjust damage types
		action_owner.adjustOxyLoss(health_half_crit * (damage_oxy / damage_total), 0)
		action_owner.adjustToxLoss(health_half_crit * (damage_tox / damage_total), 0)
		action_owner.adjustFireLoss(health_half_crit * (damage_burn / damage_total), 0)
		action_owner.adjustBruteLoss(health_half_crit * (damage_brute / damage_total), 0)
		action_owner.adjustCloneLoss(health_half_crit * (damage_clone / damage_total), 0)
		action_owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, health_half_crit * (damage_brain / damage_total))

		// Update health
		action_owner.updatehealth()

	// Check if revival is possible
	// This is used by revive(), and must be checked here to prevent false feedback
	if(!action_owner.can_be_revived())
		// Warn user
		to_chat(action_owner, span_warning("Despite your body's best attempts at mending, it remains too weak to revive! Something this terrible shouldn't be possible!"))

		// Start cooldown anyway, since healing was performed
		StartCooldown()

		// Return without revival
		return

	// Define time dead
	// Used for revive policy
	var/time_dead = world.time - action_owner.timeofdeath

	// Revive the action owner
	action_owner.revive()

	// Alert the user in chat of success
	action_owner.visible_message(span_notice("An ominous energy radiates from the [action_owner.loc]..."), span_warning("You've expended all remaining blood to bring your body back to life!"))

	// Play a haunted sound effect
	playsound(action_owner, 'sound/hallucinations/growl1.ogg', 30, 1, -2)

	// Remove all nutrition (blood)
	action_owner.set_nutrition(0)

	// Apply daze effect
	action_owner.Daze(20)

	// Define time limit for revival
	// Determines memory loss, using defib time and policies
	var/revive_time_limit = CONFIG_GET(number/defib_cmd_time_limit) * 10

	// Define revive time threshold
	// Late causes memory loss, according to policy
	var/time_late = revive_time_limit && (time_dead > revive_time_limit)

	// Define policy to use
	var/list/policies = CONFIG_GET(keyed_list/policy)
	var/time_policy = time_late? policies[POLICYCONFIG_ON_DEFIB_LATE] : policies[POLICYCONFIG_ON_DEFIB_INTACT]

	// Check if policy exists
	if(time_policy)
		// Alert user in chat of policy
		to_chat(action_owner, time_policy)

	// Log the revival and effective policy
	action_owner.log_message("revived using a vampire quirk ability after being dead for [time_dead] deciseconds. Considered [time_late? "late" : "memory-intact"] revival under configured policy limits.", LOG_GAME)

	// Start cooldown
	StartCooldown()
*/
