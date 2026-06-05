///artur is a bad influence on me
///artur is a bad influence on me I tried to add these once and was told to remove them, then artur whispered in my ear to add these, these are admin only and are explicitly only for events/micro events
/mob/living/basic/voidwalker/sunwalker/maintsroom
	name = "Pure radiant light"
	desc = "Its white, its bright, but its not blinding and it doesnt hurt to look at, you feel reverent for it almost as if it is higher than you or mightier than you as if you should drop down on your knees in worship."
	maxHealth = 7000
	health = 7000//admin spawn only for events, slightly above the heretic star gazer of whom i hate
	melee_damage_lower = 50
	melee_damage_upper = 50
	can_speak = TRUE

/mob/living/basic/voidwalker/maintsroom
	name = "Absence"
	desc = "An entity- it looks like a voidwalker but it doesnt look empty. It seems to be made of pure shadow- but yet you dont feel alarmed or afraid from it."
	maxHealth = 7000
	health = 7000
	melee_damage_type = BURN
	melee_damage_lower = 50
	melee_damage_upper = 50
	can_speak = TRUE

/mob/living/basic/voidwalker/maintsroom/Initialize(mapload)
	add_traits(list(TRAIT_ADVANCEDTOOLUSER, TRAIT_CAN_STRIP))
	add_filter(angular_blur_filter(3, 3, 1))
	add_filter("AO", 1, outline_filter(size = 0, color = "#ffffffff", flags = OUTLINE_SHARP))
	add_filter("blur", 1, gauss_blur_filter(size = 4))
	. = ..()

/mob/living/basic/voidwalker/sunwalker/maintsroom/Initialize(mapload)
	add_traits(list(TRAIT_ADVANCEDTOOLUSER, TRAIT_CAN_STRIP))
	add_filter(angular_blur_filter(3, 3, 1))
	add_filter("AO", 1, outline_filter(size = 0, color = "#ffffffff", flags = OUTLINE_SHARP))
	add_filter("blur", 1, gauss_blur_filter(size = 4))
	. = ..()
