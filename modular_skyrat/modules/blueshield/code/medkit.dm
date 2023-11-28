/obj/item/storage/medkit/tactical/blueshield
	name = "blueshield combat medical kit"
	desc = "Blue boy to the rescue!"
	color = "#AAAAFF"

/obj/item/storage/medkit/tactical/blueshield/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/suture(src)
	new /obj/item/stack/medical/mesh(src)
	new /obj/item/healthanalyzer(src)
<<<<<<< HEAD
	new /obj/item/sensor_device/blueshield(src)
=======
	new /obj/item/pinpointer/crew(src)

//Probably would not need more than this
>>>>>>> 6d93d20462a27f3351796f4b0ec8cafb715b2847
