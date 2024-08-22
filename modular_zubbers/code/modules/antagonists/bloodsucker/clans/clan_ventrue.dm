///The maximum level a Ventrue Bloodsucker can be, before they have to level up their vassal instead.
#define VENTRUE_MAX_POWERS 3

/datum/bloodsucker_clan/ventrue
	name = CLAN_VENTRUE
	description = "The Ventrue Clan is extremely snobby with their meals, and refuse to drink blood from people without a mind. \n\
		You may have up to %MAX_POWERS% powers, anything further will be ranks to spend on their Favorite Vassal through a Persuasion Rack. \n\
		The Favorite Vassal will slowly turn more Vampiric this way, until they finally lose their last bits of Humanity. \n\
		Once you finish your embracing, the newly sired vampire will become just a vassal, and you'll be able to sire another bloodsucker."
	clan_objective = /datum/objective/bloodsucker/embrace
	join_icon_state = "ventrue"
	join_description = "Lose the ability to drink from mindless mobs, can't level up or gain new powers, \
		instead you raise a vassal into a Bloodsucker."
	blood_drink_type = BLOODSUCKER_DRINK_SNOBBY
	level_cost = BLOODSUCKER_LEVELUP_PERCENTAGE_VENTRUE

/datum/bloodsucker_clan/ventrue/New(datum/antagonist/bloodsucker/owner_datum)
	. = ..()
	description = replacetext(description, "%MAX_POWERS%", VENTRUE_MAX_POWERS)

/datum/bloodsucker_clan/ventrue/proc/has_enough_abilities()
	var/power_count = 0
	for(var/datum/action/cooldown/bloodsucker/power in bloodsuckerdatum.powers)
		if(!(power.purchase_flags & BLOODSUCKER_DEFAULT_POWER))
			power_count++
	if(power_count >= VENTRUE_MAX_POWERS)
		return TRUE
	return FALSE

/datum/bloodsucker_clan/ventrue/spend_rank(datum/antagonist/bloodsucker/source, cost_rank = TRUE, blood_cost)
	if(has_enough_abilities())
		to_chat(bloodsuckerdatum.owner.current, span_danger("You can only have up to [VENTRUE_MAX_POWERS] powers, anything further must be ranks to spend on your Favorite Vassal through a Persuasion Rack."))
		return FALSE
	. = ..()

/datum/bloodsucker_clan/ventrue/proc/finish_spend_rank(datum/antagonist/vassal/vassaldatum, cost_rank, blood_cost)
	finalize_spend_rank(bloodsuckerdatum, cost_rank, blood_cost)
	vassaldatum.LevelUpPowers()

/datum/bloodsucker_clan/ventrue/interact_with_vassal(datum/antagonist/bloodsucker/source, datum/antagonist/vassal/favorite/vassaldatum)
	. = ..()
	if(.)
		return TRUE
	if(!istype(vassaldatum))
		return FALSE
	var/vassal_upgrade_cost = bloodsuckerdatum.get_level_cost()
	// We don't have any ranks to spare? Let them upgrade... with enough Blood.
	to_chat(bloodsuckerdatum.owner.current, span_warning("Do you wish to spend [vassal_upgrade_cost] Blood to Rank [vassaldatum.owner.current] up?"))
	var/static/list/rank_options = list(
		"Yes" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_yes"),
		"No" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no"),
	)
	var/rank_response = show_radial_menu(bloodsuckerdatum.owner.current, vassaldatum.owner.current, rank_options, radius = 36, require_near = TRUE)
	if(rank_response == "Yes")
		var/has_rank = bloodsuckerdatum.GetUnspentRank() >= 1
		if(!has_rank || !source.blood_level_gain())
			to_chat(bloodsuckerdatum.owner.current, span_danger("You don't have any levels or enough Blood to Rank [vassaldatum.owner.current] up with."))
			return FALSE
		vassal_level(vassaldatum.owner.current)
	return TRUE

