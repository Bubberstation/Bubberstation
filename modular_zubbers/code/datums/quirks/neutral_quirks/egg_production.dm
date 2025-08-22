/datum/quirk/egg_production
	name = "Oviparity"
	desc = "Whether it be genetics or some other factor, you are capable of producing eggs."
	icon = FA_ICON_EGG
	value = 0
	gain_text = span_notice("You suddenly feel rather productive.")
	lose_text = span_warning("You no longer feel productive. Sad.")
	medical_record_text = "Patient possesses the capability to produce eggs."
	//this tracks how many eggs are stored
	var/eggs_stored = 0
	//whether we can produce another egg yet or not
	var/production_cooldown = FALSE
	//max amount of eggs able to be stored
	var/maximum_eggs = 100
//Quirk addition
/datum/quirk/egg_production/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/datum/action/cooldown/mob_cooldown/egg_production/action = new /datum/action/cooldown/mob_cooldown/egg_production(quirk_holder)
	action.Grant(human_holder)
//Quirk removal
/datum/quirk/egg_production/remove()
	if(QDELETED(quirk_holder))
		return ..()
	var/datum/action/cooldown/mob_cooldown/egg_production/action = locate(/datum/action/cooldown/mob_cooldown/egg_production) in quirk_holder.actions
	action.Remove()

	return ..()

//List of valid reagents
GLOBAL_LIST_INIT(egg_production_reagents, list(
	/// Format: (Reagent typepath -> list(amount of reagent required per egg, cooldown per egg added to buffer))
	/datum/reagent/consumable/cum = list(15, 10 SECONDS),
	/datum/reagent/drug/aphrodisiac/crocin = list(20, 20 SECONDS),
	/datum/reagent/drug/aphrodisiac/crocin/hexacrocin = list(10, 30 SECONDS),
))

/// Egg creation segment
/datum/quirk/egg_production/proc/on_life(seconds_per_tick, times_fired)
	. = ..()
	create_egg(owner)

/datum/quirk/egg_production/proc/refresh_cooldown()
	production_cooldown = FALSE

//checks which reagent is a valid value and procs to increment stored eggs by 1, if it is below the maximum eggs stored
/datum/quirk/egg_production/proc/create_egg(mob/living/human/human_holder, seconds_per_tick, times_fired)
	var/list/cached_reagents = egg_production_reagents
	for(var/datum/reagent/reagent as anything in cached_reagents)
		if(reagents.amount >= egg_production_reagents[reagent[1]] && eggs_stored <= maximum_eggs)
			eggs_stored += 1
			production_cooldown = TRUE
			addtimer(CALLBACK(src, PROC_REF(refresh_cooldown(reagent))), egg_production_reagents[reagent[2]])
	return

// The action button segment.
/datum/action/cooldown/mob_cooldown/egg_production
	name = "Produce an Egg"
	desc = "Concentrate your efforts to lay an egg. Questionable use in public."

	button_icon = 'icons\obj\food\egg.dmi'
	button_icon_state = "egg"

	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED

	/// The the object we will produce.
	var/obj/item/food/egg/egg

/datum/action/cooldown/mob_cooldown/egg_production/Activate()
	owner.visible_message(span_alertalien("[owner] starts to lay an egg..."), span_alertalien("You start laying an egg..."))
	if(eggs_stored <= 0)
		owner.balloon_alert(owner, "no eggs to lay!")
		return FALSE

	if(!do_after(owner, 0.5 SECONDS, IGNORE_HELD_ITEM))
		new egg
		owner.put_in_hands(egg)
	owner.visible_message(span_alertalien("[owner] laid an egg!"), span_alertalien("You laid an egg!"))
	return TRUE
