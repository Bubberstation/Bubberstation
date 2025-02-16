/**
 * Revenge Ghoul
 *
 * Has the goal to 'get revenge' when their Master dies.
 */
/datum/antagonist/ghoul/revenge
	name = "\improper Revenge Ghoul"
	roundend_category = "abandoned Ghouls"
	show_in_roundend = FALSE
	show_in_antagpanel = FALSE
	antag_hud_name = "ghoul4"
	special_type = REVENGE_GHOUL
	ghoul_description = "The Revenge Ghoul will not deconvert on a Bloodsucker's Final Death, \
		instead they will gain all your Powers, and the objective to take revenge for your demise. \
		They additionally maintain Ghouls their Master's departure, rather than become aimless."

	///all ex-ghouls brought back into the fold.
	var/list/datum/antagonist/ex_ghoul/ex_ghouls = list()

/datum/antagonist/ghoul/revenge/roundend_report()
	var/list/report = list()
	report += printplayer(owner)
	if(objectives.len)
		report += printobjectives(objectives)

	// Now list their ghouls
	if(ex_ghouls.len)
		report += "<span class='header'>The Ghouls brought back into the fold were...</span>"
		for(var/datum/antagonist/ex_ghoul/all_ghouls as anything in ex_ghouls)
			if(!all_ghouls.owner)
				continue
			report += "<b>[all_ghouls.owner.name]</b> the [all_ghouls.owner.assigned_role.title]"

	return report.Join("<br>")

/datum/antagonist/ghoul/revenge/on_gain()
	. = ..()
	RegisterSignal(master, COMSIG_BLOODSUCKER_FINAL_DEATH, PROC_REF(on_master_death))

/datum/antagonist/ghoul/revenge/on_removal()
	UnregisterSignal(master, COMSIG_BLOODSUCKER_FINAL_DEATH)
	return ..()

/datum/antagonist/ghoul/revenge/proc/on_master_death(datum/antagonist/bloodsucker/bloodsuckerdatum, mob/living/carbon/master)
	SIGNAL_HANDLER

	show_in_roundend = TRUE
	for(var/datum/objective/all_objectives as anything in objectives)
		objectives -= all_objectives
	BuyPower(/datum/action/cooldown/bloodsucker/ghoul_blood)
	for(var/datum/action/cooldown/bloodsucker/master_powers as anything in bloodsuckerdatum.powers)
		if(master_powers.purchase_flags & BLOODSUCKER_DEFAULT_POWER)
			continue
		master_powers.Grant(owner.current)
		owner.current.remove_status_effect(/datum/status_effect/agent_pinpointer/ghoul_edition)

	var/datum/objective/survive/new_objective = new
	new_objective.name = "Avenge your Master"
	new_objective.explanation_text = "Avenge your Master's final death by felling the ones that killed them, recruiting their ex-ghouls and continuing their operations."
	new_objective.owner = owner
	objectives += new_objective

	antag_panel_title = "You are a Ghoul tasked with taking revenge for the death of your Master!"
	antag_panel_description = "You have gained your Master's old Powers, and a brand new \
		power. You will have to survive and maintain your old \
		Master's integrity. Bring their old Ghouls back into the \
		fold using your new Ability."
	update_static_data_for_all_viewers()
