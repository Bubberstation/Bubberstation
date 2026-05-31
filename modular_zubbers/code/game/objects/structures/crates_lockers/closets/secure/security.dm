/obj/item/clothing/gloves/kaza_ruk/sec/warden
	name = "warden's kaza ruk gloves"
	desc = "These gloves seem to guide you through a non-lizardperson friendly variant of the Tiziran martial art, Kaza Ruk. \
		Reinforced bracing helps keep the wearer planted during close-quarters scuffles."
	clothing_traits = list(TRAIT_FAST_CUFFING, TRAIT_BRAWLING_KNOCKDOWN_BLOCKED, TRAIT_NO_STAGGER, TRAIT_NO_THROW_HITPUSH)

/obj/item/clothing/gloves/kaza_ruk/sec/warden/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/clothing/gloves/kaza_ruk/sec/warden)

/obj/structure/closet/secure_closet/hos/populate_contents_immediate()
	. = ..()
	var/obj/item/gun/energy/e_gun/hos/original_primary = locate(/obj/item/gun/energy/e_gun/hos) in src
	if(original_primary)
		qdel(original_primary)
	new /obj/item/hos_primary_case(src)

/obj/structure/closet/secure_closet/warden/PopulateContents()
	. = ..()
	new /obj/item/stamp/warden(src)
	if(!locate(/obj/item/clothing/gloves/kaza_ruk/sec/warden) in src)
		new /obj/item/clothing/gloves/kaza_ruk/sec/warden(src)

/obj/structure/closet/secure_closet/warden/populate_contents_immediate()
	return ..()

/obj/structure/closet/secure_closet/hop/populate_contents_immediate()
	. = ..()
	new /obj/item/stamp/granted(src)
	new /obj/item/stamp/denied(src)
	new /obj/item/autosurgeon/paperwork(src)

/obj/structure/closet/secure_closet/nanotrasen_consultant/PopulateContents()
	. = ..()
	new /obj/item/autosurgeon/paperwork(src)
