/obj/structure/closet/secure_closet/interdynefob/munitions_locker/PopulateContents()
	// This looks terrible, but what it basically does is skip the whole skyrat thing we're trying to override
	// Yes, that is a grandparent call
	// To whoever is reading this, God abandoned us on this very day
	.......()

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/m9mm = 6,
		/obj/item/ammo_box/magazine/m9mm/fire = 2,
		/obj/item/ammo_box/advanced/s12gauge/buckshot = 1,
		/obj/item/ammo_box/advanced/s12gauge = 2,
		/obj/item/ammo_box/advanced/s12gauge/rubber = 2,
		/obj/item/ammo_box/magazine/sniper_rounds/soporific = 2,
	), src)
