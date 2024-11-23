/// Amount of blood taken from a target on bite
#define BLOODFLEDGE_DRAIN_AMT 50
/// Base amount of time to bite a target before adjustments
#define BLOODFLEDGE_DRAIN_TIME 50
/// Cooldown for the bite ability
#define BLOODFLEDGE_COOLDOWN_BITE 60 // Six seconds
/// Cooldown for the revive ability
#define BLOODFLEDGE_COOLDOWN_REVIVE 3000 // Five minutes
/// How much blood can be held after biting
#define BLOODFLEDGE_BANK_CAPACITY (BLOODFLEDGE_DRAIN_AMT * 2)
/// How much damage is healed in a coffin
#define BLOODFLEDGE_HEAL_AMT -2

/datum/quirk/item_quirk/bloodfledge
	name = "Bloodfledge"
	desc = "You are apprentice sanguine sorcerer endowed with vampiric power beyond that of a common hemophage. While not truly undead, many of the same conditions still apply."
	value = 4
	gain_text = span_notice("A sanguine blessing flows through your body, granting it new strength.")
	lose_text = span_notice("The sanguine blessing fades away...")
	medical_record_text = "Patient appears to possess a paranormal connection to otherworldly forces."
	mob_trait = TRAIT_BLOODFLEDGE
	hardcore_value = -2
	icon = FA_ICON_CHAMPAGNE_GLASSES
	/// Toggle between using blood volume or nutrition. Blood volume is used for hemophages.
	var/use_nutrition = TRUE

/datum/quirk/item_quirk/bloodfledge/add(client/client_source)
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Register examine text
	RegisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE, PROC_REF(quirk_examine_bloodfledge))

	// Register wooden stake interaction
	RegisterSignal(quirk_holder, COMSIG_MOB_STAKED, PROC_REF(on_staked))

	// Add quirk language
	quirk_mob.grant_language(/datum/language/vampiric, ALL, LANGUAGE_QUIRK)

	/**
	 * Hemophage check
	 *
	 * Check if the quirk holder is a hemophage.
	 * Ignore remaining features if they are
	 */
	if(ishemophage(quirk_mob))
		return

	// Add quirk traits
	ADD_TRAIT(quirk_mob, TRAIT_LIVERLESS_METABOLISM, TRAIT_BLOODFLEDGE)
	//ADD_TRAIT(quirk_mob, TRAIT_NOTHIRST, TRAIT_BLOODFLEDGE) // Not yet implemented

	// Register blood consumption interaction
	RegisterSignal(quirk_holder, COMSIG_REAGENT_ADD_BLOOD, PROC_REF(on_consume_blood))

	// Register coffin interaction
	RegisterSignal(quirk_holder, COMSIG_ENTER_COFFIN, PROC_REF(on_enter_coffin))

	// Set skin tone, if possible
	if(HAS_TRAIT(quirk_mob, TRAIT_USES_SKINTONES) && !(quirk_mob.skin_tone != initial(quirk_mob.skin_tone)))
		quirk_mob.skin_tone = "albino"
		quirk_mob.dna.update_ui_block(DNA_SKIN_TONE_BLOCK)

	// Add vampiric biotype
	quirk_mob.mob_biotypes |= MOB_VAMPIRIC

	// Add profane penalties
	quirk_holder.AddElementTrait(TRAIT_CHAPEL_WEAKNESS, TRAIT_BLOODFLEDGE, /datum/element/chapel_weakness)
	quirk_holder.AddElementTrait(TRAIT_HOLYWATER_WEAKNESS, TRAIT_BLOODFLEDGE, /datum/element/holywater_weakness)

/datum/quirk/item_quirk/bloodfledge/post_add()
	. = ..()

	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Teach how to make the Hemorrhagic Sanguinizer
	quirk_mob.mind?.teach_crafting_recipe(/datum/crafting_recipe/emag_bloodfledge)

	// Check for non-organic mob
	// Robotic and other mobs have technical issues with adjusting damage
	if(!(quirk_mob.mob_biotypes & MOB_ORGANIC))
		// Warn user
		to_chat(quirk_mob, span_warning("As a non-organic lifeform, your structure is only able to support limited sanguine abilities! Regeneration and revival are not possible."))

	// User is organic
	else
		// Define and grant ability Revive
		var/datum/action/cooldown/bloodfledge/revive/act_revive = new
		act_revive.Grant(quirk_mob)

	/**
	 * Hemophage check
	 *
	 * Check if the quirk holder is a hemophage.
	 * Ignore remaining features if they are
	 */
	if(ishemophage(quirk_mob))
		// Warn user
		to_chat(quirk_mob, span_warning("Because you already possess the tumor's corruption, some redundant bloodfledge abilities remain dormant. Your bite ability will manifest once the tumor's corruption takes hold."))

		// Disable nutrition mode
		use_nutrition = FALSE

		// Ignore remaining features
		return

	// Define owner tongue
	var/obj/item/organ/internal/tongue/target_tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)

	// Check if tongue exists
	if(target_tongue)
		// Force preference for bloody food
		target_tongue.disliked_foodtypes &= ~BLOODY
		target_tongue.liked_foodtypes |= BLOODY

	// Define and grant ability Bite
	var/datum/action/cooldown/bloodfledge/bite/act_bite = new
	act_bite.Grant(quirk_mob)

