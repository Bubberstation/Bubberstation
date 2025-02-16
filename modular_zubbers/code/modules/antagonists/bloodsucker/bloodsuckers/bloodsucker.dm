/datum/antagonist/bloodsucker
	name = "\improper Bloodsucker"
	show_in_antagpanel = TRUE
	roundend_category = "bloodsuckers"
	antagpanel_category = "Bloodsucker"
	job_rank = ROLE_BLOODSUCKER
	antag_hud_name = "bloodsucker"
	show_name_in_check_antagonists = TRUE
	can_coexist_with_others = FALSE
	hijack_speed = 0.5
	hud_icon = 'modular_zubbers/icons/mob/huds/bloodsucker.dmi'
	ui_name = "AntagInfoBloodsucker"
	preview_outfit = /datum/outfit/bloodsucker_outfit

	/// How much blood we have, starting off at default blood levels. Do not adjust this directly, use adjustBloodVolume(), and use getBloodVolume() to get the current value.
	VAR_PRIVATE/bloodsucker_blood_volume = BLOOD_VOLUME_NORMAL
	/// How much blood we can have without it deckaying quickly, increases per level.
	var/max_blood_volume = 600

	var/datum/bloodsucker_clan/my_clan

	// TIMERS //
	///Timer between alerts for Burn messages
	COOLDOWN_DECLARE(bloodsucker_spam_sol_burn)
	///Timer between alerts for Healing messages
	COOLDOWN_DECLARE(bloodsucker_spam_healing)
	/// Timer between exiting torpor
	COOLDOWN_DECLARE(bloodsucker_spam_torpor)

	///Used for assigning your name
	var/bloodsucker_name
	///Used for assigning your title
	var/bloodsucker_title
	///Used for assigning your reputation
	var/bloodsucker_reputation

	///Amount of Humanity lost, don't modify this directly, use AddHumanityLost(), and use GetHumanityLost() to get the current value.
	VAR_PRIVATE/humanity_lost = 0
	///Have we been broken the Masquerade?
	var/broke_masquerade = FALSE
	///How many Masquerade Infractions do we have?
	var/masquerade_infractions = 0
	///If we are currently in a Frenzy
	var/frenzied = FALSE
	/// sired by a ventrue
	var/ventrue_sired

	///ALL Powers currently owned
	var/list/datum/action/cooldown/bloodsucker/powers = list()

	///Ghouls under my control. Periodically remove the dead ones.
	var/list/datum/antagonist/ghoul/ghouls = list()
	///Special ghouls I own, to not have double of the same type.
	var/list/datum/antagonist/ghoul/special_ghouls = list()

	///How many ranks we have, don't modify this directly, use AdjustRank() and use GetRank() to get the current value.
	VAR_PRIVATE/bloodsucker_level = 0
	/// Unspent ranks, don't modify this directly, use AdjustUnspentRank() and use GetUnspentRank() to get the current value.
	VAR_PRIVATE/bloodsucker_level_unspent = 1
	var/additional_regen
	var/blood_over_cap = 0
	var/bloodsucker_regen_rate = 0.3

	// Used for Bloodsucker Objectives
	var/area/bloodsucker_haven_area
	var/obj/structure/closet/crate/coffin
	var/total_blood_drank = 0

	/// Used for Bloodsuckers gaining levels from drinking blood
	var/blood_level_gain = 0
	/// How many levels you can get from Sol
	var/sol_levels = 3

	///Blood display HUD
	var/atom/movable/screen/bloodsucker/blood_counter/blood_display
	///Vampire level display HUD
	var/atom/movable/screen/bloodsucker/rank_counter/vamprank_display

	/// Static typecache of all bloodsucker powers.
	var/static/list/all_bloodsucker_powers = typecacheof(/datum/action/cooldown/bloodsucker, ignore_root_path = TRUE)
	/// Antagonists that cannot be Ghouled no matter what
	var/static/list/ghoul_banned_antags = list(
		/datum/antagonist/bloodsucker,
		// /datum/antagonist/monsterhunter,
		/datum/antagonist/changeling,
		/datum/antagonist/cult,
		// /datum/antagonist/ert/safety_moth,
	)
	///Default Bloodsucker traits
	var/static/list/bloodsucker_traits = list(
		TRAIT_NOBREATH,
		TRAIT_SLEEPIMMUNE,
		TRAIT_NOCRITDAMAGE,
		TRAIT_RESISTCOLD,
		TRAIT_RADIMMUNE,
		TRAIT_STABLEHEART,
		TRAIT_NOSOFTCRIT,
		TRAIT_NOHARDCRIT,
		TRAIT_AGEUSIA,
		TRAIT_COLDBLOODED,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NO_MIRROR_REFLECTION,
		TRAIT_DRINKS_BLOOD,
		TRAIT_TOXIMMUNE,
		// Fun fact, toxins can still be applied to you if you loose your liver even with TOXIMMUNE
		TRAIT_STABLELIVER
	)
	var/static/biotype = MOB_VAMPIRIC

	var/list/body_signals = list(
		COMSIG_ATOM_EXAMINE = PROC_REF(on_examine),
		COMSIG_LIVING_LIFE = PROC_REF(LifeTick),
		COMSIG_LIVING_DEATH = PROC_REF(on_death),
		COMSIG_SPECIES_GAIN = PROC_REF(on_species_gain),
		COMSIG_QDELETING = PROC_REF(on_owner_deletion),
		COMSIG_ENTER_COFFIN = PROC_REF(on_enter_coffin),
		COMSIG_MOB_STAKED = PROC_REF(on_staked),
		COMSIG_CARBON_LOSE_ORGAN = PROC_REF(on_organ_removal),
		COMSIG_HUMAN_ON_HANDLE_BLOOD = PROC_REF(HandleBlood),
	)
	var/list/sol_signals = list(
		COMSIG_SOL_RANKUP_BLOODSUCKERS = PROC_REF(sol_rank_up),
		COMSIG_SOL_NEAR_START = PROC_REF(sol_near_start),
		COMSIG_SOL_END = PROC_REF(on_sol_end),
		COMSIG_SOL_RISE_TICK = PROC_REF(handle_sol),
		COMSIG_SOL_WARNING_GIVEN = PROC_REF(give_warning),
	)

