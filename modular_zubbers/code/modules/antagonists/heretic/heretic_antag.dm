/datum/antagonist/heretic
	name = "\improper Acolyte"
	roundend_category = "Acolytes"
	antagpanel_category = "Acolyte"
	knowledge_points = 15 + 1 // we always have to spend one to unlock a path
	unlimited_blades = TRUE
	passive_level = 0
	passive_gain_timer = 35 MINUTES // passive progression is VERY... SLOW...
	ui_name = "AntagInfoHereticV2"
	var/max_combat_capability = 100
	var/datum/objective/drain_influences/drain_obj
	/// How many influences have we personally drained?
	var/drained_num = 0
	var/met_drained_num = FALSE
	var/datum/objective/open_ways/way_obj
	var/ways_opened = 0
	var/met_ways_num = FALSE

	var/can_craft_blades = FALSE
	var/mark_enabled = FALSE

	/*var/static/list/possible_wildcard_objs = list(
		null = 100,
		/datum/objective/sacrifice/lesser = 50,
		/datum/objective/sacrifice_pets = 50,

	)
	var/datum/objective/wildcard_obj*/

/datum/antagonist/heretic/forge_primary_objectives(heretic_research_tree)
	// total override

	var/datum/objective/drain_influences/drain_obj = new()
	drain_obj.owner = owner
	src.drain_obj = drain_obj
	objectives += drain_obj

	var/datum/objective/open_ways/way_obj = new()
	way_obj.owner = owner
	src.way_obj = way_obj
	objectives += way_obj

/datum/antagonist/heretic/proc/adjust_drained(adjustment)
	drained_num += adjustment
	if (!drain_obj)
		return
	if (!met_drained_num)
		adjust_knowledge_points(HERETIC_POINTS_PER_INFLUENCE) // TODO - consider if codex should give more. proooobably not. codex needs a new identity...
	if (drained_num >= drain_obj.target_amount && !met_drained_num)
		met_drained_num = TRUE
		to_chat(owner, span_hypnophrase("The SEAMS of the WORLD have REVEALED THEMSELVES TO YOU. You have risen HIGH! AND you SEE!!"))
		to_chat(owner, span_warning("You can no longer obtain knowledge points from influences, as your objective has been completed."))
		SEND_SOUND(owner, 'sound/effects/magic/knock.ogg')

/datum/antagonist/heretic/proc/adjust_ways_opened(adjustment)
	ways_opened += adjustment
	if (!way_obj)
		return
	if (!met_ways_num)
		adjust_knowledge_points(HERETIC_POINTS_PER_WAY)
	if (ways_opened >= way_obj.target_amount && !met_ways_num)
		met_ways_num = TRUE
		to_chat(owner, span_hypnophrase("Your mind DAZZLES with the LIGHT! You have seen MORE of the MANSUS with your OWN EYES than ANY MORTAL could ever DREAM!!"))
		to_chat(owner, span_warning("You can no longer obtain knowledge points from ways, as your objective has been completed."))
		SEND_SOUND(owner, 'sound/effects/magic/knock.ogg')
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

/datum/antagonist/heretic/should_show_aura()
	return FALSE // no aura thx

/datum/antagonist/heretic/roundend_report()
	var/list/parts = list()
	var/hereticwin = TRUE

	parts += printplayer(owner)
	parts += "<b>Influences Drained:</b> [drained_num]"
	parts += "<b>Ways Opened:</b> [ways_opened]"
	if(length(objectives))
		var/count = 1
		for(var/o in objectives)
			var/datum/objective/objective = o
			if(objective.check_completion())
				parts += "<b>Objective #[count]</b>: [objective.explanation_text] <span class='greentext'>Success!</b></span>"
			else
				parts += "<b>Objective #[count]</b>: [objective.explanation_text] [span_redtext("Fail.")]"
				hereticwin = FALSE
			count++
	if(hereticwin)
		parts += span_greentext("The [LOWER_TEXT(heretic_path.name)] acolyte was successful!")
	else
		parts += span_redtext("The [LOWER_TEXT(heretic_path.name)] acolyte has failed.")

	parts += "<b>Knowledge Researched:</b> "

	var/list/string_of_knowledge = list()

	for(var/knowledge_path in researched_knowledge)
		var/list/knowledge_info = researched_knowledge[knowledge_path]
		var/datum/heretic_knowledge/knowledge = knowledge_info[HKT_INSTANCE]
		string_of_knowledge += knowledge.name

	parts += english_list(string_of_knowledge)

	return parts.Join("<br>")
