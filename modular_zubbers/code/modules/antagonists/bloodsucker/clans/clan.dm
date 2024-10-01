/**
 * Bloodsucker clans
 *
 * Handles everything related to clans.
 * the entire idea of datumizing this came to me in a dream.
 */
/datum/bloodsucker_clan
	///The bloodsucker datum that owns this clan. Use this over 'source', because while it's the same thing, this is more consistent (and used for deletion).
	var/datum/antagonist/bloodsucker/bloodsuckerdatum
	///The name of the clan we're in.
	var/name = CLAN_NONE
	///Description of what the clan is, given when joining and through your antag UI.
	var/description = "The Caitiff is as basic as you can get with Bloodsuckers. \n\
		Entirely without the help of a formal Clan, they are blissfully unaware of who they really are. \n\
		No additional abilities is gained, nothing is lost, if you want a plain Bloodsucker, this is it. \n\
		The Favorite Vassal will gain the Brawn ability, to help in combat."
	///The clan objective that is required to greentext.
	var/datum/objective/bloodsucker/clan_objective
	///The icon of the radial icon to join this clan.
	var/join_icon = 'modular_zubbers/icons/effects/radials/clan_icons.dmi'
	///Same as join_icon, but the state
	var/join_icon_state = "caitiff"
	///Description shown when trying to join the clan.
	var/join_description = "The default, Classic Bloodsucker."
	///Whether the clan can be joined by players. FALSE for flavortext-only clans.
	var/joinable_clan = TRUE

	///How we will drink blood using Feed.
	var/blood_drink_type = BLOODSUCKER_DRINK_NORMAL
	/// How much stamina armor we get in frenzy
	var/frenzy_stamina_mod = 0.4
	var/buy_power_flags = BLOODSUCKER_CAN_BUY
	// what percentage of blood you need to spend to level up, divided by 100
	var/level_cost = BLOODSUCKER_LEVELUP_PERCENTAGE

/datum/bloodsucker_clan/New(datum/antagonist/bloodsucker/owner_datum)
	. = ..()
	src.bloodsuckerdatum = owner_datum

	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_ON_LIFETICK, PROC_REF(handle_clan_life))
	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_RANK_UP, PROC_REF(on_spend_rank))

	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_INTERACT_WITH_VASSAL, PROC_REF(on_interact_with_vassal))
	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_MAKE_FAVORITE, PROC_REF(favorite_vassal_gain))
	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_LOOSE_FAVORITE, PROC_REF(favorite_vassal_loss))

	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_MADE_VASSAL, PROC_REF(on_vassal_made))
	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_EXIT_TORPOR, PROC_REF(on_exit_torpor))
	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_FINAL_DEATH, PROC_REF(on_final_death))

	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_ENTERS_FRENZY, PROC_REF(on_enter_frenzy))
	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_EXITS_FRENZY, PROC_REF(on_exit_frenzy))

	give_clan_objective()

/datum/bloodsucker_clan/Destroy(force)
	UnregisterSignal(bloodsuckerdatum, list(
		COMSIG_BLOODSUCKER_ON_LIFETICK,
		COMSIG_BLOODSUCKER_RANK_UP,
		COMSIG_BLOODSUCKER_INTERACT_WITH_VASSAL,
		COMSIG_BLOODSUCKER_MAKE_FAVORITE,
		COMSIG_BLOODSUCKER_MADE_VASSAL,
		COMSIG_BLOODSUCKER_EXIT_TORPOR,
		COMSIG_BLOODSUCKER_FINAL_DEATH,
		COMSIG_BLOODSUCKER_ENTERS_FRENZY,
		COMSIG_BLOODSUCKER_EXITS_FRENZY,
	))
	remove_clan_objective()
	bloodsuckerdatum = null
	return ..()

/datum/bloodsucker_clan/proc/on_enter_frenzy(datum/antagonist/bloodsucker/source)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/human_bloodsucker = bloodsuckerdatum.owner.current
	if(!istype(human_bloodsucker))
		return
	human_bloodsucker.physiology.stamina_mod *= frenzy_stamina_mod

/datum/bloodsucker_clan/proc/on_exit_frenzy(datum/antagonist/bloodsucker/source)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/human_bloodsucker = bloodsuckerdatum.owner.current
	if(!istype(human_bloodsucker))
		return
	human_bloodsucker.set_timed_status_effect(3 SECONDS, /datum/status_effect/dizziness, only_if_higher = TRUE)
	human_bloodsucker.Paralyze(2 SECONDS)
	human_bloodsucker.physiology.stamina_mod /= frenzy_stamina_mod