/**
 * Apply innate effects is everything given to the mob
 * When a body is tranferred, this is called on the new mob
 * while on_gain is called ONCE per ANTAG, this is called ONCE per BODY.
 */
/datum/antagonist/bloodsucker/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/carbon/current_mob = mob_override || owner.current
	register_body_signals(current_mob)
	talking_head(current_mob)
	handle_clown_mutation(current_mob, mob_override ? null : "As a vampiric clown, you are no longer a danger to yourself. Your clownish nature has been subdued by your thirst for blood.")
	add_team_hud(current_mob)
	remove_invalid_quirks(current_mob)

	if(current_mob.hud_used)
		on_hud_created()
	else
		RegisterSignal(current_mob, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))
	if(ishuman(current_mob))
		current_mob?.dna?.species.on_bloodsucker_gain(current_mob)
#ifdef BLOODSUCKER_TESTING
	var/turf/user_loc = get_turf(current_mob)
	new /obj/structure/closet/crate/coffin(user_loc)
	new /obj/structure/bloodsucker/ghoulrack(user_loc)
#endif

/**
 * Remove innate effects is everything given to the mob
 * When a body is transferred, this is called on the old mob.
 * while on_removal is called ONCE per ANTAG, this is called ONCE per BODY.
 */
/datum/antagonist/bloodsucker/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/carbon/current_mob = mob_override || owner.current
	unregister_body_signals(current_mob)
	handle_clown_mutation(current_mob, removing = FALSE)
	if(current_mob.hud_used)
		var/datum/hud/hud_used = current_mob.hud_used
		hud_used.infodisplay -= blood_display
		hud_used.infodisplay -= vamprank_display
		QDEL_NULL(blood_display)
		QDEL_NULL(vamprank_display)

	SSsunlight.remove_sun_sufferer(current_mob) //check if sunlight should end
	if(iscarbon(current_mob))
		current_mob?.dna.species.on_bloodsucker_loss(current_mob)
	if(current_mob.client)
		// We need to let the bloodsucker antag datum get removed before we can re-add quirks
		addtimer(CALLBACK(SSquirks, TYPE_PROC_REF(/datum/controller/subsystem/processing/quirks, AssignQuirks), current_mob, current_mob.client), 1 SECONDS)


/datum/antagonist/bloodsucker/proc/on_hud_created(datum/source)
	SIGNAL_HANDLER
	var/datum/hud/bloodsucker_hud = owner.current.hud_used

	blood_display = new(null, bloodsucker_hud)
	bloodsucker_hud.infodisplay += blood_display

	vamprank_display = new(null, bloodsucker_hud)
	bloodsucker_hud.infodisplay += vamprank_display

	bloodsucker_hud.show_hud(bloodsucker_hud.hud_version)
	SSsunlight.add_sun_sufferer(owner.current)
	UnregisterSignal(owner.current, COMSIG_MOB_HUD_CREATED)
	update_blood_hud()
	update_rank_hud()

