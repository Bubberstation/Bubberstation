/datum/antagonist/changeling_zombie

	name = "\improper Changeling Zombie"
	job_rank = ROLE_CHANGELING_ZOMBIE

	prevent_roundtype_conversion = FALSE
	can_coexist_with_others = TRUE
	replace_banned = FALSE
	show_to_ghosts = TRUE

	preview_outfit = /datum/outfit/changeling

	roundend_category = "changeling_zombie"
	antagpanel_category = "Changeling"

	show_in_antagpanel = TRUE

	hud_icon = 'modular_zubbers/icons/mob/huds/czombie.dmi'
	antag_hud_name = "zombie"

	antag_memory = "You are a mutated experiment, or a victim of one. Your mind is torn apart, you do not remember who you are. \
	All you know is that you must infect."

	default_custom_objective = "Infect as many crewmembers as possible!"

/datum/antagonist/changeling_zombie/on_gain()

	var/datum/component/changeling_zombie_infection/component
	if(owner.current)
		component = owner.current.GetComponent(/datum/component/changeling_zombie_infection) || (can_become_changeling_zombie(owner.current) ? owner.current.AddComponent(/datum/component/changeling_zombie_infection) : null)

	if(!component) //uhh
		stack_trace("Failed to give to changeling zombie component to \[[owner]\]!")
		return

	var/datum/objective/changeling_zombie_infect/infect_objective = new
	infect_objective.owner = owner
	objectives += infect_objective

	to_chat(owner, span_boldannounce(antag_memory))

	component.infect_objective = infect_objective

	. = ..()

/datum/objective/changeling_zombie_infect
	explanation_text = "Infect at least 5 other victims."
	var/required_infections = 5
	var/total_infections = 0

/datum/objective/changeling_zombie_infect/update_explanation_text()
	explanation_text = "Infect at least [required_infections] other victims."

/datum/objective/changeling_zombie_infect/check_completion()
	return total_infections >= required_infections
