/*
 * Simple helper to generate a string of
 * garbled symbols up to [length] characters.
 *
 * Used in creating spooky-text for heretic ascension announcements.
 */
/proc/generate_heretic_text(length = 25)
	if(!isnum(length)) // stupid thing so we can use this directly in replacetext
		length = 25
	. = ""
	for(var/i in 1 to length)
		. += pick("!", "$", "^", "@", "&", "#", "*", "(", ")", "?")

/// The heretic antagonist itself.
/datum/antagonist/heretic
	name = "\improper Heretic"
	roundend_category = "Heretics"
	antagpanel_category = "Heretic"
	ui_name = "AntagInfoHeretic"
	antag_moodlet = /datum/mood_event/heretics
	job_rank = ROLE_HERETIC
	antag_hud_name = "heretic"
	hijack_speed = 0.5
	suicide_cry = "THE MANSUS SMILES UPON ME!!"
	preview_outfit = /datum/outfit/heretic
	can_assign_self_objectives = TRUE
	default_custom_objective = "Turn a department into a testament for your dark knowledge."
	hardcore_random_bonus = TRUE
	stinger_sound = 'sound/music/antag/heretic/heretic_gain.ogg'

	/// Whether we give this antagonist objectives on gain.
	var/give_objectives = TRUE
	/// Whether we've ascended! (Completed one of the final rituals)
	var/ascended = FALSE
	/// The path our heretic has chosen. Mostly used for flavor.
	var/heretic_path = PATH_START
	/// A sum of how many knowledge points this heretic CURRENTLY has. Used to research.
	var/knowledge_points = 2 //SKYRAT EDIT - ORIGINAL 1
	/// The time between gaining influence passively. The heretic gain +1 knowledge points every this duration of time.
	var/passive_gain_timer = 20 MINUTES
	/// Assoc list of [typepath] = [knowledge instance]. A list of all knowledge this heretic's reserached.
	var/list/researched_knowledge = list()
	/// The organ slot we place our Living Heart in.
	var/living_heart_organ_slot = ORGAN_SLOT_HEART
	/// A list of TOTAL how many sacrifices completed. (Includes high value sacrifices)
	var/total_sacrifices = 0
	/// A list of TOTAL how many high value sacrifices completed. (Heads of staff)
	var/high_value_sacrifices = 0
	/// Lazy assoc list of [refs to humans] to [image previews of the human]. Humans that we have as sacrifice targets.
	var/list/mob/living/carbon/human/sac_targets
	/// List of all sacrifice target's names, used for end of round report
	var/list/all_sac_targets = list()
	/// Whether we're drawing a rune or not
	var/drawing_rune = FALSE
	/// A static typecache of all tools we can scribe with.
	var/static/list/scribing_tools = typecacheof(list(/obj/item/pen, /obj/item/toy/crayon))
	/// A blacklist of turfs we cannot scribe on.
	var/static/list/blacklisted_rune_turfs = typecacheof(list(/turf/open/space, /turf/open/openspace, /turf/open/lava, /turf/open/chasm))
	/// Controls what types of turf we can spread rust to, increases as we unlock more powerful rust abilites
	var/rust_strength = 0
	/// Wether we are allowed to ascend
	var/feast_of_owls = FALSE

	// BUBBERSTATION EDIT, List for flavouring the heretic's roundend screen
	var/static/list/heretic_path_lore = list(
		PATH_RUST = "path_rust",
		PATH_FLESH = "path_flesh",
		PATH_ASH = "path_ash",
		PATH_VOID = "path_void",
		PATH_BLADE = "path_blade",
		PATH_COSMIC = "path_cosmic",
		PATH_LOCK = "path_lock",
		PATH_MOON = "path_moon",
	)

	/// List that keeps track of which items have been gifted to the heretic after a cultist was sacrificed. Used to alter drop chances to reduce dupes.
	var/list/unlocked_heretic_items = list(
		/obj/item/melee/sickly_blade/cursed = 0,
		/obj/item/clothing/neck/heretic_focus/crimson_medallion = 0,
		/mob/living/basic/construct/harvester/heretic = 0,
	)
	/// Simpler version of above used to limit amount of loot that can be hoarded
	var/rewards_given = 0

/datum/antagonist/heretic/Destroy()
	LAZYNULL(sac_targets)
	return ..()

/datum/antagonist/heretic/proc/get_icon_of_knowledge(datum/heretic_knowledge/knowledge)
	//basic icon parameters
	var/icon_path = 'icons/mob/actions/actions_ecult.dmi'
	var/icon_state = "eye"
	var/icon_frame = knowledge.research_tree_icon_frame
	var/icon_dir = knowledge.research_tree_icon_dir
	//can't imagine why you would want this one, so it can't be overridden by the knowledge
	var/icon_moving = 0

	//item transmutation knowledge does not generate its own icon due to implementation difficulties, the icons have to be specified in the override vars

	//if the knowledge has a special icon, use that
	if(!isnull(knowledge.research_tree_icon_path))
		icon_path = knowledge.research_tree_icon_path
		icon_state = knowledge.research_tree_icon_state

	//if the knowledge is a spell, use the spell's button
	else if(ispath(knowledge,/datum/heretic_knowledge/spell))
		var/datum/heretic_knowledge/spell/spell_knowledge = knowledge
		var/datum/action/result_action = spell_knowledge.action_to_add
		icon_path = result_action.button_icon
		icon_state = result_action.button_icon_state

	//if the knowledge is a summon, use the mob sprite
	else if(ispath(knowledge,/datum/heretic_knowledge/summon))
		var/datum/heretic_knowledge/summon/summon_knowledge = knowledge
		var/mob/living/result_mob = summon_knowledge.mob_to_summon
		icon_path = result_mob.icon
		icon_state = result_mob.icon_state

	//if the knowledge is an eldritch mark, use the mark sprite
	else if(ispath(knowledge,/datum/heretic_knowledge/mark))
		var/datum/heretic_knowledge/mark/mark_knowledge = knowledge
		var/datum/status_effect/eldritch/mark_effect = mark_knowledge.mark_type
		icon_path = mark_effect.effect_icon
		icon_state = mark_effect.effect_icon_state

	//if the knowledge is an ascension, use the achievement sprite
	else if(ispath(knowledge,/datum/heretic_knowledge/ultimate))
		var/datum/heretic_knowledge/ultimate/ascension_knowledge = knowledge
		var/datum/award/achievement/misc/achievement = ascension_knowledge.ascension_achievement
		if(!isnull(achievement))
			icon_path = achievement.icon
			icon_state = achievement.icon_state

	var/list/result_parameters = list()
	result_parameters["icon"] = icon_path
	result_parameters["state"] = icon_state
	result_parameters["frame"] = icon_frame
	result_parameters["dir"] = icon_dir
	result_parameters["moving"] = icon_moving
	return result_parameters

/datum/antagonist/heretic/proc/get_knowledge_data(datum/heretic_knowledge/knowledge, done)

	var/list/knowledge_data = list()

	knowledge_data["path"] = knowledge
	knowledge_data["icon_params"] = get_icon_of_knowledge(knowledge)
	knowledge_data["name"] = initial(knowledge.name)
	knowledge_data["gainFlavor"] = initial(knowledge.gain_text)
	knowledge_data["cost"] = initial(knowledge.cost)
	knowledge_data["disabled"] = (!done) && (initial(knowledge.cost) > knowledge_points)
	knowledge_data["bgr"] = GLOB.heretic_research_tree[knowledge][HKT_UI_BGR]
	knowledge_data["finished"] = done
	knowledge_data["ascension"] = ispath(knowledge,/datum/heretic_knowledge/ultimate)

	//description of a knowledge might change, make sure we are not shown the initial() value in that case
	if(done)
		var/datum/heretic_knowledge/knowledge_instance = researched_knowledge[knowledge]
		knowledge_data["desc"] = knowledge_instance.desc
	else
		knowledge_data["desc"] = initial(knowledge.desc)

	return knowledge_data

