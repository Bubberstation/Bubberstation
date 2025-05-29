/obj/item/gun/ballistic/liberator
	name = "liberator pistol"
	desc = "Hey, it's better than no gun, right?"
	icon = 'GainStation13/icons/obj/weapons/gun.dmi' // Sprites were made by Static and Lew
	icon_state = "liberator"
	w_class = WEIGHT_CLASS_SMALL // It's not really much of a gun...
	mag_type = /obj/item/ammo_box/magazine/m10mm/ramrod
	can_suppress = FALSE
	/// How many bullets are currently stashed in the gun
	var/list/stashed_bullets = list()
	/// What is the max amount of bullets we can stash in this baby?
	var/max_bullets = 5

/obj/item/gun/ballistic/liberator/examine(mob/user)
	. = ..()
	. += span_notice("Inside of the weapon there is a storage container, containing [length(stashed_bullets)] 10mm bullets.")
	. += span_notice("Bullets can be removed from the internal storage using <b>Alt+Click</b>.")

/obj/item/gun/ballistic/liberator/attackby(obj/item/A, mob/user, params)
	if(!istype(A, /obj/item/ammo_casing/c10mm))
		return ..()

	if(length(stashed_bullets) >= max_bullets)
		to_chat(user, span_notice("The storage container in the gun is already full."))
		return


	if(!A.forceMove(src))
		return

	stashed_bullets += A
	to_chat(user, span_notice("You slip the [A] inside of the storage chamber."))

	return

/obj/item/gun/ballistic/liberator/AltClick(mob/user)
	if(!length(stashed_bullets))
		to_chat(user, span_notice("The storage container in the gun is already empty."))
		return

	var/obj/item/removed_bullet = stashed_bullets[1]

	if(!user.put_in_hands(removed_bullet))
		return

	stashed_bullets.Remove(removed_bullet)
	to_chat(user, span_notice("You remove the [removed_bullet] from [src]"))

/obj/item/gun/ballistic/liberator/can_shoot()
	if(!chambered)
		return FALSE
	return TRUE


/obj/item/ammo_box/magazine/m10mm/ramrod // baaaaaaa
	name = "ram rod"
	desc = "Allows for bullets to be pushed into guns."
	icon = 'GainStation13/icons/obj/weapons/gun.dmi'
	icon_state = "ram_rod"
	max_ammo = 1
	multiple_sprites = 1


