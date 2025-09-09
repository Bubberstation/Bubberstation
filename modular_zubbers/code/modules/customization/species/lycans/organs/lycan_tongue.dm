/obj/item/organ/tongue/lycan
	name = "lupine tongue"
	desc = "A massive tongue that craves meat."
	say_mod = "growls"
	icon_state = "tongue"
	modifies_speech = TRUE

	liked_foodtypes = RAW | MEAT | GORE
	disliked_foodtypes = CLOTH | GROSS
	toxic_foodtypes = TOXIC

/obj/item/organ/tongue/lycan/on_mob_insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	signer.verb_ask = "grumbles"
	signer.verb_exclaim = "awoos" // Probably will change this later.
	signer.verb_whisper = "whines"
	signer.verb_yell = "howls"

/obj/item/organ/tongue/lycan/on_mob_remove(mob/living/carbon/speaker, special = FALSE, movement_flags)
	. = ..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_sing = initial(verb_sing)
	speaker.verb_yell = initial(verb_yell)
