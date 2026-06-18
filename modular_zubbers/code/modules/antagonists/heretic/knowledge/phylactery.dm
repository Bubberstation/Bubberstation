/obj/item/reagent_containers/cup/phylactery/examine(mob/user)
	. = ..()

	. += span_notice("This small cup can draw blood from anyone nearby with a single click. Very useful for [EXAMINE_HINT("curse rituals")], which require blood of a sapient creature.")
