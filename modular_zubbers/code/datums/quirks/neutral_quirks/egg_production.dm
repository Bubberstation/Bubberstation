/datum/quirk/egg_production
	name = "Oviparity"
	desc = "Whether it be genetics or some other factor, you are capable of producing eggs."
	icon = FA_ICON_EGG
	value = 0
	gain_text = span_notice("You suddenly feel rather productive.")
	lose_text = span_warning("You no longer feel productive. Sad.")
	medical_record_text = "Patient possesses the capability to produce eggs."

/datum/quirk_constant_data/egg_production
	associated_typepath = /datum/quirk/egg_production
	customization_options = list(
		/datum/preference/numeric/oviparity_eggs_rate,
		/datum/preference/numeric/oviparity_eggs_max,
	)

/datum/preference/numeric/oviparity_eggs_max
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "oviparity_eggs_max"
	savefile_identifier = PREFERENCE_CHARACTER
	step = 1
	minimum = 1
	maximum = 100

	create_default_value()
		return 10

	apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
		return

/datum/preference/numeric/oviparity_eggs_rate
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "oviparity_eggs_rate"
	savefile_identifier = PREFERENCE_CHARACTER
	step = 5
	minimum = 5
	maximum = 300

	create_default_value()
		return 20

	apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
		return

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
	action.Remove(quirk_holder)

	return ..()

/// The full action functionality segment
/datum/action/cooldown/spell/egg_production
	name = "Produce an Egg"
	desc = "Concentrate your efforts to lay an egg. Questionable use in public."

	button_icon = 'icons/obj/food/egg.dmi'
	button_icon_state = "egg"
	spell_requirements = NONE

	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED

	// The the object we will produce.
	var/obj/item/food/egg/egg
	// This tracks how many eggs are stored
	var/eggs_stored = 0
	// Whether we can produce another egg yet or not
	var/can_produce = TRUE
	// Max amount of eggs able to be stored
	var/maximum_eggs = 10
	// How much time between each produced egg
	var/production_period = 20
	// List of possible to_chat messages egg creation is able to trigger
	var/list/possible_egg_thoughts = list(
		"You feel a slight weight added to you.",
		"You feel a warm sensation inside you.",
		"You feel slightly heavier than you were a moment ago.",
		"You feel oddly full."
	)
	// Static list of valid reagents
	var/list/egg_production_reagents = list("cum", "crocin", "hexacrocin", "Teshari Mutation Toxin")
	COOLDOWN_DECLARE(next_process)

/datum/action/cooldown/spell/egg_production/Grant(mob/granted_to)
	RegisterSignal(granted_to, COMSIG_LIVING_LIFE, PROC_REF(on_life))

	var/datum/preferences/prefs = granted_to.client?.prefs
	if(prefs)
		maximum_eggs = prefs.read_preference(/datum/preference/numeric/oviparity_eggs_max)
		production_period = prefs.read_preference(/datum/preference/numeric/oviparity_eggs_rate) SECONDS

	can_produce = TRUE //redundancy
	return ..()

/datum/action/cooldown/spell/egg_production/Remove(mob/removed_from)
	UnregisterSignal(removed_from, COMSIG_LIVING_LIFE)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/eggnant)
	return ..()

/datum/action/cooldown/spell/egg_production/proc/on_life(seconds_per_tick, times_fired) //adds a proc on_life under the condition we can even produce
	SIGNAL_HANDLER

	if(!COOLDOWN_FINISHED(src, next_process))
		return
	COOLDOWN_START(src, next_process, production_period)

	var/mob/living/carbon/human/egg_holder = owner
	var/list/cached_reagents = egg_holder.reagents?.reagent_list
	if(!length(cached_reagents) || eggs_stored >= maximum_eggs)
		return

	for(var/datum/reagent/target_reagent as anything in cached_reagents)
		if(target_reagent.name in egg_production_reagents) // checks to ensure the target reagent is even correct, this was a pain in the ass
			create_egg(egg_holder)
			break

