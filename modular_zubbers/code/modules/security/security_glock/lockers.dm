/obj/structure/closet/secure_closet/security/sec/PopulateContents()
	. = ..()
	new /obj/item/storage/toolbox/guncase/skyrat/pistol/sec_glock(src)
	if(check_holidays(APRIL_FOOLS))
		new /obj/item/clothing/shoes/gunboots/disabler(src)

/obj/structure/closet/secure_closet/warden/PopulateContents()
	. = ..()
	new /obj/item/storage/toolbox/guncase/skyrat/pistol/hos_glock(src)
