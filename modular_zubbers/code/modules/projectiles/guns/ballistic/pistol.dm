/obj/item/gun/ballistic/automatic/pistol/ntusp
	name = "NT-USP pistol"
	desc = "A small pistol that uses hardlight technology to synthesize bullets. Due to its low power, it doesn't have much use besides tiring out criminals."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "ntusp"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/ntusp
	can_suppress = TRUE
	bolt_type = BOLT_TYPE_LOCKING
	vary_fire_sound = FALSE
	fire_sound_volume = 80
	bolt_wording = "slide"
	suppressor_x_offset = 0

/obj/item/gun/ballistic/automatic/pistol/ntusp/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 15, \
		overlay_y = 13)
