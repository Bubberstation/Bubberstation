/// A global list of vampire antag datums in general
GLOBAL_LIST_EMPTY(all_vampires)

/datum/antagonist/vampire
	name = "\improper Vampire"
	roundend_category = "vampires"
	antagpanel_category = "Vampire"
	pref_flag = ROLE_VAMPIRE
	ui_name = "AntagInfoVampire"
	stinger_sound = 'modular_zubbers/sound/effects/vampires/lunge_warn.ogg'
	hud_icon = 'modular_zubbers/icons/mob/huds/vampire.dmi'
	antag_hud_name = "vampire"
	preview_outfit = /datum/outfit/vampire_outfit

	hijack_speed = 0

	show_to_ghosts = TRUE
	can_assign_self_objectives = TRUE

	/// How much blood we have, starting off at default blood levels.
	/// We don't use our actual body's temperature because some species don't have blood and we don't want to exclude them
	var/current_vitae = BLOOD_VOLUME_NORMAL
	/// How much blood we can have at once, increases per level.
	var/max_vitae = 600

	/// The vampire team, used for vassals
	var/datum/team/vampire/vampire_team
	/// The vampire's clan
	var/datum/vampire_clan/my_clan
	/// Our disciplines
	var/list/owned_disciplines = list()

	/// Timer between alerts for Healing messages
	COOLDOWN_DECLARE(vampire_spam_healing)

	/// Should we automatically forge objectives?
	var/should_forge_objectives = TRUE

	/// Flavor only
	var/vampire_name

	/// How many vampires we've diablerized, if any.
	var/diablerie_count = 0

	/// How many humanity points do we have? 0-10
	/// We actually always start with 7 and then add the clan's default humanity
	var/humanity = VAMPIRE_DEFAULT_HUMANITY

	/// Blood required to enter Frenzy
	var/frenzy_threshold = FRENZY_THRESHOLD_ENTER
	/// If we've already alerted the player about low blood
	var/low_blood_alerted = FALSE
	/// Cooldown for re-entering frenzy after we exit it, to prevent potential spam/loops.
	COOLDOWN_DECLARE(frenzy_cooldown)

	/// Goal of vitae required for the next level up
	var/current_vitae_goal = VITAE_GOAL_STANDARD
	/// progress to that goal
	var/vitae_goal_progress = 0
	/// To keep track of objective
	var/total_blood_drank = 0

	/// Powers currently owned
	var/list/datum/action/cooldown/vampire/powers = list()

	/// Vassals under my control. Periodically remove the dead ones.
	var/list/datum/antagonist/vassal/vassals = list()
	/// Minds that already earned us a free rank from being bonded, so freeing and re-bonding one can't farm levels.
	var/list/datum/weakref/ranked_vassal_minds = list()

	/// The rank this vampire is at, used to level abilities and strength up
	var/vampire_level = 0
	var/vampire_level_unspent = VAMPIRE_STARTING_LEVELS
	/// How many more "free" levels this vampire will get.
	var/free_levels_remaining = VAMPIRE_FREE_LEVELS

	/// If this guy has suffered final death.
	var/final_death = FALSE

	/// Additional regeneration when the vampire has a lot of blood
	var/additional_regen
	/// How much damage the vampire heals each life tick. Increases per rank up
	var/vampire_regen_rate = 0.3

	/// Minimum cooldown when reviving.
	COOLDOWN_DECLARE(revive_cooldown)
	/// When the last shared lockout on disabling powers runs out, so powers learned mid-lockout can join it.
	var/mind_lockout_end = 0

	/// How much more punch/kick damage the vampire gets per rank.
	var/extra_damage_per_rank = VAMPIRE_UNARMED_DMG_INCREASE_ON_RANKUP

	/// Haven
	var/area/vampire_haven_area
	var/obj/structure/closet/crate/coffin

	/// Blood display HUD
	var/atom/movable/screen/vampire/blood_counter/blood_display
	/// Vampire level display HUD
	var/atom/movable/screen/vampire/rank_counter/vamprank_display
	/// Vampire humanity display HUD
	var/atom/movable/screen/vampire/humanity_counter/humanity_display

	/// List of limbs we've applied modifications to.
	var/list/affected_limbs = list(
		BODY_ZONE_L_ARM = null,
		BODY_ZONE_R_ARM = null,
		BODY_ZONE_L_LEG = null,
		BODY_ZONE_R_LEG = null,
		BODY_ZONE_HEAD = null,
		BODY_ZONE_CHEST = null,
	)

	/// Static typecache of all vampire powers.
	var/static/list/all_vampire_powers = typecacheof(/datum/action/cooldown/vampire, ignore_root_path = TRUE)
	/// Antagonists that cannot be vassalized no matter what
	var/static/list/vassal_banned_antags = list(
		/datum/antagonist/vampire,
		/datum/antagonist/changeling,
		/datum/antagonist/cult,
		/datum/antagonist/clock_cultist,
	)

	/// List of traits that the Blush of Life ability does not remove.
	var/static/list/always_traits = list(
		TRAIT_DRINKS_BLOOD,
		TRAIT_GENELESS, // prevents vamps from having genes at all. blush of life will work around this being an antag test with TRAIT_FAKEGENES
		TRAIT_NO_DNA_COPY, // no, you can't cheat your curse with a cloner.
		TRAIT_NO_MINDSWAP, // mindswapping vampires is buggy af and I'm too lazy to properly fix it. ~Absolucy
	)

	/// List of traits applied inherently
	var/static/list/vampire_traits = list(
		TRAIT_AGEUSIA,
		TRAIT_COLD_BLOODED,
		TRAIT_HARDLY_WOUNDED,
		TRAIT_NOBREATH,
		TRAIT_NOCRITDAMAGE,
		TRAIT_NOHARDCRIT,
		TRAIT_NOSOFTCRIT,
		TRAIT_NO_MIRROR_REFLECTION,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_SLEEPIMMUNE,
		TRAIT_STABLEHEART,
		TRAIT_STABLELIVER,
		TRAIT_TOXIMMUNE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_XENO_IMMUNE, // something something facehuggers only latch onto living things
	)

	var/static/list/banned_quirks = typesof(/datum/quirk/item_quirk/addict) + list(
		/datum/quirk/skittish,
		/datum/quirk/hemophage,
	)

	/// Humanity gain tracking, when adding more, remember to add the type define
	var/humanity_petting_goal = 5
	var/humanity_art_goal = 2
	var/humanity_hugging_goal = 3
	var/list/humanity_trackgain_hugged = list()
	var/list/humanity_trackgain_petted = list()
	var/list/humanity_trackgain_art = list()