// Processing is currently only used for coffin healing
/datum/quirk/item_quirk/bloodfledge/process(seconds_per_tick)
	// Define potential coffin
	var/quirk_coffin = quirk_holder.loc

	// Check if the current area is a coffin
	if(!istype(quirk_coffin, /obj/structure/closet/crate/coffin))
		// Warn user
		to_chat(quirk_holder, span_warning("Your connection to the other-world is broken upon leaving the coffin!"))

		// Stop processing and return
		STOP_PROCESSING(SSquirks, src)
		return

	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Quirk mob must be injured
	if(quirk_mob.health >= quirk_mob.maxHealth)
		// Warn user
		to_chat(quirk_mob, span_notice("[quirk_coffin] does nothing more to help you, as your body is fully mended."))

		// Stop processing and return
		STOP_PROCESSING(SSquirks, src)
		return

	/// Define if nutrition or blood volume is sufficient. Will stop healing if FALSE.
	var/has_enough_blood = TRUE

	// Check if using nutrition mode
	if(use_nutrition)
		// Nutrition level must be above STARVING
		if(quirk_mob.nutrition <= NUTRITION_LEVEL_STARVING)
			// Set variable
			has_enough_blood = FALSE

	// Using blood volume mode
	else
		// Blood level must be above SURVIVE
		if(quirk_mob.blood_volume <= BLOOD_VOLUME_SURVIVE)
			// Set variable
			has_enough_blood = FALSE

	// Check if nutrition or blood volume is high enough
	if(!has_enough_blood)
		// Warn user
		to_chat(quirk_mob, span_warning("[quirk_coffin] requires blood to operate, which you are currently lacking. Your connection to the other-world fades once again."))

		// Stop processing and return
		STOP_PROCESSING(SSquirks, src)
		return

	// Define initial health
	var/health_start = quirk_mob.health

	// Define health needing updates
	var/need_mob_update = FALSE

	// Queue healing compatible damage types
	need_mob_update += quirk_holder.adjustBruteLoss(BLOODFLEDGE_HEAL_AMT, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
	need_mob_update += quirk_holder.adjustFireLoss(BLOODFLEDGE_HEAL_AMT, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
	need_mob_update += quirk_holder.adjustToxLoss(BLOODFLEDGE_HEAL_AMT, updating_health = FALSE, required_biotype = MOB_ORGANIC, forced = TRUE)
	need_mob_update += quirk_holder.adjustOxyLoss(BLOODFLEDGE_HEAL_AMT, updating_health = FALSE, required_biotype = MOB_ORGANIC)

	// Check if healing will be applied
	if(need_mob_update)
		// Update health
		quirk_holder.updatehealth()

	// No healing will occur
	else
		// Warn user
		to_chat(quirk_mob, span_warning("[quirk_coffin] cannot mend any more damage to your body."))

		// Stop processing and return
		STOP_PROCESSING(SSquirks, src)
		return

	// Determine healed amount
	var/health_restored = quirk_mob.health - health_start

	// Remove a resource as compensation for healing
	// Amount is equal to healing done

	// Check if using nutrition mode
	if(use_nutrition)
		quirk_mob.adjust_nutrition(health_restored*-1)

	// Using blood volume mode
	else
		quirk_mob.blood_volume -= (health_restored*-1)


/datum/quirk/item_quirk/bloodfledge/remove()
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove quirk ability action datums
	var/datum/action/cooldown/bloodfledge/revive/act_revive = locate() in quirk_mob.actions
	act_revive?.Remove(quirk_mob)

	// Remove quirk language
	quirk_mob.remove_language(/datum/language/vampiric, ALL, LANGUAGE_QUIRK)

	// Unregister examine text
	UnregisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE)

	/**
	 * Hemophage check
	 *
	 * Check if the quirk holder is a hemophage.
	 * Ignore remaining features if they are
	 */
	if(ishemophage(quirk_mob))
		return

	// Remove quirk traits
	REMOVE_TRAIT(quirk_mob, TRAIT_LIVERLESS_METABOLISM, ROUNDSTART_TRAIT)
	//REMOVE_TRAIT(quirk_mob, TRAIT_NOTHIRST, ROUNDSTART_TRAIT)

	// Check if species should still be vampiric
	if(!(quirk_mob.dna?.species?.inherent_biotypes & MOB_VAMPIRIC))
		// Remove vampiric biotype
		quirk_mob.mob_biotypes -= MOB_VAMPIRIC

	// Remove quirk ability action datums
	var/datum/action/cooldown/bloodfledge/bite/act_bite = locate() in quirk_mob.actions
	act_bite?.Remove(quirk_mob)

	// Remove profane penalties
	REMOVE_TRAIT(quirk_holder, TRAIT_CHAPEL_WEAKNESS, TRAIT_BLOODFLEDGE)
	REMOVE_TRAIT(quirk_holder, TRAIT_HOLYWATER_WEAKNESS, TRAIT_BLOODFLEDGE)

/datum/quirk/item_quirk/bloodfledge/add_unique(client/client_source)
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Create vampire ID card
	var/obj/item/card/id/advanced/quirk/bloodfledge/id_vampire = new(get_turf(quirk_mob))

	// Define default card type name
	var/card_name_type = "Blood"

	// Define possible blood prefix
	var/blood_prefix = quirk_mob.get_blood_prefix()

	// Check if species blood prefix was returned
	if(blood_prefix)
		// Set new card type
		card_name_type = blood_prefix

	// Define operative alias
	var/operative_alias = client_source?.prefs?.read_preference(/datum/preference/name/operative_alias)

	// Update card information
	// Try to use operative name
	if(operative_alias)
		id_vampire.registered_name = operative_alias

	// Fallback to default name
	else
		id_vampire.registered_name = quirk_mob.real_name

	// Attempt to set chronological age
	if(quirk_mob.chrono_age)
		id_vampire.registered_age = quirk_mob.chrono_age

	// Set assignment overrides
	id_vampire.assignment = "[card_name_type]fledge"
	id_vampire.trim?.assignment = "[card_name_type]fledge"

	// Update label
	id_vampire.update_label()

	// Check for bank account
	if(!quirk_mob.account_id)
		return

	// Define bank account
	var/datum/bank_account/account = SSeconomy.bank_accounts_by_id["[quirk_mob.account_id]"]

	// Add to cards list
	account.bank_cards += src

	// Assign account
	id_vampire.registered_account = account

	// Give ID card
	give_item_to_holder(id_vampire,
		list(
			LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
			LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
			LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
			LOCATION_HANDS = ITEM_SLOT_HANDS,
		)
	)

/**
 * Special examine text for Bloodfledges
 * * Displays hunger level notices
 * * Indicates that the holder has a revive ability
*/
/datum/quirk/item_quirk/bloodfledge/proc/quirk_examine_bloodfledge(atom/examine_target, mob/living/carbon/human/examiner, list/examine_list)
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

	// Define pronouns
	var/holder_they = quirk_holder.p_They()
	var/holder_their = quirk_holder.p_Their()
	var/holder_are = quirk_holder.p_are()

	// Check if dead
	if(quirk_holder.stat >= DEAD)
		// Add potential revival text
		examine_list += span_info("[holder_their] body radiates an unnatural energy, as though [quirk_holder.p_they()] could spring to life at any moment...")

	// Define hunger texts
	var/examine_hunger_public
	var/examine_hunger_secret

	// Check hunger levels
	switch(quirk_mob.nutrition)
		// Hungry
		if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_HUNGRY)
			examine_hunger_secret = "[holder_they] [holder_are] blood starved!"
			examine_hunger_public = "[holder_they] seem[quirk_holder.p_s()] on edge from something."

		// Starving
		if(0 to NUTRITION_LEVEL_STARVING)
			examine_hunger_secret = "[holder_they] [holder_are] in dire need of blood!"
			examine_hunger_public = "[holder_they] [holder_are] radiating an aura of frenzied hunger!"

		// Invalid hunger
		else
			// Return with no message
			return

	// Check if examiner shares the quirk
	if(isbloodfledge(examiner))
		// Add detection text
		examine_list += span_info("[holder_their] hunger makes it easy to identify [quirk_holder.p_them()] as a fellow sanguine!")

		// Add hunger text
		examine_list += span_warning(examine_hunger_secret)

	// Check if public hunger text exists
	else
		// Add hunger text
		examine_list += span_warning(examine_hunger_public)

