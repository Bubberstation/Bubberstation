/**
 * Phrases said in chat by the holder while "dreaming"
 * These should be in first person
 */
#define CURSEDBLOOD_DREAM_PHRASES_SAY pick(\
	"[deity_name] please help me...",\
	"Unshackle me please...",\
	"[deity_name]... I've had enough of this dream...",\
	"Oh, [deity_name], please...",\
	"[deity_name], why have you forsaken me?",\
	"[deity_name], let my soul be free...",\
	"The fog hides everything, but it's coming for me...",\
	"I've walked this road too long...",\
	"[deity_name]... why do I still walk?",\
	"The night's cruel heart beats in mine...",\
	"In the city of beasts, I am prey...",\
	"[deity_name], where is the light in this place?",\
	"Beneath [deity_name]'s gaze, I lose my way...",\
	"[deity_name], why do I feel its presence?",\
	"The shadows will consume me whole",\
	"I've seen too much to be sane now",\
	"In dreams, I see the horrors that await",\
	)

/**
 * Phrases said in chat by the holder while "dreaming"
 * These should be in second person or have no subject
 */
#define CURSEDBLOOD_DREAM_PHRASES_HALLUCINATE pick(\
	"The night blocks all sight...",\
	"The moon is close. It will be a long hunt tonight.",\
	"The night is near its end...",\
	"Fear the blood...",\
	"A beast is at your door.",\
	"No light can save you now.",\
	"Find the lanterns in the dark...",\
	"Let the hunter become the hunted...",\
	"Beneath the moonlight, the darkness stirs...",\
	"Beyond the gates lies madness...",\
	"Unseen hands grasp for your soul..."\
	)

/// Potential burn damage taken while "dreaming"
#define CURSEDBLOOD_DREAM_DAMAGE_BURN 20
/// Potential toxin damage taken while "dreaming"
#define CURSEDBLOOD_DREAM_DAMAGE_TOX 20

/// Chance of triggering dream phase 1: Speech
#define CURSEDBLOOD_DREAM_CHANCE_1 25
/// Chance of triggering dream phase 2: Seisure
#define CURSEDBLOOD_DREAM_CHANCE_2 10
/// Chance of triggering dream phase 3: Burning
#define CURSEDBLOOD_DREAM_CHANCE_3 25

/// Time to become unconscious during dream phase 2
#define CURSEDBLOOD_DREAM_TIME_UNCONSCIOUS 5 SECONDS
/// Duration of the dream status effect when splashed
#define CURSEDBLOOD_DREAM_DURATION_SPLASH 10 SECONDS

/datum/quirk/cursed_blood
	name = "Cursed Blood"
	desc = "Your lineage is afflicted with a blood-born curse. Avoid coming into contact with Holy Water. Hell Water, on the other hand..."
	value = 0
	gain_text = span_notice("A curse from a land where men return as beasts runs deep in your blood.")
	lose_text = span_notice("You feel the weight of the curse in your blood finally gone.")
	medical_record_text = "Patient suffers from an unknown type of aversion to holy reagents. Keep them away from chaplains."
	mob_trait = TRAIT_CURSED_BLOOD
	hardcore_value = 1
	icon = FA_ICON_FIRE_FLAME_CURVED
	mail_goodies = list (
		// This may be the only way to get Hell Water.
		/obj/item/reagent_containers/cup/glass/bottle/holywater/hell = 1
	)
	/// Deity name to use in Dream messages
	var/pref_deity

/datum/quirk/cursed_blood/add(client/client_source)
	// Register reagent interactions
	RegisterSignal(quirk_holder, COMSIG_REAGENT_EXPOSE_HOLYWATER, PROC_REF(expose_holywater))
	RegisterSignal(quirk_holder, COMSIG_REAGENT_PROCESS_HELLWATER, PROC_REF(process_hellwater))
	RegisterSignals(quirk_holder, list(COMSIG_REAGENT_METABOLIZE_END_HOLYWATER,COMSIG_LIVING_DEATH), PROC_REF(end_holywater))

	// Add profane penalties
	quirk_holder.AddElementTrait(TRAIT_CHAPEL_WEAKNESS, TRAIT_CURSED_BLOOD, /datum/element/chapel_weakness)
	quirk_holder.AddElementTrait(TRAIT_HOLYWATER_WEAKNESS, TRAIT_CURSED_BLOOD, /datum/element/holywater_weakness)

/datum/quirk/cursed_blood/post_add()
	// Try to read client preference
	var/client_pref_deity = quirk_holder.client?.prefs?.read_preference(/datum/preference/name/deity)

	// Check if pref exists and is not the default value
	if(client_pref_deity && (client_pref_deity != DEFAULT_DEITY))
		// Set new preferred deity
		pref_deity = client_pref_deity

	// No preference set
	else
		// Pick a random crew member's name
		var/datum/record/crew/random_crew = pick(GLOB.manifest.general)

		// Set deity to that name
		pref_deity = random_crew?.name

/datum/quirk/cursed_blood/remove()
	// Unregister reagent interactions
	UnregisterSignal(quirk_holder, COMSIG_REAGENT_EXPOSE_HOLYWATER)
	UnregisterSignal(quirk_holder, COMSIG_REAGENT_PROCESS_HELLWATER)

	// Remove profane penalties
	REMOVE_TRAIT(quirk_holder, TRAIT_CHAPEL_WEAKNESS, TRAIT_CURSED_BLOOD)
	REMOVE_TRAIT(quirk_holder, TRAIT_HOLYWATER_WEAKNESS, TRAIT_CURSED_BLOOD)