/// Override some properties of incompatible species
/datum/antagonist/bloodsucker/proc/on_species_gain(mob/living/carbon/human/target, datum/species/current_species, datum/species/old_species)
	SIGNAL_HANDLER
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/user = owner.current
	user?.dna?.species.on_bloodsucker_gain(target)

/datum/antagonist/bloodsucker/get_admin_commands()
	. = ..()
	.["Set blood level"] = CALLBACK(src, PROC_REF(admin_set_blood))
	.["Give Level"] = CALLBACK(src, PROC_REF(admin_rankup))
	// I know admins can technically do it via VV's dropdown, but it's super inconvenient.
	.["Give Power"] = CALLBACK(src, PROC_REF(admin_give_power))
	.["Remove Power"] = CALLBACK(src, PROC_REF(admin_remove_power))
	.["Set Power Level"] = CALLBACK(src, PROC_REF(admin_set_power_level))
	if(bloodsucker_level_unspent >= 1)
		.["Remove Level"] = CALLBACK(src, PROC_REF(RankDown))

	if(broke_masquerade)
		.["Fix Masquerade"] = CALLBACK(src, PROC_REF(fix_masquerade))
	else
		.["Break Masquerade"] = CALLBACK(src, PROC_REF(break_masquerade))

	if(my_clan)
		.["Remove Clan"] = CALLBACK(src, PROC_REF(remove_clan))
	else
		.["Add Clan"] = CALLBACK(src, PROC_REF(admin_set_clan))

///Called when you get the antag datum, called only ONCE per antagonist.
/datum/antagonist/bloodsucker/on_gain()
	if(!owner?.current)
		return ..()
	register_sol_signals()
	if(ventrue_sired) // sired bloodsuckers shouldnt be getting the same benefits as roundstart Bloodsuckers.
		bloodsucker_level_unspent = 0
	else
		// Start Sunlight if first Bloodsucker
		// Name and Titles
		SelectFirstName()
		SelectTitle(am_fledgling = TRUE)
		SelectReputation(am_fledgling = TRUE)
		// Objectives
		forge_bloodsucker_objectives()

	. = ..()
	// Assign Powers
	give_starting_powers()
	assign_starting_stats()

/// Called by the remove_antag_datum() and remove_all_antag_datums() mind procs for the antag datum to handle its own removal and deletion.
/datum/antagonist/bloodsucker/on_removal()
	free_all_ghouls()
	if(!owner?.current)
		return
	unregister_sol_signals()
	if(is_head(owner.current))
		cleanup_talking_head()
	if(ishuman(owner.current))
		var/mob/living/carbon/human/user = owner.current
		user?.dna?.species.regenerate_organs(user, null, TRUE)
	clear_powers_and_stats()
	ventrue_sired = null
	coffin?.unclaim_coffin(FALSE, TRUE)
	return ..()

