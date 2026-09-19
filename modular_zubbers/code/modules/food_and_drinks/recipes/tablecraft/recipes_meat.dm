/obj/item/food/fried_chicken/burn()
	visible_message(span_notice("THE HEAT INFUSES INTO THE CHICKEN! You swear you hear someone in a blue shirt singing..."))
	new /obj/item/food/lava_chicken(loc)
	qdel(src)
