/// Maintsroom lost

/obj/effect/mob_spawn/ghost_role/human/maintsroom
	name = "chamenos"
	prompt_name = "A being stuck in between two spaces"
	you_are_text = "You wake up. Your hideout is intact with stuff you gathered yesterday, you are safe but you get a gut feeling that once you leave your hideout you cannot come back. Maybe you should go explore, be wary of the red lights."
	flavour_text = "You've been stuck in the Maintsrooms for longer than you can remember, and this place has changed you. Is it madness, insanity, or an infection? Or are you an eldritch being, a monster who was born/created/manifested here? Survival will be challenging, and the Maintsrooms are a very hostile environment, so anything surviving here should have a believable reason to."
	important_text = "YOU ARE NOT HOSTILE YOU SHOULD NOT BE KILLING PEOPLE/CREW IN GENERAL, unless you have admin permission or good IC justification to do so."
	loadout_enabled = TRUE
	quirks_enabled = TRUE // ghost role quirks
	random_appearance = FALSE // ghost role prefs
	deletes_on_zero_uses_left = TRUE

/mob/living/basic/voidwalker/sunwalker/maintsroom
	name = "Pure radiant light"
	desc = "Its white, its bright, but its not blinding and it doesnt hurt to look at, it has a faint blue outline."
	maxHealth = 12000
	health = 12000//its a fragment of a far greater being lore wise, and mechanically it should never be fighting at all, and if it does thats an admin issue as doing so would be dis-obeying the rules of the ghost role
	melee_damage_lower = 50
	melee_damage_upper = 50
	ghost_controllable = 1
	can_speak = TRUE

/mob/living/basic/voidwalker/maintsroom
	name = "Absence"
	desc = "An entity- it looks like a voidwalker but it doesnt look empty. It seems to be made of pure shadow- but yet you dont feel alarmed or afraid from it, it has a faint purple outline."
	maxHealth = 12000
	health = 12000
	melee_damage_type = BURN
	melee_damage_lower = 50
	melee_damage_upper = 50
	ghost_controllable = 1
	can_speak = TRUE

/mob/living/basic/voidwalker/maintsroom/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_ADVANCEDTOOLUSER, TRAIT_CAN_STRIP))

/mob/living/basic/voidwalker/sunwalker/maintsroom/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_ADVANCEDTOOLUSER, TRAIT_CAN_STRIP))
