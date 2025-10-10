/// How long the aquatic will stay wet for, AKA how long until they get a mood debuff
#define DRY_UP_TIME 10 MINUTES
/// How many wetstacks an aquatic will get upon creation
#define WETSTACK_INITIAL 5
/// How many wetstacks an aquatic needs to activate the TRAIT_SLIPPERY trait
#define WETSTACK_THRESHOLD 3

/// Adds the slick skin trait
/datum/species/aquatic

	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_WATER_BREATHING,
		TRAIT_MUTANT_COLORS,
		TRAIT_SLICK_SKIN,
	)

	/// This variable stores the timer datum which appears if the mob becomes wet
	var/dry_up_timer = TIMER_ID_NULL

/datum/species/aquatic/get_species_description()
	return list("A template to create your own aquatic species! Shares traits with the Akula species.",
	)

// Wet_stacks handling
// more about grab_resists in `code\modules\mob\living\living.dm` at li 1119
// more about slide_distance in `code\game\turfs\open\_open.dm` at li 233
/// Lets register the signal which calls when we are above 10 wet_stacks
/datum/species/aquatic/on_species_gain(mob/living/carbon/aquatic, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	RegisterSignal(aquatic, COMSIG_MOB_TRIGGER_WET_SKIN, PROC_REF(wetted), aquatic)
	// lets give 15 wet_stacks on initial
	aquatic.set_wet_stacks(WETSTACK_INITIAL, remove_fire_stacks = FALSE)

/// Remove the signal on species loss
/datum/species/aquatic/on_species_loss(mob/living/carbon/aquatic, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(aquatic, COMSIG_MOB_TRIGGER_WET_SKIN)

/// This proc is called when a mob with TRAIT_SLICK_SKIN gains over 10 wet_stacks
/datum/species/aquatic/proc/wetted(mob/living/carbon/aquatic)
	SIGNAL_HANDLER
	// Apply the slippery trait if its not there yet
	if(!HAS_TRAIT(aquatic, TRAIT_SLIPPERY))
		ADD_TRAIT(aquatic, TRAIT_SLIPPERY, SPECIES_TRAIT)

	// Relieve the negative moodlet
	aquatic.clear_mood_event("dry_skin")
	// The timer which will initiate above 10 wet_stacks, and call dried() once the timer runs out
	dry_up_timer = addtimer(CALLBACK(src, PROC_REF(dried), aquatic), DRY_UP_TIME, TIMER_UNIQUE | TIMER_STOPPABLE)

/// This proc is called after a mob with the TRAIT_SLIPPERY has its related timer run out
/datum/species/aquatic/proc/dried(mob/living/carbon/aquatic)
	// A moodlet which will not go away until the user gets wet
	aquatic.add_mood_event("dry_skin", /datum/mood_event/dry_skin)

/// A simple overwrite which calls parent to listen to wet_stacks
/datum/status_effect/fire_handler/wet_stacks/tick(delta_time)
	. = ..()
	if(!owner)
		return
	if(HAS_TRAIT(owner, TRAIT_SLICK_SKIN) && stacks >= WETSTACK_THRESHOLD)
		SEND_SIGNAL(owner, COMSIG_MOB_TRIGGER_WET_SKIN)

	if(HAS_TRAIT(owner, TRAIT_SLIPPERY) && stacks <= 0.5) // Removed just before we hit 0 and delete the /status_effect/
		REMOVE_TRAIT(owner, TRAIT_SLIPPERY, SPECIES_TRAIT)

#undef DRY_UP_TIME
#undef WETSTACK_INITIAL
#undef WETSTACK_THRESHOLD
