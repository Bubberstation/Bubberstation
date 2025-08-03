/obj/item/organ/liver/protean
	name = "reagent catalyst"
	desc = "A nanite harvester that processes chemicals and distributes them to the nanite swarm."
	filterToxins = FALSE //We dont filter them, we're immune to them
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_LIVER
	organ_flags = ORGAN_ROBOTIC | ORGAN_NANOMACHINE

/obj/item/organ/liver/protean/Insert(mob/living/carbon/receiver, special, movement_flags)
	if(QDELETED(src))
		return FALSE
	return ..()

/obj/item/organ/liver/protean/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nanite_organ)
