
/obj/effect/holodeck_effect/mobspawner/activate(obj/machinery/computer/holodeck/HC)
	. = ..()
	ADD_TRAIT(our_mob, TRAIT_NOBLOOD, INNATE_TRAIT)
