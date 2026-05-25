/obj/item/ammo_box/stingball
	name = "stingball canister"
	desc = "A cut open stingbang."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ammo.dmi'
	icon_state = "stingball_mag-0"
	ammo_type = /obj/item/ammo_casing/stingballer
	max_ammo = 50

/obj/item/ammo_box/stingball/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 25)]"
