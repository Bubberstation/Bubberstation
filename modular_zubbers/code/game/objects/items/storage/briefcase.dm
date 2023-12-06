/obj/item/storage/briefcase/coderbus
	folder_path = /obj/item/folder/coderbus

/obj/item/storage/briefcase/coderbus/PopulateContents()
	new /obj/item/stamp/coderbus/merged(src)
	new /obj/item/stamp/coderbus/closed(src)
	..()

