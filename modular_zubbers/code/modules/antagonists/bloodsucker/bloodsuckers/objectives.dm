/*
 *	# Hide a random object somewhere on the station:
 *
 *	var/turf/targetturf = get_random_station_turf()
 *	var/turf/targetturf = get_safe_random_station_turf()
 */

/datum/objective/bloodsucker
	martyr_compatible = TRUE

// GENERATE
/datum/objective/bloodsucker/New()
	update_explanation_text()
	..()

//////////////////////////////////////////////////////////////////////////////
//	//							 PROCS 									//	//

/// Look at all crew members, and for/loop through.
/datum/objective/bloodsucker/proc/return_possible_targets()
	var/list/possible_targets = list()
	for(var/datum/mind/possible_target in get_crewmember_minds())
		// Check One: Default Valid User
		if(possible_target != owner && ishuman(possible_target.current) && possible_target.current.stat != DEAD)
			// Check Two: Am Bloodsucker?
			if(IS_BLOODSUCKER(possible_target.current))
				continue
			possible_targets += possible_target

	return possible_targets

/// Check Ghouls and get their occupations
/datum/objective/bloodsucker/proc/get_ghoul_occupations()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner.current)
	if(!bloodsuckerdatum || !bloodsuckerdatum.ghouls.len)
		return FALSE
	var/list/all_ghoul_jobs = list()
	var/ghoul_job
	for(var/datum/antagonist/ghoul/bloodsucker_ghouls in bloodsuckerdatum.ghouls)
		if(!bloodsucker_ghouls || !bloodsucker_ghouls.owner)	// Must exist somewhere, and as a ghoul.
			continue
		// Mind Assigned
		if(bloodsucker_ghouls.owner?.assigned_role)
			ghoul_job = bloodsucker_ghouls.owner.assigned_role
		// Mob Assigned
		else if(bloodsucker_ghouls.owner?.current?.job)
			ghoul_job = SSjob.get_job(bloodsucker_ghouls.owner.current.job)
		// PDA Assigned
		else if(bloodsucker_ghouls.owner?.current && ishuman(bloodsucker_ghouls.owner.current))
			var/mob/living/carbon/human/ghoul = bloodsucker_ghouls.owner.current
			ghoul_job = SSjob.get_job(ghoul.get_assignment())
		if(ghoul_job)
			all_ghoul_jobs += ghoul_job
	return all_ghoul_jobs

//////////////////////////////////////////////////////////////////////////////////////
//	//							 OBJECTIVES 									//	//
//////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////
//    DEFAULT OBJECTIVES    //
//////////////////////////////

/datum/objective/bloodsucker/haven
	name = "claimhaven"

// EXPLANATION
/datum/objective/bloodsucker/haven/update_explanation_text()
	explanation_text = "Create a haven by claiming a coffin, and protect it until the end of the shift."//  Make sure to keep it safe!"

// WIN CONDITIONS?
/datum/objective/bloodsucker/haven/check_completion()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner.current)
	if(bloodsuckerdatum && bloodsuckerdatum.coffin && bloodsuckerdatum.bloodsucker_haven_area)
		return TRUE
	return FALSE

/// Space_Station_13_areas.dm  <--- all the areas

//////////////////////////////////////////////////////////////////////////////////////

/datum/objective/survive/bloodsucker
	name = "bloodsuckersurvive"
	explanation_text = "Survive the entire shift without succumbing to Final Death."

/datum/objective/survive/bloodsucker/check_completion()
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/mind in owners)
		var/datum/antagonist/bloodsucker/vamp = IS_BLOODSUCKER(mind.current)
		if(!vamp)
			return FALSE
		if(!vamp.considered_alive(mind))
			return FALSE
	return TRUE

//////////////////////////////////////////////////////////////////////////////////////


/// Ghoulify a certain person / people
/datum/objective/bloodsucker/conversion
	name = "ghoulization"

/////////////////////////////////

// Ghoulify a head of staff
/datum/objective/bloodsucker/conversion/command
	name = "ghoulizationcommand"
	target_amount = 1

// EXPLANATION
/datum/objective/bloodsucker/conversion/command/update_explanation_text()
	explanation_text = "Guarantee a Ghoul ends up as a Department Head or in a Leadership role."

// WIN CONDITIONS?
/datum/objective/bloodsucker/conversion/command/check_completion()
	var/list/ghoul_jobs = get_ghoul_occupations()
	for(var/datum/job/checked_job in ghoul_jobs)
		if(checked_job.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND)
			return TRUE // We only need one, so we stop as soon as we get a match
	return FALSE

