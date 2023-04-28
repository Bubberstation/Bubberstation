/obj/item/gun/ballistic/revolver/hos_revolver
	name = "\improper HR-460MS 'Wood Pecker'"
	desc = "A medium sized revolver used by Romulus Officers prior to the destruction of the planet, this one is a military spec variant chambered in the high velocity .460 rowland magnum."
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rowland
	icon = 'modular_zubbers/icons/obj/reshi40x32.dmi'
	icon_state = "microtracker"
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/hpistol_fire.ogg'
	company_flag = COMPANY_ROMULUS

/obj/item/ammo_box/magazine/internal/cylinder/rowland
	name = "\improper rowland revolver cylinder"
	max_ammo = 7
	ammo_type = /obj/item/ammo_casing/b460
	caliber = CALIBER_460

/obj/item/gun/ballistic/revolver/hos_revolver/big
	name = "\improper HR-460OS 'Tracker'"
	desc = "A brutally effectve revolver by Romulus officers prior to destruction of the planet, While not as powerful as their Nanotrasen counterpart, the high-velocity bullet swiftly dispatch armoured target. Chambered in .460 Rowland Magnum."
	icon = 'modular_zubbers/icons/obj/reshirevolver.dmi'
	icon_state = "tracker"
	projectile_damage_multiplier = 1.6


/obj/item/storage/bag/b460reloadpouch
	name = "reload pouch"
	desc = "A pouch for holding loose casings for .460 Rowland ammo. incompatible with anything else. Fit on your belt too"
	icon = 'modular_zubbers/icons/obj/pouches.dmi'
	icon_state = "reloadpouch"
	slot_flags = ITEM_SLOT_POCKETS | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE

/obj/item/storage/bag/b460reloadpouch/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = 70
	atom_storage.max_slots = 70 //hold 20 more than a bluespace trash bag, which was how I used to reload these revolver
	atom_storage.numerical_stacking = TRUE
	atom_storage.set_holdable(list(
		/obj/item/ammo_casing/b460,
		))

/obj/item/storage/bag/b460reloadpouch/PopulateContents()
	. = ..()
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460/rubber(src)
	new /obj/item/ammo_casing/b460/rubber(src)
	new /obj/item/ammo_casing/b460/rubber(src)
	new /obj/item/ammo_casing/b460/rubber(src)
	new /obj/item/ammo_casing/b460/rubber(src)
	new /obj/item/ammo_casing/b460/rubber(src)
	new /obj/item/ammo_casing/b460/rubber(src)
	new /obj/item/ammo_casing/b460/rubber(src)
	new /obj/item/ammo_casing/b460/rubber(src)
	new /obj/item/ammo_casing/b460/rubber(src)
	new /obj/item/ammo_casing/b460/rubber(src)
	new /obj/item/ammo_casing/b460/rubber(src)
	new /obj/item/ammo_casing/b460/rubber(src)
	new /obj/item/ammo_casing/b460/rubber(src)

/obj/item/storage/box/gunset/hos_revolver/PopulateContents()
	new /obj/item/gun/ballistic/revolver/hos_revolver(src)
	new /obj/item/storage/bag/b460reloadpouch(src)

//TEST THIS OUT WHEN NEEDED

/obj/item/choice_beacon/head_of_security
	name = "gun choice beacon"
	desc = "whatever you choose will determine the outcome of space station 13. so choose wisely."
	company_source = "Romulus Shipping Company"
	company_message = span_bold("Copy that SS13, supply pod enroute!")


/obj/item/choice_beacon/head_of_security/generate_display_names()
	var/static/list/hosgun_list
	if(!hosgun_list)
		hosgun_list = list()
		for(var/obj/item/storage/box/hosgun/box as anything in typesof(/obj/item/storage/box/hosgun))
			hosgun_list[initial(box.name)] = box
	return hosgun_list

/obj/item/storage/box/hosgun
	name = "Classic Head of Security 3-round burst pistol 9mm"

