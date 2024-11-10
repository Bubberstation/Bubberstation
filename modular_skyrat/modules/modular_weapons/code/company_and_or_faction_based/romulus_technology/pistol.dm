//Pistol, Handguns and Revolvers
//Now improved

/obj/item/gun/ballistic/revolver/hos_revolver
	name = "\improper HR-460MS"
	desc = "An experimental revolver design that can only be loaded one shot at a time, if the initial damage did not kill, the bleedout would. Chambered in .457 Government."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/c457
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/revolver.dmi'
	icon_state = "microtracker"
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/revolver_heavy.ogg'

/obj/item/gun/ballistic/revolver/hos_revolver/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ROMTECH)

/obj/item/gun/ballistic/revolver/hos_revolver/long
	name = "\improper HR-460LR"
	desc = "A long unwiedly revolver from Romulus Technology. chambered in the rare .457 Government. You might be able to kill someone by whacking it over the head"
	icon_state = "tracker"
	force = 18

/obj/item/storage/bag/b460reloadpouch
	name = "reload pouch"
	desc = "A pouch for holding loose casings for .357 ammo and .457 ammo. incompatible with anything else. Fit on your belt too"
	icon = 'modular_skyrat/modules/sec_haul/icons/misc/pouches.dmi'
	icon_state = "reloadpouch"
	slot_flags = ITEM_SLOT_POCKETS | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/romulus_technology/guns_worn.dmi'
	worn_icon_state = null

/obj/item/storage/bag/b460reloadpouch/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = 35
	atom_storage.max_slots = 35
	atom_storage.numerical_stacking = TRUE
	atom_storage.set_holdable(list(
		/obj/item/ammo_casing/c457govt,
		/obj/item/ammo_casing/a357,
	))

/obj/item/storage/bag/b460reloadpouch/PopulateContents()
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)

/obj/item/storage/toolbox/guncase/skyrat/hos_revolver
	name = "heavy revolver .457"

/obj/item/storage/toolbox/guncase/skyrat/hos_revolver/PopulateContents()
	new /obj/item/gun/ballistic/revolver/hos_revolver(src)
	new /obj/item/storage/bag/b460reloadpouch(src)

/obj/item/gun/ballistic/automatic/pistol/m1911/gold
	name = "gold trimmed m1911"
	desc = "A Kayian reproduction of Terran handgun rechambered to .460 ceres  with a small magazine capacity. Now trimmed in gold"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/pistol.dmi'
	icon_state = "m1911"

/obj/item/gun/ballistic/automatic/pistol/m1911/gold/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ROMTECH)

/obj/item/gun/ballistic/automatic/pistol/m1911/gold/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/pistol/m1911/gold/examine_more(mob/user)
	. = ..()

	. += "The feeding ramp is polished to a mirror sheen. It's not going to have any feeding problems. The slide's been replaced with a reinforced version. And it meshes perfectly with the frame. \
		The frame itself has been iron-welded and scraped down multiple times for maximum precision. The front strap part of the frame has been checkered to make it dig into the hand. That prevents any slipping. \
		The sight system's original, too. It's a 3-dot type. It's got an enlarged front sight, giving it superior target sighting capability. \
		The regular hammer's been replaced with a ring hammer. That enhances the cocking control and increases the hammer-down speed. They also reworked the grip safety to accommodate a four fingered Kayian., \
		Looks like they eliminated it altogether. This is a tool for pros. The thumb safety and the slide stop are extended to allow for more precise handling. The base of the trigger guard is whittled down, so you can use a high grip. \
		And the trigger itself is a long type for easy finger access. The trigger pull is about 3.5 pounds. That's about a pound and a half lighter than normal. The magazine well has been widened to make it easier to put in a new magazine  \
		The magazine catch button has been cut down low to make it harder to hit by accident. The mainspring housing has been changed to a flat type to increase grip. \
		To whom it may concerns, These weapon were mostly used by the new Romulus National Army,\
		And it's even been fitted with stepping so that it doesn't slip from the recoil when firing. On top of that, they added cocking serrations to the front part of the slide. That lets you load and eject cartridges faster in an emergency.  \
		Weapons cannot bring people back, but it can save your life."

	return .


/obj/item/storage/toolbox/guncase/skyrat/pistol/m1911_gold
	name = "golden m1911 .460 ceres"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/m1911/gold
	extra_to_spawn = /obj/item/ammo_box/magazine/m45

/obj/item/storage/toolbox/guncase/skyrat/pistol/m1911/PopulateContents()
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/c45 = 2,
	), src)

/obj/item/storage/toolbox/guncase/skyrat/pistol/m45a5
	name = "heavy pistol .460 magnum"

/obj/item/storage/toolbox/guncase/skyrat/pistol/m45a5/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)
	new /obj/item/storage/pouch/ammo(src)

/obj/item/gun/ballistic/automatic/pistol/m45a5
	name = "M4A5"
	desc = "A standard issue pistol given to pilot officers in Romulus Federation, chambered in .460 Rowland Magnum, now commonly found in the hands of high ranking NanotTrasen Staff"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/pistol.dmi'
	icon_state = "m45a5"
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/pistol_heavy.ogg'
	force = 15
	fire_delay = 1 SECONDS
	special_mags = TRUE
	recoil = 3

	accepted_magazine_type = /obj/item/ammo_box/magazine/m45a5
	spawn_magazine_type = /obj/item/ammo_box/magazine/m45a5

/obj/item/gun/ballistic/automatic/pistol/m45a5/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ROMTECH)

/obj/item/gun/ballistic/automatic/pistol/m45a5/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/pistol/m45a5/examine_more(mob/user)
	. = ..()

	. += "This Design was made by Romulus Technology for \
		usage during the start of the NRI-Sol Border war. \
		Following the embargo and trade restriction \
		making it impossible for Romulus Federation to source weapory, \
		with this design being rapidly pushed out, being made from an advanced sol design \
		this pistol seems rather unassuming but it has been, itself, the new symbol of peace  \
		Leaving NRI weapon in the past, as it now became the symbol of the oppressive era of Romulus\
		To whom it may concerns, These weapon were mostly used by the new Romulus National Army,\
		 it was a symbol of struggle and freedom \
		Weapons cannot bring people back, but it can save your life."

	return .