/**
 * Coffin check for Bloodfledges. Enables quirk processing if all conditions pass.
 *
 * Requires the following
 * * Organic mob biotype
 * * No HOLY anti-magic
 * * No garlic reagent
 * * No stake embedded
*/
/datum/quirk/item_quirk/bloodfledge/proc/on_enter_coffin(mob/living/carbon/target, obj/structure/closet/crate/coffin/coffin, mob/living/carbon/user)
	SIGNAL_HANDLER

	// Check for organic user
	if(!(user.mob_biotypes & MOB_ORGANIC))
		// Warn user and return
		to_chat(quirk_holder, span_warning("Your body don't respond to [coffin]'s sanguine connection! Regeneration will not be possible."))
		return

	// Check for holy anti-magic
	if(user.can_block_magic(MAGIC_RESISTANCE_HOLY))
		// Warn user and return
		to_chat(quirk_holder, span_warning("[coffin] fails to form a connection with your body amidst the strong magical interference!!"))
		return

	// Check for garlic
	if(user.has_reagent(/datum/reagent/consumable/garlic, 5))
		// Warn user and return
		to_chat(quirk_holder, span_warning("The Allium Sativum in your system interferes with your regeneration!"))
		return

	// Check for stake
	if(user.am_staked())
		// Warn user and return
		to_chat(quirk_holder, span_warning("Your body cannot regenerate while impaled with a stake!"))
		return

	// User is allowed to heal!

	// Alert user
	to_chat(quirk_holder, span_good("[coffin] begins to mend your body!"))

	// Start processing
	START_PROCESSING(SSquirks, src)

/**
 * Staked interaction for Bloodfledges
 * * Causes instant death if the target is unconscious
 * * Warns normally if the target is conscious
*/
/datum/quirk/item_quirk/bloodfledge/proc/on_staked(atom/target, forced)
	SIGNAL_HANDLER

	// Check if unconscious
	if(quirk_holder.IsSleeping() || quirk_holder.stat >= UNCONSCIOUS)
		// Warn the user
		to_chat(target, span_userdanger("You have been staked while unconscious!"))

		// Kill the user
		quirk_holder.death()

		// Log the death
		quirk_holder.investigate_log("Died as a bloodfledge from staking.", INVESTIGATE_DEATHS)

		// Do nothing else
		return

	// User is conscious
	// Warn the user of staking
	to_chat(target, span_userdanger("You have been staked! Your powers are useless while it remains in place."))
	target.balloon_alert(target, "you have been staked!")

/**
 * Blood nourishment for Bloodfledges
 * * Checks if the blood was synthesized or from an invalid mob
 * * Checks if the owner tried to drink their own blood
 * * Converts any valid blood into Notriment
*/
/datum/quirk/item_quirk/bloodfledge/proc/on_consume_blood(mob/living/target, datum/reagent/blood/handled_reagent, amount, data)
	SIGNAL_HANDLER

	// Check for data
	if(!data)
		// Log warning and return
		log_game("[quirk_holder] attempted to ingest blood that had no data!")
		return

	// Define blood DNA
	var/blood_DNA = data["blood_DNA"]

	// Debug output
	#ifdef TESTING
	to_chat(quirk_holder, span_boldwarning("INGESTED DNA IS: [blood_DNA]"))
	#endif

	// Check for valid DNA
	if(!blood_DNA)
		// Warn user
		to_chat(quirk_holder, span_warning("Something about that blood tasted terribly wrong..."))

		// Add mood penalty
		quirk_holder.add_mood_event(QMOOD_BFLED_DRANK_BLOOD_FAKE, /datum/mood_event/bloodfledge/drankblood/blood_fake)

		// End here
		return

	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Define quirk mob's DNA
	var/quirk_mob_dna = quirk_mob?.dna?.unique_enzymes

	// Debug output
	#ifdef TESTING
	to_chat(quirk_holder, span_boldwarning("YOUR DNA IS: [quirk_mob_dna]"))
	#endif

	// Check for own blood
	if(blood_DNA == quirk_mob_dna)
		// Warn user
		to_chat(quirk_holder, span_warning("You should know better than to drink your own blood..."))

		// Add mood penalty
		quirk_holder.add_mood_event(QMOOD_BFLED_DRANK_BLOOD_SELF, /datum/mood_event/bloodfledge/drankblood/blood_self)

		// End here
		return

	// Check for valid reagent
	if(ispath(handled_reagent))
		// Remove reagent
		quirk_holder.reagents.remove_reagent(handled_reagent, amount)

	// Add Notriment
	quirk_holder.reagents.add_reagent(/datum/reagent/consumable/notriment, amount)

//
// Bloodfledge actions
//

// Action: Base
/datum/action/cooldown/bloodfledge
	name = "Broken Bloodfledge Ability"
	desc = "You shouldn't be seeing this!"
	background_icon = 'modular_zubbers/icons/mob/actions/bloodsucker.dmi'
	background_icon_state = "vamp_power_off"
	button_icon = 'modular_zubbers/icons/mob/actions/bloodsucker.dmi'
	button_icon_state = "power_feed"
	buttontooltipstyle = "cult"

	/// Toggle between using blood volume or nutrition. Blood volume is used for hemophages.
	var/use_nutrition = TRUE

/datum/action/cooldown/bloodfledge/Grant()
	. = ..()

	// Check if user is a hemophage
	if(ishemophage(owner))
		// Disable nutrition mode
		use_nutrition = FALSE

