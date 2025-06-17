/obj/structure/closet/secure_closet/warden/PopulateContents()
	. = ..()
	new /obj/item/stamp/warden(src)

/obj/structure/closet/secure_closet/hop/populate_contents_immediate()
	. = ..()
	new /obj/item/stamp/granted(src)
	new /obj/item/stamp/denied(src)
