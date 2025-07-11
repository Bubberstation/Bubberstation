/obj/item/organ/genital
	/// The maximum amount of fluid that can be stored in the genital.
	/// should only be used during generation/maximum size updates
	var/internal_fluid_maximum = 0

	/// The datum to be used for the tracked fluid, should it need to be added to a fluid container.
	var/internal_fluid_datum

	/// The currently inserted sex toy.
	var/obj/item/inserted_item

/obj/item/organ/genital/Initialize(mapload)
	. = ..()
	create_reagents(internal_fluid_maximum, REAGENT_HOLDER_ALIVE)