/////////////////////////////////

// Ghoulify crewmates in a department
/datum/objective/bloodsucker/conversion/department
	name = "ghoulify department"

	///The selected department we have to ghoulify.
	var/datum/job_department/target_department
	///List of all departments that can be selected for the objective.
	var/static/list/possible_departments = list(
		/datum/job_department/security,
		/datum/job_department/engineering,
		/datum/job_department/medical,
		/datum/job_department/science,
		/datum/job_department/cargo,
		/datum/job_department/service,
	)


// GENERATE!
/datum/objective/bloodsucker/conversion/department/New()
	target_department = SSjob.get_department_type(pick(possible_departments))
	target_amount = rand(2, 3)
	return ..()

// EXPLANATION
/datum/objective/bloodsucker/conversion/department/update_explanation_text()
	explanation_text = "Have [target_amount] Ghoul[target_amount == 1 ? "" : "s"] in the [target_department.department_name] department."
	return ..()

// WIN CONDITIONS?
/datum/objective/bloodsucker/conversion/department/check_completion()
	var/list/ghoul_jobs = get_ghoul_occupations()
	var/converted_count = 0
	for(var/datum/job/checked_job in ghoul_jobs)
		if(checked_job.departments_bitflags & target_department.department_bitflags)
			converted_count++
	if(converted_count >= target_amount)
		return TRUE
	return FALSE

	/**
	 * # IMPORTANT NOTE!!
	 *
	 * Look for Job Values on mobs! This is assigned at the start, but COULD be changed via the HoP
	 * ALSO - Search through all jobs (look for prefs earlier that look for all jobs, and search through all jobs to see if their head matches the head listed, or it IS the head)
	 * ALSO - registered_account in _vending.dm for banks, and assigning new ones.
	 */

//////////////////////////////////////////////////////////////////////////////////////

// NOTE: Look up /steal in objective.dm for inspiration.
/// Steal hearts. You just really wanna have some hearts.
/datum/objective/steal_n_of_type/hearts
	martyr_compatible = TRUE
	name = "heartthief"
	wanted_items = (/obj/item/organ/internal/heart)

// GENERATE!
/datum/objective/steal_n_of_type/hearts/New()
	amount = rand(2, 3)
	explanation_text = "Steal and keep [amount] organic hearts. Must be obtained from non-monkeys. Examine hearts thoroughly to see if they are valid."
	update_explanation_text()
	..()

/datum/objective/steal_n_of_type/hearts/check_if_valid_item(obj/item/organ/internal/heart/current_item)
	. = ..()
	if(current_item.type == /obj/item/organ/internal/heart/monkey || IS_ROBOTIC_ORGAN(current_item))
		return FALSE

//////////////////////////////////////////////////////////////////////////////////////

///Eat blood from a lot of people
/datum/objective/bloodsucker/gourmand
	name = "gourmand"

// GENERATE!
/datum/objective/bloodsucker/gourmand/New()
	target_amount = rand(800, 3 * BLOOD_VOLUME_NORMAL)
	..()

// EXPLANATION
/datum/objective/bloodsucker/gourmand/update_explanation_text()
	. = ..()
	explanation_text = "Using your Feed ability, drink [target_amount] units of Blood."

// WIN CONDITIONS?
/datum/objective/bloodsucker/gourmand/check_completion()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner.current)
	if(!bloodsuckerdatum)
		return FALSE
	var/stolen_blood = bloodsuckerdatum.total_blood_drank
	if(stolen_blood >= target_amount)
		return TRUE
	return FALSE

// HOW: Track each feed (if human). Count victory.



//////////////////////////////
//     CLAN OBJECTIVES      //
//////////////////////////////

/// Steal the Book of Nod - Nosferatu Clan objective
/datum/objective/bloodsucker/kindred
	name = "steal the Book of Nod"

// EXPLANATION
/datum/objective/bloodsucker/kindred/update_explanation_text()
	. = ..()
	explanation_text = "A Noddist Scholar has posted a bounty on SchreckNet for a scrap of the Book of Nod located in your sector. Their advise? Read a book."

// WIN CONDITIONS?
/datum/objective/bloodsucker/kindred/check_completion()
	if(!owner.current)
		return FALSE
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner.current)
	if(!bloodsuckerdatum)
		return FALSE

	for(var/datum/mind/bloodsucker_minds as anything in get_antag_minds(/datum/antagonist/bloodsucker))
		var/obj/item/book/kindred/the_book = locate() in bloodsucker_minds.current.get_all_contents()
		if(the_book)
			return TRUE
	return FALSE

