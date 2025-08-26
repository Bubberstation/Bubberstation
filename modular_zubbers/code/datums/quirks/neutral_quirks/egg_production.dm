//GLOBAL LIST of valid reagents
GLOBAL_LIST_INIT(egg_production_reagents, list(
	/// Format: (Reagent name = list(amount of reagent required per egg, cooldown per egg added to buffer))
	"cum" = list(20, 30 SECONDS),
	"crocin" = list(20, 20 SECONDS),
	"hexacrocin" = list(10, 30 SECONDS),
))

/datum/quirk/egg_production
	name = "Oviparity"
	desc = "Whether it be genetics or some other factor, you are capable of producing eggs."
	icon = FA_ICON_EGG
	value = 0
	gain_text = span_notice("You suddenly feel rather productive.")
	lose_text = span_warning("You no longer feel productive. Sad.")
	medical_record_text = "Patient possesses the capability to produce eggs."

//Quirk addition
/datum/quirk/egg_production/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/datum/action/cooldown/spell/egg_production/action = new /datum/action/cooldown/spell/egg_production()
	action.Grant(human_holder)

//Quirk removal
/datum/quirk/egg_production/remove()
	if(QDELETED(quirk_holder))
		return ..()
	var/datum/action/cooldown/spell/egg_production/action = locate(/datum/action/cooldown/spell/egg_production) in quirk_holder.actions
	action.Remove()

	return ..()

/// The full action functionality segment
/datum/action/cooldown/spell/egg_production
	name = "Produce an Egg"
	desc = "Concentrate your efforts to lay an egg. Questionable use in public."

	button_icon = 'icons/obj/food/egg.dmi'
	button_icon_state = "egg"
	cooldown_time = 1 SECONDS
	spell_requirements = NONE

	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED

	// The the object we will produce.
	var/obj/item/food/egg/egg
	//this tracks how many eggs are stored
	var/eggs_stored = 0
	//whether we can produce another egg yet or not
	var/can_produce = TRUE
	//max amount of eggs able to be stored
	var/maximum_eggs = 100

/datum/action/cooldown/spell/egg_production/Grant(mob/granted_to)
	RegisterSignal(granted_to, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	can_produce = TRUE //redundancy
	return ..()

/datum/action/cooldown/spell/egg_production/Remove(mob/removed_from)
	UnregisterSignal(removed_from, COMSIG_LIVING_LIFE)
	return ..()

/// Egg creation segment
/datum/action/cooldown/spell/egg_production/proc/on_life(seconds_per_tick, times_fired)
	if(can_produce == TRUE)
		create_egg()
	return

/datum/action/cooldown/spell/egg_production/proc/toggle_cooldown()
	can_produce = !can_produce

//checks if we can produce an egg, whether there are any reagents, validates that we have the correct reagents, and creates an egg as long as we have the required value and eggs_stored is not at the maximum
/datum/action/cooldown/spell/egg_production/proc/create_egg(datum/reagent/reagent)
	if(can_produce == FALSE)
		return FALSE //cooldown is active, abort the proc

	var/mob/living/carbon/human/human_holder = owner
	var/list/cached_reagents = human_holder.reagents?.reagent_list
	if(!length(cached_reagents))
		return FALSE //there were no reagents, abort the proc

	for(var/datum/reagent/target_reagent as anything in cached_reagents)
		if(!(target_reagent.name in GLOB.egg_production_reagents)) //checks to ensure the target reagent is even correct, this was a pain in the ass
			continue
		if(target_reagent.volume >= GLOB.egg_production_reagents[target_reagent.name][1] && ISINRANGE (eggs_stored, 0, maximum_eggs))
			to_chat(owner, span_notice("You feel a slight weight added to you."))
			egg_update(1)
			human_holder.reagents.remove_reagent(target_reagent.type, GLOB.egg_production_reagents[target_reagent.name][1])
			toggle_cooldown()
			addtimer(CALLBACK(src, PROC_REF(toggle_cooldown)), GLOB.egg_production_reagents[target_reagent.name][2])
			return TRUE //completed once, now kill the entire proc
	return

/datum/action/cooldown/spell/egg_production/proc/egg_update(delta)
	eggs_stored += delta
	eggs_stored = clamp(eggs_stored, 0, maximum_eggs) // clamps the stored eggs value between 0 and the maximum

	///need to add a portion that adjusts movespeed here when overburdened

/datum/action/cooldown/spell/egg_production/cast(mob/living/cast_on)
	.=..()
	if(eggs_stored <= 0) //this should work now
		owner.balloon_alert(owner, "no eggs to lay!")
		return FALSE

	owner.visible_message(span_noticealien("[owner] starts to lay an egg..."), span_alertalien("You start laying an egg..."))
	if(!do_after(owner, 5 SECONDS, cast_on, IGNORE_HELD_ITEM))
		owner.balloon_alert(owner, "stopped attempting to lay an egg.")
		return FALSE

	egg_update(-1) //this should also work now
	egg = new(owner)
	owner.put_in_hands(egg)
	owner.visible_message(span_alertalien("[owner] laid an egg!"), span_alertalien("You laid an egg!"))
	return TRUE