/datum/antagonist/bloodsucker/on_body_transfer(mob/living/old_body, mob/living/new_body)
	. = ..()
	if(!old_body || !new_body)
		CRASH("Bloodsucker on_body_transfer called with null bodies!")
	for(var/datum/action/cooldown/bloodsucker/all_powers as anything in powers)
		if(old_body)
			all_powers.Remove(old_body)
		all_powers.Grant(new_body)
	var/obj/item/bodypart/old_left_arm = old_body?.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/old_right_arm = old_body?.get_bodypart(BODY_ZONE_R_ARM)
	var/old_left_arm_unarmed_damage_low
	var/old_left_arm_unarmed_damage_high
	var/old_right_arm_unarmed_damage_low
	var/old_right_arm_unarmed_damage_high
	if(old_body && ishuman(old_body))
		var/mob/living/carbon/human/old_user = old_body
		old_user.mob_biotypes &= ~biotype
		//Keep track of what they were
		old_left_arm_unarmed_damage_low = old_left_arm?.unarmed_damage_low
		old_left_arm_unarmed_damage_high = old_left_arm?.unarmed_damage_high
		old_right_arm_unarmed_damage_low = old_right_arm?.unarmed_damage_low
		old_right_arm_unarmed_damage_high = old_right_arm?.unarmed_damage_high
		//Then reset them
		if(old_left_arm)
			old_left_arm.unarmed_damage_low = initial(old_left_arm.unarmed_damage_low)
			old_left_arm.unarmed_damage_high = initial(old_left_arm.unarmed_damage_high)
		if(old_right_arm)
			old_right_arm.unarmed_damage_low = initial(old_right_arm.unarmed_damage_low)
			old_right_arm.unarmed_damage_high = initial(old_right_arm.unarmed_damage_high)
	if(ishuman(new_body))
		var/mob/living/carbon/human/new_user = new_body
		new_user.mob_biotypes |= biotype
		var/obj/item/bodypart/new_left_arm
		var/obj/item/bodypart/new_right_arm
		//Give old punch damage values
		new_left_arm = new_body?.get_bodypart(BODY_ZONE_L_ARM)
		new_right_arm = new_body?.get_bodypart(BODY_ZONE_R_ARM)
		if(old_left_arm)
			new_left_arm.unarmed_damage_low = old_left_arm_unarmed_damage_low
			new_left_arm.unarmed_damage_high = old_left_arm_unarmed_damage_high
		if(old_right_arm)
			new_right_arm.unarmed_damage_low = old_right_arm_unarmed_damage_low
			new_right_arm.unarmed_damage_high = old_right_arm_unarmed_damage_high

	//Give Bloodsucker Traits
	if(old_body)
		old_body.remove_traits(bloodsucker_traits, BLOODSUCKER_TRAIT)
	new_body.add_traits(bloodsucker_traits, BLOODSUCKER_TRAIT)

/datum/antagonist/bloodsucker/greet()
	. = ..()
	var/fullname = return_full_name()
	to_chat(owner, span_userdanger("You are [fullname], a strain of vampire known as a Bloodsucker!"))
	owner.announce_objectives()
	if(bloodsucker_level_unspent >= 2)
		to_chat(owner, span_announce("As a latejoiner, you have [bloodsucker_level_unspent] bonus Ranks, entering your claimed coffin allows you to spend a Rank."))
	owner.current.playsound_local(null, 'modular_zubbers/sound/bloodsucker/BloodsuckerAlert.ogg', 100, FALSE, pressure_affected = FALSE)
	antag_memory += "Although you were born a mortal, in undeath you earned the name <b>[fullname]</b>.<br>"

/datum/antagonist/bloodsucker/farewell()
	to_chat(owner.current, span_userdanger("<FONT size = 3>With a snap, your curse has ended. You are no longer a Bloodsucker. You live once more!</FONT>"))
	// Refill with Blood so they don't instantly die.
	if(!HAS_TRAIT(owner.current, TRAIT_NOBLOOD))
		owner.current.blood_volume = max(owner.current.blood_volume, BLOOD_VOLUME_NORMAL)

// Called when using admin tools to give antag status
/datum/antagonist/bloodsucker/admin_add(datum/mind/new_owner, mob/admin)
	var/levels = tgui_input_number(admin, "How many unspent Ranks would you like [new_owner] to have?","Bloodsucker Rank", GetUnspentRank(), 100, 0)
	var/msg = " made [key_name_admin(new_owner)] into \a [name]"
	if(levels > 1)
		bloodsucker_level_unspent = levels
		msg += " with [levels] extra unspent Ranks."
	message_admins("[key_name_admin(usr)][msg]")
	log_admin("[key_name(usr)][msg]")
	new_owner.add_antag_datum(src)

/datum/antagonist/bloodsucker/get_preview_icon()

	var/icon/final_icon = render_preview_outfit(/datum/outfit/bloodsucker_outfit)
	final_icon.Blend(icon('icons/effects/blood.dmi', "uniformblood"), ICON_OVERLAY)

	return finish_preview_icon(final_icon)

/datum/antagonist/bloodsucker/ui_static_data(mob/user)
	var/list/data = ability_ui_data(powers)
	//we don't need to update this that much.
	data["in_clan"] = !!my_clan
	var/list/clan_data = list()
	if(my_clan)
		clan_data["clan_name"] = my_clan.name
		clan_data["clan_description"] = my_clan.description
		clan_data["clan_icon"] = my_clan.join_icon_state

	data["clan"] += list(clan_data)

	return data + ..()

/datum/antagonist/bloodsucker/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/simple/bloodsucker_icons),
	)

/datum/antagonist/bloodsucker/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	switch(action)
		if("join_clan")
			if(my_clan)
				return
			assign_clan_and_bane()
			if(ui.closing)
				return
			ui.send_full_update(force = TRUE)