/datum/bloodsucker_clan/proc/give_clan_objective()
	if(isnull(clan_objective))
		return
	clan_objective = new clan_objective()
	clan_objective.objective_name = "Clan Objective"
	clan_objective.owner = bloodsuckerdatum.owner
	bloodsuckerdatum.objectives += clan_objective
	bloodsuckerdatum.owner.announce_objectives()

/datum/bloodsucker_clan/proc/remove_clan_objective()
	bloodsuckerdatum.objectives -= clan_objective
	QDEL_NULL(clan_objective)
	bloodsuckerdatum.owner.announce_objectives()

/**
 * Called when a Bloodsucker exits Torpor
 * args:
 * source - the Bloodsucker exiting Torpor
 */
/datum/bloodsucker_clan/proc/on_exit_torpor(datum/antagonist/bloodsucker/source)
	SIGNAL_HANDLER

/**
 * Called when a Bloodsucker enters Final Death
 * args:
 * source - the Bloodsucker exiting Torpor
 */
/datum/bloodsucker_clan/proc/on_final_death(datum/antagonist/bloodsucker/source)
	SIGNAL_HANDLER
	return FALSE

/**
 * Called during Bloodsucker's LifeTick
 * args:
 * bloodsuckerdatum - the antagonist datum of the Bloodsucker running this.
 */
/datum/bloodsucker_clan/proc/handle_clan_life(datum/antagonist/bloodsucker/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER

/**
 * Called when a Bloodsucker successfully Vassalizes someone.
 * args:
 * bloodsuckerdatum - the antagonist datum of the Bloodsucker running this.
 */
/datum/bloodsucker_clan/proc/on_vassal_made(datum/antagonist/bloodsucker/source, mob/living/user, mob/living/target)
	SIGNAL_HANDLER
	user.playsound_local(null, 'sound/effects/explosion_distant.ogg', 40, TRUE)
	target.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, TRUE)
	target.set_timed_status_effect(15 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
	INVOKE_ASYNC(target, TYPE_PROC_REF(/mob, emote), "laugh")

/**
 * Called when a Bloodsucker successfully starts spending their Rank
 * args:
 * bloodsuckerdatum - the antagonist datum of the Bloodsucker running this.
 * cost_rank - TRUE/FALSE on whether this will cost us a rank when we go through with it.
 * blood_cost - A number saying how much it costs to rank up.
 */
/datum/bloodsucker_clan/proc/on_spend_rank(datum/antagonist/bloodsucker/source, mob/living/carbon/human/target, cost_rank = TRUE, blood_cost, force)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(spend_rank), bloodsuckerdatum, cost_rank, blood_cost)

/datum/bloodsucker_clan/proc/spend_rank(datum/antagonist/bloodsucker/source, cost_rank = TRUE, blood_cost, requires_coffin = TRUE)
	var/list/options = list_available_powers()
	if(length(options))
		var/datum/action/cooldown/bloodsucker/choice = choose_powers(
			"You have the opportunity to grow more ancient. [blood_cost > 0 ? " Spend [round(blood_cost, 1)] blood to advance your rank" : ""]",
			"Your Blood Thickens...",
			options
		)
		if(!is_valid_choice(choice, cost_rank, blood_cost, requires_coffin))
			return FALSE
		// Good to go - Buy Power!
		purchase_choice(source, choice)
		level_message(initial(choice.name))

	return finalize_spend_rank(bloodsuckerdatum, cost_rank, blood_cost)

/datum/bloodsucker_clan/proc/level_message(power_name)
	var/mob/living/carbon/human/human_user = bloodsuckerdatum.owner.current
	human_user.balloon_alert(human_user, "learned [power_name]!")
	to_chat(human_user, span_notice("You have learned how to use [power_name]!"))

/datum/bloodsucker_clan/proc/choose_powers(message, title, options = list())
	var/mob/living/carbon/human/human_user = bloodsuckerdatum.owner.current
	if(!length(options))
		return FALSE

	var/choice = tgui_input_list(human_user, message, title, options)
	return options[choice]

