/datum/station_trait/hos_ai
	name = "Head of Security AI"
	trait_type = STATION_TRAIT_NEGATIVE
	trait_flags = parent_type::trait_flags | STATION_TRAIT_REQUIRES_AI
	weight = 0
	show_in_report = TRUE
	report_message = "For experimental purposes, this station AI has been put in charge of the security department, Security Cyborgs are enabled for the duration of the shift. \
	Do not meddle with the silicon laws unless absolutely necessary, the AI is to be treated as a member of command, and your head of Security"
	blacklist = list(/datum/station_trait/job/human_ai, /datum/station_trait/unique_ai)
	trait_to_give = STATION_TRAIT_HOS_AI

/datum/station_trait/hos_ai/New()
	. = ..()
	SSstation.antag_restricted_roles += /datum/job/ai::title

/datum/station_trait/hos_ai/revert()
	SSstation.antag_restricted_roles -= /datum/job/ai::title
	return ..()

/datum/station_trait/hos_ai/on_round_start()
	. = ..()
	for(var/mob/living/silicon/ai/ai as anything in GLOB.ai_list)
		ai.show_laws()
