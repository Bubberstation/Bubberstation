/mob/living/basic/carp
	health = 50
	maxHealth = 50


/mob/living/basic/carp/advanced
	health = 100
	maxHealth = 100

/mob/living/basic/carp/mega/Initialize(mapload)
	. = ..()
	maxHealth += rand(15, 40)

/mob/living/basic/carp/mega/queen
	name = "Royal Space Carp"
	desc = "A ferocious, fang bearing creature that resembles a shark. The scales visibly gleam in the pale light. Sure looks tough."
	maxHealth = 300
	health = 300
	melee_damage_lower = 20
	melee_damage_upper = 25

