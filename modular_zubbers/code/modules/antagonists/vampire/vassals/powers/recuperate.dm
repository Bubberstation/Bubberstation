#define RECUPERATE_BRUTE_HEAL 2.5
#define RECUPERATE_TOX_HEAL 2
#define RECUPERATE_BURN_HEAL 1.5
#define RECUPERATE_STAMINA_MARGIN 5

/// Used by vassals
/datum/action/cooldown/vampire/recuperate
	name = "Sanguine Recuperation"
	desc = "Slowly heals you overtime using your master's blood, in exchange for some effort."
	button_icon_state = "power_recup"
	power_explanation = "Activating this Power will begin to heal your wounds.\n\
		You will heal Brute and Toxin damage at the cost of your Stamina and your master's blood.\n\
		If you aren't a bloodless race, you will additionally heal Burn damage."
	vampire_power_flags = BP_AM_TOGGLE
	vampire_check_flags = NONE
	special_flags = NONE
	constant_vitaecost = 1.5
	cooldown_time = 10 SECONDS

/datum/action/cooldown/vampire/recuperate/get_power_explanation_extended()
	. = list()
	. += "Activating this Power will begin to heal your wounds."
	. += "Every second you will heal [RECUPERATE_BRUTE_HEAL / VAMPIRE_LIFE_TICK_SECONDS] Brute and [RECUPERATE_TOX_HEAL / VAMPIRE_LIFE_TICK_SECONDS] Toxin damage and slow your bleeding, \
		at the cost of [get_stamina_cost() / VAMPIRE_LIFE_TICK_SECONDS] Stamina and [constant_vitaecost / VAMPIRE_LIFE_TICK_SECONDS] of your master's blood."
	. += "If you aren't a bloodless race, you will additionally heal [RECUPERATE_BURN_HEAL / VAMPIRE_LIFE_TICK_SECONDS] Burn damage."
	. += "It will not exhaust you completely, but it ends if you are incapacitated."

/datum/action/cooldown/vampire/recuperate/proc/get_stamina_cost()
	return constant_vitaecost * 1.1

/datum/action/cooldown/vampire/recuperate/activate_power()
	. = ..()
	to_chat(owner, span_notice("Your muscles clench as your master's immortal blood mixes with your own, knitting your wounds."))
	owner.balloon_alert(owner, "recuperate turned on.")

/datum/action/cooldown/vampire/recuperate/use_power(mob/living/source, seconds_per_tick)
	. = ..()
	if(!. || !currently_active)
		return

	var/mob/living/carbon/carbon_owner = owner
	if(!istype(carbon_owner))
		return

	var/tick_mult = seconds_per_tick / VAMPIRE_LIFE_TICK_SECONDS
	var/needs_update = FALSE
	carbon_owner.set_jitter_if_lower(10 SECONDS)
	var/stamina_room = carbon_owner.max_stamina - RECUPERATE_STAMINA_MARGIN - carbon_owner.get_stamina_loss()
	if(stamina_room > 0)
		carbon_owner.adjust_stamina_loss(min(get_stamina_cost() * tick_mult, stamina_room))
	needs_update += carbon_owner.adjust_brute_loss(-RECUPERATE_BRUTE_HEAL * tick_mult, updating_health = FALSE)
	needs_update += carbon_owner.adjust_tox_loss(-RECUPERATE_TOX_HEAL * tick_mult, updating_health = FALSE, forced = TRUE)
	if(!HAS_TRAIT(carbon_owner, TRAIT_NOBLOOD))
		needs_update += carbon_owner.adjust_fire_loss(-RECUPERATE_BURN_HEAL * tick_mult, updating_health = FALSE)

	// Stop Bleeding
	var/datum/wound/bloodiest_wound
	for(var/datum/wound/iter_wound as anything in carbon_owner.all_wounds)
		if(iter_wound.blood_flow && (!bloodiest_wound || (iter_wound.blood_flow > bloodiest_wound.blood_flow)))
			bloodiest_wound = iter_wound

	bloodiest_wound?.adjust_blood_flow(-0.25 * tick_mult)

	for(var/obj/item/bodypart/bodypart as anything in carbon_owner.bodyparts)
		if(bodypart.generic_bleedstacks)
			bodypart.adjustBleedStacks(-1 * tick_mult, 0)

	if(needs_update)
		carbon_owner.updatehealth()

/datum/action/cooldown/vampire/recuperate/continue_active()
	if(!..() || owner.stat == DEAD)
		return FALSE
	var/mob/living/living_owner = owner
	if(INCAPACITATED_IGNORING(living_owner, INCAPABLE_RESTRAINTS))
		owner.balloon_alert(owner, "too exhausted...")
		return FALSE
	return TRUE

/datum/action/cooldown/vampire/recuperate/deactivate_power()
	if(!QDELETED(owner))
		owner.balloon_alert(owner, "recuperate turned off.")
	return ..()

#undef RECUPERATE_BRUTE_HEAL
#undef RECUPERATE_TOX_HEAL
#undef RECUPERATE_BURN_HEAL
#undef RECUPERATE_STAMINA_MARGIN