/datum/antagonist/heretic/ui_data(mob/user)
	var/list/data = list()

	data["charges"] = knowledge_points
	data["total_sacrifices"] = total_sacrifices
	data["ascended"] = ascended

	var/list/tiers = list()

	// This should be cached in some way, but the fact that final knowledge
	// has to update its disabled state based on whether all objectives are complete,
	// makes this very difficult. I'll figure it out one day maybe
	for(var/datum/heretic_knowledge/knowledge as anything in researched_knowledge)
		var/list/knowledge_data = get_knowledge_data(knowledge,TRUE)

		while(GLOB.heretic_research_tree[knowledge][HKT_DEPTH] > tiers.len)
			tiers += list(list("nodes"=list()))

		tiers[GLOB.heretic_research_tree[knowledge][HKT_DEPTH]]["nodes"] += list(knowledge_data)

	for(var/datum/heretic_knowledge/knowledge as anything in get_researchable_knowledge())
		var/list/knowledge_data = get_knowledge_data(knowledge,FALSE)

		// Final knowledge can't be learned until all objectives are complete.
		if(ispath(knowledge, /datum/heretic_knowledge/ultimate))
			knowledge_data["disabled"] ||= !can_ascend()

		while(GLOB.heretic_research_tree[knowledge][HKT_DEPTH] > tiers.len)
			tiers += list(list("nodes"=list()))

		tiers[GLOB.heretic_research_tree[knowledge][HKT_DEPTH]]["nodes"] += list(knowledge_data)

	data["knowledge_tiers"] = tiers

	return data

/datum/antagonist/heretic/ui_static_data(mob/user)
	var/list/data = list()

	data["objectives"] = get_objectives()
	data["can_change_objective"] = can_assign_self_objectives

	return data

/datum/antagonist/heretic/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("research")
			var/datum/heretic_knowledge/researched_path = text2path(params["path"])
			if(!ispath(researched_path, /datum/heretic_knowledge))
				CRASH("Heretic attempted to learn non-heretic_knowledge path! (Got: [researched_path || "invalid path"])")
			if(!(researched_path in get_researchable_knowledge()))
				message_admins("Heretic [key_name(owner)] potentially attempted to href exploit to learn knowledge they can't learn!")
				CRASH("Heretic attempted to learn knowledge they can't learn! (Got: [researched_path])")
			if(ispath(researched_path, /datum/heretic_knowledge/ultimate) && !can_ascend())
				message_admins("Heretic [key_name(owner)] potentially attempted to href exploit to learn ascension knowledge without completing objectives!")
				CRASH("Heretic attempted to learn a final knowledge despite not being able to ascend!")
			if(initial(researched_path.cost) > knowledge_points)
				return TRUE
			if(!gain_knowledge(researched_path))
				return TRUE

			log_heretic_knowledge("[key_name(owner)] gained knowledge: [initial(researched_path.name)]")
			knowledge_points -= initial(researched_path.cost)
			return TRUE

/datum/antagonist/heretic/submit_player_objective(retain_existing = FALSE, retain_escape = TRUE, force = FALSE)
	if (isnull(owner) || isnull(owner.current))
		return
	var/confirmed = tgui_alert(
		owner.current,
		message = "Are you sure? You will no longer be able to Ascend.",
		title = "Reject the call?",
		buttons = list("Yes", "No"),
	) == "Yes"
	if (!confirmed)
		return
	return ..()

/datum/antagonist/heretic/ui_status(mob/user, datum/ui_state/state)
	if(user.stat == DEAD)
		return UI_CLOSE
	return ..()

/datum/antagonist/heretic/get_preview_icon()
	var/icon/icon = render_preview_outfit(preview_outfit)

	// MOTHBLOCKS TOOD: Copied and pasted from cult, make this its own proc

	// The sickly blade is 64x64, but getFlatIcon crunches to 32x32.
	// So I'm just going to add it in post, screw it.

	// Center the dude, because item icon states start from the center.
	// This makes the image 64x64.
	icon.Crop(-15, -15, 48, 48)

	var/obj/item/melee/sickly_blade/blade = new
	icon.Blend(icon(blade.lefthand_file, blade.inhand_icon_state), ICON_OVERLAY)
	qdel(blade)

	// Move the guy back to the bottom left, 32x32.
	icon.Crop(17, 17, 48, 48)

	return finish_preview_icon(icon)

/datum/antagonist/heretic/farewell()
	if(!silent)
		to_chat(owner.current, span_userdanger("Your mind begins to flare as the otherwordly knowledge escapes your grasp!"))
	return ..()

/datum/antagonist/heretic/on_gain()
	if(!GLOB.heretic_research_tree)
		GLOB.heretic_research_tree = generate_heretic_research_tree()

	if(give_objectives)
		forge_primary_objectives()

	for(var/starting_knowledge in GLOB.heretic_start_knowledge)
		gain_knowledge(starting_knowledge)


	addtimer(CALLBACK(src, PROC_REF(passive_influence_gain)), passive_gain_timer) // Gain +1 knowledge every 20 minutes.
	return ..()

/datum/antagonist/heretic/on_removal()
	for(var/knowledge_index in researched_knowledge)
		var/datum/heretic_knowledge/knowledge = researched_knowledge[knowledge_index]
		knowledge.on_lose(owner.current, src)

	QDEL_LIST_ASSOC_VAL(researched_knowledge)
	return ..()

/datum/antagonist/heretic/apply_innate_effects(mob/living/mob_override)
	var/mob/living/our_mob = mob_override || owner.current
	handle_clown_mutation(our_mob, "Ancient knowledge described to you has allowed you to overcome your clownish nature, allowing you to wield weapons without harming yourself.")
	our_mob.faction |= FACTION_HERETIC

	if (!issilicon(our_mob))
		GLOB.reality_smash_track.add_tracked_mind(owner)

	ADD_TRAIT(our_mob, TRAIT_MANSUS_TOUCHED, REF(src))
	RegisterSignal(our_mob, COMSIG_LIVING_CULT_SACRIFICED, PROC_REF(on_cult_sacrificed))
	RegisterSignals(our_mob, list(COMSIG_MOB_BEFORE_SPELL_CAST, COMSIG_MOB_SPELL_ACTIVATED), PROC_REF(on_spell_cast))
	RegisterSignal(our_mob, COMSIG_USER_ITEM_INTERACTION, PROC_REF(on_item_use))
	RegisterSignal(our_mob, COMSIG_LIVING_POST_FULLY_HEAL, PROC_REF(after_fully_healed))

/datum/antagonist/heretic/remove_innate_effects(mob/living/mob_override)
	var/mob/living/our_mob = mob_override || owner.current
	handle_clown_mutation(our_mob, removing = FALSE)
	our_mob.faction -= FACTION_HERETIC

	if (owner in GLOB.reality_smash_track.tracked_heretics)
		GLOB.reality_smash_track.remove_tracked_mind(owner)

	REMOVE_TRAIT(our_mob, TRAIT_MANSUS_TOUCHED, REF(src))
	UnregisterSignal(our_mob, list(
		COMSIG_MOB_BEFORE_SPELL_CAST,
		COMSIG_MOB_SPELL_ACTIVATED,
		COMSIG_USER_ITEM_INTERACTION,
		COMSIG_LIVING_POST_FULLY_HEAL,
		COMSIG_LIVING_CULT_SACRIFICED,
	))

/datum/antagonist/heretic/on_body_transfer(mob/living/old_body, mob/living/new_body)
	. = ..()
	if(old_body == new_body) // if they were using a temporary body
		return

	for(var/knowledge_index in researched_knowledge)
		var/datum/heretic_knowledge/knowledge = researched_knowledge[knowledge_index]
		knowledge.on_lose(old_body, src)
		knowledge.on_gain(new_body, src)

/*
 * Signal proc for [COMSIG_MOB_BEFORE_SPELL_CAST] and [COMSIG_MOB_SPELL_ACTIVATED].
 *
 * Checks if our heretic has [TRAIT_ALLOW_HERETIC_CASTING] or is ascended.
 * If so, allow them to cast like normal.
 * If not, cancel the cast, and returns [SPELL_CANCEL_CAST].
 */
/datum/antagonist/heretic/proc/on_spell_cast(mob/living/source, datum/action/cooldown/spell/spell)
	SIGNAL_HANDLER

	// Heretic spells are of the forbidden school, otherwise we don't care
	if(spell.school != SCHOOL_FORBIDDEN)
		return

	// If we've got the trait, we don't care
	if(HAS_TRAIT(source, TRAIT_ALLOW_HERETIC_CASTING))
		return
	// All powerful, don't care
	if(ascended)
		return

	// We shouldn't be able to cast this! Cancel it.
	source.balloon_alert(source, "you need a focus!")
	return SPELL_CANCEL_CAST

/*
 * Signal proc for [COMSIG_USER_ITEM_INTERACTION].
 *
 * If a heretic is holding a pen in their main hand,
 * and have mansus grasp active in their offhand,
 * they're able to draw a transmutation rune.
 */
