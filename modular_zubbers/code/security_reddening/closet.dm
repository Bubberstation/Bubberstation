/obj/structure/closet/secure_closet/hos
	icon = 'icons/obj/storage/closet.dmi'

/obj/structure/closet/secure_closet/warden
	icon = 'icons/obj/storage/closet.dmi'

/obj/structure/closet/secure_closet/armory1
	icon = 'icons/obj/storage/closet.dmi'

/obj/structure/closet/secure_closet/armory2
	icon = 'icons/obj/storage/closet.dmi'

/obj/structure/closet/secure_closet/armory3
	icon = 'icons/obj/storage/closet.dmi'

/obj/structure/closet/secure_closet/security
	name = "security officer's locker"
	icon = 'icons/obj/storage/closet.dmi'
	icon_state = "sec"
	req_access = list(ACCESS_BRIG)

/obj/structure/closet/secure_closet/security/PopulateContents()
	SEND_SIGNAL(src, COMSIG_CLOSET_POPULATE_CONTENTS)
	new /obj/item/clothing/head/helmet/sec/redsec(src)
	new /obj/item/clothing/suit/armor/vest/alt/sec/redsec(src)
	new /obj/item/clothing/suit/armor/vest/peacekeeper/black(src)
	new /obj/item/radio/headset/headset_sec(src)
	new /obj/item/radio/headset/headset_sec/alt(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/redsec(src)
	new /obj/item/flashlight/seclite(src)

/obj/structure/closet/secure_closet/security/sec/PopulateContents()
	..()
	new /obj/item/storage/belt/security/redsec/full(src)


/obj/item/storage/belt/security/redsec/full/PopulateContents()
	..()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded(src)
	update_appearance()