/datum/bloodsucker_clan/proc/is_valid_choice(datum/action/cooldown/bloodsucker/power, cost_rank, blood_cost, requires_coffin)
	var/mob/living/carbon/human/human_user = bloodsuckerdatum.owner.current
	if(!power)
		return FALSE
	if(cost_rank && bloodsuckerdatum.GetUnspentRank() <= 0)
		return FALSE
	if(blood_cost && bloodsuckerdatum.GetBloodVolume() < blood_cost)
		human_user.balloon_alert(human_user, "not enough blood!")
		to_chat(human_user, span_notice("You need at the very least [blood_cost] blood to thicken your blood."))
		return FALSE
	// Prevent Bloodsuckers from purchasing a power while outside of their Coffin.
	if(requires_coffin && !istype(human_user.loc, /obj/structure/closet/crate/coffin))
		to_chat(human_user, span_warning("You must be in your Coffin to purchase Powers."))
		return FALSE
	if(!(initial(power.purchase_flags) & buy_power_flags))
		to_chat(human_user, span_notice("[initial(power.name)] is not available for purchase."))
		return FALSE
	if(!(buy_power_flags & CAN_BUY_OWNED) && locate(power) in bloodsuckerdatum.powers)
		to_chat(human_user, span_notice("You already know [initial(power.name)]!"))
		return FALSE
	return TRUE

/datum/bloodsucker_clan/proc/finalize_spend_rank(datum/antagonist/bloodsucker/source, cost_rank = TRUE, blood_cost)
	level_up_powers(source)
	bloodsuckerdatum.bloodsucker_regen_rate += 0.05
	bloodsuckerdatum.max_blood_volume += 100

	if(ishuman(bloodsuckerdatum.owner.current))
		var/mob/living/carbon/human/human_user = bloodsuckerdatum.owner.current
		var/obj/item/bodypart/user_left_hand = human_user.get_bodypart(BODY_ZONE_L_ARM)
		var/obj/item/bodypart/user_right_hand = human_user.get_bodypart(BODY_ZONE_R_ARM)
		user_left_hand.unarmed_damage_low += 0.5
		user_right_hand.unarmed_damage_low += 0.5
		// This affects the hitting power of Brawn.
		user_left_hand.unarmed_damage_high += 0.5
		user_right_hand.unarmed_damage_high += 0.5

	// We're almost done - Spend your Rank now.
	bloodsuckerdatum.AdjustRank(1)
	if(cost_rank)
		bloodsuckerdatum.AdjustUnspentRank(-1)

	if(blood_cost)
		bloodsuckerdatum.AdjustBloodVolume(-blood_cost)

	// Ranked up enough to get your true Reputation?
	if(bloodsuckerdatum.GetRank() == BLOODSUCKER_HIGH_LEVEL)
		bloodsuckerdatum.SelectReputation(am_fledgling = FALSE, forced = TRUE)


	to_chat(bloodsuckerdatum.owner.current, span_notice("You are now a rank [bloodsuckerdatum.GetRank()] Bloodsucker. \
		Your strength, feed rate, regen rate, and maximum blood capacity have all increased! \n\
		* Your existing powers have all ranked up as well!"))
	bloodsuckerdatum.owner.current.playsound_local(null, 'sound/effects/pope_entry.ogg', 25, TRUE, pressure_affected = FALSE)
	bloodsuckerdatum.update_static_data_for_all_viewers()

	// unlock vassalizing if we have a vassal slot
	if(bloodsuckerdatum.max_vassals() >= 1 && !(/datum/crafting_recipe/vassalrack in bloodsuckerdatum.owner?.learned_recipes))
		bloodsuckerdatum.owner.teach_crafting_recipe(/datum/crafting_recipe/vassalrack)
		bloodsuckerdatum.owner.teach_crafting_recipe(/datum/crafting_recipe/candelabrum)
		bloodsuckerdatum.owner.teach_crafting_recipe(/datum/crafting_recipe/bloodthrone)
		bloodsuckerdatum.owner.teach_crafting_recipe(/datum/crafting_recipe/meatcoffin)
		bloodsuckerdatum.owner.current.balloon_alert(bloodsuckerdatum.owner.current, "new recipes learned! Vassalization unlocked!")
	return TRUE

/datum/bloodsucker_clan/proc/list_available_powers(already_known = bloodsuckerdatum.powers, powers_list = bloodsuckerdatum.all_bloodsucker_powers)
	var/list/options = list()
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers_list)
		if(initial(power.purchase_flags) & buy_power_flags && !(locate(power) in already_known))
			options[initial(power.name)] = power
	return options

/datum/bloodsucker_clan/proc/purchase_choice(datum/antagonist/bloodsucker/source, datum/action/cooldown/bloodsucker/purchased_power)
	return bloodsuckerdatum.BuyPower(purchased_power)

