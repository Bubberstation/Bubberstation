/// Phrases said to the holder when entering the chapel
#define CHAPELWEAK_PHRASES_ENTER pick(\
	"Your shadow creeps across the chapel's threshold. Seek solace from the divine, before the holy fire consumes you whole.",\
	"A sense of devotion envelops you, a bittersweet reminder of what you've lost.",\
	"The chapel's warmth is a cruel mockery, reminding you of what can never be yours.",\
	"In this sanctuary of light, you're reminded that even the purest faith cannot banish the shadows within.",\
	"You feel an unseen force from beyond pushing back against your presence, as if the very air resists your shadow.",\
	"The chapel's hallowed halls seem to whisper judgment against you, their silence a heavy weight.",\
	"An unspoken verdict hangs in the air, condemning you without a word."\
	)

/// Phrases said to the holder when exiting the chapel
#define CHAPELWEAK_PHRASES_EXIT pick(\
	"Your shadows retreats from the chapel, leaving behind only a memory of its presence.",\
	"As you leave, the chapel's influence wanes, but your darkness remains unvanquished.",\
	"The chapel's shadow retreats with yours, its influence receding from your presence.",\
	"You rejoin the night, leaving behind the chapel's influence that threatened to consume you.",\
	"The chapel's peace is restored, but at what cost to your soul?",\
	"Your shadow retreats from the holy place, no longer tainting its sacred ground."\
	)

/// Phrases said to the holder when ignited by the chapel
#define CHAPELWEAK_PHRASES_IGNITE pick(\
	"Divine fury bathes your accursed form in cleansing flame.",\
	"Holy flame sears through the darkness that clings to you.",\
	"In this moment, your will is torn asunder – your shadow consumed by an unyielding fire that seems almost... hungry.",\
	"The holy fire seems to find an unexpected fuel in your very darkness – a macabre dance of light and shadow.",\
	"Your skin feels as if it's being peeled away, exposing the dark core that lies beneath.",\
	"The flames dance with an otherworldly glee, as if they've discovered a long-forgotten secret within you.",\
	"The flames reveal your true nature: a creature forged in darkness.",\
	"Your shadow is repressed amidst the crackling inferno that engulfs your form, a living torch of divine vengeance.",\
	"Your shadow is consumed by the very fire it sought to escape."\
	)

/// Percentage chance of burning each tick while in the chapel
#define CHAPELWEAK_CHANCE_IGNITE 10
/// Amount of fire stacks to add when igniting
#define CHAPELWEAK_AMT_FIRESTACKS 2
/// Amount of disgust added per tick
#define CHAPELWEAK_AMT_DISGUST 5
/// Amount of stamina loss applied per tick
#define CHAPELWEAK_AMT_STAMLOSS 5

/**
 * Chapel Weakness element
 *
 * A mob with this element will be penalized for entering the chapel.
 * Penalty is ignored for the chaplain.
 *
 * Contains the following:
 * * Enter and leave warning messages
 * * Ticking disgust and stamina penalty
 * * Chance to spontaneously combust
 */
/datum/element/chapel_weakness
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH_ON_HOST_DESTROY
	argument_hash_start_idx = 2

/datum/element/chapel_weakness/Attach(datum/target)
	. = ..()

	// Check for living target
	if (!isliving(target))
		return ELEMENT_INCOMPATIBLE

	// Register area change signals
	RegisterSignal(target, COMSIG_ENTER_AREA, PROC_REF(on_entered))
	RegisterSignal(target, COMSIG_EXIT_AREA, PROC_REF(on_exited))

/datum/element/chapel_weakness/Detach(datum/source)
	. = ..()

	// Unregister area change signals
	UnregisterSignal(source, COMSIG_ENTER_AREA)
	UnregisterSignal(source, COMSIG_EXIT_AREA)

	// Define living mob
	var/mob/living/source_living = source

	// Remove status effect
	source_living?.remove_status_effect(/datum/status_effect/chapel_weakness)

/// Applied upon entering a new area
/datum/element/chapel_weakness/proc/on_entered(mob/living/mob_source, area/new_area)
	SIGNAL_HANDLER

	// Check for valid mob
	if(!mob_source)
		return

	// Check if this is the chapel
	if(!istype(new_area, /area/station/service/chapel))
		return

	// Check if mob is the chaplain
	if(mob_source.mind?.assigned_role?.title == JOB_CHAPLAIN)
		return

	// Add status effect
	mob_source.apply_status_effect(/datum/status_effect/chapel_weakness)

/// Applied upon exiting an area
/datum/element/chapel_weakness/proc/on_exited(mob/living/mob_source, area/old_area)
	SIGNAL_HANDLER

	// Check for valid mob
	if(!mob_source)
		return

	// Check if the departed area is the chapel
	if(!istype(old_area, /area/station/service/chapel))
		return

	// Check if the new area is also the chapel
	if(istype(get_area(mob_source), /area/station/service/chapel))
		return

	// Remove status effect
	mob_source.remove_status_effect(/datum/status_effect/chapel_weakness)

// Status effect for Chapel Weakness that applies locational penalties
/datum/status_effect/chapel_weakness
	id = "chapel_weakness_profane"
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/chapel_weakness_profane
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS

// Status effect alert
/atom/movable/screen/alert/status_effect/chapel_weakness_profane
	name = "Sacred Ground"
	desc = "The area you are currently within is protected by a holy force."
	icon_state = "terrified"
	alerttooltipstyle = "cult"

// Called when adding this status effect
/datum/status_effect/chapel_weakness/on_apply()
	. = ..()

	// Warn user
	to_chat(owner, span_cult(CHAPELWEAK_PHRASES_ENTER))

// Called when removing this status effect
/datum/status_effect/chapel_weakness/on_remove()
	. = ..()

	// Alert user
	to_chat(owner, span_cult(CHAPELWEAK_PHRASES_EXIT))

// Processing for status effect
/datum/status_effect/chapel_weakness/tick(seconds_between_ticks)
	// Define if owner is alive
	var/owner_alive = (owner.stat != DEAD)

	// Check if alive
	if(owner_alive)
		// Add disgust
		owner.adjust_disgust(CHAPELWEAK_AMT_DISGUST)

		// Inflict stamina damage
		owner.adjustStaminaLoss(CHAPELWEAK_AMT_STAMLOSS)

	// Chance to spontaneously combust
	if(prob(CHAPELWEAK_CHANCE_IGNITE))
		// Check if alive
		if(owner_alive)
			// Warn user
			to_chat(owner, span_cult_bold(CHAPELWEAK_PHRASES_IGNITE))

		// Ignite mob
		owner.adjust_fire_stacks(CHAPELWEAK_AMT_FIRESTACKS)
		owner.ignite_mob()

// Set status examine text
/datum/status_effect/chapel_weakness/get_examine_text()
	return span_notice("[owner.p_They()] [owner.p_are()] visibly disturbed by something about this room.")

#undef CHAPELWEAK_CHANCE_IGNITE
#undef CHAPELWEAK_AMT_FIRESTACKS
#undef CHAPELWEAK_AMT_DISGUST
#undef CHAPELWEAK_AMT_STAMLOSS