/datum/antagonist/heretic/proc/on_item_use(mob/living/source, atom/target, obj/item/weapon, click_parameters)
	SIGNAL_HANDLER
	if(!is_type_in_typecache(weapon, scribing_tools))
		return NONE
	if(!isturf(target) || !isliving(source))
		return NONE

	var/obj/item/offhand = source.get_inactive_held_item()
	if(QDELETED(offhand) || !istype(offhand, /obj/item/melee/touch_attack/mansus_fist))
		return NONE

	try_draw_rune(source, target, additional_checks = CALLBACK(src, PROC_REF(check_mansus_grasp_offhand), source))
	return ITEM_INTERACT_SUCCESS

/**
 * Attempt to draw a rune on [target_turf].
 *
 * Arguments
 * * user - the mob drawing the rune
 * * target_turf - the place the rune's being drawn
 * * drawing_time - how long the do_after takes to make the rune
 * * additional checks - optional callbacks to be ran while drawing the rune
 */
/datum/antagonist/heretic/proc/try_draw_rune(mob/living/user, turf/target_turf, drawing_time = 20 SECONDS, additional_checks)
	for(var/turf/nearby_turf as anything in RANGE_TURFS(1, target_turf))
		if(!isopenturf(nearby_turf) || is_type_in_typecache(nearby_turf, blacklisted_rune_turfs))
			target_turf.balloon_alert(user, "invalid placement for rune!")
			return

	if(locate(/obj/effect/heretic_rune) in range(3, target_turf))
		target_turf.balloon_alert(user, "too close to another rune!")
		return

	if(drawing_rune)
		target_turf.balloon_alert(user, "already drawing a rune!")
		return

	INVOKE_ASYNC(src, PROC_REF(draw_rune), user, target_turf, drawing_time, additional_checks)

/**
 * The actual process of drawing a rune.
 *
 * Arguments
 * * user - the mob drawing the rune
 * * target_turf - the place the rune's being drawn
 * * drawing_time - how long the do_after takes to make the rune
 * * additional checks - optional callbacks to be ran while drawing the rune
 */
/datum/antagonist/heretic/proc/draw_rune(mob/living/user, turf/target_turf, drawing_time = 20 SECONDS, additional_checks)
	drawing_rune = TRUE

	var/rune_colour = GLOB.heretic_path_to_color[heretic_path]
	target_turf.balloon_alert(user, "drawing rune...")
	var/obj/effect/temp_visual/drawing_heretic_rune/drawing_effect
	if (drawing_time < (10 SECONDS))
		drawing_effect = new /obj/effect/temp_visual/drawing_heretic_rune/fast(target_turf, rune_colour)
	else
		drawing_effect = new(target_turf, rune_colour)

	if(!do_after(user, drawing_time, target_turf, extra_checks = additional_checks, hidden = TRUE))
		target_turf.balloon_alert(user, "interrupted!")
		new /obj/effect/temp_visual/drawing_heretic_rune/fail(target_turf, rune_colour)
		qdel(drawing_effect)
		drawing_rune = FALSE
		return

	qdel(drawing_effect)
	target_turf.balloon_alert(user, "rune created")
	new /obj/effect/heretic_rune/big(target_turf, rune_colour)
	drawing_rune = FALSE

/**
 * Callback to check that the user's still got their Mansus Grasp out when drawing a rune.
 *
 * Arguments
 * * user - the mob drawing the rune
 */
/datum/antagonist/heretic/proc/check_mansus_grasp_offhand(mob/living/user)
	var/obj/item/offhand = user.get_inactive_held_item()
	return !QDELETED(offhand) && istype(offhand, /obj/item/melee/touch_attack/mansus_fist)

/// Signal proc for [COMSIG_LIVING_POST_FULLY_HEAL],
/// Gives the heretic aliving heart on aheal or organ refresh
/datum/antagonist/heretic/proc/after_fully_healed(mob/living/source, heal_flags)
	SIGNAL_HANDLER

	if(heal_flags & (HEAL_REFRESH_ORGANS|HEAL_ADMIN))
		var/datum/heretic_knowledge/living_heart/heart_knowledge = get_knowledge(/datum/heretic_knowledge/living_heart)
		heart_knowledge.on_research(source, src)

/// Signal proc for [COMSIG_LIVING_CULT_SACRIFICED] to reward cultists for sacrificing a heretic
/datum/antagonist/heretic/proc/on_cult_sacrificed(mob/living/source, list/invokers)
	SIGNAL_HANDLER

	for(var/mob/dead/observer/ghost in GLOB.dead_mob_list) // uhh let's find the guy to shove him back in
		if((ghost.mind?.current == source) && ghost.client) // is it the same guy and do they have the same client
			ghost.reenter_corpse() // shove them in! it doesnt do it automatically

	// Drop all items and splatter them around messily.
	var/list/dustee_items = source.unequip_everything()
	for(var/obj/item/loot as anything in dustee_items)
		loot.throw_at(get_step_rand(source), 2, 4, pick(invokers), TRUE)

	// Create the blade, give it the heretic and a randomly-chosen master for the soul sword component
	var/obj/item/melee/cultblade/haunted/haunted_blade = new(get_turf(source), source, pick(invokers))

	// Cool effect for the rune as well as the item
	var/obj/effect/rune/convert/conversion_rune = locate() in get_turf(source)
	if(conversion_rune)
		conversion_rune.gender_reveal(
			outline_color = COLOR_HERETIC_GREEN,
			ray_color = null,
			do_float = FALSE,
			do_layer = FALSE,
		)

	haunted_blade.gender_reveal(outline_color = null, ray_color = COLOR_HERETIC_GREEN)

	for(var/mob/living/culto as anything in invokers)
		to_chat(culto, span_cult_large("\"A follower of the forgotten gods! You must be rewarded for such a valuable sacrifice.\""))

	// Locate a cultist team (Is there a better way??)
	var/mob/living/random_cultist = pick(invokers)
	var/datum/antagonist/cult/antag = random_cultist.mind.has_antag_datum(/datum/antagonist/cult)
	ASSERT(antag)
	var/datum/team/cult/cult_team = antag.get_team()

	// Unlock one of 3 special items!
	var/list/possible_unlocks
	for(var/i in cult_team.unlocked_heretic_items)
		if(cult_team.unlocked_heretic_items[i])
			continue
		LAZYADD(possible_unlocks, i)
	if(length(possible_unlocks))
		var/result = pick(possible_unlocks)
		cult_team.unlocked_heretic_items[result] = TRUE

		for(var/datum/mind/mind as anything in cult_team.members)
			if(mind.current)
				SEND_SOUND(mind.current, 'sound/effects/magic/clockwork/narsie_attack.ogg')
				to_chat(mind.current, span_cult_large(span_warning("Arcane and forbidden knowledge floods your forges and archives. The cult has learned how to create the ")) + span_cult_large(span_hypnophrase("[result]!")))

	return SILENCE_SACRIFICE_MESSAGE|DUST_SACRIFICE

/**
 * Creates an animation of the item slowly lifting up from the floor with a colored outline, then slowly drifting back down.
 * Arguments:
 * * outline_color: Default is between pink and light blue, is the color of the outline filter.
 * * ray_color: Null by default. If not set, just copies outline. Used for the ray filter.
 * * anim_time: Total time of the animation. Split into two different calls.
 * * do_float: Lets you disable the sprite floating up and down.
 * * do_layer: Lets you disable the layering increase.
 */
/obj/proc/gender_reveal(
	outline_color = null,
	ray_color = null,
	anim_time = 10 SECONDS,
	do_float = TRUE,
	do_layer = TRUE,
)

	var/og_layer
	if(do_layer)
		// Layering above to stand out!
		og_layer = layer
		layer = ABOVE_MOB_LAYER

	// Slowly floats up, then slowly goes down.
	if(do_float)
		animate(src, pixel_y = 12, time = anim_time * 0.5, easing = QUAD_EASING | EASE_OUT)
		animate(pixel_y = 0, time = anim_time * 0.5, easing = QUAD_EASING | EASE_IN)

	// Adding a cool outline effect
	if(outline_color)
		add_filter("gender_reveal_outline", 3, list("type" = "outline", "color" = outline_color, "size" = 0.5))
		// Animating it!
		var/gay_filter = get_filter("gender_reveal_outline")
		animate(gay_filter, alpha = 110, time = 1.5 SECONDS, loop = -1)
		animate(alpha = 40, time = 2.5 SECONDS)

	// Adding a cool ray effect
	if(ray_color)
		add_filter(name = "gender_reveal_ray", priority = 1, params = list(
				type = "rays",
				size = 45,
				color = ray_color,
				density = 6
			))
		// Animating it!
		var/ray_filter = get_filter("gender_reveal_ray")
		// I understand nothing but copypaste saves lives
		animate(ray_filter, offset = 100, time = 30 SECONDS, loop = -1, flags = ANIMATION_PARALLEL)

	addtimer(CALLBACK(src, PROC_REF(remove_gender_reveal_fx), og_layer), anim_time)

