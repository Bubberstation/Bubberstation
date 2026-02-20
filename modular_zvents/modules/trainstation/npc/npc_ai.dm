/datum/targeting_strategy/basic/force_retaliate
	var/only_players = FALSE

/datum/targeting_strategy/basic/force_retaliate/faction_check(datum/ai_controller/controller, mob/living/living_mob, mob/living/the_target)
	if(only_players && !the_target.client)
		return ..()
	var/list/enemy_list = controller.blackboard[BB_BASIC_MOB_RETALIATE_LIST]
	if(enemy_list && islist(enemy_list))
		if(the_target in enemy_list)
			return FALSE
	return ..()

/datum/targeting_strategy/basic/force_retaliate/only_players
	only_players = TRUE

/datum/ai_behavior/observed_aggression
	var/target_list_kay = BB_BASIC_MOB_RETALIATE_LIST

/datum/ai_behavior/observed_aggression/perform(seconds_per_tick, datum/ai_controller/controller, atom/target)
	var/list/target_list = controller.blackboard[target_list_kay]
	if(!target || !target_list || !islist(target_list))
		return AI_BEHAVIOR_FAILED | AI_BEHAVIOR_INSTANT

	if(target in target_list)
		return AI_BEHAVIOR_SUCCEEDED | AI_BEHAVIOR_INSTANT
	target_list += target
	return AI_BEHAVIOR_SUCCEEDED | AI_BEHAVIOR_INSTANT


/datum/ai_controller/basic_controller/civilian
	blackboard = list(
		BB_ALWAYS_IGNORE_FACTION = TRUE,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/force_retaliate/only_players,
		BB_FLEE_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk/often

	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/clean_target_timed/flee_from,
		/datum/ai_planning_subtree/target_retaliate/to_flee,
		/datum/ai_planning_subtree/call_for_help/from_flee_key,
		/datum/ai_planning_subtree/flee_target/from_flee_key,
		/datum/ai_planning_subtree/random_speech/basic_npc,
	)

/datum/idle_behavior/idle_random_walk/often
	walk_chance = 80

/datum/ai_planning_subtree/random_speech/basic_npc

/datum/ai_planning_subtree/random_speech/basic_npc/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/basic/npc/pawn = controller.pawn
	if(!pawn || !istype(pawn, /mob/living/basic/npc))
		return

	var/speech_chance = pawn.speech_chance
	var/list/speak = pawn.speech_phrases
	var/list/emote_see = pawn.speech_emote_see
	var/list/emote_hear = pawn.speech_emote_hear

	if(!SPT_PROB(speech_chance, seconds_per_tick))
		return

	var/audible_length = length(emote_hear)
	var/non_audible_length = length(emote_see)
	var/speak_length = length(speak)

	var/total = audible_length + non_audible_length + speak_length
	if(total <= 0)
		return

	var/choice = rand(1, total)
	var/sound_to_play = null

	if(choice <= audible_length)
		var/emote = default_replace_text(pick(emote_hear), pawn)
		controller.queue_behavior(/datum/ai_behavior/perform_emote, emote, sound_to_play)
		return

	choice -= audible_length
	if(choice <= non_audible_length)
		var/emote = default_replace_text(pick(emote_see), pawn)
		controller.queue_behavior(/datum/ai_behavior/perform_emote, emote)
		return

	for(var/mob/living/carbon/human/H in view(5, pawn))
		if(H.stat == CONSCIOUS && H.alpha != 0 && H.client)
			var/phrase = pick(speak)
			phrase = default_replace_text(phrase, pawn, H)
			controller.queue_behavior(/datum/ai_behavior/perform_speech, phrase, sound_to_play)
			break

/datum/ai_planning_subtree/random_speech/basic_npc/proc/default_replace_text(phrase, mob/living/pawn, mob/living/target)
	if(!phrase || !istext(phrase))
		return ""
	phrase = replacetext(phrase, "%PTHEIR%", pawn.p_their())
	if(target)
		phrase = replacetext(phrase, "%MOBNAME%", target.name)
	return phrase

/datum/ai_planning_subtree/call_for_help
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/set_key = BB_BASIC_MOB_CURRENT_TARGET
	var/list/call_for_faction = list(FACTION_POLICE)
	var/list/trusted_factions = list(FACTION_POLICE)
	var/list/exclude_faction = list(FACTION_NEUTRAL, FACTION_HOSTILE)
	var/search_range = 9
	var/speak = TRUE
	var/list/speak_help = list("Help!", "I was attacked!")