/datum/action/cooldown/spell/egg_production/proc/create_egg(mob/living/carbon/human/egg_holder)
	var/egg_thought = pick(possible_egg_thoughts)
	to_chat(owner, span_notice("[egg_thought]"))
	egg_update(1, egg_holder)

#define in_range_float(prev, current, val, range) abs(prev-val)>range && abs(current-val)<=range
/datum/action/cooldown/spell/egg_production/proc/egg_update(delta, mob/living/egg_holder)
	var/slow_mult_prev = FLOOR((eggs_stored) / (maximum_eggs), 0.01)

	eggs_stored = clamp((eggs_stored + delta), 0, maximum_eggs) // clamps the stored eggs value between 0 and the maximum, AND increments by the delta amount (which should be 1)
	desc = "[initial(desc)]. You carry [eggs_stored] egg\s." // this is meant to add an active readout of how many eggs are stored on mouse-over of the action

	if(eggs_stored == 0)// handles removal of the modifier if stored eggs is 0
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/eggnant, update = TRUE)
		return

	var/slow_mult = FLOOR((eggs_stored) / (maximum_eggs), 0.01)
	var/datum/movespeed_modifier/eggnant/modifier = new()
	modifier.multiplicative_slowdown = CEILING((5 * slow_mult), 0.01)
	if(owner.has_movespeed_modifier(/datum/movespeed_modifier/eggnant))
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/eggnant)
	owner.add_movespeed_modifier(modifier, update = TRUE)

	var/is_delta_negative = delta < 0

	if(eggs_stored == 0)
		to_chat(owner, span_purple("You feel all clear and relieved!"))
	else if(in_range_float(slow_mult_prev, slow_mult, 0.15, 0.1))
		to_chat(owner, span_purple("You're beginning to feel [is_delta_negative ? "less weighed down, but still lumpy..." : "rather heavy..."]"))
	else if(in_range_float(slow_mult_prev, slow_mult, 0.35, 0.1))
		to_chat(owner, span_purple("You feel [is_delta_negative ? "less swollen, but still really heavy..." : "really swollen with all these eggs..."]"))
	else if(in_range_float(slow_mult_prev, slow_mult, 0.55, 0.1))
		to_chat(owner, span_crossooc("[is_delta_negative ? "You're a bit less taut, but still feel very swollen!" : "You're overly gravid! You feel like you should really lay these eggs soon..."]"))
	else if(in_range_float(slow_mult_prev, slow_mult, 0.75, 0.1))
		to_chat(owner, span_crossooc("You feel [is_delta_negative ? "a little relieved, but still extremely taut!" : "very close to full at this point, any more eggs and you'll run out of room!"]"))
	else if(in_range_float(slow_mult_prev, slow_mult, 0.95, 0.1))
		to_chat(owner, span_warning("You feel painful bulging and stretching!"))
	else if(eggs_stored == maximum_eggs)
		to_chat(owner, span_alertwarning("Your body can't handle anymore eggs! You need to lay some to make room, now!"))
#undef in_range_float

//setting the base movespeed modifier
/datum/movespeed_modifier/eggnant
	variable = TRUE
	multiplicative_slowdown = 5

/datum/action/cooldown/spell/egg_production/cast(mob/living/cast_on)
	.=..()
	if(eggs_stored <= 0)
		owner.balloon_alert(owner, "no eggs to lay!")
		return FALSE

	to_chat(owner, span_noticealien("You start laying an egg..."))
	if(!do_after(owner, 5 SECONDS, cast_on, IGNORE_HELD_ITEM))
		owner.balloon_alert(owner, "stopped attempting to lay an egg.")
		return FALSE

	egg_update(-1) //decrements the stored eggs by 1
	egg = new(owner)
	owner.put_in_hands(egg)
	owner.visible_message(span_noticealien("[owner] laid an egg!"), span_alertalien("You laid an egg!"))
	INVOKE_ASYNC(src, PROC_REF(cast), cast_on) // Keep laying without need to press button
	return TRUE