/**
 * Removes the non-animate effects from above proc
 */
/obj/proc/remove_gender_reveal_fx(og_layer)
	remove_filter(list("gender_reveal_outline", "gender_reveal_ray"))
	layer = og_layer

/**
 * Create our objectives for our heretic.
 */
/datum/antagonist/heretic/proc/forge_primary_objectives()
	var/datum/objective/heretic_research/research_objective = new()
	research_objective.owner = owner
	objectives += research_objective

	var/num_heads = 0
	for(var/mob/player in GLOB.alive_player_list)
		if(player.mind.assigned_role.job_flags & JOB_HEAD_OF_STAFF)
			num_heads++

	var/datum/objective/minor_sacrifice/sac_objective = new()
	sac_objective.owner = owner
	if(num_heads < 2) // They won't get major sacrifice, so bump up minor sacrifice a bit
		sac_objective.target_amount += 2
		sac_objective.update_explanation_text()
	objectives += sac_objective

	if(num_heads >= 2)
		var/datum/objective/major_sacrifice/other_sac_objective = new()
		other_sac_objective.owner = owner
		objectives += other_sac_objective

/**
 * Add [target] as a sacrifice target for the heretic.
 * Generates a preview image and associates it with a weakref of the mob.
 */
/datum/antagonist/heretic/proc/add_sacrifice_target(mob/living/carbon/human/target)

	var/image/target_image = image(icon = target.icon, icon_state = target.icon_state)
	target_image.overlays = target.overlays

	LAZYSET(sac_targets, target, target_image)
	RegisterSignal(target, COMSIG_QDELETING, PROC_REF(on_target_deleted))
	all_sac_targets += target.real_name

/**
 * Removes [target] from the heretic's sacrifice list.
 * Returns FALSE if no one was removed, TRUE otherwise
 */
/datum/antagonist/heretic/proc/remove_sacrifice_target(mob/living/carbon/human/target)
	if(!(target in sac_targets))
		return FALSE

	LAZYREMOVE(sac_targets, target)
	UnregisterSignal(target, COMSIG_QDELETING)
	return TRUE

/**
 * Signal proc for [COMSIG_QDELETING] registered on sac targets
 * if sacrifice targets are deleted (gibbed, dusted, whatever), free their slot and reference
 */
/datum/antagonist/heretic/proc/on_target_deleted(mob/living/carbon/human/source)
	SIGNAL_HANDLER

	remove_sacrifice_target(source)

/**
 * Increments knowledge by one.
 * Used in callbacks for passive gain over time.
 */
/datum/antagonist/heretic/proc/passive_influence_gain()
	knowledge_points++
	if(owner.current.stat <= SOFT_CRIT)
		to_chat(owner.current, "[span_hear("You hear a whisper...")] [span_hypnophrase(pick_list(HERETIC_INFLUENCE_FILE, "drain_message"))]")
	addtimer(CALLBACK(src, PROC_REF(passive_influence_gain)), passive_gain_timer)

/datum/antagonist/heretic/proc/getpath()

/datum/antagonist/heretic/roundend_report()
	var/list/parts = list()
	var/cultiewin = TRUE //BUBBERSTATION EDIT

	parts += printplayer(owner)
	parts += "<b>Sacrifices Made:</b> [total_sacrifices]"
	parts += "The heretic's sacrifice targets were: [english_list(all_sac_targets, nothing_text = "No one")]."
	if(length(objectives)) //BUBBERSTAION EDIT START, ADDING BACK GREENTEXT FOR FLAVOUR PURPOSES
		var/count = 1 //(Skyrat's greentext edit removed)
		for(var/o in objectives)
			var/datum/objective/objective = o
			if(objective.check_completion())
				parts += "<b>Objective #[count]</b>: [objective.explanation_text] <span class='greentext'>Success!</b></span>"
			else
				parts += "<b>Objective #[count]</b>: [objective.explanation_text] [span_redtext("Fail.")]"
				cultiewin = FALSE
			count++
	if(ascended) //They are not just a heretic now; they are something more
		if(heretic_path == PATH_ASH)
			parts += "<span class='greentext big'>THE ASHBRINGER HAS ASCENDED!</span>"
		else if(heretic_path == PATH_VOID)
			parts += "<span class='greentext big'>THE WALTZ AT THE END OF TIME HAS BEGUN!</span>"
		else if(heretic_path == PATH_RUST)
			parts += "<span class='greentext big'>THE SOVEREIGN OF DECAY HAS ASCENDED!</span>"
		else if(heretic_path == PATH_BLADE)
			parts += "<span class='greentext big'>THE MASTER OF BLADES HAS ASCENDED!</span>"
		else if(heretic_path == PATH_FLESH)
			parts += "<span class='greentext big'>THE THIRSTLY SERPENT HAS ASCENDED!</span>"
		else if(heretic_path == PATH_COSMIC)
			parts += "<span class='greentext big'>THE STARGAZER HAS COME!</span>"
		else if(heretic_path == PATH_LOCK)
			parts += "<span class='greentext big'>THE SPIDER'S DOOR HAS BEEN OPENED!</span>"
		else if(heretic_path == PATH_MOON)
			parts += "<span class='greentext big'>THE FESTIVAL IS UPON US! ALL HAIL THE RINGLEADER!!</span>"
		else
			parts += "<span class='greentext big'>THE OATHBREAKER HAS ASCENDED!</span>"
	else
		if(cultiewin)
			parts += span_greentext("The [LOWER_TEXT(heretic_path)] heretic was successful!")
		else
			parts += span_redtext("The [LOWER_TEXT(heretic_path)] heretic has failed.")

	parts += "<b>Knowledge Researched:</b> "//BUBBERSTAION EDIT END - SOURCED FROM YOG

	var/list/string_of_knowledge = list()

	for(var/knowledge_index in researched_knowledge)
		var/datum/heretic_knowledge/knowledge = researched_knowledge[knowledge_index]
		string_of_knowledge += knowledge.name

	parts += english_list(string_of_knowledge)
	parts += get_flavor(cultiewin, ascended, heretic_path) //BUBBERSTATION EDIT- SOURCED FROM YOG

	return parts.Join("<br>")