//////////////////////////////////////////////////////////////////////////////////////

/// Max out a Tremere Power - Tremere Clan objective
/datum/objective/bloodsucker/tremere_power
	name = "tremerepower"
	var/power_level = TREMERE_OBJECTIVE_POWER_LEVEL

// EXPLANATION
/datum/objective/bloodsucker/tremere_power/update_explanation_text()
	explanation_text = "Your Regent is doubting your abilities, level some Blood Magic to [power_level] to prove them wrong! Remember that Ghoulifying gives more Ranks!"

// WIN CONDITIONS?
/datum/objective/bloodsucker/tremere_power/check_completion()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner.current)
	if(!bloodsuckerdatum)
		return FALSE
	for(var/datum/action/cooldown/bloodsucker/tremere_powers in bloodsuckerdatum.powers)
		if(tremere_powers.purchase_flags & TREMERE_CAN_BUY && tremere_powers.level_current >= power_level)
			return TRUE
	return FALSE

//////////////////////////////////////////////////////////////////////////////////////

/// Convert a crewmate - Ventrue Clan objective
/datum/objective/bloodsucker/embrace
	name = "embrace"

// EXPLANATION
/datum/objective/bloodsucker/embrace/update_explanation_text()
	. = ..()
	explanation_text = "Your Strategoi has granted you permission to embrace your favourite ghoul , use the Rack to 'level' them up."

// WIN CONDITIONS?
/datum/objective/bloodsucker/embrace/check_completion()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner.current)
	if(!bloodsuckerdatum)
		return FALSE
	for(var/datum/antagonist/bloodsucker/sired_vamp in GLOB.antagonists)
		if(sired_vamp.ventrue_sired == bloodsuckerdatum)
			return TRUE
	return FALSE



//////////////////////////////
// MONSTERHUNTER OBJECTIVES //
//////////////////////////////

/datum/objective/bloodsucker/monsterhunter
	name = "destroymonsters"

// EXPLANATION
/datum/objective/bloodsucker/monsterhunter/update_explanation_text()
	. = ..()
	explanation_text = "Destroy all monsters on [station_name()]."

// WIN CONDITIONS?
/datum/objective/bloodsucker/monsterhunter/check_completion()
	var/list/datum/mind/monsters = list()
	for(var/datum/antagonist/monster in GLOB.antagonists)
		var/datum/mind/brain = monster.owner
		if(!brain || brain == owner)
			continue
		if(brain.current.stat == DEAD)
			continue
		if(IS_HERETIC(brain.current) || IS_CULTIST(brain.current) || IS_BLOODSUCKER(brain.current) || IS_WIZARD(brain.current))
			monsters += brain
		if(brain.has_antag_datum(/datum/antagonist/changeling))
			monsters += brain

	return completed || !monsters.len



//////////////////////////////
//     GHOUL OBJECTIVES    //
//////////////////////////////

/datum/objective/bloodsucker/ghoul

// EXPLANATION
/datum/objective/bloodsucker/ghoul/update_explanation_text()
	. = ..()
	explanation_text = "Guarantee the success of your Master's mission!"

// WIN CONDITIONS?
/datum/objective/bloodsucker/ghoul/check_completion()
	var/datum/antagonist/ghoul/antag_datum = owner.has_antag_datum(/datum/antagonist/ghoul)
	return antag_datum.master?.owner?.current?.stat != DEAD



//////////////////////////////
//    REMOVED OBJECTIVES    //
// NOT GUARANTEED FUNCTIONAL//
//////////////////////////////

// NOTE: Look up /assassinate in objective.dm for inspiration.
/// Ghoulify a target.
/datum/objective/bloodsucker/ghoulhim
	name = "ghoulhim"
	var/target_department_type = FALSE

/datum/objective/bloodsucker/ghoulhim/New()
	var/list/possible_targets = return_possible_targets()
	find_target(possible_targets)
	..()

// EXPLANATION
/datum/objective/bloodsucker/ghoulhim/update_explanation_text()
	. = ..()
	if(target?.current)
		explanation_text = "Ensure [target.name], the [!target_department_type ? target.assigned_role.title : target.special_role], is Ghoulifyd via the Persuasion Rack."
	else
		explanation_text = "Free Objective"

/datum/objective/bloodsucker/ghoulhim/admin_edit(mob/admin)
	admin_simple_target_pick(admin)

// WIN CONDITIONS?
/datum/objective/bloodsucker/ghoulhim/check_completion()
	if(!target || target.has_antag_datum(/datum/antagonist/ghoul))
		return TRUE
	return FALSE
