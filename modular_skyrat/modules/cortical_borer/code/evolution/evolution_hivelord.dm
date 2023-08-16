/datum/borer_evolution/hivelord
	evo_type = BORER_EVOLUTION_HIVELORD

// T1

/datum/borer_evolution/hivelord/movespeed
	name = "Increased Energy"
	desc = "Boost your speed by a large amount."
	gain_text = "And as I watched, the Cortical Borer was able to complete the course in just over half the time it had last week."
	tier = 1
	evo_cost = 1
	unlocked_evolutions = list(/datum/borer_evolution/hivelord/blood_chemical)

/datum/borer_evolution/hivelord/movespeed/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.add_movespeed_modifier(/datum/movespeed_modifier/borer_speed)

// T2
/datum/borer_evolution/hivelord/blood_chemical
	name = "Learn Blood Chemical"
	desc = "Learn a synthesizable chemical from the blood of your host."
	gain_text = "As we were dissecting a former host monkey's fecal matter, I noticed a high concentration of banana matter, despite us not feeding them any for the past week."
	tier = 2
	unlocked_evolutions = list(/datum/borer_evolution/hivelord/produce_offspring)

/datum/borer_evolution/hivelord/blood_chemical/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	var/datum/action/cooldown/borer/learn_bloodchemical/attack_action = new()
	attack_action.Grant(cortical_owner)

// T3


/datum/borer_evolution/hivelord/produce_offspring
	name = "Produce Offspring"
	desc = "Produce an egg, which your host will vomit up."
	gain_text = "The way that a Cortical Borer produces an egg is a strange one. So far, we have not seen how it produces one, or it doing so outside a host."
	tier = 3
	mutually_exclusive = TRUE
	unlocked_evolutions = list(/datum/borer_evolution/hivelord/stealth_mode, /datum/borer_evolution/hivelord/torment)
	evo_cost = 3

/datum/borer_evolution/hivelord/produce_offspring/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	var/datum/action/cooldown/borer/produce_offspring/attack_action = new()
	attack_action.Grant(cortical_owner)


// T4 + TORMENT
/datum/borer_evolution/hivelord/stealth_mode
	name = "Stealth Mode"
	desc = "While in stealth mode, your presence is much less noticable in hosts, but you do not gain passive benefits."
	gain_text = "As I was writing my report one day, I noticed that one of the worms had slipped out of its cage and into a monkey without so much as a sound. Fascinating how they seem to know the importance of sound."
	tier = 4
	evo_cost = 2
	unlocked_evolutions = list(/datum/borer_evolution/hivelord/produce_offspring_alone)

/datum/borer_evolution/hivelord/stealth_mode/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	var/datum/action/cooldown/borer/stealth_mode/attack_action = new()
	attack_action.Grant(cortical_owner)


//Bubber addition
/datum/borer_evolution/hivelord/torment
	name = "Torment Host"
	desc = "Cause a host pain in order to stop them from disobeying you."
	gain_text = "Some worms seemed to writhe in their hosts, causing them to drop and scream for hours on end..."
	tier = 4
	evo_cost = 2

/datum/borer_evolution/hivelord/torment/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	var/datum/action/cooldown/borer/torment/attack_action = new()
	attack_action.Grant(cortical_owner)
//Addition end

// T5
/datum/borer_evolution/hivelord/produce_offspring_alone
	name = "Produce Offspring II"
	desc = "Allows you to produce eggs outside a host, in exchange for health and chemicals."
	gain_text = "One of the worms seems to have taken an... Alpha position in the hive, producing more eggs than the others. Most worryingly, eggs have shown up without them having a host, but I haven't *seen* them lay any..."
	evo_cost = 3
	tier = 5
	unlocked_evolutions = list(
		/datum/borer_evolution/sugar_immunity,
		/datum/borer_evolution/synthetic_borer,
		/datum/borer_evolution/synthetic_chems_positive,
		/datum/borer_evolution/synthetic_chems_negative,
	)

/datum/borer_evolution/hivelord/produce_offspring_alone/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.upgrade_flags |= BORER_ALONE_PRODUCTION
