/mob/living/basic/trooper/syndicate/boggins //unique and powerful operative for a special evac shuttle
	name = "Shipmaster Boggins"
	desc = "He's the master of the ship. Stay friendly, and nobody gets hurt."
	faction = list(FACTION_NEUTRAL) //simple hack to make him not attack anyone but will cause hostiles (including other troopers) to attack him but it shouldn't be an issue
	health = 250
	maxHealth = 250
	gender = MALE
	ai_controller = /datum/ai_controller/basic_controller/trooper
	melee_damage_lower = 15
	melee_damage_upper = 25
	armour_penetration = 15
	melee_attack_cooldown = 0.70 SECONDS
	attack_verb_continuous = "brutally strikes"
	attack_verb_simple = "brutally strike"
	attack_sound = 'sound/items/weapons/cqchit1.ogg'
	r_hand = /obj/item/megaphone/sec //I can't figure out how to make this actually work like a megaphone

/mob/living/basic/trooper/syndicate/boggins/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/simple_access, ACCESS_SYNDICATE)
