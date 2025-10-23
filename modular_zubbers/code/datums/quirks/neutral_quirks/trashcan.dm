/datum/quirk/trashcan
	name = "Trashcan"
	desc = "You are able to consume and digest trash."
	value = 0
	gain_text = span_notice("You feel like munching on a can of soda.")
	lose_text = span_notice("You no longer feel like you should be eating trash.")
	medical_record_text = "Patient has a strange craving for trash."
	mob_trait = TRAIT_TRASHCAN
	icon = FA_ICON_TRASH_ALT

/datum/quirk/trashcan/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	RegisterSignal(H, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))

/datum/quirk/trashcan/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		UnregisterSignal(H, COMSIG_ATOM_ATTACKBY)

/datum/quirk/trashcan/proc/on_attackby(datum/source, obj/item/I, mob/living/attacker, params)
	SIGNAL_HANDLER

	if(!istype(I, /obj/item/trash) && !istype(I, /obj/item/cigbutt))
		return

	var/mob/living/carbon/human/H = quirk_holder

	H.visible_message(attacker == H ? span_notice("[H] starts to eat the [I.name].") : span_notice("[attacker] starts to feed [H] the [I.name].") )

	if(!do_after(H, 10 SECONDS))
		return

	playsound(H.loc,'sound/items/eatfood.ogg', rand(10,50), 1)
	H.visible_message(span_notice("[H] consumes the [I.name]."))

	qdel(I)

	return COMPONENT_NO_AFTERATTACK
