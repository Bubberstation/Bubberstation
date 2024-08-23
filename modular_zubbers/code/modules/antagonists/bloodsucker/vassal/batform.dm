/**
 * # BATFORM
 *
 * TG removed this, so we're re-adding it
 */
/datum/action/cooldown/spell/shapeshift/bat
	name = "Bat Form"
	desc = "Take on the shape of a space bat. You can fly and see in the dark, and you heal from doing melee attacks."
	power_explanation = "You can fly and see in the dark, and you heal from doing melee attacks."
	invocation = "Master, grant me your might, BAT FORM!!"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = NONE
	convert_damage = TRUE
	cooldown_time = 1 MINUTES
	possible_shapes = list(/mob/living/basic/bat/bloodsucker)
	var/bats_to_spawn = 3

/datum/action/cooldown/spell/shapeshift/bat/cast(mob/living/cast_on)
	. = ..()
	// spawn bats around
	if(!get_turf(cast_on))
		return
	for(var/i in 1 to bats_to_spawn)
		var/mob/living/basic/bat/bat = new(get_turf(cast_on))
		QDEL_IN(bat, cooldown_time)
		random_step(bat, 2, 50)

/mob/living/basic/bat/bloodsucker
	name ="vampiric bat"
	desc = "A bat with a thirst for blood."
	maxHealth = 100
	health = 100
	speed = 0
	melee_damage_lower = 10
	melee_damage_upper = 15
	wound_bonus = 10
	obj_damage = 10
	lighting_cutoff_red = 25
	lighting_cutoff_green = 8
	lighting_cutoff_blue = 5
	melee_attack_cooldown = CLICK_CD_MELEE
	basic_mob_flags = FLAMMABLE_MOB
	lighting_color_cutoffs = BLOODSUCKER_SIGHT_COLOR_CUTOFF
	damage_coeff = list(BRUTE = 0.9, BURN = 1.25, TOX = 1, STAMINA = 1, OXY = 1)
	attack_verb_simple = "drain blood from"
	attack_verb_continuous = "drains blood from"

/mob/living/basic/bat/bloodsucker/Initialize(mapload)
	. = ..()
	// Go as fast as people can run
	AddElement(/datum/element/lifesteal, melee_damage_lower)
	// Too fat to fit through vents
	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
