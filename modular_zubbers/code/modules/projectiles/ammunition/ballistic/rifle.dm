/obj/item/ammo_casing/strilka310/phasic
	can_be_printed = FALSE

/obj/item/ammo_casing/stingballer
	name = "stingball pellet"
	desc = "A small metal bearing."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ammo.dmi'
	icon_state = "stingball"
	caliber = CALIBER_STINGBALL
	projectile_type = /obj/projectile/bullet/pellet/stingball

/obj/item/ammo_casing/stingballer/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)