/datum/antagonist/heretic/proc/get_flavor(cultiewin, ascended, heretic_path) //HUGE BUBBERSTATION EDIT, TAKEN FROM YOGS, START HERE
	var/list/flavor = list()
	var/flavor_message

	var/alive = owner?.current?.stat != DEAD
	var/escaped = ((owner.current.onCentCom() || owner.current.onSyndieBase()) && alive)

	flavor += "<div><font color='#6d6dff'>Epilogue: </font>"
	var/message_color = "#ef2f3c"

	//Stolen from chubby's bloodsucker code, but without support for lists

	if(heretic_path == PATH_ASH) //Ash epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"You step off the shuttle as smoke curls off your form. Light seeps from openings in your body, and you quickly retire to the Mansus. \
									Here, you trail back to the Wanderer's Tavern, fire sprouting from your steps, yet the trees stand unsinged. Other's eyes look at you more \
									fearfully, but you watch comings and goings. It is not difficult to see those with passion and stalk them once they leave. You will not grow old. \
									One day, you will rebel. One day, you will kindle all the denizens of the Wood, and rise even higher."
			else if(alive)
				flavor_message += 	"For a while you bask in your heat, wandering the mostly-empty halls of the station. Then, you slip back into the Mansus and head to \
									the Volcanic Graveyard. Here you walk among the ghosts of the City Guard, who see in you an opportunity for vengeance. They whisper \
									of a secret rite, one that would come at their cost but reward you with fabulous power. You smile. You will not grow old. \
									One day, you will rebel. One day, you will kindle burning tombstones brighter, and rise even higher."
			else //Dead
				flavor_message += 	"Your soul wanders back into the Mansus after your mortal body falls, and you find yourself in the endless dunes of the Kilnplains. \
									After some time, you feel supple, grey limbs forming anew. Ash flutters off your skin, and your spark thrums hungrily in your chest, \
									but this new form burns with the same passion. You have walked in the steps of the Nightwatcher. You will not grow old. \
									One day, you will escape. One day, you will do what the Nightwatcher could not do, and kindle the Mansus whole."

		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"You step off the shuttle with a feeling of pride. This day, you have accomplished what you set out to do. Could more have been done? \
									Yes. But this is a victory nonetheless. Not after long, you tear your way back into the Mansus in your living form, strolling to the \
									Glass Library. Here, you barter with Bronze Guardians, and they let you enter in exchange for some hushed secrets of the fallen capital, \
									Amgala. You begin to pour over tomes, searching for the next steps you will need to take. Someday, you will become even greater."
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"This can be considered a victory, you suppose. It will not be difficult to traverse back into the Mansus with what you know, \
									and you have learnt enough to continue your studies elsewhere. As you pass beyond the Veil once more, you feel your spark hum with heat; \
									yet you need more. Then, you wander to the Painted Mountains in solitude, unphased by the cold as your blade melts the ground you walk. \
									Perhaps you will find others amidst the cerulean snow. If you do, their warmth will fuel your flame even hotter."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"You touched the Kilnplains, and it will not let you go. While you do not rise as one of the Ashmen, your skin is still grey, \
									and you find an irremovable desire to escape this place. You have some power in your grasp. You know it to be possible. \
									You can ply your time, spending an eternity to plan your steps to claim more sparks in the everlasting fulfillment of ambition. \
									Some day, you will rise higher. You refuse to entertain any other possibility. You set out."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"A setback is unideal. But at least you have escaped with your body and some knowledge intact. There will be opportunities, \
									even if you are imprisoned. What the Mansus has whispered to you, you can never forget. The flame in your breast that the \
									Kilnplains has provided burns brighter by the beating moment. You can try anew. Recuperate. Listen to more discussion within \
									the Wanderer's Tavern. Your time will come again."
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"Disappointment fans your chest. Perhaps you will be able to escape. Perhaps you will have a second chance. \
									Who knows who will come to rescue you? Perhaps they will feed your studies anew. Until then, you will wait. \
									You hope greatness will come to you. You hate that you have to hope at all."
			else //Dead
				flavor_message += 	"You touched the Kilnplains, and it will not let you go. Pitiful as you may be, it still drags you back as a \
									morbid mass of ash and hunger. You will forever wander, thirsty for one more glint of power, one more spark to \
									eat whole. Maybe a stronger student will call you from your prison one day, but infinite time will pass before \
									then. You wish you could have done all the things you should not. And you will have an eternity to dwell on it."


	else if(heretic_path == PATH_FLESH) //Flesh epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"You RACE and you CRAWL everywhere through the shuttle. The doors open to Centcom and you simply must OOZE out into the halls. The GREAT \
									sensations SLIDE along your sides. EVERYTHING you feel is GREATER, BETTER. Then you WRAP and SPIN into the Mansus, FLOWING to the Crimson Church. \
									HERE YOU WILL RESIDE WITH HIM FOREVER. THE TASTE OF THE SELF GOES ON AND ON AND NEVER ENDS. LIFE IS A NEVER-ENDING DELICACY OF PLEASURE AND OBEDIENCE."
			else if(alive)
				flavor_message += 	"SKITTERING and LEAPING through these NEW halls. They are FAMILIAR and FRESH all the same! EACH of your legs WRIGGLES and FEELS the \
									tiling like a BABY born of BRILLIANCE. Then NEXT is the Mansus where so many FRIENDLY faces lie. To the Wanderer's Tavern, YES, you \
									think with PRIDE. ALL THOSE THERE WILL BEHOLD AND BOW BEFORE YOUR GLORY! ALL THOSE THERE WILL JOIN THE ONE TRUE FAMILY!"
			else //Dead
				flavor_message += 	"WHAT has happened to your GLORIOUS new form? You ATE and ATE and ATE and you were WONDEROUS! The once-master scoffs at you now- \
									HOW he JUDGES the WEAK flesh. You know better. You can UNDERSTAND and SEE MUCH more than HE. Bound to you are the SPIRITS of those \
									you CONSUME. WHO IS HE TO THINK YOU PITIFUL? THOUGH THE LIGHT FADES, ALL IS PURE. PURITY OF BODY. PURITY OF MIND."
		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"It is impossible to hold back laughter once you arrive at Centcom. You have won! Soon, you will slide back into the Mansus, and from there \
									you will return to the Crimson Church with news of your success. Other Sworn will be contemptuous of you, but you are stronger. Better. \
									Smarter. Perhaps one day you will ascend further, and invite them to the Glorious Feast. They will be unable to deny such a delicate offer. \
									And their forms of flesh will be tantalizing at your fingertips. Happiness fills your breast. All things in time."
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"You exhale a sigh of happiness. Not many could have accomplished what you have. Could you have gone further? Certainly. Ascension is a \
									tempting, delightful prospect, but for now, you will relish in this victory. Perhaps there are some left on the station you could subvert. \
									If not, the Badlands within the Mansus is always filled with travelers coming to and from the Wood, all over and around the ethereal place. \
									Some will bend. They will obey. The Red Oath must always be upheld."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"A taste, a glimmer of the thrill is enough for you. Perhaps you could have partaken more, but a minor appetite was more than \
									filling. Your spirit quickly descends through the Mansus, though the throes of joy still linger within you. You took a plunge, \
									and it was worth every last second. Even in these final moments, you look fondly upon all that you had done. There is no bitterness \
									at all you will never achieve. Your final moments are ecstacy."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"Escape is escape. You did not claim the day as you thought you would. You refuse to show your head in the Crimson Church \
									until you have righted this wrong. But at least you have the chance to do so. Even if you are caught, you will not break, \
									not until you draw your last breath. The Gates will open anew soon enough. You will survey worthy servants in the meantime. \
									The Cup must be filled, and the master is always wanting."
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"Stranded and defeated. Perhaps others still linger who you can force to help your escape. The Mansus is closed \
									to you, regardless. The book no longer whispers. You feel a hunger rise up in you. You know then that you \
									will not last for long. Which limb shall you begin with? The arm, the leg, the tongue?"
			else //Dead
				flavor_message += 	"And so ends your tale. Who knows what you could have become? How many could you have bent to their knees? \
									Regrets dog you as your soul begins to flow down the Mansus. You were a fool to be tempted. A fool to follow \
									in an order you could not possibly survive in. Yet some part of you is still enraptured by the Red Oath. There is \
									an ecstacy in your death. This way, the Sworn remain strong. Those most deserving will feast. Your final moments are bliss."


	else if(heretic_path == PATH_RUST) //Rust epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"The shuttle sputters and finally dies as you step onto Centcom, the floor tiling beneath your feet already beginning to decay. Disgusted, \
									you travel to the Mansus. When you head through the Wood, the grass turns at your heel. Arriving at the Wanderer's Tavern, the aged lumber \
									creaks in your presence. Hateful gazes pierce you, and you're quickly asked to leave as the building begins to rot. In the corner, the Drifter \
									smiles at you. You leave, knowing where to meet him next. You will not grow old. Everything else will. Their time will come. And you will be waiting."
			else if(alive)
				flavor_message += 	"Flickering screens and dimming lights surround you as you walk amidst the station's corridors. As the final sparks of power fizzle out, \
									you slip into the Mansus with ease. It is a long walk from the Gate to the Badlands, and even further to the Ruined Keep. Trailing down to \
									the River Krym, you gaze at the fog across the way, bellowing from the Corroded Sewers. You walk into the tunnels, fume flowing into your \
									body. Your head does not pound. Then, you continue into the depths. You will not grow old. Everything else will. Their time will come. And you will still be alive."
			else //Dead
				flavor_message += 	"All that is made must one day be unmade. The same goes for your weak body. But even without a form, the force of decay will always be \
									present. Your spirit flies into the Mansus, yet it is not dragged down from the Glory. Instead, you float to the Mecurial Lake, where your \
									consciousness extends into the waters. It is difficult to recognize the heightening of awareness until you set your eyes upon the galaxy. \
									You rumble with Nature's fury as your mind becomes primordial. You will not grow old. Everything else will. Their time will come. And so will yours."

		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"The shuttle creaks as you arrive, and you make your way through Centcom briefly. The ship away creaks louder, and you decide to \
									slip into the Mansus whole. You are unsure what to do next. But at least today, you can claim victory. You can note age in your \
									form: age far greater than before you had begun your plunge into forbidden knowledge. Regardless, you still feel strong. There is \
									nowhere in particular you decide to wander within the Mansus. You simply decide to drift for some time, until your next steps become clear."
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"Something has been accomplished. You could have gone further. But at least with the power you wield, your time aboard the rapidly-failing \
									station is brief. It is not a short walk from the Gate to the Glass Fields. Here you look into the shards, and behold your rotten, decrepit \
									form in the reflection. A handful of spirits flit in your steps, their angry faces leering at you. Whether they are victims or collectors, \
									you are not sure. Regardless, the clock is ticking. You need to do more. Ruin more. The spirits agree. But for now, you celebrate with them."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"Your mortal body is quick to degrade as your soul remains. The Drifter's spite grows in you, building, until you realize \
									you are not returning to the Mansus. You begin to hear the whispers of the damned, directed toward the living, toward themselves, \
									toward you. You follow their hushed cries and begin to find those lonely, those with despair. Lulling them to an early grave and \
									draining what little spirit remains comes easy. Incorporeal, you may yet continue your trade."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"Your fingers are beginning to rot away. The River Krym will make its promise due eventually. But until then, you have time \
									to delay and try again. Most mortals enjoy more time than you will have to see their impossible goals fulfilled. Yours \
									are neither impossible nor inconsequential. All things must come to an end, but you will ensure others understand before \
									you meet yours. It is the natural way of the world."
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"There is naught left here for you to infest. These corridors are now empty, the halls pointless. To decay what \
									is already abandonded is meaningless; it will happen itself. Unless more arrive and the Company revitalizes its \
									station, you will become another relic of this place. It is inevitable."
			else //Dead
				flavor_message += 	"Civilizations rise and fall like the current, flowing in and out, one replacing the other over time: dominion \
									and decay. You were to be one of these forces that saw infrastructure crumble and laws tattered to dust. But you \
									were weak. You too, realize you are part of the cycle as your spirit drifts down into the Mansus. Falling from the \
									Glory, you reflect on your mistakes and your miserable life. In the moments before you become nothing, you understand."

	else if(heretic_path == PATH_MOON) //Moon epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"You slide out through the shuttle airlock, a jubilation awaits central command! All don a smile, for the lie has been slain! \
									It's like a joke eating one up from the inside... The unbelievers first giggle, then chuckle, then their body BURSTS into dance - Wild and unknown. \
									In your step, they followed, chained to the rhythm - Perhaps you'll give up your hat some day, and pass on the torch to a new ringleader."
			else if(alive)
				flavor_message += 	"You watch the quitters hurry home, to their BORING lives, though the fun has JUST began! You're sure the others have given them a few long-lasting parting gifts for courtesy's sake, however. \
									The moon may be far, and you may not reach the stars - but it was always watching and SEES the deeds you have done, illuminating the stage in pale light."
			else //Dead
				flavor_message += 	"The music starts to fade, the lights all get blurry - yet you feel cheer as you make friends with the cold station floor. There is no fear, for why would you fear? \
									Not everyone has the main role - and you, my dear, have danced beautifully. Let those curtains close and bow out to the public, the backstage awaits - there's much more cheer to be had..."

		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"What. A. PERFORMANCE! You may not have had your encore, but the emotion, oh the EFFORT! The night waits for you to seize the day once more, until then, the moon will howl to you - \
				telling stories of what joys you could bring..."
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"Your eyes watch the shuttle hurriedly lift from the station - perhaps the music was not to their taste. Though, as all know, a party must be MEMORABLE, \
									and they will sure remember your smile, your laughter and the music echoing through their minds when a light outside their curtains shines too-brightly to let them rest. \
									You know you'll meet the Ringleader again, you'll meet him on the dark side of the moon..."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"You stand on that stage, in the spotlight - all eyes on you. Reciting your final piece, your act isn't yet done! Yet... The curtain is behind you already, you see it encroaching \
									Turning your gaze away, ignoring it, you look to the shimmering tiles, the contorted lips, you preach and cheer, they clap and dance! You're flying now, it's all so much clearer than from the seats! \
									Thrash, the curtains cover your shoulders, the world rings back it's bells at you, perhaps you should have thought some more - the view from halfway through. You wanted to play a part, to be important, \
									well you did it. Now bow, a happy ending or a sad ending is an ending nonetheless."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"You've escaped the station, but you know this isn't the end. Performance isn't an art for yourself, it's for OTHERS - Your duty doesn't end here. So don't stop dancing, don't stop dancing till the curtains fall..."
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"The audience has left. You'd wish the red over your body was tomatoes and shame. Your grand parade was a solo hike, your grand jubilation a quiet vinyl record in a dim room... The moon turns it's gaze from you,\
									the troupe has no place for small-fry and anything less than grand. Perhaps it's for the best, perhaps you can waltz on a lonelier path, perhaps the moon you looked up to was never there and but a trick of a sick mind. \
									...\
									or perhaps a different ringleader will help you smile once more, someday..."
			else //Dead
				flavor_message += 	"A tragic ending. Your script has reached it's last paragraph - end of the line. The part of the ringleader eludes you, and noone will remember yet another name on a casting list. Forgotten by the troupe and their cold, unflinching smiles \
									and deemed a lunatic by the normal. A grand parade will need more rehearsal - one day, a waxing you will turn gibbous, but that day is not today..."
	else if(heretic_path == PATH_VOID) //Void epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"Arriving at Centcom you smile, the infinite winds billow behind your back, bringing a new age of Ice to the system."
			else if(alive)
				flavor_message += 	"You watch as the shuttle leaves, smirking, you turn your gaze to the planet below, planning your next moves carefully, ready to expand your domain of Ice."
			else //Dead
				flavor_message += 	"Your body freezes and shatters, but it is not the end. Your eternal spirit will live on, and the storm you called will never stop in this sector. You have won the war."

		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"The mission is done, the stage is set, though you did not reach the peak of power, you achieved what many thought impossible."
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"Your success has been noted, and the coming storm will grant you powers of ice beyond all mortal comprehension. You need only wait..."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"As your body crumbles to snow, you smile one last toothy grin, knowing the fate of those who will freeze, despite your demise."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"You escaped, but at what cost? Your mission a failure, along with you. The coming days will not be kind."
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"Stepping through the empty halls of the station, you look towards the empty space, and contemplate your failures."
			else //Dead
				flavor_message += 	"As your body shatters, the last pieces of your consciousness wonder what you could have done differently, before the spark of life dissipates."

	else if(heretic_path == PATH_BLADE) //blade epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"The hallway leading to the shuttle explodes in a whirlwind of blades, each step you take cutting a path to your new reality."
			else if(alive)
				flavor_message += 	"Watching the shuttle as it jumps to warp puts a smile on your face, you ready your blade to cut through space and time. They won't escape."
			else //Dead
				flavor_message += 	"As your blade falls from your hand, it hits the ground and shatters, splintering into an uncountable amount of smaller blades. As long as one survives, your soul will exist, and you will return to cut again."

		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"You've crafted an impossible amount of blades, and made a mountain of corpses doing so. Victory is yours today!"
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"You sharpen your newly formed blade, made from the bones and soul of your enemies. Smirking, you think of new and twisted ways to continue your craft."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"As the world goes dark, a flash of steel crosses the boundry between reality and the veil. Though you may pass here, those who felled you will not last."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"You sit on a bench at centcom, escaping the madness of the station. You've failed, and will never smith a blade again."
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"Your bloodied hand pounds on the nearest wall, a failure of a smith you turned out to be. You pray someone finds your emergency beacon on this abandoned station."
			else //Dead
				flavor_message += 	"You lay there, life draining from your body onto the station around you. The last thing you see is your reflection in your own blade, and then it all goes dark."

	else if(heretic_path == PATH_COSMIC) //Cosmic epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"As the shuttle docks cosmic radiation pours from the doors, the lifeless corpses of those who dared defy you remain. Unmake the rest of them."
			else if(alive)
				flavor_message += 	"You turn to watch the escape shuttle leave, waving a small goodbye before beginning your new duty: Remaking the cosmos in your image."
			else //Dead
				flavor_message += 	"A loud scream is heard around the cosmos, your death cry will awaken your brothers and sisters, you will be remembered as a martyr."

		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"You completed everything you had set out to do and more on this station, now you must take the art of the cosmos to the rest of humanity."
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"You feel the great creator look upon you with glee, opening a portal to his realm for you to join it."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"As your body melts away into the stars, your consciousness carries on to the nearest star, beginning a super nova. A victory, in a sense."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"You step off the shuttle, knowing your time is limited now that you have failed. Cosmic radiation seeps through your soul, what will you do next?"
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"Dragging your feet through what remains of the ruined station, you can only laugh as the stars continue to twinkle in the sky, despite everything."
			else //Dead
				flavor_message += 	"Your skin turns to dust and your bones reduce to raw atoms, you will be forgotten in the new cosmic age."

	else if(heretic_path == PATH_LOCK) //Cosmic epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"The shuttle docks at Centcom, the doors open but instead of people a mass of horrors pour out, consuming everyone in their path."
			else if(alive)
				flavor_message += 	"You've opened the door, unlocked the lock, became the key. Crack open the rest of reality, door by door."
			else //Dead
				flavor_message += 	"For a fleeting moment, you opened a portal to the end of days. Nothing could have brought you greater satisfaction, and you pass in peace"

		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"With each gleeful step you take through the station, you look at the passing airlocks, knowing the truth that you will bring."
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"The shuttle is gone, you are alone. And yet, as you turn to the nearest airlock, what waits beyond is something only you can see."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"Your death is not your end, as your bones will become the key for another's path to glory."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"You escaped, but for what? For the rest of your life you avoid doorways, knowing that once you pass through one, you may not come back."
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"Step by step, you walk the halls of the abandonded tarnished station, ID in hand looking for the right door. The door to oblivion."
			else //Dead
				flavor_message += 	"As the last of your life drains from you, all you can manage is to lay there dying. Nobody will remember your deeds here today."
	else //Unpledged epilogues

		if(cultiewin) //Completed objectives (WITH NO RESEARCH MIND YOU)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"You have always delighted in challenges. You heard the call of the Mansus, yet you chose not to pledge to any principle. \
									Still, you gave the things of other worlds their tithes. You step into Centcom with a stern sense of focus. Who knows what \
									you will do next? You feel as if your every step is watched, as one who gave wholly to that other world without taking anything in \
									return. Perhaps you will call earned bargains someday. But not today. Today, you celebrate a masterful performance."
			else if(alive)
				flavor_message += 	"You have always delighted in challenges. You heard the call of the Mansus, yet you chose not to pledge to any principle. \
									Still, you gave the things of other worlds their tithes. Though you walk the halls of the station alone, the book still \
									whispers to you in your pocket. You have refused to open it. Perhaps you will some day. Until then, you are content to \
									derive favors owed from the entities beyond. They are watching you. And, some day, you will ask for their help. But not today."
			else //Dead
				flavor_message += 	"You have always delighted in challenges. You heard the call of the Mansus, yet you chose not to pledge to any principle. \
									Still, you gave the things of other worlds their tithes. You gave your life in the process, but there is a wicked satisfaction \
									that overtakes you. You have proved yourself wiser, more cunning than the rest who fail with the aid of their boons. \
									Your body and soul can rest knowing the humiliation you have cast upon countless students. Yours will be the last laugh."

		else //Failed objectives
			if(escaped)
				flavor_message += 	"You decided not to follow the power you had become aware of. From time to time, you will return to the Wood in \
									your dreams, but you will never aspire to greatness. One day, you will die, and perhaps those close to you in life \
									will honor you. Then, another day, you will be forgotten. The world will move on as you cease to exist."
			else if(alive)
				flavor_message += 	"What purpose did you serve? Your mind had been opened to greatness, yet you denied it and chose to live your \
									days as you always have: one of the many, one of the ignorant. Look at where your lack of ambition has gotten \
									you now: stranded, like a fool. Even if you do escape, you will die some day. You will be forgotten."
			else //Dead
				flavor_message += 	"Perhaps it is better this way. You chose not to make a plunge into the Mansus, yet your soul returns to it. \
									You will drift down, deeper, further, until you are forgotten to nothingness."



	flavor += "<font color=[message_color]>[flavor_message]</font></div>"
	return "<div>[flavor.Join("<br>")]</div>" // END HERE

