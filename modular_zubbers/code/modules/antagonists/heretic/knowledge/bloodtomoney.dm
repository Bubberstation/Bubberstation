#define BLOOD_AMOUNT_TO_STEAL_PERCENT_RATIO 5 // 1u, 5%, 10u, 50%
#define PHYLACTERY_ACCOUNT_MIN 300

/datum/heretic_knowledge/blood_to_money
	name = "Claw of the Capitalist"
	desc = "Allows you to use blood to steal credits out of a target's bank account. Blood gained from the Phlyactery can only steal from \
	accounts with three hundred credits or more. Notifies the target on invocation."
	gain_text = "Nanotrasen's efforts were not in vain. The Capitalist, one of many gods-from-steel, successfully penetrated the mansus \
	and established itself after a long and gruesome war. What Nanotrasen did not anticipate, however, was its reluctance to work with its \
	creators, and instead pursuing its own goals of greed and avarice."
	drafting_cost = 1
	drafting_tier = 1
	research_tree_icon_path = 'icons/obj/medical/syringe.dmi'
	research_tree_icon_state = "mod_0"
	required_atoms = list()

/datum/heretic_knowledge/blood_to_money/can_be_invoked(datum/antagonist/heretic/invoker)
	return TRUE

/datum/heretic_knowledge/blood_to_money/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if (!.)
		return

	var/list/blood_data = get_blood_data_from(atoms)
	return length(blood_data)

/datum/heretic_knowledge/blood_to_money/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/datum/antagonist/heretic/our_heretic = GET_HERETIC(user)
	var/list/atom/atoms = list()
	for(var/atom/close_atom as anything in range(1, loc))
		if(!ismovable(close_atom))
			continue
		if(isitem(close_atom))
			var/obj/item/close_item = close_atom
			if(close_item.item_flags & ABSTRACT) //woops sacrificed your own head
				continue
		if(close_atom.invisibility)
			continue
		if(close_atom == user)
			continue

		atoms += close_atom

	var/list/blood_data = get_blood_data_from(atoms)
	if (!length(blood_data))
		return FALSE

	for (var/list/entry in blood_data)
		var/datum/bank_account/account = entry[1]
		var/creds = entry[2]
		var/blood_amount = entry[3]
		var/from_phylactery = entry[4]
		var/mob/living/curr_mob = entry[5]
		var/datum/reagents/holder = entry[6]
		if (curr_mob?.can_block_magic(MAGIC_RESISTANCE))
			to_chat(curr_mob, span_warning("You feel the cold grasp of capitalism gripping your finances... but then it slips away."))
			continue

		var/to_steal = (creds * ((blood_amount * 0.01) * BLOOD_AMOUNT_TO_STEAL_PERCENT_RATIO))

		if (from_phylactery)
			if (account.account_balance < PHYLACTERY_ACCOUNT_MIN)
				continue

		to_steal = floor(to_steal)
		account.adjust_money(-to_steal, "##^@%%$^")
		if (curr_mob != null)
			to_chat(curr_mob, span_warning("You feel the cold grasp of capitalism gripping your finanaces and tearing them away... someone just stole some of your money through the mansus!"))
			curr_mob.balloon_alert(curr_mob, "money stolen!")

		// no space cash bc space cash is picky
		var/obj/item/holochip/cash = new /obj/item/holochip(loc)
		cash.credits = to_steal
		SEND_SIGNAL(our_heretic, COMSIG_HERETIC_STOLE_MONEY, curr_mob, to_steal)

		holder.remove_reagent(/datum/reagent/blood, blood_amount)

/datum/heretic_knowledge/blood_to_money/proc/get_blood_data_from(list/atoms)
	var/list/datum/reagent/blood/all_blood = list()
	for (var/obj/item/reagent_containers/container in atoms)
		var/datum/reagent/blood/iter_blood = container.reagents.has_reagent(/datum/reagent/blood)
		if (istype(iter_blood))
			all_blood += iter_blood

	// bank account, credits, amount, phylactery, mob, container
	var/blood_data = list()

	for (var/datum/reagent/blood/iter_blood as anything in all_blood)
		var/datum/mind/iter_mind = iter_blood.data["mind"]
		if (isnull(iter_mind))
			continue
		var/mob/living/curr_mob = iter_mind.current
		if (isnull(curr_mob))
			continue
		var/datum/bank_account/account = curr_mob.get_bank_account()
		if (isnull(account))
			continue

		blood_data += list(list(account, account.account_balance, iter_blood.holder.get_reagent_amount(/datum/reagent/blood), iter_blood.data["phlyacterized"], curr_mob, iter_blood.holder))

	return blood_data

#undef BLOOD_AMOUNT_TO_STEAL_PERCENT_RATIO
#undef PHYLACTERY_ACCOUNT_MIN