/datum/antagonist/vampire/proc/create_vampire_team()
	vampire_team = new(owner)
	vampire_team.name = "[ADMIN_LOOKUP(owner.current)]'s vampire team" // only displayed to admins
	vampire_team.master_vampire = src

/datum/team/vampire
	name = "vampire team"
	var/datum/antagonist/vampire/master_vampire

/datum/team/vampire/roundend_report()
	return

/**
 * Apply innate effects is everything given to the mob
 * When a body is tranferred, this is called on the new mob
 * while on_gain is called ONCE per ANTAG, this is called ONCE per BODY.
 */
/datum/antagonist/vampire/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	RegisterSignals(current_mob, list(COMSIG_MOB_LOGIN, COMSIG_MOVABLE_Z_CHANGED), PROC_REF(on_login))
	RegisterSignal(current_mob, COMSIG_LIVING_LIFE, PROC_REF(life_tick))
	RegisterSignal(current_mob, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(current_mob, COMSIG_ATOM_EXPOSE_REAGENTS, PROC_REF(after_expose_reagents))
	RegisterSignal(current_mob, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	RegisterSignal(current_mob, COMSIG_HUMAN_ON_HANDLE_BLOOD, PROC_REF(handle_blood))
	RegisterSignal(current_mob, COMSIG_MOB_UPDATE_SIGHT, PROC_REF(on_update_sight))
	RegisterSignal(current_mob, COMSIG_SPECIES_GAIN, PROC_REF(on_species_gain))

	RegisterSignal(current_mob, COMSIG_LIVING_PET_ANIMAL, PROC_REF(on_pet_animal))
	RegisterSignal(current_mob, COMSIG_LIVING_HUG_CARBON, PROC_REF(on_hug_carbon))
	RegisterSignal(current_mob, COMSIG_LIVING_APPRAISE_ART, PROC_REF(on_appraise_art))

	handle_clown_mutation(current_mob, "Your clownish nature has been subdued by your thirst for blood.")

	current_mob.update_sight()
	current_mob.clear_mood_event("vampcandle")

	add_team_hud(current_mob)

	current_mob.add_faction(FACTION_VAMPIRE)

	if(current_mob.hud_used)
		on_hud_created()
	else
		RegisterSignal(current_mob, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))

	if(ishuman(current_mob))
		var/mob/living/carbon/human/current_human = current_mob
		current_human.dna?.species?.on_vampire_gain(current_human)

	ensure_brain_nonvital(current_mob)
	setup_limbs(current_mob)
	setup_tracker(current_mob)

	MODIFY_PHYSIOLOGY(current_mob, STAMINA, VAMPIRE_INHERENT_STAMINA_RESIST)

	var/datum/dna/current_dna = current_mob.has_dna()
	current_dna?.remove_all_mutations()
	current_mob.add_traits(vampire_traits + always_traits, TRAIT_VAMPIRE)

	current_mob.grant_language(/datum/language/vampiric, source = LANGUAGE_VAMPIRE)

	my_clan?.apply_effects(current_mob)

/**
 * Remove innate effects is everything given to the mob
 * When a body is tranferred, this is called on the old mob.
 * while on_removal is called ONCE per ANTAG, this is called ONCE per BODY.
**/
/datum/antagonist/vampire/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	UnregisterSignal(current_mob, list(
		COMSIG_MOB_LOGIN,
		COMSIG_MOVABLE_Z_CHANGED,
		COMSIG_LIVING_LIFE,
		COMSIG_ATOM_EXAMINE,
		COMSIG_ATOM_EXPOSE_REAGENTS,
		COMSIG_LIVING_DEATH,
		COMSIG_HUMAN_ON_HANDLE_BLOOD,
		COMSIG_MOB_UPDATE_SIGHT,
		COMSIG_SPECIES_GAIN,
		COMSIG_LIVING_PET_ANIMAL,
		COMSIG_LIVING_HUG_CARBON,
		COMSIG_LIVING_APPRAISE_ART,
		COMSIG_MOB_HUD_CREATED,
	))
	current_mob.update_sight()
	current_mob.remove_traits(vampire_traits + always_traits, TRAIT_VAMPIRE)

	handle_clown_mutation(current_mob, removing = FALSE)

	cleanup_limbs(current_mob)
	cleanup_tracker()

	remove_hud_elements(current_mob)

	current_mob.remove_faction(FACTION_VAMPIRE)

	MODIFY_PHYSIOLOGY(current_mob, STAMINA, (1 / VAMPIRE_INHERENT_STAMINA_RESIST))

	if(QDELETED(current_mob))
		return
	my_clan?.remove_effects(current_mob)
	if(ishuman(current_mob))
		var/mob/living/carbon/human/current_human = current_mob
		current_human.dna?.species?.on_vampire_loss(current_human)

/datum/antagonist/vampire/proc/remove_hud_elements(mob/living/current_mob)
	var/datum/hud/hud_used = current_mob?.hud_used
	if(hud_used)
		for(var/atom/movable/screen/vampire/display in list(blood_display, vamprank_display, humanity_display))
			hud_used.remove_screen_object(display, update = FALSE)
		hud_used.show_hud(hud_used.hud_version)
	QDEL_NULL(blood_display)
	QDEL_NULL(vamprank_display)
	QDEL_NULL(humanity_display)

/datum/antagonist/vampire/proc/on_hud_created(datum/source)
	SIGNAL_HANDLER
	var/datum/hud/vampire_hud = owner.current.hud_used

	blood_display = new(null, vampire_hud)
	vampire_hud.add_screen_object(blood_display, null, HUD_GROUP_INFO)

	vamprank_display = new(null, vampire_hud)
	vampire_hud.add_screen_object(vamprank_display, null, HUD_GROUP_INFO)

	humanity_display = new(null, vampire_hud)
	vampire_hud.add_screen_object(humanity_display, null, HUD_GROUP_INFO)

	vampire_hud.show_hud(vampire_hud.hud_version)
	UnregisterSignal(owner.current, COMSIG_MOB_HUD_CREATED)
	update_hud()

/// Override some properties of incompatible species
/datum/antagonist/vampire/proc/on_species_gain(mob/living/carbon/human/target, datum/species/current_species, datum/species/old_species)
	SIGNAL_HANDLER
	current_species?.on_vampire_gain(target)

/datum/antagonist/vampire/get_admin_commands()
	. = ..()
	.["Level Add"] = CALLBACK(src, PROC_REF(rank_up), 1)

	if(vampire_level_unspent > 0)
		.["Level Deduct"] = CALLBACK(src, PROC_REF(rank_down))

	if(humanity > 0)
		.["Humanity Deduct"] = CALLBACK(src, PROC_REF(adjust_humanity), -1, FALSE)
	if(humanity < 10)
		.["Humanity Add"] = CALLBACK(src, PROC_REF(adjust_humanity), 1, FALSE)

/datum/antagonist/vampire/on_gain()
	// Set name and reputation
	select_first_name()

	// Objectives
	if(should_forge_objectives)
		forge_objectives()

	. = ..()
	ADD_TRAIT(owner, TRAIT_VAMPIRE_ALIGNED, REF(src))

	var/datum/action/antag_info/info_button = info_button_ref?.resolve()
	if(info_button)
		info_button.background_icon = 'modular_zubbers/icons/mob/actions/actions_vampire.dmi'
		info_button.background_icon_state = "vamp_power_off"
		info_button.build_all_button_icons(UPDATE_BUTTON_BACKGROUND)

	RegisterSignal(src, COMSIG_VAMPIRE_TRACK_HUMANITY_GAIN, PROC_REF(on_track_humanity_gain_signal))
	RegisterSignals(owner, list(COMSIG_ANTAGONIST_GAINED, COMSIG_ANTAGONIST_REMOVED), PROC_REF(on_login))

	for(var/recipe in list(
		/datum/crafting_recipe/vassalrack,
		/datum/crafting_recipe/candelabrum,
		/datum/crafting_recipe/bloodthrone,
		/datum/crafting_recipe/meatcoffin,
	))
		owner.teach_crafting_recipe(recipe)

	create_vampire_team()

	// Assign starting stats skill point.
	give_starting_powers()
	GLOB.all_vampires += src
	SSvampire_leveling.check_enable()

	if(!QDELETED(owner.current))
		for(var/quirk_type in banned_quirks)
			owner.current.remove_quirk(quirk_type)

#ifdef VAMPIRE_TESTING
	var/turf/user_loc = get_turf(owner.current)
	new /obj/structure/closet/crate/coffin(user_loc)
	new /obj/structure/vampire/vassalrack(user_loc)
#endif

/datum/antagonist/vampire/on_removal()
	REMOVE_TRAIT(owner, TRAIT_VAMPIRE_ALIGNED, REF(src))
	UnregisterSignal(owner, list(
		COMSIG_ANTAGONIST_GAINED,
		COMSIG_ANTAGONIST_REMOVED,
	))

	for(var/recipe in list(
		/datum/crafting_recipe/vassalrack,
		/datum/crafting_recipe/candelabrum,
		/datum/crafting_recipe/bloodthrone,
		/datum/crafting_recipe/meatcoffin,
	))
		owner.forget_crafting_recipe(recipe)

	clear_powers_and_stats()
	GLOB.all_vampires -= src
	SSvampire_leveling.check_enable()

	if(iscarbon(owner.current))
		var/mob/living/carbon/carbon_owner = owner.current
		var/obj/item/organ/brain/not_vamp_brain = carbon_owner.get_organ_slot(ORGAN_SLOT_BRAIN)
		if(not_vamp_brain && (not_vamp_brain.decoy_override != initial(not_vamp_brain.decoy_override)))
			not_vamp_brain.organ_flags |= ORGAN_VITAL
			not_vamp_brain.decoy_override = FALSE

	if(owner.current?.client)
		addtimer(CALLBACK(SSquirks, TYPE_PROC_REF(/datum/controller/subsystem/processing/quirks, AssignQuirks), owner.current, owner.current.client), 1 SECONDS)

	return ..()

/datum/antagonist/vampire/on_body_transfer(mob/living/old_body, mob/living/new_body)
	. = ..()

	// Transfer powers
	for(var/datum/action/cooldown/vampire/all_powers in powers)
		if(old_body)
			if(all_powers.currently_active)
				all_powers.deactivate_power()
			all_powers.Remove(old_body)
		all_powers.Grant(new_body)

	// Vampire Traits
	old_body?.remove_traits(vampire_traits + always_traits, TRAIT_VAMPIRE)
	new_body.add_traits(vampire_traits + always_traits, TRAIT_VAMPIRE)

	addtimer(CALLBACK(src, TYPE_PROC_REF(/datum/antagonist, add_team_hud), new_body), 0.5 SECONDS, TIMER_OVERRIDE | TIMER_UNIQUE) //i don't trust this to not act weird

/datum/antagonist/vampire/greet()
	if(silent)
		return
	var/fullname = return_full_name()
	var/list/msg = list()

	msg += span_cult_large("You are a Vampire!\n")
	msg += span_cult("Open the Vampire Information panel for information about your Powers, Clan, and more. \n\n\
			You can also click on all of your hud meters for more information about them!")

	to_chat(owner, boxed_message(msg.Join("\n")))
	play_stinger()

	if(should_forge_objectives)
		owner.announce_objectives()
	antag_memory += "Although you were born a mortal, in undeath you earned the name <b>[fullname]</b>.<br>"

/datum/antagonist/vampire/farewell()
	to_chat(owner.current, span_userdanger("With a snap, your curse has ended. You are no longer a Vampire. You live once more!"))
	// Refill with Blood so they don't instantly die.
	if(!HAS_TRAIT(owner.current, TRAIT_NOBLOOD))
		owner.current.set_blood_volume(max(owner.current.blood_volume, BLOOD_VOLUME_NORMAL))

// Called when using admin tools to give antag status
/datum/antagonist/vampire/admin_add(datum/mind/new_owner, mob/admin)
	var/levels = tgui_input_number(admin, "How many unspent Ranks would you like [new_owner] to have?", "Vampire Rank", vampire_level_unspent, 100, 0)
	var/msg = "made [key_name_admin(new_owner)] into \a [name]"
	if(levels > 0)
		vampire_level_unspent = levels
		msg += " with [levels] extra unspent Ranks."
	message_admins("[key_name_admin(usr)] [msg]")
	log_admin("[key_name(usr)] [msg]")
	new_owner.add_antag_datum(src)

/datum/antagonist/vampire/ui_data(mob/user)
	return list(
		"vassal_count" = count_vassals(),
		"max_vassals" = max_vampire_vassals(),
	)

/datum/antagonist/vampire/ui_static_data(mob/user)
	. = ..()

	//we don't need to update this that much.
	.["in_clan"] = !!my_clan
	var/list/clan_data = list()
	if(my_clan)
		clan_data["name"] = my_clan.name
		clan_data["description"] = my_clan.description
		clan_data["icon"] = my_clan.join_icon
		clan_data["icon_state"] = my_clan.join_icon_state

	.["clan"] += list(clan_data)

	for(var/datum/action/cooldown/vampire/power as anything in powers)
		var/list/power_data = list()

		power_data["name"] = power.name
		power_data["explanation"] = jointext(power.get_power_explanation(), "\n")
		power_data["icon"] = power.button_icon
		power_data["icon_state"] = power.button_icon_state

		power_data["cost"] = power.vitaecost ? power.vitaecost : "0"
		power_data["constant_cost"] = power.constant_vitaecost ? power.constant_vitaecost : "0"
		power_data["cooldown"] = power.cooldown_time / 10

		.["powers"] += list(power_data)

/datum/antagonist/vampire/get_preview_icon()
	var/datum/universal_icon/final_icon = render_preview_outfit(preview_outfit)
	var/datum/universal_icon/blood_icon = uni_icon('icons/effects/blood.dmi', "uniformblood")
	blood_icon.blend_color(BLOOD_COLOR_RED, ICON_MULTIPLY)
	final_icon.blend_icon(blood_icon, ICON_OVERLAY)

	return finish_preview_icon(final_icon)

/datum/antagonist/vampire/roundend_report()
	var/list/report = list()

	// Vamp name
	report += "<br>[span_header(return_full_name())]"
	report += printplayer(owner)
	if(my_clan)
		report += "They were part of the <b>[my_clan.name]</b>!"

	// Default Report
	var/objectives_complete = TRUE
	if(length(objectives))
		report += printobjectives(objectives)
		for(var/datum/objective/objective in objectives)
			if(!objective.check_completion())
				objectives_complete = FALSE
				break

	// Now list their vassals
	if(length(vassals))
		report += span_header("<br>Their vassals were...")
		var/list/vassal_minds = list()
		for(var/datum/antagonist/vassal/vassal in vassals)
			vassal_minds += vassal.owner
		report += printplayerlist(vassal_minds)

	if(objectives_complete)
		report += span_greentext(span_big("The [name] was successful!"))
	else
		report += span_redtext(span_big("The [name] has failed!"))

	return report.Join("<br>")

/datum/antagonist/vampire/hijack_speed()
	. = ..()
	if(istype(my_clan, /datum/vampire_clan/malkavian)) // the voices told them to do it
		return max(., 1)

/// "Oh, well, that's step one. What about two through ten?"
/// Beheading vampires is kinda buggy and results in them being dead-dead without actually being final deathed, which is NOT something that's desired.
/// Just stake them. No shortcuts.
/datum/antagonist/vampire/proc/ensure_brain_nonvital(mob/living/mob_override)
	var/mob/living/carbon/carbon_owner = mob_override || owner.current
	if(!iscarbon(carbon_owner))
		return
	var/obj/item/organ/brain/brain = carbon_owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(QDELETED(brain))
		return
	brain.organ_flags &= ~ORGAN_VITAL
	brain.decoy_override = TRUE


/datum/antagonist/vampire/proc/give_starting_powers()
	for(var/datum/action/cooldown/vampire/all_powers as anything in all_vampire_powers)
		if(!(initial(all_powers.special_flags) & VAMPIRE_DEFAULT_POWER))
			continue
		grant_power(new all_powers)

/**
 * ##clear_power_and_stats()
 *
 * Removes all Vampire related Powers/Stats changes, setting them back to pre-Vampire
 * Order of steps and reason why:
 * Remove clan - Clans like Nosferatu give Powers on removal, we have to make sure this is given before removing Powers.
 * Powers - Remove all Powers, so things like Blush of Life are off.
 * Species traits, Traits, MaxHealth, Language - Misc stuff, has no priority.
 * Organs - At the bottom to ensure everything that changes them has reverted themselves already.
 * Update Sight - Done after Eyes are regenerated.
 */
/datum/antagonist/vampire/proc/clear_powers_and_stats()
	var/mob/living/carbon/user = owner.current

	// Remove clan first
	if(my_clan)
		if(!QDELETED(user))
			my_clan.remove_effects(user)
		QDEL_NULL(my_clan)

	// Powers
	for(var/datum/action/cooldown/vampire/all_powers as anything in powers)
		remove_power(all_powers)

	if(QDELETED(user))
		return

	// Remove all vampire traits
	user.remove_traits(vampire_traits + always_traits, TRAIT_VAMPIRE)

	// Update Health
	user.setMaxHealth(initial(user.maxHealth))

	// Language
	user.remove_language(/datum/language/vampiric, source = LANGUAGE_VAMPIRE)

	// Heart
	var/obj/item/organ/heart/newheart = user.get_organ_slot(ORGAN_SLOT_HEART)
	newheart?.Restart()

/datum/antagonist/vampire/proc/claim_coffin(obj/structure/closet/crate/claimed)
	var/static/list/always_valid_areas_typecache = typecacheof(list(/area/shuttle/custom))
	var/static/list/banned_areas_typecache
	if(isnull(banned_areas_typecache))
		banned_areas_typecache = typecacheof(list(
			/area/icemoon,
			/area/lavaland,
			/area/ocean,
			/area/space,
		))

	// ALREADY CLAIMED
	if(claimed.resident)
		if(claimed.resident == owner)
			to_chat(owner, span_notice("This is your [claimed]."))
		else
			to_chat(owner, span_warning("This [claimed] has already been claimed by another."))
		return FALSE
	var/turf/coffin_turf = get_turf(claimed)
	var/area/current_area = get_area(coffin_turf)
	// this if check is split up bc it's annoying to read and mentally parse when it's combined into one big if statement
	var/valid_haven_area = TRUE
	if(!coffin_turf)
		valid_haven_area = FALSE
	else if(!is_type_in_typecache(current_area, always_valid_areas_typecache))
		if(istype(current_area, /area/centcom) || is_type_in_typecache(current_area, banned_areas_typecache) || (istype(current_area, /area/ruin) && current_area.outdoors))
			valid_haven_area = FALSE
	if(!valid_haven_area)
		claimed.balloon_alert(owner.current, "ineligible area!")
		return
	// This is my Haven
	coffin = claimed
	coffin.resident = owner
	vampire_haven_area = current_area

	if(!(locate(/datum/action/cooldown/vampire/gohome) in powers))
		grant_power(new /datum/action/cooldown/vampire/gohome)

	to_chat(owner, span_userdanger("You have claimed [claimed] as your place of immortal rest! Your haven is now [vampire_haven_area]."))
	return TRUE

/// Name shown on antag list
/datum/antagonist/vampire/antag_listing_name()
	return ..() + return_full_name()

/datum/antagonist/vampire/add_team_hud(mob/target, antag_to_check)
	antag_hud_name = my_clan?.antag_hud_icon || initial(antag_hud_name)

	QDEL_NULL(team_hud_ref)

	var/datum/atom_hud/alternate_appearance/basic/has_antagonist/hud = target.add_alt_appearance(
		/datum/atom_hud/alternate_appearance/basic/has_antagonist,
		"antag_team_hud_[REF(src)]",
		hud_image_on(target),
	)
	team_hud_ref = WEAKREF(hud)

	var/list/mob/living/mob_list = list()
	for(var/datum/antagonist/antag as anything in GLOB.antagonists)
		if(!istype(antag, /datum/antagonist/vampire) && !istype(antag, /datum/antagonist/vassal))
			continue
		var/mob/living/current = antag.owner?.current
		if(!QDELETED(current))
			mob_list |= current

	for (var/datum/atom_hud/alternate_appearance/basic/has_antagonist/antag_hud as anything in GLOB.has_antagonist_huds)
		if(!(antag_hud.target in mob_list))
			continue
		antag_hud.show_to(target)
		hud.show_to(antag_hud.target)


/**
 * Every vampire has 3 starting objective categories:
 * Ego: Grow more powerful / strengthen your position / etc
 * Hedonism: Indulge in bad things that feel all too right.
 * Survival: Survive. Obviously.
 */
/datum/antagonist/vampire/forge_objectives()
	var/datum/objective/vampire/extra_objective

	if(prob(80))
		extra_objective = new /datum/objective/vampire/ego/vassals
	else
		extra_objective = new /datum/objective/vampire/ego/department_vassal

	extra_objective.owner = owner
	objectives += extra_objective

	//pick Hedonism objective
	switch(rand(1, 2))
		if(1)
			extra_objective = new /datum/objective/vampire/hedonism/gourmand
		if(2)
			extra_objective = new /datum/objective/vampire/hedonism/thirster

	extra_objective.owner = owner
	objectives += extra_objective

	// Survive Objective
	var/datum/objective/survive/vampire/survive_objective = new
	survive_objective.owner = owner
	objectives += survive_objective

/// Use this instead of `length(vassals)`, as it won't count round removed vassals and such.
/datum/antagonist/vampire/proc/count_vassals(only_living = FALSE)
	. = 0
	for(var/datum/antagonist/vassal/vassal as anything in vassals)
		var/mob/living/vassal_body = vassal.owner.current
		if(QDELETED(vassal_body))
			continue
		if(only_living && !considered_alive(vassal.owner))
			continue
		if(!HAS_TRAIT(vassal_body, TRAIT_MIND_TEMPORARILY_GONE))
			if(vassal_body.stat == DEAD)
				if(HAS_TRAIT(vassal_body, TRAIT_DEFIB_BLACKLISTED))
					continue
				if(!vassal_body.key)
					var/mob/dead/observer/vassal_ghost = vassal_body.get_ghost(TRUE, TRUE)
					if(isnull(vassal_ghost) || (istype(vassal_ghost) && !vassal_ghost.can_reenter_corpse)) // soulcatcher shitcode workaround
						continue
			else if(!vassal_body.key)
				continue
		.++

/datum/antagonist/vampire/proc/on_examine(datum/source, mob/examiner, list/examine_text)
	SIGNAL_HANDLER
	if(is_deathly_pale(examiner))
		examine_text += span_warning("[owner.current.p_They()] [owner.current.p_are()] deathly pale.")

	var/text = "<img class='icon' src='\ref['modular_zubbers/icons/obj/antags/vampire/vampiric.dmi']?state=vampire'> "

	if(IS_VASSAL(examiner) in vassals)
		text += span_vampire_master("<EM>This is, [return_full_name()] your Master!</EM>")
		examine_text += text
		return

	if(HAS_MIND_TRAIT(examiner, TRAIT_VAMPIRE_ALIGNED))

		if(my_clan)
			text += span_cult("<EM>[return_full_name()], of the [my_clan].</EM>")
		else
			text += span_cult("<EM>[return_full_name()], a disgusting caitiff thinblood.</EM>")

		examine_text += text

	if(diablerie_count > 0 && HAS_TRAIT(examiner, TRAIT_SEE_DIABLERIE))
		examine_text += span_cult_large("<br><EM>You can see the corrupted marks of a diablerist in [owner.current.p_their()] aura!</EM>")

/// Low humanity shows on the skin, unless every body part is covered. Rock bottom shows from across the room.
/datum/antagonist/vampire/proc/is_deathly_pale(mob/examiner)
	if(humanity >= VAMPIRE_LOW_HUMANITY || !iscarbon(owner.current))
		return FALSE
	var/mob/living/carbon/pale_body = owner.current
	var/all_covered = HEAD | CHEST | GROIN | ARMS | HANDS | LEGS | FEET
	if((pale_body.get_all_covered_flags() & all_covered) == all_covered)
		return FALSE
	return humanity <= VAMPIRE_HUMANITY_MONSTROUS || get_dist(examiner, pale_body) <= 2

/datum/antagonist/vampire/proc/setup_limbs(mob/living/carbon/target)
	if(!iscarbon(target))
		return
	RegisterSignal(target, COMSIG_CARBON_POST_ATTACH_LIMB, PROC_REF(register_limb))
	RegisterSignal(target, COMSIG_CARBON_POST_REMOVE_LIMB, PROC_REF(unregister_limb))
	for(var/body_part in affected_limbs)
		var/obj/item/bodypart/limb = target.get_bodypart(check_zone(body_part))
		if(limb)
			register_limb(target, limb)

/datum/antagonist/vampire/proc/cleanup_limbs(mob/living/carbon/target)
	if(!iscarbon(target))
		return
	UnregisterSignal(target, list(COMSIG_CARBON_POST_ATTACH_LIMB, COMSIG_CARBON_POST_REMOVE_LIMB))
	for(var/body_part in affected_limbs)
		var/obj/item/bodypart/limb = target.get_bodypart(check_zone(body_part))
		if(limb)
			unregister_limb(target, limb)

/datum/antagonist/vampire/proc/register_limb(mob/living/carbon/limb_owner, obj/item/bodypart/new_limb, special)
	SIGNAL_HANDLER

	affected_limbs[new_limb.body_zone] = new_limb
	RegisterSignal(new_limb, COMSIG_QDELETING, PROC_REF(limb_gone))

	// if the limb has reduced burn damage, offset that.
	if(initial(new_limb.burn_modifier) < 1)
		new_limb.burn_modifier /= initial(new_limb.burn_modifier)

	if(new_limb.body_zone in GLOB.limb_zones)
		var/extra_damage = 1 + (vampire_level * extra_damage_per_rank)
		new_limb.unarmed_damage_low += extra_damage
		new_limb.unarmed_damage_high += extra_damage

/datum/antagonist/vampire/proc/unregister_limb(mob/living/carbon/limb_owner, obj/item/bodypart/lost_limb, special)
	SIGNAL_HANDLER

	affected_limbs[lost_limb.body_zone] = null
	UnregisterSignal(lost_limb, COMSIG_QDELETING)

	// undo any offset we've done to reduce limb burn damage.
	if(initial(lost_limb.burn_modifier) < 1)
		lost_limb.burn_modifier *= initial(lost_limb.burn_modifier)

	if(lost_limb.body_zone in GLOB.limb_zones)
		var/extra_damage = 1 + (vampire_level * extra_damage_per_rank)
		// safety measure in case we ever accidentally fuck up the math or something
		lost_limb.unarmed_damage_low = max(lost_limb.unarmed_damage_low - extra_damage, initial(lost_limb.unarmed_damage_low))
		lost_limb.unarmed_damage_high = max(lost_limb.unarmed_damage_high - extra_damage, initial(lost_limb.unarmed_damage_high))

/datum/antagonist/vampire/proc/limb_gone(obj/item/bodypart/deleted_limb)
	SIGNAL_HANDLER
	if(affected_limbs[deleted_limb.body_zone])
		affected_limbs[deleted_limb.body_zone] = null
		UnregisterSignal(deleted_limb, COMSIG_QDELETING)

/datum/antagonist/vampire/proc/after_expose_reagents(atom/source, list/reagents, datum/reagents/source_reagents, methods = TOUCH, show_message = TRUE)
	SIGNAL_HANDLER
	var/datum/reagent/blood/blood_reagent = locate() in reagents
	if(!blood_reagent)
		return NONE
	var/blood_volume = round(reagents[blood_reagent], 0.1)
	if(blood_volume > 0)
		adjust_blood_volume(blood_volume)
	return NONE

/datum/antagonist/vampire/proc/on_login()
	SIGNAL_HANDLER
	var/mob/living/current = owner.current
	if(!QDELETED(current))
		addtimer(CALLBACK(src, TYPE_PROC_REF(/datum/antagonist, add_team_hud), current), 0.5 SECONDS, TIMER_OVERRIDE | TIMER_UNIQUE) //i don't trust this to not act weird

/datum/antagonist/vampire/proc/on_update_sight(mob/user)
	SIGNAL_HANDLER
	user.add_sight(SEE_MOBS)
	user.lighting_cutoff = max(user.lighting_cutoff, LIGHTING_CUTOFF_HIGH)
	user.lighting_color_cutoffs = user.lighting_color_cutoffs ? blend_cutoff_colors(user.lighting_color_cutoffs, VAMPIRE_SIGHT_COLOR_CUTOFF) : VAMPIRE_SIGHT_COLOR_CUTOFF

/datum/outfit/vampire_outfit
	name = "Vampire outfit (Preview only)"
	suit = /obj/item/clothing/suit/costume/dracula

/datum/outfit/vampire_outfit/post_equip(mob/living/carbon/human/enrico, visuals_only = FALSE)
	enrico.set_hairstyle("Undercut", update = FALSE)
	enrico.set_haircolor("#FFFFFF", update = FALSE)
	enrico.skin_tone = "african2"
	enrico.set_eye_color("#663300")

	enrico.update_body(is_creating = TRUE)