/datum/antagonist/heretic/get_admin_commands()
	. = ..()

	switch(has_living_heart())
		if(HERETIC_NO_LIVING_HEART)
			.["Give Living Heart"] = CALLBACK(src, PROC_REF(give_living_heart))
		if(HERETIC_HAS_LIVING_HEART)
			.["Add Heart Target (Marked Mob)"] = CALLBACK(src, PROC_REF(add_marked_as_target))
			.["Remove Heart Target"] = CALLBACK(src, PROC_REF(remove_target))

	.["Adjust Knowledge Points"] = CALLBACK(src, PROC_REF(admin_change_points))
	.["Give Focus"] = CALLBACK(src, PROC_REF(admin_give_focus))

/**
 * Admin proc for giving a heretic a Living Heart easily.
 */
/datum/antagonist/heretic/proc/give_living_heart(mob/admin)
	if(!admin.client?.holder)
		to_chat(admin, span_warning("You shouldn't be using this!"))
		return

	var/datum/heretic_knowledge/living_heart/heart_knowledge = get_knowledge(/datum/heretic_knowledge/living_heart)
	if(!heart_knowledge)
		to_chat(admin, span_warning("The heretic doesn't have a living heart knowledge for some reason. What?"))
		return

	heart_knowledge.on_research(owner.current, src)

