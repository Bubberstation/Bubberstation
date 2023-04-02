/obj/item/storage/medkit/tactical/blueshield
	name = "blueshield combat medical kit"
	desc = "Blue boy to the rescue!"

/obj/item/storage/medkit/tactical/blueshield/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/suture(src)
	new /obj/item/stack/medical/mesh(src)
	new /obj/item/storage/pill_bottle/probital(src)
	new /obj/item/healthanalyzer(src)
	new /obj/item/pinpointer/crew(src)

//Probably won't need that many things
