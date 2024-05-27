/datum/antagonist/changeling_zombie

	name = "\improper Mutated Abomination"
	job_rank = ROLE_CHANGELING_ZOMBIE

	roundend_category = "changeling_zombie"
	antagpanel_category = "Changeling Zombie"

	show_in_antagpanel = TRUE

	hud_icon = 'modular_zubbers/code/modules/changeling_zombies/icons/antag_hud.dmi'
	antag_hud_name = "zombie"

	antag_memory = "You are a mutated Nanotrasen experiment. Your mind is torn apart, you do not remember who you are. \
	All you know is that you must kill. \
	Leave no one alive."

/datum/antagonist/changeling_zombie/on_gain()
	. = ..()
	var/component = owner.current?.GetComponent(/datum/component/changeling_zombie_infection)
	if(!component)
		owner.current?.AddComponent(/datum/component/changeling_zombie_infection)
	to_chat(owner, span_boldannounce(antag_memory))