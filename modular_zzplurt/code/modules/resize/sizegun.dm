/obj/projectile/sizelaser
	name = "sizeray laser"
	icon_state = "omnilaser"
	hitsound = null
	damage = 5
	damage_type = STAMINA
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE

/obj/projectile/sizelaser/shrinkray
	icon_state = "bluelaser"

/obj/projectile/sizelaser/growthray
	icon_state = "laser"

/obj/projectile/sizelaser/shrinkray/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/living = target
		var/new_size = RESIZE_NORMAL
		switch(get_size(target))
			if(RESIZE_MACRO to INFINITY)
				new_size = RESIZE_HUGE
			if(RESIZE_HUGE to RESIZE_MACRO)
				new_size = RESIZE_BIG
			if(RESIZE_BIG to RESIZE_HUGE)
				new_size = RESIZE_NORMAL
			if(RESIZE_NORMAL to RESIZE_BIG)
				new_size = RESIZE_SMALL
			if(RESIZE_SMALL to RESIZE_NORMAL)
				new_size = RESIZE_TINY
			if(RESIZE_TINY to RESIZE_SMALL)
				new_size = RESIZE_MICRO
			if((0 - INFINITY) to RESIZE_NORMAL)
				new_size = RESIZE_MICRO
		living.update_size(new_size)

/obj/projectile/sizelaser/growthray/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/living = target
		var/new_size = RESIZE_NORMAL
		switch(get_size(target))
			if(RESIZE_HUGE to RESIZE_MACRO)
				new_size = RESIZE_MACRO
			if(RESIZE_BIG to RESIZE_HUGE)
				new_size = RESIZE_HUGE
			if(RESIZE_NORMAL to RESIZE_BIG)
				new_size = RESIZE_BIG
			if(RESIZE_SMALL to RESIZE_NORMAL)
				new_size = RESIZE_NORMAL
			if(RESIZE_TINY to RESIZE_SMALL)
				new_size = RESIZE_SMALL
			if(RESIZE_MICRO to RESIZE_TINY)
				new_size = RESIZE_TINY
			if((0 - INFINITY) to RESIZE_MICRO)
				new_size = RESIZE_MICRO
		living.update_size(new_size)

/obj/item/ammo_casing/energy/laser/growthray
	projectile_type = /obj/projectile/sizelaser/growthray
	select_name = "Growth"

/obj/item/ammo_casing/energy/laser/shrinkray
	projectile_type = /obj/projectile/sizelaser/shrinkray
	select_name = "Shrink"

//Gun
/obj/item/gun/energy/laser/sizeray
	name = "size ray"
	icon_state = "bluetag"
	desc = "Debug size manipulator. You probably shouldn't have this!"
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/laser/shrinkray, /obj/item/ammo_casing/energy/laser/growthray)
	selfcharge = TRUE
	charge_delay = 5
	ammo_x_offset = 2
	clumsy_check = 1

/obj/item/gun/energy/laser/sizeray/update_overlays()
	. = ..()
	var/current_index = select
	if(current_index == 1)
		icon_state = "redtag"
	else
		icon_state = "bluetag"
