//GS13: Pysch pills
/obj/item/reagent_containers/pill/lsdpsych
	name = "antipsychotic pill"
	desc = "Talk to your healthcare provider immediately if hallucinations worsen or new hallucinations emerge."
	icon_state = "pill14"
	list_reagents = list(/datum/reagent/toxin/mindbreaker = 5)

/obj/item/reagent_containers/pill/happinesspsych
	name = "mood stabilizer pill"
	desc = "Used to temporarily alleviate anxiety and depression, take only as prescribed."
	icon_state = "pill_happy"
	list_reagents = list(/datum/reagent/drug/happiness = 5)

/obj/item/reagent_containers/pill/paxpsych
	name = "pacification pill"
	desc = "Used to temporarily suppress violent, homicidal, or suicidal behavior in patients."
	icon_state = "pill12"
	list_reagents = list(/datum/reagent/pax = 5)
