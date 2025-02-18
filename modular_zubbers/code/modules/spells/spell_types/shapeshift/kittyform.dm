//Normal supercat spell
/datum/action/cooldown/spell/shapeshift/kitty
	name = "KITTY POWER!!"
	desc = "Take on the shape of a kitty cat! Gain their powers at a loss of vitality."

	cooldown_time = 20 SECONDS
	invocation = "MRR MRRRW!!"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC

	possible_shapes = list(
		/mob/living/basic/pet/cat/super,
		/mob/living/basic/pet/cat/super/tux,
		/mob/living/basic/pet/cat/super/pancake,
		/mob/living/basic/pet/cat/super/original,
		/mob/living/basic/pet/cat/cak/super,
	)
	keep_name = TRUE

//Traitor's Super cat spell
/datum/action/cooldown/spell/shapeshift/kitty/syndie
	name = "SYNDICATE KITTY POWER!!"
	desc = "Take on the shape of an kitty cat, clad in blood-red armor! Gain their powers at a loss of vitality."
	possible_shapes = list(/mob/living/basic/pet/cat/syndicat/super)
