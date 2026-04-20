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
	health = 12000//its a fragment of a far greater being lore wise, and mechanically it should never be fighting at all, and if it does thats an admin issue as doing so would be dis-obeying the rules of the ghost role
	melee_damage_lower = 50
	melee_damage_upper = 50
	ghost_controllable = 1

/mob/living/basic/voidwalker/maintsroom
	name = "Absence"
	desc = "An entity- it looks like a voidwalker but it doesnt look empty. It seems to be made of pure shadow- but yet you dont feel alarmed or afraid from it, it has a faint purple outline."
	health = 12000
	melee_damage_type = BURN
	melee_damage_lower = 50
	melee_damage_upper = 50
	ghost_controllable = 1

/obj/effect/mob_spawn/ghost_role/savior
	name = "Savior"
	desc = "A being that is a fragment of a far greater being is sleeping soundly in the bed."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	show_flavor = TRUE
	you_are_text = "You are a second chance."
	flavour_text = "You are a infitesimally small fragment of the light or the shadow god, the only difference is in flavor in which the light god is more arrogant and above thee while the shadow god is more respectful and down to earth and normal, the fragment itself can have its own personality though so go nuts."
	important_text = "Your role and your goal is extremely simple you give people who died in the initial stages of the maintsrooms a second chance- only if there is no way they are being recovered, otherwise no. you should NEVER be engaging in any form of combat ever, doing so is against ze rules for this ghost role- unless in the specific circumstances that somebody clearly trying to pick a fight with you specifically in which case make an a-help and if you are approved to- you may kill whoever was trying to fight you. Furthermore you can ghost in and out of your body as you please- but be warned others can take your body."
	faction = list(FACTION_NEUTRAL)
	prompt_ghost = FALSE
	random_appearance = FALSE
	/// the option between the light and the dark, i do not feel a need to add icons for these as there are only two
	var/list/potentialspawns = list(
		/mob/living/basic/voidwalker/maintsroom,
		/mob/living/basic/voidwalker/sunwalker/maintsroom,
	)