/**
 * Check if Bloodfledge power is allowed to be used
 *
 * Requires the following:
 * * No HOLY anti-magic
 * * No garlic reagent
 * * No stake embedded
 * * Not just a brain
*/
/datum/action/cooldown/bloodfledge/proc/can_use(mob/living/carbon/action_owner)
	// Check for deleted owner
	if(QDELETED(owner))
		return FALSE

	// Check for holiness
	if(owner.can_block_magic(MAGIC_RESISTANCE_HOLY))
		// Warn user and return
		to_chat(owner, span_warning("A holy force prevents you from using your powers!"))
		owner.balloon_alert(owner, "holy interference!")
		return FALSE

	// Check for garlic
	if(action_owner.has_reagent(/datum/reagent/consumable/garlic, 5))
		// Warn user and return
		to_chat(owner, span_warning("The Allium Sativum in your system is stifling your powers!"))
		owner.balloon_alert(owner, "garlic interference!")
		return FALSE

	// Check for stake
	if(action_owner.am_staked())
		to_chat(owner, span_warning("Your powers are useless while you have a stake in your chest!"))
		owner.balloon_alert(owner, "staked!")
		return FALSE

	// Check if just a brain
	if(isbrain(owner))
		to_chat(owner, span_warning("You think extra hard about how you can't do this right now!"))
		owner.balloon_alert(owner, "just a brain!")
		return FALSE

	// Action can be used
	return TRUE

// Action: Bite
/datum/action/cooldown/bloodfledge/bite
	name = "Fledgling Bite"
	desc = "Sink your fangs into the person you are grabbing, and attempt to drink their blood."
	button_icon_state = "power_feed"
	cooldown_time = BLOODFLEDGE_COOLDOWN_BITE
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED | AB_CHECK_LYING | AB_CHECK_PHASED

	/// How long it takes to bite a target
	var/time_interact = BLOODFLEDGE_DRAIN_TIME

	/// Reagent holder, used to change reaction type
	var/datum/reagents/blood_bank

// Corrupted tongue variant
/datum/action/cooldown/bloodfledge/bite/corrupted_tongue
	name = "Sanguine Bite"

/datum/action/cooldown/bloodfledge/bite/Grant()
	. = ..()

	// Check if using nutrition mode
	if(use_nutrition)
		// Create reagent holder
		blood_bank = new(BLOODFLEDGE_BANK_CAPACITY)

	// Check for voracious
	if(HAS_TRAIT(owner, TRAIT_VORACIOUS))
		// Make times twice as fast
		cooldown_time *= 0.5
		time_interact*= 0.5