/datum/bloodsucker_clan/proc/level_up_powers(datum/antagonist/bloodsucker/source)
	bloodsuckerdatum.LevelUpPowers()
/**
 * Called when we are trying to turn someone into a Favorite Vassal
 * args:
 * bloodsuckerdatum - the antagonist datum of the Bloodsucker performing this.
 * vassaldatum - the antagonist datum of the Vassal being offered up.
 */
/datum/bloodsucker_clan/proc/on_interact_with_vassal(datum/antagonist/bloodsucker/source, datum/antagonist/vassal/vassaldatum)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(interact_with_vassal), bloodsuckerdatum, vassaldatum)

/datum/bloodsucker_clan/proc/interact_with_vassal(datum/antagonist/bloodsucker/source, datum/antagonist/vassal/vassaldatum)
	var/mob/living/carbon/human/master = bloodsuckerdatum.owner.current
	var/mob/living/carbon/human/servant = vassaldatum.owner.current
	if(vassaldatum.special_type || IS_BLOODSUCKER(servant))
		to_chat(master, span_notice("This Vassal was already assigned a special position."))
		return FALSE
	if(!vassaldatum.owner.can_make_special(creator = bloodsuckerdatum.owner))
		to_chat(master, span_notice("This Vassal is unable to gain a Special rank due to innate features."))
		return FALSE
	if(bloodsuckerdatum.GetBloodVolume() < SPECIAL_VASSAL_COST)
		to_chat(master, span_notice("You need at least 150 blood to make a Vassal a Favorite Vassal."))
		return FALSE
	var/list/options = list()
	var/list/radial_display = list()
	for(var/datum/antagonist/vassal/vassaldatums as anything in subtypesof(/datum/antagonist/vassal))
		var/vassal_type = initial(vassaldatums.special_type)
		var/slot = bloodsuckerdatum.special_vassals[vassal_type]
		if(vassal_type && slot)
			continue
		options[initial(vassaldatums.name)] = vassaldatums

		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(vassaldatums.hud_icon), icon_state = initial(vassaldatums.antag_hud_name), pixel_y = -12, pixel_x = -12)
		option.info = "[initial(vassaldatums.name)] - [span_boldnotice(initial(vassaldatums.vassal_description))]"
		radial_display[initial(vassaldatums.name)] = option

	if(!options.len)
		master.balloon_alert(master, "Out of Special Vassal slots!")
		return FALSE

	to_chat(master, span_notice("You can change who this Vassal is, who are they to you? This will cost [SPECIAL_VASSAL_COST] blood."))
	var/vassal_response = show_radial_menu(master, servant, radial_display)
	if(!vassal_response)
		return FALSE
	var/datum/antagonist/vassal/vassal_type = options[vassal_response]
	// let's ask if the vassal themselves actually wants to be a favorite
#ifndef BLOODSUCKER_TESTING
	servant.balloon_alert(master, "asking...")
	var/vassal_permission = tgui_alert(servant, initial(vassal_type.vassal_description), "Become a Special Vassal?", list("Yes", "No"), 1 MINUTES) == "Yes"
	if(!vassal_permission)
		servant.balloon_alert(master, "refused!")
		return FALSE
#endif
	if(QDELETED(src) || QDELETED(master) || QDELETED(servant) || !vassal_type)
		return FALSE
	if(bloodsuckerdatum.GetBloodVolume() < SPECIAL_VASSAL_COST)
		to_chat(master, span_notice("You took too long to make your vassal, you no longer have enough blood!"))
		return FALSE
	vassaldatum.make_special(vassal_type)
	bloodsuckerdatum.AdjustBloodVolume(-SPECIAL_VASSAL_COST)
	return TRUE

/**
 * Called when we are successfully turn a Vassal into a Favorite Vassal
 * args:
 * bloodsuckerdatum - antagonist datum of the Bloodsucker who turned them into a Vassal.
 * vassaldatum - the antagonist datum of the Vassal being offered up.
 */
/datum/bloodsucker_clan/proc/favorite_vassal_gain(datum/antagonist/bloodsucker/source, datum/antagonist/vassal/vassaldatum)
	SIGNAL_HANDLER
	vassaldatum.BuyPower(/datum/action/cooldown/bloodsucker/targeted/brawn)

/datum/bloodsucker_clan/proc/favorite_vassal_loss(datum/antagonist/bloodsucker/source, datum/antagonist/vassal/vassaldatum)
	SIGNAL_HANDLER
