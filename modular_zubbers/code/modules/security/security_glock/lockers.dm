/obj/structure/closet/secure_closet/security/sec/PopulateContents()
	. = ..()
	new /obj/item/storage/toolbox/guncase/skyrat/pistol/sec_glock(src)

/obj/structure/closet/secure_closet/warden/PopulateContents()
	. = ..()
	if(!locate(/obj/item/clothing/gloves/kaza_ruk/sec/warden) in src)
		new /obj/item/clothing/gloves/kaza_ruk/sec/warden(src)
	new /obj/item/storage/toolbox/guncase/skyrat/pistol/hos_glock(src)
