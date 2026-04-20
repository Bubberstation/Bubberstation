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

/obj/effect/mob_spawn/ghost_role/pure_radiant_light
	name = "Pure radiant light"
	mob_type = /mob/living/basic/voidwalker/sunwalker/maintsroom
	prompt_name = "a fragment"
	you_are_text = "You're a fragment"
	flavour_text = "You are a part of the god of light, you are stuck up, you are rude, but due to your nature of being a mere fragment of the greater being you have plenty of leeway for a good personality."
	important_text = "This is a comms larp role, you are over-glorified comms agent, you are a fragment of a greater being that being of one of pure light, as such you think you are godlike and superior to all else, feel free to ghost and re-enter your body at will with this one but never give out any information relating to outside the maintsroom and only help people out if theyve been struggling with something for more than an hour- with the final section excluded, dont help them at all with that. if you want to have somebody in your chamber/leave your chamber, ask the admins."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/obj/effect/mob_spawn/ghost_role/absence
	name = "Absence"
	mob_type = /mob/living/basic/voidwalker/maintsroom
	prompt_name = "a fragment"
	you_are_text = "You're a fragment"
	flavour_text = "You are a part of the god of shadows, you are down to earth, you are polite, but due to your nature of being a mere fragment of the greater being you have plenty of leeway for a good personality."
	important_text = "This is a comms larp role, you are over-glorified comms agent, you are a fragment of a greater being that being of one of pure light, as such you are more down to earth and more so just like a normal person, feel free to ghost and re-enter your body at will with this one but never give out any information relating to outside the maintsroom and only help people out if theyve been struggling with something for more than an hour- with the final section excluded, dont help them at all with that. if you want to have somebody in your chamber/leave your chamber, ask the admins."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/mob/living/basic/voidwalker/maintsroom/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_ADVANCEDTOOLUSER, TRAIT_CAN_STRIP))

/mob/living/basic/voidwalker/sunwalker/maintsroom/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_ADVANCEDTOOLUSER, TRAIT_CAN_STRIP))
