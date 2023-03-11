#define REGENERATION_DELAY (5 SECONDS)  // After taking damage, how long it takes for automatic regeneration to begin

/datum/species/mutant
	name = "High-Functioning mutant"
	id = SPECIES_MUTANT
	meat = /obj/item/food/meat/slab/human/mutant/zombie
	eyes_icon = 'modular_skyrat/modules/mutants/icons/mutant_eyes.dmi'
	species_traits = list(
		NOZOMBIE,
		NOEYESPRITES,
		LIPS,
		HAIR
		)
	inherent_traits = list(
		TRAIT_NOBLOOD,
		TRAIT_NODISMEMBER,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_NOMETABOLISM,
		TRAIT_TOXIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RADIMMUNE,
		TRAIT_LIMBATTACHMENT,
		TRAIT_NOBREATH,
		TRAIT_NOCLONELOSS
		)
	inherent_biotypes = MOB_UNDEAD | MOB_HUMANOID
	mutanttongue = /obj/item/organ/internal/tongue/zombie
	disliked_food = NONE
	liked_food = GROSS | MEAT | RAW | GORE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | ERT_SPAWN
	bodytemp_normal = T0C // They have no natural body heat, the environment regulates body temp
	bodytemp_heat_damage_limit = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD // Take damage at fire temp
	bodytemp_cold_damage_limit = MINIMUM_TEMPERATURE_TO_MOVE // take damage below minimum movement temp
	/// A list of spooky sounds we can play intermittantly.
	var/static/list/spooks = list(
		'sound/hallucinations/growl1.ogg',
		'sound/hallucinations/growl2.ogg',
		'sound/hallucinations/growl3.ogg',
		'sound/hallucinations/veryfar_noise.ogg',
		'sound/hallucinations/wail.ogg'
		)
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant_zombie,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant_zombie,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant_zombie,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant_zombie,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant_zombie,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant_zombie
	)

/datum/species/mutant/check_roundstart_eligible()
	if(check_holidays(HALLOWEEN))
		return TRUE
	return ..()

/mob/living/carbon/human/species/mutant
	race = /datum/species/mutant

/mob/living/carbon/human/species/mutant/infectious
	race = /datum/species/mutant/infectious

/datum/species/mutant/infectious
	name = "Mutated Abomination"
	id = SPECIES_MUTANT_INFECTIOUS
	speedmod = 1
	armor = 10
	mutanteyes = /obj/item/organ/internal/eyes/zombie
	changesource_flags = MIRROR_BADMIN | WABBAJACK | ERT_SPAWN
	var/hands_to_give = /obj/item/hnz_mutant_hand
	/// The rate the mutants regenerate at
	var/heal_rate = 1
	/// The cooldown before the mutant can start regenerating
	COOLDOWN_DECLARE(regen_cooldown)

/datum/species/mutant/infectious/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	C.AddComponent(/datum/component/mutant_hands, mutant_hand_path = hands_to_give)

/datum/species/mutant/infectious/fast
	name = "Fast Mutated Abomination"
	id = SPECIES_MUTANT_FAST
	hands_to_give = /obj/item/hnz_mutant_hand/fast
	armor = 0
	/// The rate the mutants regenerate at
	heal_rate = 0.5
	speedmod = 0.5

/datum/species/mutant/infectious/slow
	name = "Slow Mutated Abomination"
	id = SPECIES_MUTANT_SLOW
	armor = 15
	speedmod = 1.5
	/// The rate the mutants regenerate at
	heal_rate = 1.5

/// mutants do not stabilize body temperature they are the walking dead and are cold blooded
/datum/species/mutant/body_temperature_core(mob/living/carbon/human/humi, delta_time, times_fired)
	return

/datum/species/mutant/infectious/check_roundstart_eligible()
	return FALSE

/datum/species/mutant/infectious/spec_stun(mob/living/carbon/human/H,amount)
	. = min(20, amount)

/datum/species/mutant/infectious/apply_damage(damage, damagetype = BRUTE, def_zone = null, blocked, mob/living/carbon/human/H, spread_damage = FALSE, forced = FALSE, wound_bonus = 0, bare_wound_bonus = 0, sharpness = NONE, attack_direction)
	. = ..()
	if(.)
		COOLDOWN_START(src, regen_cooldown, REGENERATION_DELAY)