/datum/action/cooldown/bloodfledge/bite/Activate()
	// Check if powers are allowed
	if(!can_use(owner))
		return FALSE

	// Define action owner carbon mob
	var/mob/living/carbon/action_owner = owner

	// Check for any grabbed target
	if(!action_owner.pulling)
		// Warn the user, then return
		//to_chat(action_owner, span_warning("You need a victim first!"))
		action_owner.balloon_alert(action_owner, "need a victim!")
		return FALSE

	// Check for muzzle
	// Unimplemented here
	/*
	if(action_owner.is_muzzled())
		// Warn the user, then return
		to_chat(action_owner, span_warning("You can't bite things while muzzled!"))
		owner.balloon_alert(owner, "muzzled!")
		return FALSE
	*/

	// Check for covered mouth
	if(action_owner.is_mouth_covered())
		// Warn the user, then return
		to_chat(action_owner, span_warning("You can't bite things with your mouth covered!"))
		owner.balloon_alert(owner, "mouth covered!")
		return FALSE

	// Using nutrition mode
	if(use_nutrition)
		// Limit maximum nutrition
		if(action_owner.nutrition >= NUTRITION_LEVEL_FAT)
			// Warn the user, then return
			to_chat(action_owner, span_warning("You are too full to drain any more."))
			owner.balloon_alert(owner, "too full!")
			return

		// Limit maximum potential nutrition
		if(action_owner.nutrition + BLOODFLEDGE_DRAIN_AMT >= NUTRITION_LEVEL_FAT)
			// Warn the user, then return
			to_chat(action_owner, span_warning("You would become too full by draining any more blood."))
			owner.balloon_alert(owner, "too full!")
			return

	// Using blood volume mode
	else
		// Limit maximum blood volume
		if(action_owner.blood_volume >= BLOOD_VOLUME_MAXIMUM)
			// Warn the user, then return
			to_chat(action_owner, span_warning("Your body contains too much blood to drain any more."))
			owner.balloon_alert(owner, "too full!")
			return

		// Limit maximum potential blood volume
		if(action_owner.blood_volume + BLOODFLEDGE_DRAIN_AMT >= BLOOD_VOLUME_MAXIMUM)
			// Warn the user, then return
			to_chat(action_owner, span_warning("You body would become overwhelmed by draining any more blood."))
			owner.balloon_alert(owner, "too full!")
			return

	// Define pulled target
	var/pull_target = action_owner.pulling

	// Define bite target
	var/mob/living/carbon/human/bite_target

	/// Does action owner dumb has the dumb trait? Changes the result of some failure interactions.
	var/action_owner_dumb = HAS_TRAIT(action_owner, TRAIT_DUMB)

	// Face the target
	action_owner.face_atom(pull_target)

	// Check if the target is carbon
	if(iscarbon(pull_target))
		// Set the bite target
		bite_target = pull_target

	// Or cocooned carbon
	else if(istype(pull_target,/obj/structure/spider/cocoon))
		// Define if cocoon has a valid target
		// This cannot use pull_target
		var/possible_cocoon_target = locate(/mob/living/carbon/human) in action_owner.pulling.contents

		// Check defined cocoon target
		if(possible_cocoon_target)
			// Set the bite target
			bite_target = possible_cocoon_target

	// Or a blood tomato
	else if(istype(pull_target,/obj/item/food/grown/tomato/blood))
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
	if(!bite_target.can_inject(action_owner, target_zone))
		// Warn the user, then return
		to_chat(action_owner, span_warning("There\'s no exposed flesh or thin material in that region of [bite_target]'s body. You're unable to bite them!"))
		return

	// Check targeted body part
	var/obj/item/bodypart/bite_bodypart = bite_target.get_bodypart(target_zone)

	// Define zone name
	var/target_zone_name = "flesh"

	/// Does the target zone have unique interactions?
	var/target_zone_effects = FALSE

	/**
	* If targeted zone should be checked
	* * Uses dismember check to determine if it can be missing.
	* * Missing limbs are assumed to be dismembered.
	*/
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
			if(!bite_target.has_eyes() == REQUIRE_GENITAL_EXPOSED)
				// Warn user and return
				to_chat(action_owner, span_warning("You can't find [bite_target]'s eyes to bite them!"))
				owner.balloon_alert(owner, "no eyes?")
				return

			// Set region data normally
			target_zone_name = "eyes"
			target_zone_check = FALSE
			target_zone_effects = TRUE

		if(BODY_ZONE_PRECISE_MOUTH)
			// Check if mouth is covered
			if(bite_target.is_mouth_covered())
				to_chat(action_owner, span_warning("You can't reach [bite_target]'s lips to bite them!"))
				owner.balloon_alert(owner, "no lips?")
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
			owner.balloon_alert(owner, "no [target_zone_name]?")
			return

		// Check if bodypart is organic
		if(!IS_ORGANIC_LIMB(bite_bodypart))
			// Display local message
			action_owner.visible_message(span_danger("[action_owner] tries to bite [bite_target]'s [target_zone_name], but is unable to penetrate the mechanical prosthetic!"), span_warning("You attempt to bite [bite_target]'s [target_zone_name], but can't penetrate the mechanical prosthetic!"), ignored_mobs=bite_target)

			// Warn user
			to_chat(bite_target, span_warning("[action_owner] tries to bite your [target_zone_name], but is unable to penetrate the mechanical prosthetic!"))

			// Play metal hit sound
			playsound(bite_target, "sound/effects/clang.ogg", 30, 1, -2)

			// Start cooldown early to prevent spam
			StartCooldown()

			// Return without further effects
			return

	// Check for anti-magic
	if(bite_target.can_block_magic(MAGIC_RESISTANCE_HOLY))
		// Check for a dumb user
		if(action_owner_dumb)
			// Display local message
			action_owner.visible_message(span_danger("[action_owner] tries to bite [bite_target]'s [target_zone_name], but bursts into flames just as [action_owner.p_they()] come[action_owner.p_s()] into contact with [bite_target.p_them()]!"), span_userdanger("Surges of pain course through your body as you attempt to bite [bite_target]! What were you thinking?"), ignored_mobs=bite_target)

			// Warn target
			to_chat(bite_target, span_warning("[action_owner] tries to bite you, but bursts into flames just as [action_owner.p_they()] come[action_owner.p_s()] into contact with you!"))

			// Stop grabbing
			action_owner.stop_pulling()

			// Ignite action owner
			action_owner.adjust_fire_stacks(2)
			action_owner.ignite_mob()

			// Return with no further effects
			return

		// Warn the user and target, then return
		to_chat(bite_target, span_warning("[action_owner] tries to bite your [target_zone_name], but stops before touching you!"))
		to_chat(action_owner, span_warning("[bite_target] is blessed! You stop just in time to avoid catching fire."))
		return

	// Check for garlic in the bloodstream
	if(bite_target.has_reagent(/datum/reagent/consumable/garlic, 5))
		// Check for a dumb user
		if(action_owner_dumb)
			// Display local message
			action_owner.visible_message(span_danger("[action_owner] tries to bite [bite_target]'s [target_zone_name], but immediately recoils in disgust upon touching [bite_target.p_them()]!"), span_userdanger("An intense wave of disgust washes over your body as you attempt to bite [bite_target]! What were you thinking?"), ignored_mobs=bite_target)

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
	if(target_blood_volume < BLOODFLEDGE_DRAIN_AMT)
		// Warn the user, then return
		to_chat(action_owner, span_warning("There's not enough blood in [bite_target]!"))
		return

	// Check if total blood would become too low
	if((target_blood_volume - BLOODFLEDGE_DRAIN_AMT) <= BLOOD_VOLUME_OKAY)
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
		action_owner.visible_message(span_danger("[action_owner] tries to bite down on [bite_target]'s [target_zone_name], but can't seem to pierce [bite_target.p_them()]!"), span_danger("You try to bite down on [bite_target]'s [target_zone_name], but are completely unable to pierce [bite_target.p_them()]!"), ignored_mobs=bite_target)

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
			if(findtext(bite_target.dna?.features["snout"], "Synthetic Lizard"))
				// Display local chat message
				action_owner.visible_message(span_notice("[action_owner]'s fangs clank harmlessly against [bite_target]'s face-screen!"), span_notice("Your fangs clank harmlessly against [bite_target]'s face-screen!"), ignored_mobs=bite_target)

				// Alert bite target
				to_chat(bite_target, span_notice("[action_owner]'s fangs clank harmlessly against your face-screen"))

				// Play glass tap sound
				playsound(bite_target, 'sound/effects/glass/glasshit.ogg', 50, 1, -2)

				// Start cooldown early to prevent spam
				StartCooldown()

				// Return without further effects
				return

		// Check for strange bite regions
		switch(target_zone)
			// Zone is eyes
			if(BODY_ZONE_PRECISE_EYES)
				// Define target's eyes
				var/obj/item/organ/internal/eyes/target_eyes = bite_target.get_organ_slot(ORGAN_SLOT_EYES)

				// Check if eyes exist
				// This should always be the case since eyes exposed was checked above
				if(!target_eyes)
					// Warn user and return
					to_chat(bite_target, span_userdanger("Something has gone terribly wrong with [bite_target]'s eyes! Please report this to a coder!"))
					return

				// Check for cybernetic eyes
				if(IS_ROBOTIC_ORGAN(target_eyes))
					// Warn users and return
					to_chat(action_owner, span_danger("Your fangs aren't powerful enough to penetrate robotic eyes!"))
					to_chat(bite_target, span_danger("[action_owner] tries to bite into your [target_eyes], but can't break through!"))
					return

				// Display warning
				to_chat(bite_target, span_userdanger("Your [target_eyes] rupture in pain as [action_owner]'s fangs pierce their surface!"))

				// Blur vision equal to drunkenness
				bite_target.adjust_eye_blur_up_to(4 SECONDS, 20 SECONDS)

				// Add organ damage
				target_eyes.apply_organ_damage(rand(10, 20))

			// Zone is mouth
			if(BODY_ZONE_PRECISE_MOUTH)
				// Cause temporary stuttering
				bite_target.set_stutter_if_lower(10 SECONDS)

	// Display local chat message
	action_owner.visible_message(span_danger("[action_owner] bites down on [bite_target]'s [target_zone_name]!"), span_danger("You bite down on [bite_target]'s [target_zone_name]!"), ignored_mobs=bite_target)

	// Play a bite sound effect
	playsound(action_owner, 'sound/items/weapons/bite.ogg', 30, 1, -2)

	// Warn bite target
	to_chat(bite_target, span_userdanger("[action_owner] has bitten your [target_zone_name], and is trying to drain your blood!"))

	// Try to perform action timer
	if(!do_after(action_owner, time_interact, target = bite_target))
		// When failing
		// Display a local chat message
		action_owner.visible_message(span_danger("[action_owner]'s fangs are prematurely torn from [bite_target]'s [target_zone_name], spilling some of [bite_target.p_their()] blood!"), span_danger("Your fangs are prematurely torn from [bite_target]'s [target_zone_name], spilling some of [bite_target.p_their()] blood!"), ignored_mobs=bite_target)

		// Warn bite target
		to_chat(bite_target, span_userdanger("[action_owner]\'s fangs are prematurely torn from your [target_zone_name], spilling some of your blood!"))

		// Bite target "drops" 20% of the blood
		// This creates large blood splatter
		bite_target.bleed((BLOODFLEDGE_DRAIN_AMT*0.2), FALSE)

		// Play splatter sound
		playsound(get_turf(target), 'sound/effects/splat.ogg', 40, 1)

		// Check for masochism
		if(!HAS_TRAIT(bite_target, TRAIT_MASOCHISM))
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
			bite_bodypart.adjustBleedStacks(2)

			// Apply minor damage
			bite_bodypart.receive_damage(brute = rand(4,8), sharpness = SHARP_POINTY)

		// Start cooldown early
		// This is to prevent bite interrupt spam
		StartCooldown()

		// Return
		return
	else
		/// Is this valid nourishing blood? Does not grant nutrition if FALSE.
		var/blood_valid = TRUE

		/// Should blood be transferred anyway? Used when blood_valid is FALSE.
		var/blood_transfer = FALSE

		/// Name of exotic blood substitute determined by species
		var/blood_name = "blood"

		// Check if target has exotic bloodtype
		if(bite_target.dna?.species?.exotic_bloodtype)
			// Define blood types for owner and target
			var/blood_type_owner = action_owner.dna?.species?.exotic_bloodtype
			var/blood_type_target = bite_target.dna?.species?.exotic_bloodtype

			/// Define if owner and target blood types match. Used for providing a mood bonus and immunity to exotic blood mood penalties.
			var/blood_type_match = (blood_type_owner == blood_type_target ? TRUE : FALSE)

			// Check if types matched
			if(blood_type_match)
				// Add positive mood
				action_owner.add_mood_event(QMOOD_BFLED_DRANK_MATCH, /datum/mood_event/bloodfledge/drankblood/exotic_matched)

			// Switch for target's blood type
			switch(blood_type_target)
				// Lizard blood
				if("L")
					// Set blood type name
					blood_name = "reptilian blood"

					// No penalty

				// Bug blood
				// Not used here
				/*
				if("BUG")
					// Set blood type name
					blood_name = "hemolymph"

					// Check if blood types match
					if(!blood_type_match)
						// Mark blood as invalid
						blood_valid = FALSE

						// Cause negative mood
						action_owner.add_mood_event(QMOOD_BFLED_DRANK_BUG, /datum/mood_event/bloodfledge/drankblood/insect)
				*/

				// Vampire blood
				if("U")
					// Set blood type name
					blood_name = "sanguine blood"

					// EDIT: Allowed again
					/*
					// Don't drink from vampires!
					// Mark blood as invalid
					blood_valid = FALSE

					// Cause negative mood
					action_owner.add_mood_event(QMOOD_BFLED_DRANK_VAMP, /datum/mood_event/bloodfledge/drankblood/vampire)
					*/

				// Ethreal blood
				if("LE")
					// Set blood type name
					blood_name = "liquid electricity"

					// Mark blood as invalid
					blood_valid = FALSE

					// Allow transferring blood from this
					blood_transfer = TRUE

					// Cause neutral mood
					action_owner.add_mood_event(QMOOD_BFLED_DRANK_ETHER, /datum/mood_event/bloodfledge/drankblood/ethereal)

				// Edge case
				else
					// Set blood type name
					blood_name = "unknown exotic bloodtype"

					// Mark blood as invalid
					blood_valid = FALSE

		// Check if target has exotic blood reagent
		// Second check for the separate exotic_blood variable
		else if(bite_target.dna?.species?.exotic_blood)
			// Define blood types for owner and target
			var/blood_type_owner = action_owner.dna?.species?.exotic_blood
			var/blood_type_target = bite_target.dna?.species?.exotic_blood

			/// Define if owner and target blood types match. Used for providing a mood bonus and immunity to exotic blood mood penalties.
			var/blood_type_match = (blood_type_owner == blood_type_target ? TRUE : FALSE)

			// Check if types matched
			if(blood_type_match)
				// Add positive mood
				action_owner.add_mood_event(QMOOD_BFLED_DRANK_MATCH, /datum/mood_event/bloodfledge/drankblood/exotic_matched)

			// Check for target's blood type
			switch(blood_type_target)
				// Synthetic blood
				if(/datum/reagent/fuel/oil)
					// Mark blood as invalid
					blood_valid = FALSE

					// Set blood type name
					blood_name = "oil"

					// Cause negative mood
					action_owner.add_mood_event(QMOOD_BFLED_DRANK_SYNTH, /datum/mood_event/bloodfledge/drankblood/synth)

				// Slime blood
				if(/datum/reagent/toxin/slimejelly)
					// Mark blood as invalid
					blood_valid = FALSE

					// Allow transferring blood from this
					blood_transfer = TRUE

					// Set blood type name
					blood_name = "slime jelly"

					// Check if blood types match
					if(!blood_type_match)
						// Cause negative mood
						action_owner.add_mood_event(QMOOD_BFLED_DRANK_SLIME, /datum/mood_event/bloodfledge/drankblood/slime)

				// Podperson blood
				if(/datum/reagent/water)
					// Set blood type name
					blood_name = "water"

					// Mark blood as invalid
					blood_valid = FALSE

					// Cause neutral mood
					action_owner.add_mood_event(QMOOD_BFLED_DRANK_POD, /datum/mood_event/bloodfledge/drankblood/podperson)

				// Snail blood
				if(/datum/reagent/lube)
					// Set blood type name
					blood_name = "space lube"

					// Mark blood as invalid
					blood_valid = FALSE

					// Check if blood types match
					if(!blood_type_match)
						// Cause negative mood
						action_owner.add_mood_event(QMOOD_BFLED_DRANK_SNAIL, /datum/mood_event/bloodfledge/drankblood/snail)

				// Skrell blood
				if(/datum/reagent/copper)
					// Set blood type name
					blood_name = "copper"

					// Mark blood as invalid
					blood_valid = FALSE

					// Check if blood types match
					if(!blood_type_match)
						// Cause negative mood
						action_owner.add_mood_event(QMOOD_BFLED_DRANK_SKREL, /datum/mood_event/bloodfledge/drankblood/skrell)

				// Xenomorph Hybrid blood
				if(/datum/reagent/toxin/acid)
					// Set blood type name
					blood_name = "sulfuric acid"

					// Mark blood as invalid
					blood_valid = FALSE

					// Allow transferring blood from this
					blood_transfer = TRUE

					// Check if blood types match
					if(!blood_type_match)
						// Cause negative mood
						action_owner.add_mood_event(QMOOD_BFLED_DRANK_XENO, /datum/mood_event/bloodfledge/drankblood/xeno)

				// Edge case
				else
					// Set blood type name
					blood_name = "unknown exotic blood"

					// Mark blood as invalid
					blood_valid = FALSE

		// Check if bite target has any blood
		// Checked later since some species have NOBLOOD and exotic blood type
		else if(HAS_TRAIT(bite_target, TRAIT_NOBLOOD))
			// Warn the user and target
			to_chat(bite_target, span_warning("[action_owner] bit your [target_zone_name] in an attempt to drain your blood, but couldn't find any!"))
			to_chat(action_owner, span_warning("[bite_target] doesn't have any blood to drink!"))

			// Start cooldown early to prevent sound spam
			StartCooldown()

			// Return without effects
			return

		// End of exotic blood checks

		// Define user's remaining capacity to absorb blood
		var/blood_volume_difference = BLOOD_VOLUME_MAXIMUM - action_owner.blood_volume
		var/drained_blood = min(target_blood_volume, BLOODFLEDGE_DRAIN_AMT, blood_volume_difference)

		// Transfer reagents from target to action owner
		// Limited to a maximum 10% of bite amount (default 10u)
		bite_target.reagents.trans_to(action_owner, (drained_blood*0.1))

		// Alert the bite target and local user of success
		// Yes, this is AFTER the message for non-valid blood
		to_chat(bite_target, span_danger("[action_owner] has taken some of your [blood_name]!"))
		to_chat(action_owner, span_notice("You've drained some of [bite_target]'s [blood_name]!"))

		// Check if action owner received valid blood
		if(blood_valid)
			// Using nutrition mode
			if(use_nutrition)
				// Add blood reagent to reagent holder
				blood_bank.add_reagent(/datum/reagent/blood/, drained_blood, bite_target.get_blood_data())

				// Transfer reagent to action owner
				blood_bank.trans_to(action_owner, drained_blood, methods = INGEST)

				// Remove all reagents
				blood_bank.remove_all()

			// Using blood volume mode
			else
				// Transfer blood directly
				bite_target.transfer_blood_to(action_owner, drained_blood, TRUE)

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
			to_chat(action_owner, span_warning("Your body cannot process the [blood_name]!"))

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
			action_owner.adjust_disgust(10)

			// Cause negative mood
			action_owner.add_mood_event(QMOOD_BFLED_DRANK_DEAD, /datum/mood_event/bloodfledge/drankblood/dead)

		// Check if bite target's blood has been depleted
		if(!bite_target.blood_volume)
			// Warn the user
			to_chat(action_owner, span_warning("You've depleted [bite_target]'s [blood_name] supply!"))

			// Cause negative mood
			action_owner.add_mood_event(QMOOD_BFLED_DRANK_KILL, /datum/mood_event/bloodfledge/drankblood/killed)

		// Check if bite target has cursed blood
		if(HAS_TRAIT(bite_target, TRAIT_CURSED_BLOOD))
			/// Does action owner have the cursed blood quirk?
			var/owner_cursed = HAS_TRAIT(action_owner, TRAIT_CURSED_BLOOD)

			// Set chat message based on action owner's trait status
			var/warn_message = (owner_cursed ? "You taste the unholy touch of a familiar curse in [bite_target]\'s blood." : "You experience a sensation of intense dread just after drinking from [bite_target]. Something about their blood feels... wrong.")

			// Alert user in chat
			to_chat(action_owner, span_notice(warn_message))

			// Set mood type based on curse status
			var/mood_type = (owner_cursed ? /datum/mood_event/bloodfledge/drankblood/cursed_good : /datum/mood_event/bloodfledge/drankblood/cursed_bad)

			// Cause mood event
			action_owner.add_mood_event(QMOOD_BFLED_DRANK_CURSE, mood_type)

		// Start cooldown
		StartCooldown()

