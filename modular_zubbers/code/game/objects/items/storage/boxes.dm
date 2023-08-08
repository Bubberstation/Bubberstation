/obj/item/storage/box/disks_plantgene
	name = "plant data disks box"
	illustration = "disk_kit"

/obj/item/storage/box/disks_plantgene/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/disk/plantgene(src)
