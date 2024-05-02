/obj/item/gun/ballistic/automatic/ar23
	name = "\improper AR-550 'Defender' Assault Rifle"
	desc = "A bullpup full auto assault rifle chambered in .223, Ideal for defending your Managed Democracy."
	icon = 'modular_zubbers/icons/obj/reshirifle.dmi'
	icon_state = "c20r"
	inhand_icon_state = "arg"
	selector_switch_icon = TRUE
	accepted_magazine_type = /obj/item/ammo_box/magazine/m223
	fire_delay = 1.5
	burst_size = 3
	pin = /obj/item/firing_pin
	can_bayonet = TRUE
	mag_display = TRUE
	mag_display_ammo = TRUE
	spread = 15

/obj/item/gun/ballistic/automatic/ar23/Initialize(mapload)
	AddComponent(/datum/component/automatic_fire, 0.6 SECONDS)
