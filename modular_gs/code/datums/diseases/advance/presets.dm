// Weight gain - GS13
/datum/disease/advance/weight_gain
	copy_type = /datum/disease/advance

/datum/disease/advance/weight_gain/New(make_typecache = TRUE)
	name = "Weight Gain"
	symptoms = list(new/datum/symptom/weight_gain)
	..()

/obj/item/reagent_containers/glass/bottle/weight_gain
	name = "Weight gain virus bottle"
	desc = "A small bottle. Contains weight gain virus in synthblood medium."
	spawned_disease = /datum/disease/advance/weight_gain


// Berry virus - GS13
/datum/disease/advance/berry_virus
	copy_type = /datum/disease/advance

/datum/disease/advance/berry_virus/New(make_typecache = TRUE)
	name = "Blueberry Virus"
	symptoms = list(new/datum/symptom/berry)
	..()

/obj/item/reagent_containers/glass/bottle/berry
	name = "Blueberry virus bottle"
	desc = "A small bottle. Contains blueberry virus in synthblood medium."
	spawned_disease = /datum/disease/advance/berry_virus