/datum/bloodsucker_clan/ventrue/proc/vassal_level(mob/living/carbon/human/target, datum/antagonist/vassal/favorite/vassaldatum)
	var/datum/action/cooldown/bloodsucker/choice = choose_powers(
		"You have the opportunity to level up your Favorite Vassal. Select a power you wish them to recieve.",
		"A wise master's hand is neccesary",
		VASSAL_CAN_BUY
	)
	if(!vassaldatum.BuyPower(choice, vassaldatum.bloodsucker_powers))
		bloodsuckerdatum.owner.current.balloon_alert(bloodsuckerdatum.owner.current, "[target] already knows [choice]!")
		return
	bloodsuckerdatum.owner.current.balloon_alert(bloodsuckerdatum.owner.current, "taught [choice]!")
	to_chat(bloodsuckerdatum.owner.current, span_notice("You taught [target] how to use [choice]!"))
	target.balloon_alert(target, "learned [choice]!")
	to_chat(target, span_notice("Your master taught you how to use [choice]!"))

	vassaldatum.vassal_level++
	finish_spend_rank(vassaldatum, TRUE, FALSE)
	bloodsuckerify(vassaldatum.vassal_level)

/datum/bloodsucker_clan/ventrue/proc/bloodsuckerify(mob/living/carbon/human/target, stage = 1)
	var/datum/antagonist/vassal/favorite/vassaldatum = IS_FAVORITE_VASSAL(target)
	var/list/traits_possible = list(
		list(TRAIT_COLDBLOODED, TRAIT_NOBREATH, TRAIT_AGEUSIA),
		list(TRAIT_NOCRITDAMAGE, TRAIT_NOSOFTCRIT, TRAIT_SLEEPIMMUNE, TRAIT_VIRUSIMMUNE),
		list(TRAIT_NOHARDCRIT, TRAIT_HARDLY_WOUNDED)
	)
	var/traits_to_add = length(traits_possible) >= stage ? traits_possible[stage] : list()
	switch(stage)
		if(1)
			to_chat(target, span_notice("Your blood begins to feel cold, and as a mote of ash lands upon your tongue, you stop breathing..."))

		if(2)
			to_chat(target, span_notice("You feel your Master's blood reinforce you, strengthening you up."))
			if(ishuman(target))
				var/mob/living/carbon/human/human_target = target
				human_target.skin_tone = "albino"

		if(3)
			to_chat(target, span_notice("You feel yourself able to take cuts and stabbings like it's nothing."))

		if(4 to INFINITY)
			var/datum/antagonist/bloodsucker/bloodsucker_target = target.mind.has_antag_datum(/datum/antagonist/bloodsucker)

			if(!bloodsucker_target)
				to_chat(target, span_notice("You feel your heart stop pumping for the last time as you begin to thirst for blood, you feel... dead."))
				// Unfavorites you, so the ventrue isn't stuck with you forever
				var/powers_to_transfer = list()
				// Get rid of the favorite datum and replace with a normal vassal datum
				if(vassaldatum)
					vassaldatum.silent = TRUE
					for(var/datum/power as anything in vassaldatum.bloodsucker_powers)
						powers_to_transfer += power.type
					target.mind.remove_antag_datum(/datum/antagonist/vassal/favorite)
				else
					target.remove_traits(flatten_list(traits_to_add), VASSAL_TRAIT)

				var/datum/antagonist/bloodsucker/vamp = new()
				vamp.ventrue_sired = bloodsuckerdatum
				bloodsucker_target = target.mind.add_antag_datum(vamp)
				bloodsucker_target.BuyPowers(powers_to_transfer)
				// Check for the recuperate power and remove it if they have it
				bloodsuckerdatum.owner.current.add_mood_event("madevamp", /datum/mood_event/madevamp)

	if(vassaldatum && QDELETED(vassaldatum) && length(traits_to_add))
		target.add_traits(traits_to_add, VASSAL_TRAIT)
		vassaldatum.traits += traits_to_add

/datum/bloodsucker_clan/ventrue/favorite_vassal_gain(datum/antagonist/bloodsucker/source, datum/antagonist/vassal/vassaldatum)
	to_chat(source.owner.current, span_announce("* Bloodsucker Tip: You can now upgrade your Favorite Vassal by buckling them onto a persuasion rack!"))
	vassaldatum.BuyPower(/datum/action/cooldown/bloodsucker/distress)

#undef VENTRUE_MAX_POWERS
