/obj/item/organ/heart/protean
	name = "orchestrator module"
	desc = "A small computer, designed for highly parallel workloads."
	icon = PROTEAN_ORGAN_SPRITE
	icon_state = "orchestrator"
	organ_flags = ORGAN_ROBOTIC | ORGAN_NANOMACHINE

/obj/item/organ/stomach/protean
	name = "refactory"
	desc = "An extremely fragile factory used to rescyle materials and create more nanite mass"
	icon = PROTEAN_ORGAN_SPRITE
	icon_state = "refactory"
	organ_flags = ORGAN_ROBOTIC | ORGAN_NANOMACHINE
	organ_traits = list(TRAIT_NOHUNGER)

	/// How much max metal can we hold at any given time (In sheets). This isn't using nutrition code because nutrition code gets weird without livers.
	var/metal_max = PROTEAN_STOMACH_FULL
	/// How much metal are we holding currently (In sheets)
	var/metal = PROTEAN_STOMACH_FULL

/obj/item/organ/stomach/protean/Initialize(mapload)
	. = ..()
	metal = rand(PROTEAN_STOMACH_FULL/2, PROTEAN_STOMACH_FULL)

/obj/item/organ/stomach/protean/on_life(seconds_per_tick, times_fired)
	. = ..()
	metal -= ((PROTEAN_STOMACH_FULL / 4000) * seconds_per_tick)
	handle_hunger_slowdown(owner)

/// Reused here to check if our stomach is faltering
/obj/item/organ/stomach/protean/handle_hunger_slowdown(mob/living/carbon/human/human)
	if(!istype(owner.dna.species, /datum/species/protean))
		return
	if(metal > PROTEAN_STOMACH_FALTERING)
		return
	// Insert integrity faltering code here once that's done






/obj/item/organ/eyes/robotic/protean
	name = "imaging nanites"
	desc = "Nanites designed to collect visual data from the surrounding world"
	organ_flags = ORGAN_ROBOTIC
	flash_protect = FLASH_PROTECTION_WELDER

/obj/item/organ/eyes/robotic/protean/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nanite_organ)

/obj/item/organ/ears/cybernetic/protean
	name = "sensory nanites"
	desc = "Nanites designed to collect audio feedback from the surrounding world"
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/ears/cybernetic/protean/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nanite_organ)

/obj/item/organ/tongue/cybernetic/protean
	name = "protean audio fabricator"
	desc = "Millions of nanites vibrate in harmony to create the sound you hear."
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/tongue/cybernetic/protean/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nanite_organ)

#undef PROTEAN_STOMACH_FULL
#undef PROTEAN_STOMACH_FALTERING
