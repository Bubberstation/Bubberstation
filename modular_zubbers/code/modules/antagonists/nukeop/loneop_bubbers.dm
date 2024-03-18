/datum/antagonist/bubbers_lone_op
	name = "\improper Opportunistic Operative"
	roundend_category = "traitors"
	antagpanel_category = ANTAG_GROUP_SYNDICATE
	show_in_antagpanel = TRUE
	antagpanel_category = "Other"
	antag_hud_name = "traitor"
	show_to_ghosts = TRUE
	job_rank = ROLE_OPERATIVE
	antag_moodlet = /datum/mood_event/focused
	hijack_speed = 0.5 //10 seconds per hijack stage by default
	default_custom_objective = "Steal the Nuke Disk. Punish the heads. Escape."
	ui_name = "AntagInfoTraitor"
	hardcore_random_bonus = TRUE
	preview_outfit = /datum/outfit/bubbers_lone_op

/datum/outfit/bubbers_lone_op
	name = "Nuclear Operative (Regular, Preview only)"

	back = /obj/item/mod/control/pre_equipped/empty
	uniform = /obj/item/clothing/under/syndicate
	l_hand = /obj/item/modular_computer/pda/nukeops
	r_hand = /obj/item/shield/energy

/datum/antagonist/bubbers_lone_op/on_gain()

	owner.special_role = job_rank

	owner.give_uplink(silent = TRUE, antag_datum = src)

	owner.equip_to_appropriate_slot(new /obj/item/pinpointer(get_turf(owner)), delete_on_fail = TRUE)

	generate_replacement_codes()

	. = ..()

/datum/antagonist/bubbers_lone_op/greet()
	. = ..()
	owner.announce_objectives()

/datum/antagonist/bubbers_lone_op/forge_objectives()

	//Copied from Highlander. Gets that fuckkin disk.
	var/datum/objective_item/steal/steal_objective = new
	steal_objective.owner = owner
	steal_objective.set_target(new /datum/objective_item/steal/nukedisc)
	objectives += steal_objective

	//Get all the minds of the crew.
	var/list/crewmember_minds = get_crewmember_minds()


	//List of possible kill targets.
	var/list/possible_targets = list()

	//Get everyone in view of the nuke disk. They are partially responsible, based on distance.
	if(steal_objective.target) //This should always pass, but you never know.
		for(var/mob/living/carbon/human/possible_sex_haver in view(steal_objective.target,5))
			if(!possible_sex_haver.mind)
				continue
			if(!(possible_sex_haver.mind in crewmember_minds))
				continue
			possible_targets[possible_sex_haver] = (5 - get_dist(possible_sex_haver,steal_objective.target)) * (30/5) //Between 30 and 150 points.
			if(length(possible_targets) > 4) //Prevents memes.
				break

	//Get everyone who is command. They are also responsible. Captains get a higher score.
	for(var/datum/mind/possible_command as anything in crewmember_minds)
		if(!ishuman(possible_command.current))
			continue
		if(possible_target.current.stat == DEAD)
			continue
		if(!(possible_target.assigned_role.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND))
			continue
		var/score_to_add = is_captain_job(possible_target) ? 69420 : 100 //69420 points if captain, 100 points if head. This ensure that a captain is always picked.
		if(possible_targets[possible_command.current])
			possible_targets[possible_command.current] += score_to_add*2 //Jesus christ dude.
		else
			possible_targets[possible_command.current] = score_to_add
		if(length(possible_targets) > 12) //Prevents memes.
			break

	//Add 1 kill objective, and an additional kill objective for every 4 potential targets after 4.
	for(var/i=1,i<=ceiling(length(possible_targets/4)),i++)
		var/datum/objective/mutiny/kill_objective = new
		var/mob/living/carbon/human/picked_human = pick_weight(possible_targets)
		kill_objective.owner = owner
		kill_objective.target = picked_human
		possible_targets -= picked_human
		objectives += kill_objective

	//Finally, add a hijack objective.
	var/datum/objective/hijack/hijack_objective = new
	hijack_objective.owner = owner
	objectives += hijack_objective


/datum/round_event_control/bubbers_lone_op
	name = "Opportunistic Operative Awakening"
	typepath = /datum/round_event/bubbers_lone_op
	max_occurrences = 1
	min_players = 30
	category = EVENT_CATEGORY_INVASION
	description = "A random crewmember becomes an Opportunistic Operative."

/datum/round_event/bubbers_lone_op
	fakeable = FALSE

/datum/round_event/bubbers_lone_op/start()

	for(var/mob/living/carbon/human/H in shuffle(GLOB.player_list))
		if(!H.client || !(ROLE_OPERATIVE in H.client.prefs.be_special) || !(ROLE_TRAITOR in H.client.prefs.be_special))
			continue
		if(H.stat == DEAD)
			continue
		if(!(H.mind.assigned_role.job_flags & JOB_CREW_MEMBER)) //only station jobs sans nonhuman roles, prevents ashwalkers trying to stalk with crewmembers they never met
			continue
		if(H.mind.has_antag_datum(/datum/antagonist/bubbers_lone_op))
			continue
		if(!H.get_organ_by_type(/obj/item/organ/internal/brain))
			continue
		H.add_antag_datum(/datum/antagonist/bubbers_lone_op)
		message_admins("[ADMIN_LOOKUPFLW(H)] has been made into an Opportunistic Operative by an event.")
		H.log_message("was made an Opportunistic Operative by an event.", LOG_GAME)
		break