/datum/species/mutant/infectious/spec_life(mob/living/carbon/carbon_mob, delta_time, times_fired)
	. = ..()
	//mutants never actually die, they just fall down until they regenerate enough to rise back up.
	if(COOLDOWN_FINISHED(src, regen_cooldown))
		var/heal_amt = heal_rate
		if(HAS_TRAIT(carbon_mob, TRAIT_CRITICAL_CONDITION))
			heal_amt *= 2
		carbon_mob.heal_overall_damage(heal_amt * delta_time, heal_amt * delta_time)
		carbon_mob.adjustStaminaLoss(-heal_amt * delta_time)
		carbon_mob.adjustToxLoss(-heal_amt * delta_time)
		for(var/i in carbon_mob.all_wounds)
			var/datum/wound/iter_wound = i
			if(DT_PROB(2-(iter_wound.severity/2), delta_time))
				iter_wound.remove_wound()
	if(!HAS_TRAIT(carbon_mob, TRAIT_CRITICAL_CONDITION) && DT_PROB(2, delta_time))
		playsound(carbon_mob, pick(spooks), 50, TRUE, 10)

#undef REGENERATION_DELAY

/mob/living/carbon/human/canBeHandcuffed()
	if(is_species(src, /datum/species/mutant/infectious))
		return FALSE
	else
		. = ..()

/obj/item/hnz_mutant_hand
	name = "mutant claw"
	desc = "A mutant's claw is its primary tool, capable of infecting \
		humans, butchering all other living things to \
		sustain the mutant, smashing open airlock doors and opening \
		child-safe caps on bottles."
	item_flags = ABSTRACT | DROPDEL
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	icon = 'icons/effects/blood.dmi'
	icon_state = "bloodhand_left"
	inhand_icon_state = "mutant"
	lefthand_file = 'modular_skyrat/modules/mutants/icons/mutant_hand_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/mutants/icons/mutant_hand_righthand.dmi'
	hitsound = 'sound/hallucinations/growl1.ogg'
	force = 26
	sharpness = SHARP_EDGED
	wound_bonus = -20
	damtype = BRUTE
	var/icon_left = "bloodhand_left"
	var/icon_right = "bloodhand_right"

/obj/item/hnz_mutant_hand/fast
	name = "weak mutant claw"
	force = 21
	sharpness = NONE
	wound_bonus = -40

/obj/item/hnz_mutant_hand/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)

/obj/item/hnz_mutant_hand/equipped(mob/user, slot)
	. = ..()
	//these are intentionally inverted
	var/i = user.get_held_index_of_item(src)
	if(!(i % 2))
		icon_state = icon_left
	else
		icon_state = icon_right

/obj/item/hnz_mutant_hand/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(!proximity_flag)
		return
	else if(isliving(target))
		if(ishuman(target))
			try_to_mutant_infect(target, user = user)
		else
			check_feast(target, user)

#define INFECT_CHANCE 70

/proc/try_to_mutant_infect(mob/living/carbon/human/target, forced = FALSE, mob/user)
	CHECK_DNA_AND_SPECIES(target)

	if(forced)
		target.AddComponent(/datum/component/mutant_infection)
		return TRUE

	if(NOZOMBIE in target.dna.species.species_traits)
		// cannot infect any NOZOMBIE subspecies (such as high functioning
		// mutants)
		return FALSE

	if(target.GetComponent(/datum/component/mutant_infection))
		return FALSE

	if(!target.can_inject(user))
		return FALSE

	if(prob(INFECT_CHANCE))
		return FALSE

	if(HAS_TRAIT(target, TRAIT_MUTANT_IMMUNE))
		return FALSE

	target.AddComponent(/datum/component/mutant_infection)
	return TRUE

#undef INFECT_CHANCE

/proc/try_to_mutant_cure(mob/living/carbon/target) //For things like admin procs
	var/datum/component/mutant_infection/infection = target.GetComponent(/datum/component/mutant_infection)
	if(infection)
		qdel(infection)

/obj/item/hnz_mutant_hand/proc/check_feast(mob/living/target, mob/living/user)
	if(target.stat == DEAD)
		var/hp_gained = target.maxHealth
		target.investigate_log("has been feasted upon by the mutant [user].", INVESTIGATE_DEATHS)
		target.gib()
		// zero as argument for no instant health update
		user.adjustBruteLoss(-hp_gained, 0)
		user.adjustToxLoss(-hp_gained, 0)
		user.adjustFireLoss(-hp_gained, 0)
		user.adjustCloneLoss(-hp_gained, 0)
		user.updatehealth()
		user.adjustOrganLoss(ORGAN_SLOT_BRAIN, -hp_gained) // Zom Bee gibbers "BRAAAAISNSs!1!"
		user.set_nutrition(min(user.nutrition + hp_gained, NUTRITION_LEVEL_FULL))