/datum/antagonist/bloodsucker/roundend_report()
	var/list/report = list()

	// Vamp name
	report += "<br><span class='header'><b>\[[return_full_name()]\]</b></span>"
	report += printplayer(owner)
	if(my_clan)
		report += "They were part of the <b>[my_clan.name]</b>!"

	// Default Report
	var/objectives_complete = TRUE
	if(objectives.len)
		report += printobjectives(objectives)
		for(var/datum/objective/objective in objectives)
			if(objective.objective_name == "Optional Objective")
				continue
			if(!objective.check_completion())
				objectives_complete = FALSE
				break

	// Now list their ghouls
	if(ghouls.len)
		report += "<span class='header'>Their Ghouls were...</span>"
		for(var/datum/antagonist/ghoul/all_ghouls as anything in ghouls)
			if(!all_ghouls.owner)
				continue
			var/list/ghoul_report = list()
			ghoul_report += "<b>[all_ghouls.owner.name]</b>"

			if(all_ghouls.owner.assigned_role)
				ghoul_report += " the [all_ghouls.owner.assigned_role.title]"
			if(IS_FAVORITE_GHOUL(all_ghouls.owner.current))
				ghoul_report += " and was the <b>Favorite Ghoul</b>"
			else if(IS_REVENGE_GHOUL(all_ghouls.owner.current))
				ghoul_report += " and was the <b>Revenge Ghoul</b>"
			report += ghoul_report.Join()

	if(objectives.len == 0 || objectives_complete)
		report += "<span class='greentext big'>The [name] was successful!</span>"
	else
		report += "<span class='redtext big'>The [name] has failed!</span>"

	return report.Join("<br>")

/datum/antagonist/bloodsucker/proc/give_starting_powers()
	for(var/datum/action/cooldown/bloodsucker/all_powers as anything in all_bloodsucker_powers)
		if(!(initial(all_powers.purchase_flags) & BLOODSUCKER_DEFAULT_POWER))
			continue
		BuyPower(all_powers)

/datum/antagonist/bloodsucker/proc/assign_starting_stats()
	//Traits: Species
	if(ishuman(owner.current))
		var/mob/living/carbon/human/user = owner.current
		var/obj/item/bodypart/user_left_arm = user.get_bodypart(BODY_ZONE_L_ARM)
		var/obj/item/bodypart/user_right_arm = user.get_bodypart(BODY_ZONE_R_ARM)
		user.dna?.remove_all_mutations()
		user_left_arm.unarmed_damage_low += 1 //lowest possible punch damage - 6 now
		user_left_arm.unarmed_damage_high += 1 //highest possible punch damage - 11
		user_right_arm.unarmed_damage_low += 1 //lowest possible punch damage - 6
		user_right_arm.unarmed_damage_high += 1 //highest possible punch damage - 11
		user.mob_biotypes |= biotype
	//Give Bloodsucker Traits
	owner.current.add_traits(bloodsucker_traits, BLOODSUCKER_TRAIT)
	//Clear Addictions
	for(var/addiction_type in subtypesof(/datum/addiction))
		owner.current.mind.remove_addiction_points(addiction_type, MAX_ADDICTION_POINTS)
	//No Skittish "People" allowed
	if(HAS_TRAIT(owner.current, TRAIT_SKITTISH))
		REMOVE_TRAIT(owner.current, TRAIT_SKITTISH, ROUNDSTART_TRAIT)
	// Tongue & Language
	owner.current.grant_language(/datum/language/vampiric, ALL, LANGUAGE_MIND)
	/// Clear Disabilities & Organs
	heal_vampire_organs()

/**
 * ##clear_power_and_stats()
 *
 * Removes all Bloodsucker related Powers/Stats changes, setting them back to pre-Bloodsucker
 * Order of steps and reason why:
 * Remove clan - Clans like Nosferatu give Powers on removal, we have to make sure this is given before removing Powers.
 * Powers - Remove all Powers, so things like Masquerade are off.
 * Species traits, Traits, Language - Misc stuff, has no priority.
 * Organs - At the bottom to ensure everything that changes them has reverted themselves already.
 * Update Sight - Done after Eyes are regenerated.
 */
