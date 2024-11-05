#define GHOUL_SCAN_MIN_DISTANCE 5
#define GHOUL_SCAN_MAX_DISTANCE 500
/// 2s update time.
#define GHOUL_SCAN_PING_TIME 20

/datum/antagonist/ghoul
	name = "\improper Ghoul"
	roundend_category = "ghouls"
	antagpanel_category = "Bloodsucker"
	job_rank = ROLE_VASSAL
	antag_hud_name = "ghoul"
	show_in_roundend = FALSE
	hud_icon = 'modular_zubbers/icons/mob/huds/bloodsucker.dmi'
	ui_name = "AntagInfoGhoul"
	antag_panel_description = "You are a Ghoul, a mortal servant of a Bloodsucker."

	/// The Master Bloodsucker's antag datum.
	var/datum/antagonist/bloodsucker/master
	/// List of all Purchased Powers, to be cleaned up on antag removal.
	var/list/datum/action/powers = list()
	///Whether this ghoul is already a special type of Ghoul.
	var/special_type = FALSE
	///Description of what this Ghoul does.
	///  It's shown to the bloodsucker in the radial for setting ghoul type
	var/ghoul_description
	/// inherent traits that are removed and addded on antag datum loss and gain
	var/list/traits = list()

/datum/antagonist/ghoul/antag_panel_data()
	return "Master : [master?.owner.name ? master.owner.name : "Gone"]"

// todo make this into a shared proc that bloodsuckers and ghouls share
/datum/antagonist/ghoul/ui_static_data(mob/user)
	return ability_ui_data(powers) + ..()

/datum/antagonist/ghoul/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	current_mob.apply_status_effect(/datum/status_effect/agent_pinpointer/ghoul_edition)
	add_team_hud(current_mob)
	if(length(traits))
		current_mob.add_traits(traits, GHOUL_TRAIT)

/datum/antagonist/ghoul/add_team_hud(mob/target)
	QDEL_NULL(team_hud_ref)

	team_hud_ref = WEAKREF(target.add_alt_appearance(
		/datum/atom_hud/alternate_appearance/basic/has_antagonist,
		"antag_team_hud_[REF(src)]",
		hud_image_on(target),
	))

	var/datum/atom_hud/alternate_appearance/basic/has_antagonist/hud = team_hud_ref.resolve()

	var/list/mob/living/mob_list = list()
	mob_list += master.owner.current
	for(var/datum/antagonist/ghoul/ghoul as anything in master.ghouls)
		mob_list += ghoul.owner.current

	for (var/datum/atom_hud/alternate_appearance/basic/has_antagonist/antag_hud as anything in GLOB.has_antagonist_huds)
		if(!(antag_hud.target in mob_list))
			continue
		antag_hud.show_to(target)
		hud.show_to(antag_hud.target)

/datum/antagonist/ghoul/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	current_mob.remove_status_effect(/datum/status_effect/agent_pinpointer/ghoul_edition)
	if(length(traits))
		current_mob.remove_traits(traits, GHOUL_TRAIT)

/datum/antagonist/ghoul/pre_mindshield(mob/implanter, mob/living/mob_override)
	return COMPONENT_MINDSHIELD_PASSED

/// This is called when the antagonist is successfully mindshielded.
/datum/antagonist/ghoul/on_mindshield(mob/implanter, mob/living/mob_override)
	owner.remove_antag_datum(/datum/antagonist/ghoul)
	owner.current.log_message("has been deconverted from Ghouling by [implanter]!", LOG_ATTACK, color="#960000")
	return COMPONENT_MINDSHIELD_DECONVERTED

/datum/antagonist/ghoul/proc/on_examined(datum/source, mob/examiner, examine_text)
	SIGNAL_HANDLER
	var/ghoul_examine = return_ghoul_examine(examiner)
	if(ghoul_examine)
		examine_text += ghoul_examine


/datum/antagonist/ghoul/on_gain()
	RegisterSignal(owner.current, COMSIG_ATOM_EXAMINE, PROC_REF(on_examined))
	RegisterSignal(SSsunlight, COMSIG_SOL_WARNING_GIVEN, PROC_REF(give_warning))
	/// Enslave them to their Master
	if(!master || !istype(master, master))
		return
	if(special_type)
		if(!master.special_ghouls[special_type])
			master.special_ghouls[special_type] = list()
		master.special_ghouls[special_type] |= src
	master.ghouls += src
	owner.enslave_mind_to_creator(master.owner.current)
	owner.current.log_message("has been ghouled by [master.owner.current]!", LOG_ATTACK, color="#960000")
	/// Give Recuperate Power
	BuyPower(/datum/action/cooldown/bloodsucker/recuperate)
	/// Give Objectives
	var/datum/objective/bloodsucker/ghoul/ghoul_objective = new
	ghoul_objective.owner = owner
	objectives += ghoul_objective
	/// Give Vampire Language & Hud
	owner.current.grant_all_languages(FALSE, FALSE, TRUE)
	owner.current.grant_language(/datum/language/vampiric, ALL, LANGUAGE_MIND)
	return ..()