/obj/item/storage/box/hosgun/PopulateContents()
	new /obj/item/storage/box/gunset/glock18_hos(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/storage/box/hecu_rations(src)
	new /obj/item/storage/fancy/cigarettes/cigars(src)

/obj/item/storage/box/hosgun/revolver
	name = "Romulus Officer Heavy Revolver .460"

/obj/item/storage/box/hosgun/revolver/PopulateContents()
	new /obj/item/storage/box/gunset/hos_revolver(src)
	new	/obj/item/clothing/neck/cloak/hos/redsec(src)
	new /obj/item/clothing/under/rank/security/head_of_security/redsec(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/redsec(src)
	new /obj/item/clothing/shoes/jackboots/sec/redsec(src)
	new /obj/item/storage/box/nri_rations(src)
	new /obj/item/knife/combat(src)

/obj/item/storage/box/hosgun/glock
	name = "Solaris International Contractor Dual .45 Pistol"

/obj/item/storage/box/hosgun/glock/PopulateContents()
	new /obj/item/storage/box/gunset/m1911_captains(src)
	new /obj/item/storage/box/gunset/m1911_captains(src)
	new /obj/item/clothing/under/rank/security/head_of_security/peacekeeper/sol(src)
	new /obj/item/clothing/neck/tie/red/hitman(src)
	new /obj/item/storage/pill_bottle/probital(src)

/obj/item/paper/hos_gun_notes
	name = "READ THIS"
	default_raw_text = {"HOS Note<br>
	Congratulations on your assignment to Space Station 13!<br>
	You are being given a choice to sport the loadout of one of our three heroes from the past!<br>
	Yes, you did read that correctly! I'm sure you're excited!<br>
	Classic Head of Security: It contains the Glock 18, a box of cigars and two boxes of ammunition for your pistol. You can print more from the autolathe by hacking it, Or from the ammo workbench if you were to purchase or research the lethal ammunition disk you can obtain special ammunition type.<br>
	Romulus Officer: It contains the Heavy Revolver .460 Military Spec, a rare revolver from Romulus chambered in .460 Rowland Magnum. You get no speedloader included in the kit but at the very least you get a pouch to hold your ammo. Comes with the classic red security loadout.<br>
	Solaris International Contractor: Contains two Custom M1911s originally intended as replacement of the captain's pistol. Comes with an expensive red neosilk necktie and the Sol chief of police uniform. Painkillers included.<br>
	- Rowley"}

//Special Ammo for 460

/datum/techweb_node/rowlandmagnumresearch
	id = "romulus_ammo"
	display_name = "Romulus Technology"
	description = "From the field of Romulus comes special ammo."
	prereq_ids = list("weaponry")
	design_ids = list(
		"b460_print",
		"b460_rose",
		"b460_trac",
		"b460_rubber",
		"b460_softpoint"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 4500)

/datum/design/b460_print
	name = ".460 Rowland Magnum High Velocity Bullet Casing"
	desc = "high velocity bullet casing for any gun that can chamber .460 Rowland Magnum."
	id = "b460_print"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1000) //Print a lot or something
	build_path = /obj/item/ammo_casing/b460
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/b460_rose
	name = ".460 Rowland Magnum Rose Bullet Casing"
	desc = "soft point bullet casing for any gun that can chamber .460 Rowland Magnum."
	id = "b460_rose"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1000, /datum/material/silver = 1000)
	build_path = /obj/item/ammo_casing/b460/rose
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/b460_trac
	name = ".460 Rowland Magnum Tracking Bullet Casing"
	desc = "tracking bullet casing for any gun that can chamber .460 Rowland Magnum."
	id = "b460_trac"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1000, /datum/material/plasma= 2000, /datum/material/gold = 1500)
	build_path = /obj/item/ammo_casing/b460/trac
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY


/datum/design/b460_rubber
	name = ".460 Rowland Magnum Rubber Bullet Casing"
	desc = "rubber bullet casing for any gun that can chamber .460 Rowland Magnum."
	id = "b460_rubber"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1000, /datum/material/silver = 1000)
	build_path = /obj/item/ammo_casing/b460/rubber
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

//AMMO ITSELF

/obj/item/ammo_casing/b460/rubber
	name = ".460 Rowland Magnum Rubber bullet casing"
	desc = "A .460 Rowland magnum casing, ideal for giving people lots of pains"
	projectile_type = /obj/projectile/bullet/b460/rubber

/obj/projectile/bullet/b460/rubber
	name = ".460 RM Rubber bullet"
	damage = 10
	stamina = 45
	armour_penetration = 0
	speed = 0.7 //back to normal speed!

/obj/item/ammo_casing/b460/rose
	name = ".460 Rowland Magnum Rose bullet casing"
	desc = "A .460 Rowland magnum casing, great against flesh, extremely bad against armour"
	projectile_type = /obj/projectile/bullet/b460/rose

/obj/projectile/bullet/b460/rose
	name = ".460 RM Rose bullet"
	damage = 60 //Don't worry, even just a level 2 armour will make this thing fucking worthless
	bare_wound_bonus = 40
	speed = 2.4 //Slow so you can dodge
	weak_against_armour = TRUE
	dismemberment = 1

/obj/item/ammo_casing/b460/trac
	name = ".460 Rowland Magnum \"TRAC\" bullet casing"
	desc = "A .460 Rowland magnum casing."
	projectile_type = /obj/projectile/bullet/b460/trac

/obj/projectile/bullet/b460/trac
	name = ".460 TRAC bullet"
	damage = 25
	ricochets_max = 3 //You don't escape the law
	ricochet_chance = 50
	ricochet_shoots_firer = FALSE
	ricochet_auto_aim_range = 3
	ricochet_auto_aim_angle = 30
	ricochet_incidence_leeway = 40
	armour_penetration = 0

/obj/projectile/bullet/b460/trac/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/mob/living/carbon/M = target
	if(!istype(M))
		return
	var/obj/item/implant/tracking/c38/imp
	for(var/obj/item/implant/tracking/c38/TI in M.implants) //checks if the target already contains a tracking implant
		imp = TI
		return
	if(!imp)
		imp = new /obj/item/implant/tracking/c38(M)
		imp.implant(M)

//Clothings stuff...?
/*
/obj/item/storage/belt/security/peacekeeper/hos_revolver
	name = "peacekeeper belt"
	desc = "This belt can hold security gear like handcuffs and flashes. It has a holster for a gun."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "peacekeeperbelt"
	worn_icon_state = "peacekeeperbelt"
*/

