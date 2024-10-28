/datum/bloodsucker_clan/malkavian
	name = CLAN_MALKAVIAN
	description = "Little is documented about Malkavians. Complete insanity is the most common theme. \n\
		The Favorite Ghoul will suffer the same fate as the Master, while gaining the ability to tap into the madness when fighting."
	join_icon_state = "malkavian"
	join_description = "Completely insane. You gain constant hallucinations, become a prophet with unintelligable rambling, \
		and become the enforcer of the Masquerade code."
	blood_drink_type = BLOODSUCKER_DRINK_INHUMANELY
	/// The prob chance of a malkavian spouting a revelation.
	var/max_madness_chance = 10
	var/min_madness_chance = 5

/datum/bloodsucker_clan/malkavian/on_enter_frenzy(datum/antagonist/bloodsucker/source)
	ADD_TRAIT(bloodsuckerdatum.owner.current, TRAIT_STUNIMMUNE, FRENZY_TRAIT)

/datum/bloodsucker_clan/malkavian/on_exit_frenzy(datum/antagonist/bloodsucker/source)
	REMOVE_TRAIT(bloodsuckerdatum.owner.current, TRAIT_STUNIMMUNE, FRENZY_TRAIT)

/datum/bloodsucker_clan/malkavian/New(datum/antagonist/bloodsucker/owner_datum)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_BLOODSUCKER_BROKE_MASQUERADE, PROC_REF(on_bloodsucker_broke_masquerade))
	ADD_TRAIT(bloodsuckerdatum.owner.current, TRAIT_XRAY_VISION, BLOODSUCKER_TRAIT)
	var/mob/living/carbon/carbon_owner = bloodsuckerdatum.owner.current
	if(istype(carbon_owner))
		carbon_owner.gain_trauma(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		carbon_owner.gain_trauma(/datum/brain_trauma/special/bluespace_prophet, TRAUMA_RESILIENCE_ABSOLUTE)
	owner_datum.owner.current.update_sight()

	bloodsuckerdatum.owner.current.playsound_local(get_turf(bloodsuckerdatum.owner.current), 'sound/music/antag/creepalert.ogg', 80, FALSE, pressure_affected = FALSE, use_reverb = FALSE)
	to_chat(bloodsuckerdatum.owner.current, span_hypnophrase("Welcome to the Malkavian..."))

/datum/bloodsucker_clan/malkavian/Destroy(force)
	UnregisterSignal(SSdcs, COMSIG_BLOODSUCKER_BROKE_MASQUERADE)
	REMOVE_TRAIT(bloodsuckerdatum.owner.current, TRAIT_XRAY_VISION, BLOODSUCKER_TRAIT)
	var/mob/living/carbon/carbon_owner = bloodsuckerdatum.owner.current
	if(istype(carbon_owner))
		carbon_owner.cure_trauma_type(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		carbon_owner.cure_trauma_type(/datum/brain_trauma/special/bluespace_prophet, TRAUMA_RESILIENCE_ABSOLUTE)
	bloodsuckerdatum.owner.current.update_sight()
	return ..()

/datum/bloodsucker_clan/malkavian/handle_clan_life(datum/antagonist/bloodsucker/source, seconds_per_tick, times_fired)
	. = ..()
	// Using linear interpolation to calculate the chance of a revelation. The more humanity lost, the higher the chance.
	// This is the reversed version since we want to increase the prob as the number decreases.
	// Equation: interpolated value = end + normalized factor * (start - end)
	// normalized factor(between 0 and 1, in decimals)
	var/humanity_lost_modifier = source.GetHumanityLost() / 50
	if(humanity_lost_modifier == 0)
		// 0 * anything = 0, this makes having 0 humanity not max out the chance.
		humanity_lost_modifier = 1
	var/interpolated_chance = max_madness_chance + humanity_lost_modifier * (min_madness_chance - max_madness_chance)
	var/madness_chance = clamp(interpolated_chance, min_madness_chance, max_madness_chance)
	if(!prob(madness_chance) || source.owner.current.stat != CONSCIOUS || HAS_TRAIT(source.owner.current, TRAIT_MASQUERADE))
		return
	var/message = pick(strings("malkavian_revelations.json", "revelations", "modular_zubbers/strings/bloodsuckers"))
	INVOKE_ASYNC(source.owner.current, TYPE_PROC_REF(/atom/movable, say), message, forced = CLAN_MALKAVIAN)

/datum/bloodsucker_clan/malkavian/favorite_ghoul_gain(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	var/mob/living/carbon/carbonowner = ghouldatum.owner.current
	if(istype(carbonowner))
		carbonowner.gain_trauma(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		carbonowner.gain_trauma(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)
	var/datum/martial_art/psychotic_brawling/psychotic_brawling = new(null)
	psychotic_brawling.teach(ghouldatum.owner.current, TRUE)
	to_chat(ghouldatum.owner.current, span_notice("Additionally, you now suffer the same fate as your Master, while also gaining the ability to tap into the madness when fighting."))

/datum/bloodsucker_clan/malkavian/favorite_ghoul_loss(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	var/mob/living/carbon/carbonowner = ghouldatum.owner.current
	if(istype(carbonowner))
		carbonowner.cure_trauma_type(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		carbonowner.cure_trauma_type(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)
	if(!istype(/datum/martial_art/psychotic_brawling, ghouldatum.owner.martial_art))
		return
	var/datum/martial_art/psychotic_brawling/psychotic_brawling = ghouldatum.owner.martial_art
	psychotic_brawling.remove(ghouldatum.owner.current)

/datum/bloodsucker_clan/malkavian/on_exit_torpor(datum/antagonist/bloodsucker/source)
	var/mob/living/carbon/carbonowner = bloodsuckerdatum.owner.martial_art
	if(istype(carbonowner))
		carbonowner.gain_trauma(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		carbonowner.gain_trauma(/datum/brain_trauma/special/bluespace_prophet, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/bloodsucker_clan/malkavian/on_final_death(datum/antagonist/bloodsucker/source)
	var/obj/item/soulstone/bloodsucker/stone = new /obj/item/soulstone/bloodsucker(get_turf(bloodsuckerdatum.owner.current))
	if(!bloodsuckerdatum.owner.current.ckey)
		return
	ASYNC
		stone.capture_soul(bloodsuckerdatum.owner.current, forced = TRUE)
	return DONT_DUST

/datum/bloodsucker_clan/malkavian/proc/on_bloodsucker_broke_masquerade(datum/source, datum/antagonist/bloodsucker/masquerade_breaker)
	SIGNAL_HANDLER
	to_chat(bloodsuckerdatum.owner.current, span_userdanger("[masquerade_breaker.owner.current] has broken the Masquerade! Ensure [masquerade_breaker.owner.current.p_they()] [masquerade_breaker.owner.current.p_are()] eliminated at all costs!"))
	var/datum/objective/assassinate/masquerade_objective = new()
	masquerade_objective.target = masquerade_breaker.owner.current
	masquerade_objective.objective_name = "Clan Objective"
	masquerade_objective.explanation_text = "Ensure [masquerade_breaker.owner.current], who has broken the Masquerade, succumbs to Final Death."
	bloodsuckerdatum.objectives += masquerade_objective
	bloodsuckerdatum.owner.announce_objectives()
