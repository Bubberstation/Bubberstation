#define OBJECTIVES_TO_WIN 2
#define MAX_INFLUENCE_DRAIN 8

/datum/antagonist/heretic
	name = "\improper Acolyte"
	roundend_category = "Acolytes"
	antagpanel_category = "Acolyte"
	knowledge_points = 14 + 1 // we always have to spend one to unlock a path
	unlimited_blades = TRUE
	passive_level = 0
	passive_gain_timer = 40 MINUTES // passive progression is VERY... SLOW...
	ui_name = "AntagInfoHereticV2"
	var/max_combat_capability = 100
	/// How many influences have we personally drained?
	var/drained_num = 0
	var/met_drained_num = FALSE
	var/datum/objective/open_ways/way_obj
	var/ways_opened = 0
	var/met_ways_num = FALSE

	var/can_craft_blades = FALSE
	var/mark_enabled = FALSE

	/// Will this heretic antag datum be added to the global reality smash tracker list?
	var/generate_influences = TRUE

	var/static/list/possible_wildcard_objs = list(
		/datum/objective/heretic_wildcard/sacrifice = 80,
		/datum/objective/heretic_wildcard/supermatter = 80,
		/datum/objective/heretic_wildcard/ai_law = 80,
		/datum/objective/heretic_wildcard/steal_money = 70,
	)
	var/datum/objective/heretic_wildcard/wildcard_obj

/datum/antagonist/heretic/on_gain()
	. = ..()

	var/mob/living/carbon/owner_carbon = owner.current
	if (!istype(owner_carbon))
		return
	if (has_living_heart() != HERETIC_HAS_LIVING_HEART)
		var/obj/item/organ/heart/our_heart = owner_carbon.get_organ_slot(ORGAN_SLOT_HEART)
		our_heart.AddComponent(/datum/component/living_heart) // even synths get one free go

	to_chat(owner_carbon, span_doyourjobidiot("Acolyte is significnatly different from heretic. If you are a veteran, re-read everything."))

/datum/antagonist/heretic/forge_primary_objectives(heretic_research_tree)
	// total override

	var/datum/objective/open_ways/way_obj = new()
	way_obj.owner = owner
	src.way_obj = way_obj
	objectives += way_obj

	var/datum/objective/heretic_wildcard/wildcard_type = pick_weight(possible_wildcard_objs)
	src.wildcard_obj = new wildcard_type()
	wildcard_obj.owner = owner
	wildcard_obj.apply_to(src)
	objectives += wildcard_obj

/datum/antagonist/heretic/proc/adjust_drained(adjustment)
	drained_num += adjustment
	if (!met_drained_num)
		adjust_knowledge_points(HERETIC_POINTS_PER_INFLUENCE) // TODO - consider if codex should give more. proooobably not. codex needs a new identity...
	if (drained_num >= MAX_INFLUENCE_DRAIN && !met_drained_num)
		met_drained_num = TRUE
		to_chat(owner, span_hypnophrase("The SEAMS of the WORLD have REVEALED THEMSELVES TO YOU. You have risen HIGH! AND you SEE!!"))
		to_chat(owner, span_warning("You can no longer obtain knowledge points from influences."))
		SEND_SOUND(owner.current, sound('sound/effects/magic/knock.ogg'))

/datum/antagonist/heretic/proc/adjust_ways_opened(adjustment)
	ways_opened += adjustment
	if (!way_obj)
		return
	if (!met_ways_num)
		adjust_knowledge_points(HERETIC_POINTS_PER_WAY)
	if (ways_opened >= way_obj.target_amount && !met_ways_num)
		met_ways_num = TRUE
		way_obj.completed = TRUE
		to_chat(owner, span_hypnophrase("Your mind DAZZLES with the LIGHT! You have seen MORE of the MANSUS with your OWN EYES than ANY MORTAL could ever DREAM!!"))
		to_chat(owner, span_warning("You can no longer obtain knowledge points from ways, as your objective has been completed."))
		SEND_SOUND(owner.current, sound('sound/effects/magic/knock.ogg'))
		// its important we only give heretics very limtied progression. while progression is nice, unchecked progression ruins the way nonantags interact with them

/datum/antagonist/heretic/proc/get_allocated_combat_points()
	var/total = 0
	for (var/datum/heretic_knowledge/knowledge as anything in researched_knowledge)
		total += knowledge::combat_specialty
	return total

/datum/antagonist/heretic/purchase_knowledge(datum/heretic_knowledge/knowledge_type, category, update)
	var/budget = max_combat_capability - get_allocated_combat_points()
	var/wanted = knowledge_type::combat_specialty
	if (wanted > budget)
		return FALSE

	return ..()

/datum/antagonist/heretic/get_knowledge_data(datum/heretic_knowledge/knowledge, list/source_list, done, category)
	. = ..()

	.["combat_specialty"] = knowledge.combat_specialty

/datum/antagonist/heretic/ui_data(mob/user)
	. = ..()

	.["combat_points"] = get_allocated_combat_points()
	.["influences_drained"] = drained_num
	.["ways_opened"] = ways_opened

/datum/antagonist/heretic/ui_static_data(mob/user)
	. = ..()

	.["win_amount"] = OBJECTIVES_TO_WIN

/datum/antagonist/heretic/should_show_aura()
	return FALSE // no aura thx

/datum/antagonist/heretic/roundend_report()
	var/list/parts = list()

	parts += printplayer(owner)
	parts += "<b>Influences Drained:</b> [drained_num]"
	parts += "<b>Ways Opened:</b> [ways_opened]"
	var/completed = 0
	if(length(objectives))
		var/count = 1
		for(var/o in objectives)
			var/datum/objective/objective = o
			if(objective.check_completion())
				parts += "<b>Objective #[count]</b>: [objective.explanation_text] <span class='greentext'>Success!</b></span>"
				completed++
			else
				parts += "<b>Objective #[count]</b>: [objective.explanation_text] [span_redtext("Fail.")]"
			count++
	parts += span_boldnotice("[OBJECTIVES_TO_WIN] objectives were required to succeed...")
	if(completed >= min(OBJECTIVES_TO_WIN, objectives.len))
		parts += span_greentext("The [LOWER_TEXT(heretic_path.route)] acolyte was successful!")
	else
		parts += span_redtext("The [LOWER_TEXT(heretic_path.route)] acolyte has failed.")

	parts += "<b>Knowledge Researched:</b> "

	var/list/string_of_knowledge = list()

	for(var/knowledge_path in researched_knowledge)
		var/list/knowledge_info = researched_knowledge[knowledge_path]
		var/datum/heretic_knowledge/knowledge = knowledge_info[HKT_INSTANCE]
		string_of_knowledge += knowledge.name

	parts += english_list(string_of_knowledge)

	return parts.Join("<br>")

/datum/antagonist/heretic/proc/purge_shop_of_duplicates()
	for (var/iter_path in heretic_shops[HERETIC_KNOWLEDGE_SHOP])
		if (iter_path in researched_knowledge)
			heretic_shops[HERETIC_KNOWLEDGE_SHOP] -= iter_path

/datum/antagonist/heretic/event
	name = "Acolyte (No Influence Spawning)"

	generate_influences = FALSE

#undef OBJECTIVES_TO_WIN
#undef MAX_INFLUENCE_DRAIN
