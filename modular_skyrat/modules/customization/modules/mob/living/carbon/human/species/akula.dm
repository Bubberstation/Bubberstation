/// How long the akula will stay wet for, AKA how long until they get a mood debuff
#define DRY_UP_TIME 10 MINUTES
/// How many wetstacks an Akula will get upon creation
#define WETSTACK_INITIAL 5
/// How many wetstacks an Akula needs to activate the TRAIT_SLIPPERY trait
#define WETSTACK_THRESHOLD 3

/datum/species/akula
	name = "Akula"
	id = SPECIES_AKULA
	lore_protected = TRUE
	offset_features = list(
		OFFSET_GLASSES = list(0, 1),
		OFFSET_EARS = list(0, 2),
		OFFSET_FACEMASK = list(0, 2),
		OFFSET_HEAD = list(0, 2),
		OFFSET_HAIR = list(0, 1),
	)
	eyes_icon = 'modular_skyrat/modules/organs/icons/akula_eyes.dmi'
	mutanteyes = /obj/item/organ/internal/eyes/akula
	mutanttongue = /obj/item/organ/internal/tongue/akula
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_WATER_BREATHING,
		TRAIT_SLICK_SKIN,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	outfit_important_for_life = /datum/outfit/akula
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/akula,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/akula,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/akula,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/akula,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/akula,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/akula,
	)

	meat = /obj/item/food/fishmeat/moonfish/akula

	/// This variable stores the timer datum which appears if the mob becomes wet
	var/dry_up_timer = TIMER_ID_NULL

/datum/species/akula/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Akula", TRUE),
		"legs" = list("Normal Legs", FALSE),
	)

/datum/species/akula/get_species_description()
	return list("The Akula are a species of sharklike humanoids hailing from a largely oceanic homeworld, Azulea. They tend to be tall, with smooth skin unlike the sharks of Earth, but share a lot of similarities in biology with those sharks, including their buoyant liver and their ability to store chlorine and consume saltwater with no ill effects. They are amphibious, and have skin that can retain small amounts of water for a time. They also posess the shark's unhinged jaw and constantly regenerating, unseated teeth.",
	)

/datum/species/akula/get_species_lore()
	return list("the Akula, once known as the Azuleans for their homeworld, are known for their pride and their martial prowess. They are a democratic people, who overthrew the old feudal monarchy that once governed them, and now live as a democratic vassal under the mysterious Soato Empire.",
	"In the times before the Democratic Union, the Akula were ruled by a longstanding royal line, the Line of Agurrkal, dating back to the ancient times. This line was often carried by very corrupt and very mentally unwell rulers due to several queens not wishing to reproduce with anyone and undergoing parthenogenesis, causing mental and physical deformities in their offspring. To this day, the reputation of the Old Nobility as a bunch of degenerate, unstable, feckless hedonists is still held by the surviving Nobles who fled to the fringes of Akulaspace.",
	"In the modern day, the Akula people are split into three factions: the Akula Democratic Union, the main government of the Akula people; the Old Nobles, who have fled to the edge of Akulaspace and still squabble with eachother over who would logically succeed the dead line of Agurrkal; the Border Principalities, who are largely independent border fiefdoms that consist of merchant princes, Old Nobles, and the occasional Mercenary Bandit Kingdom.",
	"The Akula Democratic Union is the largest of the three, and comprises most of Akulaspace, headquartered on Azulea. It is a Representative Democracy, with delegates from each world coming together alongside the elected President and VP to govern the Akula. ADU Akula tend to be very community-minded and close, often forming tight webs of association, and are known for their large and common celebrations. The ADU, also, hilariously, has a galaxy-famous wrestling entertainment industry.",
	"The Old Nobles, once the lords and masters of the old Azulean people, are now consigned to the fringes of Akulaspace, having fled the persecutions of the revolution that overthrew their rule. These Old Nobles are widely seen as a bunch of vile, backwards, hedonistic fops, obsessed with honor and genetics. They routinely espouse views of Azulean genetic supremacy, attempt to genetically transform their subjects into Azuleans, and endlessly squabble with eachother over who should rightfully succeed the broken Line of Agurrkal. While most of these deplorable beings of pomp and circumstance fit this reputation, there are a few who were, and are, not as reprehensible.",
	"The Border Principalities consist of various relatively small fiefdoms that, in one way or another, refuse governance by the ADU or the Kingdom of Agurrkal before them. These principalities are ruled by merchant princes, independent-minded lesser nobles, and other independents, the largest of which is the wealthy and opportunistic Principality of Hakonen, who has brokered deals with the ADU to be their one trade inroad to the rest of the galaxy. The cultures of these border states are as varied as their rulers; some are capitalist paradises where everything has a price, and others are cruel despotic dictatorships ruled by madmen or wealthy retired mercenaries.",
	"These three factions have deep divides, and those who belong to them often tend to clash. Regardless of faction, however, most Akula are known rather well for their pride, their loyalty to friends, family, and ideals, and their love of the oceans they come from, and the whales they once lived beside.",
	)