// Action: Revive
/datum/action/cooldown/bloodfledge/revive
	name = "Fledgling Revive"
	desc = "Expend all of your remaining energy to escape death."
	button_icon_state = "power_strength"
	cooldown_time = BLOODFLEDGE_COOLDOWN_REVIVE

/datum/action/cooldown/bloodfledge/revive/Activate()
	// Check if powers are allowed
	if(!can_use(owner))
		return FALSE

	// Early check for being dead
	// Users are most likely to click this while alive
	if(owner.stat != DEAD)
		// Warn user and return
		//to_chat(action_owner, "You can't use this ability while alive!")
		owner.balloon_alert(owner, "not dead!")
		return

	/// Define failure messages. Will not revive if any failure message is set.
	var/revive_failed

	// Disabled check
	/*
	// Condition: Mob isn't in a closed coffin
	if(!istype(owner.loc, /obj/structure/closet/crate/coffin))
		revive_failed += "\n- You need to be in a closed coffin!"
	*/

	// Define mob
	var/mob/living/carbon/human/action_owner = owner

	// Condition: Insufficient nutrition
	if(use_nutrition)
		if(action_owner.nutrition <= NUTRITION_LEVEL_STARVING)
			revive_failed += "\n- You're too blood-starved!"

	// Condition: Insufficient blood volume
	else
		if(action_owner.blood_volume > BLOOD_VOLUME_SURVIVE)
			revive_failed += "\n- You don't have enough blood volume left!"

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

	// Condition: Suicide
	if(HAS_TRAIT(action_owner, TRAIT_SUICIDED))
		revive_failed += "\n- You chose this path."

	// Condition: Do Not Revive quirk
	if(HAS_TRAIT(action_owner, TRAIT_DNR))
		revive_failed += "\n- You only had one chance."

	// Unimplemented here
	/*
	// Condition: No revivals
	if(HAS_TRAIT(action_owner, TRAIT_NOCLONE))
		revive_failed += "\n- You only had one chance."

	// Condition: Demonic contract
	if(action_owner.hellbound)
		revive_failed += "\n- The soul pact must be honored."
	*/

	// Check for failure
	if(revive_failed)
		// Set combined message
		revive_failed = span_warning("You can't revive right now because: [revive_failed]")

		// Alert user in chat of failure
		to_chat(action_owner, revive_failed)

		// Return
		return

	// Remove oxygen damage
	action_owner.adjustOxyLoss(-100, FALSE)

	// Heal and revive the action owner
	action_owner.heal_and_revive()

	// Check if health is too low to use revive()
	// Obsolete as of heal_and_revive
	/*
	if(action_owner.health <= HEALTH_THRESHOLD_DEAD)
		// Set health high enough to revive
		// Based on defib.dm

		// Define damage values
		var/damage_brute = action_owner.getBruteLoss()
		var/damage_burn = action_owner.getFireLoss()
		var/damage_tox = action_owner.getToxLoss()
		var/damage_oxy = action_owner.getOxyLoss()
		var/damage_brain = action_owner.get_organ_loss(ORGAN_SLOT_BRAIN)

		// Define total damage
		var/damage_total = damage_brute + damage_burn + damage_tox + damage_oxy + damage_brain

		// Define to prevent redundant math
		// Equal to HALFWAYCRITDEATH in defib.dm
		var/health_half_crit = action_owner.health - ((HEALTH_THRESHOLD_CRIT + HEALTH_THRESHOLD_DEAD) * 0.5)

		// Adjust damage types
		action_owner.adjustOxyLoss(health_half_crit * (damage_oxy / damage_total), updating_health = FALSE)
		action_owner.adjustToxLoss(health_half_crit * (damage_tox / damage_total), updating_health = FALSE)
		action_owner.adjustFireLoss(health_half_crit * (damage_burn / damage_total), updating_health = FALSE)
		action_owner.adjustBruteLoss(health_half_crit * (damage_brute / damage_total), updating_health = FALSE)
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
	*/

	// Revive the action owner
	//action_owner.revive()

	// Alert the user in chat of success
	action_owner.visible_message(span_notice("An ominous energy radiates from the [action_owner.loc]..."), span_warning("You've expended all remaining blood to bring your body back to life!"))

	// Warn user about revive policy
	to_chat(action_owner, span_userdanger("[CONFIG_GET(string/blackoutpolicy)]"))

	// Log the revival
	action_owner.log_message("revived using a bloodfledge quirk ability.", LOG_GAME)

	// Play a haunted sound effect
	playsound(action_owner, 'sound/effects/hallucinations/growl1.ogg', 30, 1, -2)

	// Nutrition mode
	if(use_nutrition)
		// Set nutrition to starving
		action_owner.set_nutrition(NUTRITION_LEVEL_STARVING)

	// Blood volume mode
	else
		// Set dangerously low blood
		action_owner.blood_volume = min(action_owner.blood_volume, BLOOD_VOLUME_SURVIVE)

	// Apply dizzy effect
	action_owner.adjust_dizzy_up_to(20 SECONDS, 60 SECONDS)

	// Start cooldown
	StartCooldown()

