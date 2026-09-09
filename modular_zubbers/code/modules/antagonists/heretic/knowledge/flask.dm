/obj/item/reagent_containers/cup/beaker/eldritch/examine(mob/user)
	. = ..()

	. += span_notice("This flask nominally contains [EXAMINE_HINT("eldritch essence")], a potent toxin to non-acolytes but \
	a potent healing tool for those attuned to the Mansus. Needless to say, whoever is holding this might be an Acolyte.")