/datum/antagonist/bloodsucker/proc/clear_powers_and_stats()
	// Remove clan first
	// if(my_clan)
	// 	QDEL_NULL(my_clan)
	// Powers
	for(var/datum/action/cooldown/bloodsucker/all_powers as anything in powers)
		RemovePower(all_powers)
	if(QDELETED(owner.current))
		return
	/// Stats
	if(ishuman(owner.current))
		var/mob/living/carbon/human/user = owner.current
		user.mob_biotypes &= ~biotype
		var/obj/item/bodypart/left_arm = user.get_bodypart(BODY_ZONE_L_ARM)
		var/obj/item/bodypart/right_arm = user.get_bodypart(BODY_ZONE_R_ARM)
		if(left_arm)
			left_arm.unarmed_damage_low = initial(left_arm.unarmed_damage_low)
			left_arm.unarmed_damage_high = initial(left_arm.unarmed_damage_high)
		if(right_arm)
			right_arm.unarmed_damage_low = initial(right_arm.unarmed_damage_low)
			right_arm.unarmed_damage_high = initial(right_arm.unarmed_damage_high)
	var/obj/item/bodypart/chest/target_chest = owner.current.get_bodypart(BODY_ZONE_CHEST)
	if(target_chest && target_chest.bodypart_flags & BODYPART_UNREMOVABLE)
		target_chest.bodypart_flags &= ~BODYPART_UNREMOVABLE
	// Remove all bloodsucker traits
	owner.current.remove_traits(bloodsucker_traits, BLOODSUCKER_TRAIT)
	// Language
	owner.current.remove_language(/datum/language/vampiric, ALL, LANGUAGE_MIND)
	// Heart & Eyes
	var/mob/living/carbon/user = owner.current
	var/obj/item/organ/internal/heart/newheart = owner.current.get_organ_slot(ORGAN_SLOT_HEART)
	if(newheart)
		newheart.Restart()
	var/obj/item/organ/internal/eyes/user_eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	if(user_eyes)
		user_eyes.flash_protect = initial(user_eyes.flash_protect)
		user_eyes.color_cutoffs = initial(user_eyes.color_cutoffs)
		user_eyes.sight_flags = initial(user_eyes.sight_flags)
	user.update_sight()

/datum/antagonist/bloodsucker/proc/remove_invalid_quirks(mob/target)
	var/datum/quirk/bad_quirk = owner.current.get_quirk(/datum/quirk/sol_weakness)
	if(!bad_quirk)
		return
	// silently remove the quirk if it's not valid
	bad_quirk.remove_from_current_holder(TRUE)
	owner.current.remove_quirk(/datum/quirk/sol_weakness)

/// Name shown on antag list
/datum/antagonist/bloodsucker/antag_listing_name()
	return ..() + "([return_full_name()])"

/// Whatever interesting things happened to the antag admins should know about
/// Include additional information about antag in this part
/datum/antagonist/bloodsucker/antag_listing_status()
	if(owner && !considered_alive(owner))
		return "<font color=red>Final Death</font>"
	return ..()

/datum/antagonist/bloodsucker/proc/considered_alive(datum/mind/player_mind, enforce_human)
	if(!player_mind?.current) // no owner.current means there is no body, thus we final-death'd
		return FALSE
	if(is_head(player_mind.current))
		return FALSE
	if(am_staked())
		return FALSE
	return TRUE

/datum/antagonist/bloodsucker/proc/forge_bloodsucker_objectives()
	// Claim a haven Objective
	var/datum/objective/bloodsucker/haven/haven_objective = new
	haven_objective.owner = owner
	objectives += haven_objective
	// Survive Objective
	var/datum/objective/survive/bloodsucker/survive_objective = new
	survive_objective.owner = owner
	objectives += survive_objective

	// Objective 1: Ghoulize a Head/Command, or a specific target
	switch(rand(1, 3))
		if(1) // Conversion Objective
			var/datum/objective/bloodsucker/conversion/chosen_subtype = pick(subtypesof(/datum/objective/bloodsucker/conversion))
			var/datum/objective/bloodsucker/conversion/conversion_objective = new chosen_subtype
			conversion_objective.owner = owner
			conversion_objective.objective_name = "Optional Objective"
			objectives += conversion_objective
		if(2) // Heart Thief Objective
			var/datum/objective/steal_n_of_type/hearts/heartthief_objective = new
			heartthief_objective.owner = owner
			heartthief_objective.objective_name = "Optional Objective"
			objectives += heartthief_objective
		if(3) // Drink Blood Objective
			var/datum/objective/bloodsucker/gourmand/gourmand_objective = new
			gourmand_objective.owner = owner
			gourmand_objective.objective_name = "Optional Objective"
			objectives += gourmand_objective