//
// Bloodfledge mood events
//

// Base event for drinking blood
/datum/mood_event/bloodfledge/drankblood
	mood_change = -4
	timeout = 5 MINUTES

// Matching exotic blood
/datum/mood_event/bloodfledge/drankblood/exotic_matched
	description = "I tasted familiarity from the blood I drank."
	mood_change = 2

// Insect blood - Currently unused
/datum/mood_event/bloodfledge/drankblood/insect
	description = "I drank an insect's hemolymph."

// Vampire and Hemophage blood
/datum/mood_event/bloodfledge/drankblood/vampire
	description = "I drank the forbidden blood of a true sanguine."

// Ethreal blood
/datum/mood_event/bloodfledge/drankblood/ethereal
	description = "I drank the liquid electricity of an ethereal."

// Synthetic blood
/datum/mood_event/bloodfledge/drankblood/synth
	description = "I tried to drink oil from a synth..."

// Slime blood
/datum/mood_event/bloodfledge/drankblood/slime
	description = "I drank the toxic jelly of a slime."
	mood_change = -6

// Podperson blood
/datum/mood_event/bloodfledge/drankblood/podperson
	description = "I drank... water?"
	mood_change = 0

// Snail blood
/datum/mood_event/bloodfledge/drankblood/snail
	description = "I tried to drink space lube..."

