/obj/structure/closet/secure_closet/hydroponics/PopulateContents()
	. = ..()
	for(var/i in 1 to 2)
		new /obj/item/storage/box/disks_plantgene(src)
