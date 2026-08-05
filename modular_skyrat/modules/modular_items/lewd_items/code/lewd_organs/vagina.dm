/obj/item/organ/genital/vagina
	internal_fluid_datum = /datum/reagent/consumable/femcum
	internal_fluid_maximum = 10

/obj/item/organ/genital/vagina/build_from_dna(datum/dna/DNA, associated_key)
	. = ..()
	reagents.maximum_volume = internal_fluid_maximum