// Skrell blood
/datum/mood_event/bloodfledge/drankblood/skrell
	description = "I tried to drink liquid copper."

// Xenomorph Hybrid blood
/datum/mood_event/bloodfledge/drankblood/xeno
	description = "I drank sulfuric acid from a xeno."
	mood_change = -6

// Dead creature
/datum/mood_event/bloodfledge/drankblood/dead
	description = "I drank dead blood. I am better than this."
	mood_change = -8
	timeout = 10 MINUTES

// Killed from feeding
/datum/mood_event/bloodfledge/drankblood/killed
	description = "I drank from my victim until they died. I feel...lesser."
	mood_change = -12
	timeout = 25 MINUTES

// Cursed blood matched
/datum/mood_event/bloodfledge/drankblood/cursed_good
	description = "I've tasted sympathy from a fellow curse bearer."
	mood_change = 1

// Cursed blood non-matched
/datum/mood_event/bloodfledge/drankblood/cursed_bad
	description = "I can feel a pale curse from the blood I drank."
	mood_change = -1

// Drinking own blood
/datum/mood_event/bloodfledge/drankblood/blood_self
	description = "I drink my own blood. Why would I do that?"

// Drinking fake blood (no DNA)
/datum/mood_event/bloodfledge/drankblood/blood_fake
	description = "I drink artifical blood. I should know better."

#undef BLOODFLEDGE_DRAIN_AMT
#undef BLOODFLEDGE_DRAIN_TIME
#undef BLOODFLEDGE_COOLDOWN_BITE
#undef BLOODFLEDGE_COOLDOWN_REVIVE
#undef BLOODFLEDGE_BANK_CAPACITY
#undef BLOODFLEDGE_HEAL_AMT
