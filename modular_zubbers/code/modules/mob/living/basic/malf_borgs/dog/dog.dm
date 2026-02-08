/mob/living/basic/malf_borg/dog
	name = "Malfunctioning Canine Cyborg"
	desc = "A canine-borg, hacked or malfunctioning. This one appears to be a mining variant."
	icon = 'modular_skyrat/master_files/icons/mob/newmobs64x32.dmi'

	icon_state = "evilbotmine"
	icon_living = "evilbotmine"
	icon_dead = "evilbotmine"

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	health = 115
	maxHealth = 115

	speed = 1.3

	melee_damage_type = BRUTE
	wound_bonus = 10
	exposed_wound_bonus = 5
	sharpness = SHARP_EDGED

	attack_verb_continuous = "cleaves"
	attack_verb_simple = "smash"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'

/mob/living/basic/malf_borg/dog/Initialize(mapload)
	. = ..()

/mob/living/basic/malf_borg/dogstrong
	name = "Corrupt Hound"
	desc = "A canine-borg, hacked or malfunctioning. This one is large, imposing, and can pack a big punch."
	icon = 'modular_skyrat/master_files/icons/mob/newmobs64x32.dmi'

	icon_state = "evilbotelite"
	icon_living = "evilbotelite"
	icon_dead = "evilbotelite"

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	health = 130
	maxHealth = 130

	speed = 1.15

	melee_damage_type = BRUTE
	wound_bonus = 15
	exposed_wound_bonus = 8
	sharpness = SHARP_POINTY

	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/items/weapons/bite.ogg'

/mob/living/basic/malf_borg/dogstrong/Initialize(mapload)
	. = ..()
