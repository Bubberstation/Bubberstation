/obj/item/storage/box/disks_plantgene
	name = "plant data disks box"
	illustration = "disk_kit"

/obj/item/storage/box/disks_plantgene/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/disk/plantgene(src)

// Syndicate Admiral's Medals box
/obj/item/storage/lockbox/medal/bubber/synd
	name = "syndicate medal box"
	desc = "A locked box used to store medals of honor."
	icon = 'modular_zubbers/icons/obj/box.dmi'
	icon_state = "syndbox+l"
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	req_access = list(ACCESS_SYNDICATE_LEADER)
	icon_locked = "syndbox+l"
	icon_closed = "syndbox"
	icon_broken = "syndbox+b"
	icon_open = "syndboxopen"

/obj/item/storage/lockbox/medal/bubber/synd/PopulateContents()
	new /obj/item/clothing/accessory/medal/bubber/syndicate(src)
	new /obj/item/clothing/accessory/medal/bubber/syndicate/espionage(src)
	new /obj/item/clothing/accessory/medal/bubber/syndicate/interrogation(src)
	new /obj/item/clothing/accessory/medal/bubber/syndicate/intelligence(src)
	new /obj/item/clothing/accessory/medal/bubber/syndicate/diligence(src)
	new /obj/item/clothing/accessory/medal/bubber/syndicate/communications(src)
