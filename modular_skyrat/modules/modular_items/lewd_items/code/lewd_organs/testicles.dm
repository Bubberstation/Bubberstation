/obj/item/organ/genital/testicles
	internal_fluid_datum = /datum/reagent/consumable/cum
	internal_fluid_maximum = 10
	var/cumshot_size = 0
	var/cumshot_size_mod = 1
	var/cumshot_size_mult = 0.5

/obj/item/organ/genital/testicles/build_from_dna(datum/dna/DNA, associated_key)
	. = ..()
	var/size = 0.5
	if(DNA.features["balls_size"] > 0)
		size = DNA.features["balls_size"]

	internal_fluid_maximum = size * 20
	if(internal_fluid_maximum > 300)
		internal_fluid_maximum = 300

	reagents.maximum_volume = internal_fluid_maximum
	reagents.add_reagent(internal_fluid_datum, internal_fluid_maximum) // should make you start with full balls? (cum is stored in the balls in ss13)

/obj/item/organ/genital/testicles/proc/calculate_cumshot()
	cumshot_size = (reagents.total_volume * cumshot_size_mod) * cumshot_size_mult