/datum/species/akula/randomize_features()
	var/list/features = ..()
	var/main_color
	var/secondary_color
	var/tertiary_color
	var/random = rand(1, 4)
	switch(random)
		if(1)
			main_color = "#1CD3E5"
			secondary_color = "#6AF1D6"
			tertiary_color = "#CCF6E2"
		if(2)
			main_color = "#CF3565"
			secondary_color = "#d93554"
			tertiary_color = "#fbc2dd"
		if(3)
			main_color = "#FFC44D"
			secondary_color = "#FFE85F"
			tertiary_color = "#FFF9D6"
		if(4)
			main_color = "#DB35DE"
			secondary_color = "#BE3AFE"
			tertiary_color = "#F5E2EE"
	features["mcolor"] = main_color
	features["mcolor2"] = secondary_color
	features["mcolor3"] = tertiary_color
	return features

/datum/species/akula/prepare_human_for_preview(mob/living/carbon/human/akula)
	var/main_color = "#1CD3E5"
	var/secondary_color = "#6AF1D6"
	var/tertiary_color = "#CCF6E2"
	akula.dna.features["mcolor"] = main_color
	akula.dna.features["mcolor2"] = secondary_color
	akula.dna.features["mcolor3"] = tertiary_color
	akula.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Akula", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	akula.dna.features["legs"] = "Normal Legs"
	regenerate_organs(akula, src, visual_only = TRUE)
	akula.update_body(TRUE)

/obj/item/organ/internal/eyes/akula
	// Eyes over hair as bandaid for the low amounts of head matching hair
	eyes_layer = HAIR_LAYER-0.1


/obj/item/organ/internal/tongue/akula
	liked_foodtypes = SEAFOOD | RAW
	disliked_foodtypes = CLOTH | DAIRY
	toxic_foodtypes = TOXIC


/datum/species/akula/get_random_body_markings(list/passed_features)
	var/datum/body_marking_set/body_marking_set = GLOB.body_marking_sets["Akula"]
	var/list/markings = list()
	if(body_marking_set)
		markings = assemble_body_markings_from_set(body_marking_set, passed_features, src)
	return markings

/datum/species/akula/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)
	if(job?.akula_outfit)
		equipping.equipOutfit(job.akula_outfit, visuals_only)
	else
		give_important_for_life(equipping)

// Wet_stacks handling
// more about grab_resists in `code\modules\mob\living\living.dm` at li 1119
// more about slide_distance in `code\game\turfs\open\_open.dm` at li 233
/// Lets register the signal which calls when we are above 10 wet_stacks
/datum/species/akula/on_species_gain(mob/living/carbon/akula, datum/species/old_species, pref_load)
	. = ..()
	RegisterSignal(akula, COMSIG_MOB_TRIGGER_WET_SKIN, PROC_REF(wetted), akula)
	// lets give 15 wet_stacks on initial
	akula.set_wet_stacks(WETSTACK_INITIAL, remove_fire_stacks = FALSE)

/// Remove the signal on species loss
/datum/species/akula/on_species_loss(mob/living/carbon/akula, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(akula, COMSIG_MOB_TRIGGER_WET_SKIN)

/// This proc is called when a mob with TRAIT_SLICK_SKIN gains over 10 wet_stacks
/datum/species/akula/proc/wetted(mob/living/carbon/akula)
	SIGNAL_HANDLER
	// Apply the slippery trait if its not there yet
	if(!HAS_TRAIT(akula, TRAIT_SLIPPERY))
		ADD_TRAIT(akula, TRAIT_SLIPPERY, SPECIES_TRAIT)

	// Relieve the negative moodlet
	akula.clear_mood_event("dry_skin")
	// The timer which will initiate above 10 wet_stacks, and call dried() once the timer runs out
	dry_up_timer = addtimer(CALLBACK(src, PROC_REF(dried), akula), DRY_UP_TIME, TIMER_UNIQUE | TIMER_STOPPABLE)

/// This proc is called after a mob with the TRAIT_SLIPPERY has its related timer run out
/datum/species/akula/proc/dried(mob/living/carbon/akula)
	// A moodlet which will not go away until the user gets wet
	akula.add_mood_event("dry_skin", /datum/mood_event/dry_skin)

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
