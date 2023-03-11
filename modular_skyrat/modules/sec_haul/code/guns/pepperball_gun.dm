/obj/item/gun/ballistic/automatic/pistol/pepperball
	name = "\improper Bolt Pepperball AHG"
	desc = "An incredibly mediocre 'firearm' designed to fire soft pepper balls meant to easily subdue targets."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pepperball.dmi'
	icon_state = "peppergun"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/pepperball
	can_suppress = FALSE
	fire_sound = 'sound/effects/pop_expl.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	fire_sound_volume = 50

/obj/item/gun/ballistic/automatic/pistol/pepperball/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_BOLT)

/obj/item/gun/ballistic/automatic/pistol/pepperball/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', light_overlay = "flight")

/obj/item/ammo_box/magazine/pepperball
	name = "pistol magazine (pepperball)"
	desc = "A gun magazine filled with balls."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pepperball.dmi'
	icon_state = "pepperball"
	ammo_type = /obj/item/ammo_casing/pepperball
	caliber = CALIBER_PEPPERBALL
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_casing/pepperball
	name = "pepperball"
	desc = "A pepperball casing."
	caliber = CALIBER_PEPPERBALL
	projectile_type = /obj/projectile/bullet/pepperball
	harmful = FALSE

/obj/projectile/bullet/pepperball
	name = "pepperball orb"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/projectiles.dmi'
	icon_state = "pepperball"
	damage = 0
	stamina = 5
	shrapnel_type = null
	sharpness = NONE
	embedding = null
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	var/contained_reagent = /datum/reagent/consumable/condensedcapsaicin
	var/reagent_volume = 5

/obj/projectile/bullet/pepperball/on_hit(atom/target, blocked, pierce_hit)
	if(isliving(target))
		var/mob/living/M = target
		if(M.can_inject())
			var/datum/reagent/R = new contained_reagent
			R.expose_mob(M, VAPOR, reagent_volume)
	. = ..()

/datum/design/pepperballs
	name = "Pepperball Ammo Box"
	id = "pepperballs"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 5000)
	build_path = /obj/item/ammo_box/advanced/pepperballs
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/obj/item/ammo_box/advanced/pepperballs
	name = "pepperball ammo box"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box10x24-15"
	ammo_type = /obj/item/ammo_casing/pepperball
	custom_materials = list(/datum/material/iron = 5000)
	max_ammo = 15