/datum/ai_planning_subtree/call_for_help/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/atom/attacker = controller.blackboard[target_key]
	var/mob/living/pawn = controller.pawn
	if(!attacker || QDELETED(attacker) || pawn == attacker)
		return

	if(is_ally(attacker, pawn, faction_to_check = call_for_faction, trusted_check = trusted_factions))
		return

	if(speak && SPT_PROB(70, seconds_per_tick))
		controller.queue_behavior(/datum/ai_behavior/perform_speech, pick(speak_help))

	for(var/mob/living/saver in view(search_range, pawn))
		if(saver == pawn)
			continue
		if(!saver.ai_controller)
			continue
		if(!is_ally(saver, pawn, faction_to_check = call_for_faction, trusted_check = trusted_factions))
			continue
		if(saver.stat >= UNCONSCIOUS || saver.health <= 0)
			continue
		saver.ai_controller.queue_behavior(/datum/ai_behavior/observed_aggression, attacker)

/datum/ai_planning_subtree/call_for_help/proc/is_ally(mob/living/target, mob/living/pawn, list/faction_to_check, list/trusted_check)
	var/list/target_factions = target.faction
	if(trusted_check && faction_check(target_factions, trusted_check))
		return TRUE
	var/has_good = faction_check(target_factions, faction_to_check)
	var/has_bad = faction_check(target_factions, exclude_faction)

	if(has_good && !has_bad)
		return TRUE
	return FALSE

/datum/ai_planning_subtree/call_for_help/from_flee_key
	target_key = BB_BASIC_MOB_FLEE_TARGET

/datum/ai_planning_subtree/call_for_help/police
	call_for_faction = list(FACTION_POLICE)
	speak = TRUE
	speak_help = list("Officer needs backup!", "Suspect attacking officer!", "10-13!", "Shots fired!")


/datum/ai_controller/basic_controller/npc_police
	blackboard = list(
		BB_TARGET_MINIMUM_STAT = SOFT_CRIT,
		BB_BASIC_MOB_FLEE_DISTANCE = 5,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/force_retaliate/only_players,
		BB_BASIC_MOB_CUFF_TYPE = /obj/item/restraints/handcuffs/cable/zipties/used,
		BB_NPC_PATROL_POINT = null,
	)
	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/walk_near_target/patrol_point

	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/clean_target_timed,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/call_for_help/police,
		/datum/ai_planning_subtree/random_speech/basic_npc,
		/datum/ai_planning_subtree/return_to_point/patrol_point,
		/datum/ai_planning_subtree/cuff_if_downed,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/datum/ai_controller/basic_controller/npc_police/ranged
	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/walk_near_target/patrol_point

	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/clean_target_timed,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/call_for_help/police,
		/datum/ai_planning_subtree/random_speech/basic_npc,
		/datum/ai_planning_subtree/return_to_point/patrol_point,
		/datum/ai_planning_subtree/flee_target/if_to_close,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree,
	)

/datum/idle_behavior/walk_near_target/patrol_point
	target_key = BB_NPC_PATROL_POINT
	walk_chance = 50
	minimum_distance = 5

/datum/ai_planning_subtree/return_to_point
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/minimum_distance = 10
	var/stop_chase = TRUE

/datum/ai_planning_subtree/return_to_point/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	var/atom/current_target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(current_target && !stop_chase)
		return
	var/atom/return_to = controller.blackboard[target_key]
	if(!return_to)
		return
	if(get_dist(return_to, pawn) < minimum_distance)
		return
	controller.queue_behavior(/datum/ai_behavior/travel_towards_atom, return_to)

/datum/ai_planning_subtree/return_to_point/patrol_point
	target_key = BB_NPC_PATROL_POINT



/datum/ai_planning_subtree/clean_target_timed
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/target_time = 15 SECONDS
	var/forget_distance = 5

