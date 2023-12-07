/obj/item/storage/briefcase/coderbus
	name = "maintainer's briefcase"
	folder_path = null //I hate this whole fucking system wtf.

/obj/item/storage/briefcase/coderbus/PopulateContents()
	new /obj/item/paper/fluff/merging_guidelines(src)
	new /obj/item/folder/coderbus(src)
	new /obj/item/stamp/coderbus/merged(src)
	new /obj/item/stamp/coderbus/closed(src)
