/// This is a special subtype of mob_holder that *spawns with a mob included* instead of being created by scooping a mob.
/// It can override the name & description of the included mob as well.
/obj/item/mob_holder/pet
	// Path to the mob that should be spawned on initialization.
	var/mob/living/starting_pet
	// Tracks if a custom name has been provided that should override the mob's default.
	var/renamed = FALSE
	// Tracks if a custom description has been provided that should override the mob's default.
	var/redescribed = FALSE

/obj/item/mob_holder/pet/Initialize(mapload, mob/living/held_mob, worn_state, head_icon, lh_icon, rh_icon, worn_slot_flags = NONE)
	held_mob = new starting_pet(src)
	if(renamed)
		held_mob.name = name
	if(redescribed)
		held_mob.desc = desc
	worn_state = held_mob.held_state
	head_icon = held_mob.head_icon
	lh_icon = held_mob.held_lh
	rh_icon = held_mob.held_rh
	worn_slot_flags = held_mob.worn_slot_flags
	return ..()

/// If this gets renamed, make sure to paste the new name onto the mob as well.
/// If, for whatever reason, this gets called before Initialize, it also sets renamed = TRUE to ensure that the mob gets the custom name on initialization.
/obj/item/mob_holder/pet/on_loadout_custom_named()
	. = ..()
	renamed = TRUE
	if(held_mob != null)
		held_mob.name = name

/// See above.
/obj/item/mob_holder/pet/on_loadout_custom_described()
	. = ..()
	redescribed = TRUE
	if(held_mob != null)
		held_mob.desc = desc

/// == DONATOR PET: Mr. Fluff, Central's Mothroach, ckey centralsmith ==
/mob/living/basic/mothroach/mr_fluff
	name = "Mr. Fluff"
	desc = "Central's beloved pet mothroach, Mr. Fluff. He looks so happy to be here!"
	gender = MALE
	icon = 'modular_zubbers/icons/mob/donator_pets.dmi'
	ai_controller = /datum/ai_controller/basic_controller/mothroach/mr_fluff

/// Mr. Fluff's controller. Uses not_friends for fleeing so he won't panic at his own owner.
/datum/ai_controller/basic_controller/mothroach/mr_fluff
	blackboard = list(
		BB_FLEE_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_EAT_FOOD_COOLDOWN = 1 MINUTES,
	)

/mob/living/basic/mothroach/mr_fluff
	/// His command list. Separate var - base pet_commands is static, so assigning it would hit every mothroach.
	var/static/list/fluff_pet_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/free,
		/datum/pet_command/follow/start_active,
		/datum/pet_command/nuzzle,
		/datum/pet_command/good_boy/mr_fluff,
	)

/mob/living/basic/mothroach/mr_fluff/Initialize(mapload)
	. = ..()
	// obeys_commands is DUPE_UNIQUE, so the stock list has to go before his goes on.
	qdel(GetComponent(/datum/component/obeys_commands))
	AddComponent(/datum/component/obeys_commands, fluff_pet_commands)
	// No udder for my moff. Stop trying to milk him, you weirdo.
	qdel(GetComponent(/datum/component/udder))

/// Pick this from his radial menu and click someone, and he'll trundle over to say hi.
/datum/pet_command/nuzzle
	command_name = "Nuzzle"
	command_desc = "Send Mr. Fluff over to nuzzle someone."
	radial_icon_state = "move"
	requires_pointing = TRUE
	command_feedback = "flutters"
	pointed_reaction = "affectionately"

/datum/pet_command/nuzzle/add_new_friend(mob/living/tamer)
	. = ..()
	// Ignore plain pointing - don't want him bolting at whoever I'm gesturing at mid-conversation.
	UnregisterSignal(tamer, COMSIG_MOVABLE_POINTED)