/datum/ai_planning_subtree/clean_target_timed/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/atom/current_target = controller.blackboard[target_key]
	if(!current_target)
		return

	var/last_target = controller.blackboard[BB_MEMORY_LAST_TARGET]
	var/last_time   = controller.blackboard[BB_MEMORY_LAST_TARGET_TIME]

	if(current_target != last_target)
		controller.set_blackboard_key(BB_MEMORY_LAST_TARGET, current_target)
		controller.set_blackboard_key(BB_MEMORY_LAST_TARGET_TIME, world.time)
		return

	if(!last_time)
		return

	var/time_elapsed = world.time - last_time
	var/dist = get_dist(controller.pawn, current_target)
	var/should_clear = (time_elapsed >= target_time && (dist > forget_distance || !isturf(current_target.loc)))
	if(isliving(current_target))
		var/mob/living/living_target = current_target
		if(living_target.stat == DEAD)
			should_clear = TRUE
	if(should_clear)
		controller.clear_blackboard_key(target_key)
		controller.clear_blackboard_key(BB_MEMORY_LAST_TARGET)
		controller.clear_blackboard_key(BB_MEMORY_LAST_TARGET_TIME)


/datum/ai_planning_subtree/cuff_if_downed
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/cuff_time = 5 SECONDS
	var/clear_target = TRUE

/datum/ai_planning_subtree/cuff_if_downed/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	var/atom/target = controller.blackboard[target_key]
	if(!target || !iscarbon(target))
		return
	if(controller.blackboard[BB_BASIC_MOB_BEGIN_CUFFING])
		return
	var/mob/living/carbon/carbon_target = target
	if(carbon_target.handcuffed)
		if(clear_target)
			controller.clear_blackboard_key(target_key)
		return
	if(!carbon_target.canBeHandcuffed())
		return
	if(!(carbon_target.staminaloss >= carbon_target.max_stamina))
		return
	if(get_dist(pawn, carbon_target) > 1)
		return
	var/cuff_type = controller.blackboard[BB_BASIC_MOB_CUFF_TYPE] || BB_BASIC_MOB_DEFAULT_CUFF_TYPE
	controller.queue_behavior(/datum/ai_behavior/zipties_target, target_key, cuff_type, cuff_time, clear_target)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_behavior/zipties_target/perform(seconds_per_tick, datum/ai_controller/controller, target_key, cuff_type, cuff_time, clear_target)
	var/mob/living/pawn = controller.pawn
	var/mob/living/carbon/carbon_target = controller.blackboard[target_key]
	if(!carbon_target || (get_dist(pawn, carbon_target) > 1) || carbon_target.handcuffed)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED
	if(controller.blackboard[BB_BASIC_MOB_BEGIN_CUFFING])
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED
	controller.set_blackboard_key(BB_BASIC_MOB_BEGIN_CUFFING, TRUE)
	to_chat(carbon_target, span_userdanger("[pawn] is trying to put zipties on you!"))
	pawn.visible_message(span_danger("[pawn] is trying to put zipties on [carbon_target]!"))
	if(!do_after(pawn, cuff_time, carbon_target))
		controller.clear_blackboard_key(BB_BASIC_MOB_BEGIN_CUFFING)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED
	controller.clear_blackboard_key(BB_BASIC_MOB_BEGIN_CUFFING)
	if(!QDELETED(carbon_target) && carbon_target.canBeHandcuffed())
		carbon_target.set_handcuffed(new cuff_type(carbon_target))
		carbon_target.update_handcuffed()
	if(clear_target)
		controller.clear_blackboard_key(target_key)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/add_enemy

/datum/ai_behavior/add_enemy/perform(seconds_per_tick, datum/ai_controller/controller, atom/enemy_shit)
	if(!controller.blackboard[BB_MEMORY_ENEMIES_LIST])
		controller.set_blackboard_key(BB_MEMORY_ENEMIES_LIST, list())
	if(!islist(controller.blackboard[BB_MEMORY_ENEMIES_LIST]))
		controller.set_blackboard_key(BB_MEMORY_ENEMIES_LIST, list())
	var/list/enemy_list = controller.blackboard[BB_MEMORY_ENEMIES_LIST]
	if(islist(enemy_list))
		if(enemy_list[enemy_shit])
			return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED
		enemy_list[enemy_shit] = world.time
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/ai_planning_subtree/clean_target_timed/flee_from
	target_key = BB_BASIC_MOB_FLEE_TARGET

/datum/ai_planning_subtree/flee_target/if_to_close
	var/maximum_distance = 2

/datum/ai_planning_subtree/flee_target/if_to_close/should_flee(datum/ai_controller/controller, atom/flee_from)
	if(get_dist(controller.pawn, flee_from) > maximum_distance)
		return FALSE
	return ..()
