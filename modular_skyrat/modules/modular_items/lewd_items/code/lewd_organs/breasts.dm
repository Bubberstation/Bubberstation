/obj/item/organ/genital/breasts
	internal_fluid_datum = /datum/reagent/consumable/breast_milk
	internal_fluid_maximum = 60

/obj/item/organ/genital/breasts/build_from_dna(datum/dna/DNA, associated_key)
	. = ..()
	var/breasts_capacity = 0
	var/size = 0.5
	if(DNA.features["breasts_size"] > 0)
		size = DNA.features["breasts_size"]

	switch(genital_type)
		if("pair")
			breasts_capacity = 2
		if("quad")
			breasts_capacity = 2.5
		if("sextuple")
			breasts_capacity = 3
	internal_fluid_maximum = size * breasts_capacity * 60 // This seems like it could balloon drastically out of proportion with larger breast sizes.
	if(internal_fluid_maximum > 3500)
		internal_fluid_maximum = 3500 // this is fucking grim and should be reworked at some point; remember, a wooden barrel the size of a small person has like 600u capacity

	reagents.maximum_volume = internal_fluid_maximum
	// i guess you start dry? - you should only have milk if you are lactating