/datum/pet_command/nuzzle/look_for_target(mob/living/pointing_friend, mob/living/pointed_atom)
	var/mob/living/parent = weak_parent.resolve()
	if(isnull(parent))
		return FALSE
	if(isliving(pointed_atom) && pointed_atom != parent && pointed_atom.stat != DEAD && ..())
		return TRUE
	parent.balloon_alert_to_viewers("tilts head")
	parent.visible_message(span_notice("[parent] doesn't know what to do with [pointed_atom]."))
	return FALSE

/datum/pet_command/nuzzle/on_target_set(mob/living/friend, atom/potential_target)
	. = ..()
	if(!.)
		return
	var/mob/living/parent = weak_parent.resolve()
	execute_action(parent.ai_controller)

/datum/pet_command/nuzzle/execute_action(datum/ai_controller/controller)
	var/atom/nuzzle_target = controller.blackboard[BB_CURRENT_PET_TARGET]
	if(QDELETED(nuzzle_target))
		return
	controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, /datum/bt_node/subtree/pet_command/nuzzle)

/// Praise leaves his current command alone.
/datum/pet_command/good_boy/mr_fluff/set_command_active(mob/living/parent, mob/living/commander, radial_command = FALSE)
	new /obj/effect/temp_visual/heart(parent.loc)
	parent.emote("spin")

/datum/bt_node/subtree/pet_command/nuzzle
	behavior_tree_json = "modular_zubbers/code/modules/~donator/mothdonator_nuzzle.bt.json"

/// The nuzzle itself. He's already standing next to them by the time this runs.
/datum/bt_node/ai_behavior/nuzzle_target
	var/target_key

/datum/bt_node/ai_behavior/nuzzle_target/perform(seconds_per_tick, datum/ai_controller/controller)
	var/mob/living/nuzzler = controller.pawn
	var/mob/living/nuzzle_target = controller.blackboard[target_key]
	if(QDELETED(nuzzle_target) || nuzzle_target.stat == DEAD)
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	// Being next to someone isn't the same as being able to touch them. Windows exist.
	if(!nuzzle_target.IsReachableBy(nuzzler))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	nuzzler.manual_emote(pick(
		"nuzzles up against [nuzzle_target], wings fluttering happily!",
		"bonks his head against [nuzzle_target] and squeaks in delight!",
		"flutters excitedly and nuzzles [nuzzle_target]!",
		"burrows into [nuzzle_target] for a moment, chirping contentedly!",
		"nuzzles [nuzzle_target] with his entire fluffy being!",
	))
	new /obj/effect/temp_visual/heart(nuzzler.loc)
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED

/// Nuzzle's off. Target died, wandered out of reach, or he couldn't path to them.
/datum/bt_node/ai_behavior/nuzzle_give_up
	var/target_key

/datum/bt_node/ai_behavior/nuzzle_give_up/perform(seconds_per_tick, datum/ai_controller/controller)
	var/mob/living/nuzzler = controller.pawn
	var/mob/living/nuzzle_target = controller.blackboard[target_key]
	if(!QDELETED(nuzzle_target))
		if(nuzzle_target.stat == DEAD)
			nuzzler.manual_emote("droops his wings sadly at [nuzzle_target].")
		else
			nuzzler.manual_emote("droops his wings, unable to reach [nuzzle_target].")
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED

/obj/item/mob_holder/pet/donator/centralsmith
	name = "Mr. Fluff"
	desc = "Central's beloved pet mothroach, Mr. Fluff. He looks so happy to be here!"
	icon = 'modular_zubbers/icons/mob/donator_pets.dmi'
	icon_state = "mothroach"
	starting_pet = /mob/living/basic/mothroach/mr_fluff

//FIND A BETTER SPOT FOR THIS
/datum/preference/choiced/pet_gender
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "pet_gender"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/choiced/pet_gender/init_possible_values()
	return list("Random", MALE, FEMALE, PLURAL, NEUTER)

/datum/preference/choiced/pet_gender/create_default_value()
	return PLURAL

/datum/preference/choiced/pet_gender/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Pet Owner" in preferences.all_quirks

/datum/preference/choiced/pet_gender/apply_to_human(mob/living/carbon/human/target, value)
	return

