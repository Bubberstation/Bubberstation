//ROMULUS REVOLVER

/obj/item/ammo_box/b460 //MOSTLY EXIST SO I CAN TEST WITHOUT HAVING TO PAINSTAKINGLY RELOAD BY HAND
	name = "speed loader (.460)"
	desc = "Designed to quickly reload revolvers used by Romulus officers."
	icon = 'modular_zubbers/icons/obj/reshirevolver.dmi'
	icon_state = "460"
	ammo_type = /obj/item/ammo_casing/b460
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/gun/ballistic/revolver/hos_revolver
	name = "\improper HR-460MS 'Wood Pecker'"
	desc = "A heavy revolver used by Romulus Officers prior to the destruction of the planet, this one is a military spec variant chambered in the high velocity .460 rowland magnum."
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
	worn_icon = null

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
	desc = "Nanotrasen approved head of security kits used by various heroes of the past."
	company_source = "Romulus Shipping Company"
	company_message = span_bold("Copy that SS13, supply pod enroute!")


/obj/item/choice_beacon/head_of_security/generate_display_names()
	var/static/list/hosgun_list
	if(!hosgun_list)
		hosgun_list = list()
		for(var/obj/item/storage/box/hosgun/box as anything in typesof(/obj/item/storage/box/hosgun))
			hosgun_list[initial(box.name)] = box
	return hosgun_list

//KIT STARTS HERE

/obj/item/storage/box/hosgun
	name = "Classic Head of Security 3-round burst pistol 9mm"

