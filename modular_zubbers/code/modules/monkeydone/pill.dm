/obj/item/reagent_containers/pill/monkeydone
	name = "monkeydone pill"
	desc = "Used to make monkeys return to human. Now banana flavored!"
	icon_state = "pill22"
	list_reagents = list(/datum/reagent/medicine/monkeydone = 5, /datum/reagent/consumable/banana = 10)
	rename_with_volume = TRUE

/obj/item/storage/pill_bottle/monkeydone
	name = "bottle of monkeydone pills"
	desc = "Used to make monkeys return to human. Now banana flavored!"

/obj/item/storage/pill_bottle/monkeydone/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/monkeydone(src)

/obj/structure/closet/secure_closet/chief_medical/PopulateContents()
	. = ..()
	new /obj/item/storage/pill_bottle/monkeydone(src)
