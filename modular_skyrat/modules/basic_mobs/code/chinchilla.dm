/mob/living/basic/pet/chinchilla
	name = "chinchilla"
	desc = "They're like a mouse, but Australian."

	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	held_lh = 'modular_skyrat/master_files/icons/mob/inhands/pets_held_lh.dmi'
	held_rh = 'modular_skyrat/master_files/icons/mob/inhands/pets_held_rh.dmi'
	icon_state = "chinchilla_white"
	icon_living = "chinchilla_white"
	icon_dead = "chinchilla_white_dead"

	maxHealth = 10
	health = 10
	mob_size = MOB_SIZE_TINY

	speed = 1.25 //speedy little fuckers
	see_in_dark = 6

	butcher_results = list(/obj/item/food/meat/slab = 1)

	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kick"
	response_harm_simple = "kicks"

	gold_core_spawnable = FRIENDLY_SPAWN

	held_w_class = WEIGHT_CLASS_TINY
	held_state = "chinchilla_white"

	///In the case 'melee_damage_upper' is somehow raised above 0
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE

	ai_controller = /datum/ai_controller/basic_controller/chinchilla

	/// The color (i.e. "black" or "white") of this chinchilla, to determine the `icon_state`s to use for
	/// this specific instance. `null` by default, which makes it pick a valid value at random in
	/// Initialize()`.
	var/body_color

/mob/living/basic/pet/chinchilla/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/pet_bonus, "squeaks happily!")

	if(isnull(body_color))
		body_color = pick("black", "white")

	held_state = "chinchilla_[body_color]" // not handled by variety element
	AddElement(/datum/element/animal_variety, "chinchilla", body_color, FALSE)

	AddElement(/datum/element/can_be_held)

//ai behavior

/datum/ai_controller/basic_controller/chinchilla
	behavior_tree_json = "modular_skyrat/modules/basic_mobs/code/chinchilla.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_CURRENT_HUNTING_TARGET = null, // dust to take dust baths
	)
	ai_traits = STOP_MOVING_WHEN_PULLED

/datum/bt_node/subtree/roll_in_dust
	behavior_tree_json = "modular_skyrat/modules/basic_mobs/code/roll_in_dust.bt.json"

/datum/bt_node/ai_behavior/roll_in_dust
	time_between_perform = 10 SECONDS
	/// The smudge of dust we're chasing
	var/target_key
	/// The name of our target name
	var/target_name

/datum/bt_node/ai_behavior/roll_in_dust/setup(datum/ai_controller/controller)
	var/obj/effect/decal/cleanable/target = controller.blackboard[target_key]
	return !QDELETED(target)

/datum/bt_node/ai_behavior/roll_in_dust/perform(seconds_per_tick, datum/ai_controller/controller)
	var/obj/effect/decal/cleanable/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED
	target_name = target.name
	qdel(target)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/bt_node/ai_behavior/roll_in_dust/finish_action(datum/ai_controller/controller, succeeded)
	. = ..()
	var/mob/living/living_pawn = controller.pawn
	controller.clear_blackboard_key(target_key)
	if(!succeeded)
		return
	living_pawn.manual_emote("starts taking a dust bath in [target_name].")
	living_pawn.spin(10, 1)

/datum/bt_node/ai_behavior/random_speech/chinchilla
	speech_chance = 5
	emote_hear = list(
		"squeaks.",
		"chirps.",
	)
	emote_see = list(
		"sniffs around.",
		"jumps around.",
	)

//subtypes

/mob/living/basic/pet/chinchilla/white
	body_color = "white"

/mob/living/basic/pet/chinchilla/black
	body_color = "black"