/obj/item/storage/box/hosgun/PopulateContents()
	new /obj/item/storage/box/gunset/glock18_hos(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/storage/box/hecu_rations(src)
	new /obj/item/storage/fancy/cigarettes/cigars(src)
	new /obj/item/clothing/neck/tie/red/hitman(src)

/obj/item/storage/box/hosgun/revolver
	name = "Romulus Expeditionary Officer Heavy Revolver .460"

/obj/item/storage/box/hosgun/revolver/PopulateContents()
	new /obj/item/storage/box/gunset/hos_revolver(src)
	new /obj/item/storage/box/nri_rations(src)
	new /obj/item/knife/combat/survival(src)
	new	/obj/item/clothing/neck/cloak/hos/redsec(src)
	new /obj/item/clothing/under/rank/security/head_of_security/redsec(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/redsec(src)
	new /obj/item/clothing/shoes/jackboots/sec/redsec(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/storage/secure/briefcase/white/mcr_loadout/tacticool(src)

/obj/item/storage/box/hosgun/glock
	name = "Underworld Stylistic Dual .45 Pistol"

/obj/item/storage/box/hosgun/glock/PopulateContents()
	new /obj/item/storage/box/gunset/m1911red_hos(src)
	new /obj/item/storage/box/gunset/m1911blue_hos(src)
	new /obj/item/knife/combat(src)
	new /obj/item/clothing/under/rank/expeditionary_corps/leader(src)
	new /obj/item/clothing/gloves/color/black/expeditionary_corps(src)
	new /obj/item/clothing/suit/armor/vest/expeditionary_corps(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper(src)
	new /obj/item/storage/belt/security/webbing(src)
	new /obj/item/clothing/shoes/combat/expeditionary_corps(src)
	new /obj/item/clothing/head/beret/durathread/hos(src)

/obj/item/paper/hos_gun_notes
	name = "READ THIS"
	default_raw_text = {"HOS Note<br>
	Congratulations on your assignment to Space Station 13!<br>
	You are being given a choice to sport the loadout of one of our three heroes from the past!<br>
	Yes, you did read that correctly! I'm sure you're excited!<br>
	Classic Head of Security: It contains the Glock 18, a box of cigars and two boxes of ammunition for your pistol. You can print more from the autolathe by hacking it, Or from the ammo workbench if you were to purchase or research the lethal ammunition disk you can obtain special ammunition type.<br>
	Romulus Expeditionary Officer: It contains the Heavy Revolver .460 Military Spec, a rare revolver from Romulus chambered in .460 Rowland Magnum. You get no speedloader included in the kit but at the very least you get a pouch to hold your ammo. Comes with the classic expeditionary corps gear minus the helmet due to some safety concerns. if you need more ammo, you can research Romulus Technology Node.<br>
	Underworld Stylistic Devil: Contains two Custom M1911s originally intended as replacement of the captain's pistol that has been modified even further for combatting supernatural forces. Red security gear included, comes with a complimentary knife though if you run out of ammo<br>
	- Rowley"}

//Special Ammo for 460

/datum/techweb_node/rowlandmagnumresearch
	id = "romulus_ammo"
	display_name = "Romulus Technology"
	description = "From the field of Romulus comes special ammo."
	prereq_ids = list("weaponry")
	design_ids = list(
		"b460_print",
		"b460_trac",
		"b460_rubber",
		"b460_softpoint",
		"b460_bouncing"
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


//SCRAPPED
/*
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
*/
/datum/design/b460_trac
	name = ".460 Rowland Magnum Tracking Bullet Casing"
	desc = "tracking bullet casing for any gun that can chamber .460 Rowland Magnum."
	id = "b460_trac"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 700, /datum/material/plasma= 1000, /datum/material/gold = 500, /datum/material/titanium = 500)
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
	materials = list(/datum/material/iron = 100, /datum/material/silver = 100)
	build_path = /obj/item/ammo_casing/b460/rubber
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/b460_softpoint
	name = ".460 Rowland Magnum Soft Point Bullet Casing"
	desc = "soft point expanding bullet casing for any gun that can chamber .460 Rowland Magnum."
	id = "b460_softpoint"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 100, /datum/material/titanium = 800)
	build_path = /obj/item/ammo_casing/b460/softpoint
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/b460_bouncing
	name = ".460 Rowland Magnum Bouncing Bullet Casing"
	desc = "smart bouncing bullet casing capable of tracking enemy"
	id = "b460_bouncing"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 100, /datum/material/silver = 500)
	build_path = /obj/item/ammo_casing/b460/bouncing
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
	damage = 15 //Don't try to kill people with this!
	stamina = 45
	armour_penetration = 0 //it shouldn't be weak against armour so just set it to no armour penetration is fine
	speed = 0.7 //back to normal speed!
	wound_bonus = 0 //Rubber bullet are designed to not pierce the skin, would not make sense it does
	bare_wound_bonus = 0

/obj/item/ammo_casing/b460/rose
	name = ".460 Rowland Magnum Rose bullet casing"
	desc = "A .460 Rowland magnum casing, great against flesh, extremely bad against armour"
	projectile_type = /obj/projectile/bullet/b460/rose

/obj/projectile/bullet/b460/rose
	name = ".460 RM Rose bullet"
	damage = 60 //Don't worry, even just a level 2 armour will make this thing fucking worthless
	bare_wound_bonus = 40
	speed = 2.4 //Slow so you can dodge
	armour_penetration = 0
	weak_against_armour = TRUE
	dismemberment = 1

/obj/item/ammo_casing/b460/softpoint
	name = ".460 Rowland Magnum Low Velocity Soft Point bullet casing"
	desc = "A .460 Rowland magnum casing, great against flesh, exceptionally bad against armour"
	projectile_type = /obj/projectile/bullet/b460/softpoint

/obj/projectile/bullet/b460/softpoint
	name = ".460 RM Softpoint bullet"
	damage = 45 //Ballistic Softpoint, will probably kill you in a lot of circumstances
	wound_bonus = 25
	bare_wound_bonus = 50
	speed = 1.6 //Slow so you can dodge
	armour_penetration = 0
	weak_against_armour = TRUE

/obj/item/ammo_casing/b460/trac
	name = ".460 Rowland Magnum tracking bullet casing"
	desc = "A .460 Rowland magnum casing. this one is loaded with a micro gps technology that can track target."
	projectile_type = /obj/projectile/bullet/b460/trac

/obj/item/ammo_casing/b460/bouncing
	name = ".460 Rowland Magnum Smart bullet casing"
	desc = "A .460 Rowland magnum casing. This one has a smart sensor that seeks out the nearest target upon impacting a wall to ricochet and hit your target for you"
	projectile_type = /obj/projectile/bullet/b460/bouncing

/obj/projectile/bullet/b460/bouncing
	name = ".460 Smart bullet"
	damage = 27 //Low damage comparatively since the main upside is it can home in on target
	armour_penetration = 25 //It still need to break armour else you're kinda skewed
	ricochets_max = 3 //You don't escape the law
	ricochet_chance = 100
	ricochet_shoots_firer = FALSE
	ricochet_auto_aim_range = 5
	ricochet_auto_aim_angle = 310
	ricochet_incidence_leeway = 0

/obj/item/ammo_casing/b460/hi
	name = ".460 Rowland Magnum High Impact casing"
	desc = "High Impact Rowland Magnum, extremely effective at knocking people off their feet. quickly lose effectiveness over range however"
	projectile_type = /obj/projectile/bullet/b460/hi


/obj/projectile/bullet/b460/hi
	name = ".460 High Impact"
	damage = 45
	knockdown = 3 SECONDS
	dismemberment = 0 //If this thing cause dismemberment it would be literally unbeatable
	paralyze = 1 SECONDS //An extremely brief stun meant to stop you from pulling out your gun or something
	stutter = 20 SECONDS
	var/tile_dropoff = 10
	var/tile_dropoff_s = 5

/obj/projectile/bullet/b460/hi/Range()
	..()
	if(damage > 0)
		damage -= tile_dropoff
	if(stamina > 0)
		stamina -= tile_dropoff_s
	if(damage < 0 && stamina < 0)
		qdel(src)

/obj/projectile/bullet/b460/trac
	name = ".460 TRAC bullet"
	damage = 22 //You shouldn't be trying to kill people with this
	armour_penetration = 5

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

//We modularising everything so I'm just gonna shove any auxilary edit I made into my files for now

/obj/item/ammo_casing/energy/laser/blueshield
	e_cost = 100

/obj/item/ammo_casing/energy/electrode/blueshield
	e_cost = 600

//Debugging item

/obj/item/ammo_box/advanced/b460testing
	name = "rowland magnum ammo box"
	desc = "you should not be seeing this"
	icon = 'modular_skyrat/modules/shotgunrebalance/icons/shotbox.dmi'
	icon_state = "slug"
	ammo_type = /obj/item/ammo_casing/b460/hi
	max_ammo = 15

//Clothings stuff...?

/obj/item/clothing/under/rank/expeditionary_corps/leader
	name = "expeditionary corps leader uniform"
	armor_type = /datum/armor/security_head_of_security

/obj/item/clothing/head/beret/durathread/hos
	name = "expeditionary corps leader beret"
	desc = "A durathread reinforced beret used by Romulus expeditionary corps leader"
	armor_type = /datum/armor/hats_hos

/*
/obj/item/storage/belt/security/peacekeeper/hos_revolver
	name = "peacekeeper belt"
	desc = "This belt can hold security gear like handcuffs and flashes. It has a holster for a gun."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "peacekeeperbelt"
	worn_icon_state = "peacekeeperbelt"
*/