/// Called when exposed to Holy Water. Applies the dream status effect.
/datum/quirk/cursed_blood/proc/expose_holywater(mob/living/carbon/affected_mob, datum/reagent/handled_reagent, methods, reac_volume, show_message, touch_protection)
	SIGNAL_HANDLER

	// Handled via status effect because .say cannot be used by a signal handler

	// Define if this effect should expire automatically
	var/duration_override = FALSE

	// Check for splashing
	if(methods & TOUCH)
		// Set effect duration
		duration_override = CURSEDBLOOD_DREAM_DURATION_SPLASH

	// Add status effect
	quirk_holder.apply_status_effect(/datum/status_effect/quirk_cursed_blood/dreaming, duration_override, pref_deity)

/// Called when done metabolizing Holy Water or on death. Clears the dream status effect.
/datum/quirk/cursed_blood/proc/end_holywater()
	SIGNAL_HANDLER

	// Remove status effect
	quirk_holder.remove_status_effect(/datum/status_effect/quirk_cursed_blood/dreaming)

/// Handle effects applied by consuming Hell Water
/datum/quirk/cursed_blood/proc/process_hellwater()
	SIGNAL_HANDLER

	// Reduce disgust, hunger, and thirst
	// These effects should match Hallowed bonus for Holy Water
	quirk_holder.adjust_disgust(-2)
	quirk_holder.adjust_nutrition(6)
	//quirk_holder.adjust_thirst(6)

// Status effect for Cursed Blood that applies Holy Water effects
/datum/status_effect/quirk_cursed_blood/dreaming
	id = "cursed_blood_dream"
	//duration = 10 SECONDS
	tick_interval = 2 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/cursed_blood_dream
	remove_on_fullheal = TRUE

	/// Default name of the target's religious deity
	var/deity_name = DEFAULT_DEITY

// Status effect condition checks
/datum/status_effect/quirk_cursed_blood/dreaming/on_creation(mob/living/new_owner, duration_override, pref_deity)
	// Check for duration override
	if(duration_override)
		// Set limited duration
		src.duration = duration_override

	// Check if owner is a blood cultist
	if(IS_CULTIST(new_owner))
		// Set name to blood cultist god
		deity_name = "Nar'Sie"

	// Check if owner is a clock cultist
	else if(IS_CLOCK(new_owner))
		// Set name to clock cultist god
		deity_name = "Ratvar"

	// Check disabled: Requires /carbon/human
	/*
	// Check if owner is a clown
	else if(is_clown_job(new_owner.mind?.assigned_role))
		// Set name to clown god
		deity_name = "Honkmother"
	*/

	// Check if a global deity is set
	else if(GLOB.deity)
		// Set global deity name
		deity_name = GLOB.deity

	// Check if a client preference was given
	else if(pref_deity)
		// Use preferred deity
		deity_name = pref_deity

	// Run normally
	return ..()

// Status effect alert
/atom/movable/screen/alert/status_effect/cursed_blood_dream
	name = "Endless Dream"
	desc = "The night blocks all sight."
	icon_state = "terrified"
	alerttooltipstyle = "cult"

// Processing dreaming status effect
/datum/status_effect/quirk_cursed_blood/dreaming/tick(seconds_between_ticks)
	// Random chance to continue
	if(!prob(CURSEDBLOOD_DREAM_CHANCE_1))
		return

	// Character speaks nonsense
	owner.say(CURSEDBLOOD_DREAM_PHRASES_SAY, forced = "holy water", spans = list("cult_italic"))

	// Random chance to continue
	if(!prob(CURSEDBLOOD_DREAM_CHANCE_2))
		return

	// Trigger a seisure

	// Alert in chat
	owner.visible_message(span_danger("[owner] starts having a seizure!"), span_userdanger("You have a seizure!"))

	// Set unconscious
	owner.Unconscious(CURSEDBLOOD_DREAM_TIME_UNCONSCIOUS)

	// Display messages
	to_chat(owner, span_cult("[CURSEDBLOOD_DREAM_PHRASES_HALLUCINATE]"))

	// Add damage to queue
	owner.adjustFireLoss(CURSEDBLOOD_DREAM_DAMAGE_BURN, updating_health = FALSE)
	owner.adjustToxLoss(CURSEDBLOOD_DREAM_DAMAGE_TOX, updating_health = FALSE, forced = TRUE)

	// Update health
	owner.updatehealth()

	// Random chance to continue
	if(!prob(CURSEDBLOOD_DREAM_CHANCE_3))
		return

	// Ignite mob
	owner.adjust_fire_stacks(2)
	owner.ignite_mob()

// Set status examine text
/datum/status_effect/quirk_cursed_blood/dreaming/get_examine_text()
	return span_notice("[owner.p_They()] will never wake from this dream.")

#undef CURSEDBLOOD_DREAM_PHRASES_SAY
#undef CURSEDBLOOD_DREAM_PHRASES_HALLUCINATE
#undef CURSEDBLOOD_DREAM_DAMAGE_BURN
#undef CURSEDBLOOD_DREAM_DAMAGE_TOX
#undef CURSEDBLOOD_DREAM_CHANCE_1
#undef CURSEDBLOOD_DREAM_CHANCE_2
#undef CURSEDBLOOD_DREAM_CHANCE_3
#undef CURSEDBLOOD_DREAM_TIME_UNCONSCIOUS
