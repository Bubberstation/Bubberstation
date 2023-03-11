/obj/item/organ/internal/tongue/dog
	name = "long tongue"
	desc = "A long and wet tongue. It seems to jump when it's called good, oddly enough."
	say_mod = "woofs"
	icon_state = "tongue"
	modifies_speech = TRUE

/obj/item/organ/internal/tongue/dog/Insert(mob/living/carbon/signer, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	signer.verb_ask = "arfs"
	signer.verb_exclaim = "wans"
	signer.verb_whisper = "whimpers"
	signer.verb_yell = "barks"

/obj/item/organ/internal/tongue/dog/Remove(mob/living/carbon/speaker, special = 0)
	..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_sing = initial(verb_sing)
	speaker.verb_yell = initial(verb_yell)

/// This "human" tongue is only used in Character Preferences / Augmentation menu.
/// The base tongue class lacked a say_mod. With say_mod included it makes a non-Human user sound like a Human.
/obj/item/organ/internal/tongue/human
	say_mod = "says"

/obj/item/organ/internal/tongue/cybernetic
	name = "cybernetic tongue"
	icon = 'modular_skyrat/modules/organs/icons/cyber_tongue.dmi'
	icon_state = "cybertongue"
	desc =  "A fully-functional synthetic tongue, encased in soft silicone. Features include high-resolution vocals and taste receptors."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC
	say_mod = "says"
	// Not as good as organic tongues, not as bad as the robotic voicebox.
	taste_sensitivity = 20

/obj/item/organ/internal/tongue/vox
	name = "vox tongue"
	desc = "A fleshy muscle mostly used for skreeing."
	say_mod = "skrees"

/obj/item/organ/internal/tongue/dwarven
	name = "dwarven tongue"
	desc = "A fleshy muscle mostly used for bellowing."
	say_mod = "bellows"

/obj/item/organ/internal/tongue/ghoul
	name = "ghoulish tongue"
	desc = "A fleshy muscle mostly used for rasping."
	say_mod = "rasps"

/obj/item/organ/internal/tongue/insect
	name = "insect tongue"
	desc = "A fleshy muscle mostly used for chittering."
	say_mod = "chitters"

/obj/item/organ/internal/tongue/xeno // like lizard tongue but without taste sensitivity modifiers
	name = "xenomorph tongue"
	desc = "A fleshy muscle mostly used for hissing."
	say_mod = "hisses"

/obj/item/organ/internal/tongue/skrell
	name = "skrell tongue"
	desc = "A fleshy muscle mostly used for warbling."
	say_mod = "warbles"