/datum/antagonist/ghoul/on_removal()
	UnregisterSignal(owner.current, COMSIG_ATOM_EXAMINE)
	UnregisterSignal(SSsunlight, COMSIG_SOL_WARNING_GIVEN)
	//Free them from their Master
	if(master && master.owner)
		if(special_type && master.special_ghouls[special_type])
			master.special_ghouls.Remove(special_type)
		master.ghouls -= src
		owner.enslaved_to = null
	//Remove ALL Traits, as long as its from BLOODSUCKER_TRAIT's source.
	for(var/all_status_traits in owner.current._status_traits)
		REMOVE_TRAIT(owner.current, all_status_traits, GHOUL_TRAIT)
	//Remove Recuperate Power
	remove_powers(powers)
	//Remove Language & Hud
	owner.current.remove_language(/datum/language/vampiric, ALL, LANGUAGE_MIND)
	return ..()

/datum/antagonist/ghoul/proc/remove_powers(list/removing_powers)
	for(var/datum/action/cooldown/bloodsucker/power as anything in removing_powers)
		removing_powers -= power
		if(!(power in owner.current.actions))
			continue
		power.Remove(owner.current)

/datum/antagonist/ghoul/on_body_transfer(mob/living/old_body, mob/living/new_body)
	. = ..()
	for(var/datum/action/cooldown/bloodsucker/all_powers as anything in powers)
		all_powers.Remove(old_body)
		all_powers.Grant(new_body)

/datum/antagonist/ghoul/greet()
	. = ..()
	if(silent)
		return

	to_chat(owner, span_userdanger("You are now the mortal servant of [master.owner.current], a Bloodsucker!"))
	to_chat(owner, span_boldannounce("The power of [master.owner.current.p_their()] immortal blood compels you to obey [master.owner.current.p_them()] in all things, even offering your own life to prolong theirs.\n\
		You are not required to obey any other Bloodsucker, for only [master.owner.current] is your master. The laws of Nanotrasen do not apply to you now; only your vampiric master's word must be obeyed."))
	owner.current.playsound_local(null, 'sound/effects/magic/mutate.ogg', 100, FALSE, pressure_affected = FALSE)
	antag_memory += "You, becoming the mortal servant of <b>[master.owner.current]</b>, a bloodsucking vampire!<br>"
	/// Message told to your Master.
	to_chat(master.owner, span_userdanger("[owner.current] has become addicted to your immortal blood. [capitalize(owner.current.p_they(TRUE))] [owner.current.p_are()] now your mortal servant!"))
	master.owner.current.playsound_local(null, 'sound/effects/magic/mutate.ogg', 100, FALSE, pressure_affected = FALSE)

/datum/antagonist/ghoul/farewell()
	if(silent)
		return

	owner.current.visible_message(
		span_deconversion_message("[owner.current]'s eyes dart feverishly from side to side, and then stop. [owner.current.p_they(TRUE)] seem[owner.current.p_s()] calm, \
			like [owner.current.p_they()] [owner.current.p_have()] regained some lost part of [owner.current.p_them()]self."), \
		span_deconversion_message("With a snap, you are no longer enslaved to [master.owner]! You breathe in heavily, having regained your free will."))
	owner.current.playsound_local(null, 'sound/effects/magic/mutate.ogg', 100, FALSE, pressure_affected = FALSE)
	/// Message told to your (former) Master.
	if(master && master.owner)
		to_chat(master.owner, span_cult_bold("You feel the bond with your ghoul [owner.current] has somehow been broken!"))

/datum/antagonist/ghoul/admin_add(datum/mind/new_owner, mob/admin)
	var/list/datum/mind/possible_vampires = list()
	for(var/datum/antagonist/bloodsucker/bloodsuckerdatums in GLOB.antagonists)
		var/datum/mind/vamp = bloodsuckerdatums.owner
		if(!vamp)
			continue
		if(!vamp.current)
			continue
		if(vamp.current.stat == DEAD)
			continue
		possible_vampires += vamp
	if(!length(possible_vampires))
		message_admins("[key_name_admin(admin)] tried ghoulizing [key_name_admin(new_owner)], but there were no bloodsuckers!")
		return
	var/datum/mind/choice = tgui_input_list(admin, "Which bloodsucker should this ghoul belong to?", "Bloodsucker", possible_vampires)
	if(!choice)
		return
	log_admin("[key_name_admin(admin)] turned [key_name_admin(new_owner)] into a ghoul of [key_name_admin(choice)]!")
	var/datum/antagonist/bloodsucker/vampire = IS_BLOODSUCKER(choice.current)
	master = vampire
	new_owner.add_antag_datum(src)
	to_chat(choice, span_notice("Through divine intervention, you've gained a new ghoul!"))
