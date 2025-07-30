//The missile launcher
/obj/item/gun/ballistic/rocketlauncher/security
	name = "\improper \"VARS\" Variable Active Radar Missile System"
	desc = "A (relatively) cheap, reusable missile launcher cooked up by the crackpots in the Nanotrasen weapons development labs meant to deal with those pesky space tiders. \
	Uses special patented 69mm \"fire and fuhgeddaboudit\" missiles that home in on targets with large radar signatures, including walls, floors, and most importantly, people."
	icon = 'modular_zubbers/icons/obj/weapons/guns/sec_missile.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	icon_state = "rocketlauncher"
	inhand_icon_state = "rocketlauncher"
	worn_icon_state = "rocketlauncher"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/security_rocketlauncher
	fire_sound = 'modular_zubbers/sound/weapons/sec_missile.ogg'
	cartridge_wording = "missile"
	pin = /obj/item/firing_pin
	backblast = FALSE
	var/self_targeting = FALSE

/obj/item/gun/ballistic/rocketlauncher/security/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(self_targeting)
		return FALSE
	self_targeting = TRUE
	balloon_alert(user, "targeting systems tampered")
	do_sparks(2, FALSE, src)
	return TRUE

//Internal Magazine
/obj/item/ammo_box/magazine/internal/security_rocketlauncher
	name = "missile launcher internal magazine"
	ammo_type = /obj/item/ammo_casing/security_missile
	caliber = CALIBER_69MM
	max_ammo = 1