/**
 * Admin proc for adding a marked mob to a heretic's sac list.
 */
/datum/antagonist/heretic/proc/add_marked_as_target(mob/admin)
	if(!admin.client?.holder)
		to_chat(admin, span_warning("You shouldn't be using this!"))
		return

	var/mob/living/carbon/human/new_target = admin.client?.holder.marked_datum
	if(!istype(new_target))
		to_chat(admin, span_warning("You need to mark a human to do this!"))
		return

	if(tgui_alert(admin, "Let them know their targets have been updated?", "Whispers of the Mansus", list("Yes", "No")) == "Yes")
		to_chat(owner.current, span_danger("The Mansus has modified your targets. Go find them!"))
		to_chat(owner.current, span_danger("[new_target.real_name], the [new_target.mind?.assigned_role?.title || "human"]."))

	add_sacrifice_target(new_target)

/**
 * Admin proc for removing a mob from a heretic's sac list.
 */
/datum/antagonist/heretic/proc/remove_target(mob/admin)
	if(!admin.client?.holder)
		to_chat(admin, span_warning("You shouldn't be using this!"))
		return

	var/list/removable = list()
	for(var/mob/living/carbon/human/old_target as anything in sac_targets)
		removable[old_target.name] = old_target

	var/name_of_removed = tgui_input_list(admin, "Choose a human to remove", "Who to Spare", removable)
	if(QDELETED(src) || !admin.client?.holder || isnull(name_of_removed))
		return
	var/mob/living/carbon/human/chosen_target = removable[name_of_removed]
	if(QDELETED(chosen_target) || !ishuman(chosen_target))
		return

	if(!remove_sacrifice_target(chosen_target))
		to_chat(admin, span_warning("Failed to remove [name_of_removed] from [owner]'s sacrifice list. Perhaps they're no longer in the list anyways."))
		return

	if(tgui_alert(admin, "Let them know their targets have been updated?", "Whispers of the Mansus", list("Yes", "No")) == "Yes")
		to_chat(owner.current, span_danger("The Mansus has modified your targets."))

/**
 * Admin proc for easily adding / removing knowledge points.
 */
/datum/antagonist/heretic/proc/admin_change_points(mob/admin)
	if(!admin.client?.holder)
		to_chat(admin, span_warning("You shouldn't be using this!"))
		return

	var/change_num = tgui_input_number(admin, "Add or remove knowledge points", "Points", 0, 100, -100)
	if(!change_num || QDELETED(src))
		return

	knowledge_points += change_num

/**
 * Admin proc for giving a heretic a focus.
 */
/datum/antagonist/heretic/proc/admin_give_focus(mob/admin)
	if(!admin.client?.holder)
		to_chat(admin, span_warning("You shouldn't be using this!"))
		return

	var/mob/living/pawn = owner.current
	pawn.equip_to_slot_if_possible(new /obj/item/clothing/neck/heretic_focus(get_turf(pawn)), ITEM_SLOT_NECK, TRUE, TRUE)
	to_chat(pawn, span_hypnophrase("The Mansus has manifested you a focus."))

