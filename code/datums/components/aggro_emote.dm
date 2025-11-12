/// A component for ai-controlled atoms which plays a sound if they switch to a living target which they can attack
/datum/component/aggro_emote
	/// Blackboard key in which target data is stored
	var/target_key
	/// If we want to limit emotes to only play at mobs
	var/living_only
	/// List of emotes to play
	var/list/emote_list
	/// Audiable emotes to play
	var/list/audible_emote_list
	/// Do we taunt the target?
	var/list/speak_list
	/// Do we play any sounds?
	var/list/sounds
	/// Chance to play an emote
	var/emote_chance
	/// Chance to subtract every time we play an emote (permanently)
	var/subtract_chance
	/// Minimum chance to play an emote
	var/minimum_chance

/datum/component/aggro_emote/Initialize(
	target_key = BB_BASIC_MOB_CURRENT_TARGET,
	living_only = FALSE,
	list/emote_list,
	list/speak_list,
	list/sounds,
	list/audible_emote_list,
	emote_chance = 30,
	minimum_chance = 2,
	subtract_chance = 7,
)
	. = ..()
	if (!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	var/atom/atom_parent = parent
	if (!atom_parent.ai_controller)
		return COMPONENT_INCOMPATIBLE

	src.target_key = target_key
	src.emote_list = emote_list
	src.speak_list = speak_list
	src.sounds = sounds
	src.audible_emote_list = audible_emote_list
	src.emote_chance = emote_chance
	src.minimum_chance = minimum_chance
	src.subtract_chance = subtract_chance

/datum/component/aggro_emote/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_AI_BLACKBOARD_KEY_SET(target_key), PROC_REF(on_target_changed))

/datum/component/aggro_emote/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_AI_BLACKBOARD_KEY_SET(target_key))
	return ..()

/// When we get a new target, see if we want to bark at it
/datum/component/aggro_emote/proc/on_target_changed(atom/source)
	SIGNAL_HANDLER
	var/atom/new_target = source.ai_controller.blackboard[target_key]
	var/mob/living/mob = source
/// Used to pick and choose between emotes and audiable sounds

	// Grab the number length of each list
	var/emotes_length = emote_list?.len
	var/audible_emote_length = audible_emote_list?.len
	var/speak_emote_length = speak_list?.len
	// Add them all together
	var/total_choices_length = audible_emote_length + speak_emote_length + emotes_length
	//Pick a random number between 1 and the total length of every list
	var/random_number_in_range = rand(1, total_choices_length)
	var/sound_to_play = length(sounds) > 0 ? pick(sounds) : null
	// Calculate the emote chance and determin if you'll run an emote
	emote_chance = max(emote_chance - subtract_chance, minimum_chance)
	if (isnull(new_target) || !prob(emote_chance))
		return
	if (living_only && !isliving(new_target))
		return // If we don't want to bark at food items or chairs or windows

/// Randomly choose between each emote
	if(random_number_in_range <= audible_emote_length)
		source.manual_emote("[pick(audible_emote_list)]")
		playsound(source, sound_to_play, 80, vary = TRUE)
	else if(random_number_in_range <= (audible_emote_length + emotes_length))
		source.manual_emote("[pick(emote_list)] at [new_target].")
	else
		INVOKE_ASYNC(mob, TYPE_PROC_REF(/atom/movable, say), pick(speak_list), forced = "AI Controller")
		playsound(source, sound_to_play, 80, vary = TRUE)
