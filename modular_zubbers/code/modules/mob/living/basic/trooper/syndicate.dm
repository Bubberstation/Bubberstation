/mob/living/basic/trooper/syndicate/boggins //unique and powerful operative for a special evac shuttle
	name = "Shipmaster Boggins"
	desc = "He's the master of the ship. Stay friendly, and nobody gets hurt."
	faction = list(FACTION_NEUTRAL, ROLE_SYNDICATE)
	health = 250
	maxHealth = 250
	gender = MALE
	ai_controller = /datum/ai_controller/basic_controller/trooper/peaceful //not meant to attack people on sight
	melee_damage_lower = 15
	melee_damage_upper = 20
	armour_penetration = 10
	speed = 0.8
	melee_attack_cooldown = 0.70 SECONDS
	attack_verb_continuous = "strikes"
	attack_verb_simple = "strike"
	attack_sound = 'sound/items/weapons/cqchit1.ogg'
	r_hand = /obj/item/megaphone/sec

/mob/living/basic/trooper/syndicate/boggins/Initialize(mapload)
	. = ..()
	add_traits(list(
		TRAIT_SILICON_ACCESS //just so he can access the ship stuff what could possibly go wrong
	), INNATE_TRAIT)