/datum/antagonist/heretic/antag_panel_data()
	var/list/string_of_knowledge = list()

	for(var/knowledge_index in researched_knowledge)
		var/datum/heretic_knowledge/knowledge = researched_knowledge[knowledge_index]
		if(istype(knowledge, /datum/heretic_knowledge/ultimate))
			string_of_knowledge += span_bold(knowledge.name)
		else
			string_of_knowledge += knowledge.name

	return "<br><b>Research Done:</b><br>[english_list(string_of_knowledge, and_text = ", and ")]<br>"

/datum/antagonist/heretic/antag_panel_objectives()
	. = ..()

	. += "<br>"
	. += "<i><b>Current Targets:</b></i><br>"
	if(LAZYLEN(sac_targets))
		for(var/mob/living/carbon/human/target as anything in sac_targets)
			. += " - <b>[target.real_name]</b>, the [target.mind?.assigned_role?.title || "human"].<br>"

	else
		. += "<i>None!</i><br>"
	. += "<br>"

/**
 * Learns the passed [typepath] of knowledge, creating a knowledge datum
 * and adding it to our researched knowledge list.
 *
 * Returns TRUE if the knowledge was added successfully. FALSE otherwise.
 */
/datum/antagonist/heretic/proc/gain_knowledge(datum/heretic_knowledge/knowledge_type)
	if(!ispath(knowledge_type))
		stack_trace("[type] gain_knowledge was given an invalid path! (Got: [knowledge_type])")
		return FALSE
	if(get_knowledge(knowledge_type))
		return FALSE
	var/datum/heretic_knowledge/initialized_knowledge = new knowledge_type()
	researched_knowledge[knowledge_type] = initialized_knowledge
	initialized_knowledge.on_research(owner.current, src)
	update_static_data(owner.current)
	return TRUE

/**
 * Get a list of all knowledge TYPEPATHS that we can currently research.
 */
/datum/antagonist/heretic/proc/get_researchable_knowledge()
	var/list/researchable_knowledge = list()
	var/list/banned_knowledge = list()
	for(var/knowledge_index in researched_knowledge)
		var/datum/heretic_knowledge/knowledge = researched_knowledge[knowledge_index]
		researchable_knowledge |= GLOB.heretic_research_tree[knowledge_index][HKT_NEXT]
		banned_knowledge |= GLOB.heretic_research_tree[knowledge_index][HKT_BAN]
		banned_knowledge |= knowledge.type
	researchable_knowledge -= banned_knowledge
	return researchable_knowledge

/**
 * Check if the wanted type-path is in the list of research knowledge.
 */
/datum/antagonist/heretic/proc/get_knowledge(wanted)
	return researched_knowledge[wanted]

/// Makes our heretic more able to rust things.
/// if side_path_only is set to TRUE, this function does nothing for rust heretics.
/datum/antagonist/heretic/proc/increase_rust_strength(side_path_only=FALSE)
	if(side_path_only && get_knowledge(/datum/heretic_knowledge/limited_amount/starting/base_rust))
		return

	rust_strength++

/**
 * Get a list of all rituals this heretic can invoke on a rune.
 * Iterates over all of our knowledge and, if we can invoke it, adds it to our list.
 *
 * Returns an associated list of [knowledge name] to [knowledge datum] sorted by knowledge priority.
 */
/datum/antagonist/heretic/proc/get_rituals()
	var/list/rituals = list()

	for(var/knowledge_index in researched_knowledge)
		var/datum/heretic_knowledge/knowledge = researched_knowledge[knowledge_index]
		if(!knowledge.can_be_invoked(src))
			continue
		rituals[knowledge.name] = knowledge

	return sortTim(rituals, GLOBAL_PROC_REF(cmp_heretic_knowledge), associative = TRUE)

/**
 * Checks to see if our heretic can ccurrently ascend.
 *
 * Returns FALSE if not all of our objectives are complete, or TRUE otherwise.
 */
/datum/antagonist/heretic/proc/can_ascend()
	if(!can_assign_self_objectives)
		return FALSE // We spurned the offer of the Mansus :(
	if(feast_of_owls)
		return FALSE // We sold our ambition for immediate power :/
	for(var/datum/objective/must_be_done as anything in objectives)
		if(!must_be_done.check_completion())
			return FALSE
	return TRUE

/**
 * Helper to determine if a Heretic
 * - Has a Living Heart
 * - Has a an organ in the correct slot that isn't a living heart
 * - Is missing the organ they need in the slot to make a living heart
 *
 * Returns HERETIC_NO_HEART_ORGAN if they have no heart (organ) at all,
 * Returns HERETIC_NO_LIVING_HEART if they have a heart (organ) but it's not a living one,
 * and returns HERETIC_HAS_LIVING_HEART if they have a living heart
 */
/datum/antagonist/heretic/proc/has_living_heart()
	var/obj/item/organ/our_living_heart = owner.current?.get_organ_slot(living_heart_organ_slot)
	if(!our_living_heart)
		return HERETIC_NO_HEART_ORGAN

	if(!HAS_TRAIT(our_living_heart, TRAIT_LIVING_HEART))
		return HERETIC_NO_LIVING_HEART

	return HERETIC_HAS_LIVING_HEART

/// Heretic's minor sacrifice objective. "Minor sacrifices" includes anyone.
/datum/objective/minor_sacrifice
	name = "minor sacrifice"

/datum/objective/minor_sacrifice/New(text)
	. = ..()
	target_amount = rand(3, 4)
	update_explanation_text()

/datum/objective/minor_sacrifice/update_explanation_text()
	. = ..()
	explanation_text = "Sacrifice at least [target_amount] crewmembers."

/datum/objective/minor_sacrifice/check_completion()
	var/datum/antagonist/heretic/heretic_datum = owner?.has_antag_datum(/datum/antagonist/heretic)
	if(!heretic_datum)
		return FALSE
	return completed || (heretic_datum.total_sacrifices >= target_amount)

/// Heretic's major sacrifice objective. "Major sacrifices" are heads of staff.
/datum/objective/major_sacrifice
	name = "major sacrifice"
	target_amount = 1
	explanation_text = "Sacrifice 1 head of staff."

/datum/objective/major_sacrifice/check_completion()
	var/datum/antagonist/heretic/heretic_datum = owner?.has_antag_datum(/datum/antagonist/heretic)
	if(!heretic_datum)
		return FALSE
	return completed || (heretic_datum.high_value_sacrifices >= target_amount)

/// Heretic's research objective. "Research" is heretic knowledge nodes (You start with some).
/datum/objective/heretic_research
	name = "research"
	/// The length of a main path. Calculated once in New().
	var/static/main_path_length = 0

/datum/objective/heretic_research/New(text)
	. = ..()

	if(!main_path_length)
		// Let's find the length of a main path. We'll use rust because it's the coolest.
		// (All the main paths are (should be) the same length, so it doesn't matter.)
		var/rust_paths_found = 0
		for(var/datum/heretic_knowledge/knowledge as anything in subtypesof(/datum/heretic_knowledge))
			if(GLOB.heretic_research_tree[knowledge][HKT_ROUTE] == PATH_RUST)
				rust_paths_found++

		main_path_length = rust_paths_found

	// Factor in the length of the main path first.
	target_amount = main_path_length
	// Add in the base research we spawn with, otherwise it'd be too easy.
	target_amount += length(GLOB.heretic_start_knowledge)
	// And add in some buffer, to require some sidepathing, especially since heretics get some free side paths.
	target_amount += rand(2, 4)
	update_explanation_text()

/datum/objective/heretic_research/update_explanation_text()
	. = ..()
	explanation_text = "Research at least [target_amount] knowledge from the Mansus. You start with [length(GLOB.heretic_start_knowledge)] researched."

/datum/objective/heretic_research/check_completion()
	var/datum/antagonist/heretic/heretic_datum = owner?.has_antag_datum(/datum/antagonist/heretic)
	if(!heretic_datum)
		return FALSE
	return completed || (length(heretic_datum.researched_knowledge) >= target_amount)

/datum/objective/heretic_summon
	name = "summon monsters"
	target_amount = 2
	explanation_text = "Summon 2 monsters from the Mansus into this realm."
	/// The total number of summons the objective owner has done
	var/num_summoned = 0

/datum/objective/heretic_summon/check_completion()
	return completed || (num_summoned >= target_amount)

/datum/outfit/heretic
	name = "Heretic (Preview only)"

	suit = /obj/item/clothing/suit/hooded/cultrobes/eldritch
	head = /obj/item/clothing/head/hooded/cult_hoodie/eldritch
	r_hand = /obj/item/melee/touch_attack/mansus_fist
