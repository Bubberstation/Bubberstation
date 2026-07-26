/obj/item/pen/fountain/green
	name = "nanotrasen fountain pen"
	desc = "It's an expensive green fountain pen. The case may be plastic, but that gold is real!"
	icon = 'modular_zubbers/icons/obj/service/bureaucracy.dmi'
	icon_state = "pen-fountain-nt"
	colour = "#18610D"
	custom_materials = list(/datum/material/gold = SMALL_MATERIAL_AMOUNT*7.5)

/obj/item/storage/belt/holster/consultant
	name = "consultant's holster"
	desc = "A familiar-looking leather holster, with black, leather straps and padded jackets painted in an iconic CentCom green. This one belongs to the Nanotrasen consultant."
	icon = 'modular_zubbers/icons/obj/clothing/belts/belts.dmi'
	icon_state = "holster_ntc"
	storage_type = /datum/storage/holster/consultant

//Storage is the same as the regular holster but it can hold cigar(ette)s, lighters and stamps :)
/datum/storage/holster/consultant/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound, list/holdables)
	holdables = list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/ammo_box/magazine/m9mm,
		/obj/item/ammo_box/magazine/m9mm_aps,
		/obj/item/ammo_box/magazine/m10mm,
		/obj/item/ammo_box/magazine/m45,
		/obj/item/ammo_box/magazine/m50,
		/obj/item/gun/ballistic/revolver,
		/obj/item/ammo_box/speedloader,
		/obj/item/ammo_box/magazine/toy/pistol,
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/dueling,
		/obj/item/gun/energy/laser/thermal,
		/obj/item/gun/energy/laser/captain,
		/obj/item/gun/energy/laser/pistol,
		/obj/item/gun/energy/e_gun/hos,
		/obj/item/gun/ballistic/rifle/boltaction,
		/obj/item/cigarette,
		/obj/item/lighter,
		/obj/item/stamp,
	)

	return ..()

/obj/item/storage/belt/holster/consultant/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/speedloader/c38/c32 = 1,
		/obj/item/gun/ballistic/revolver/consultant = 1,
		/obj/item/stamp/void = 1,
	), src)

/obj/item/consultant/weapon_case
	name = "consultant's weapon case"
	desc = "A secure case containing the consultant's trustworthy weapon."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/gunsets.dmi'
	icon_state = "guncase"
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/worn/cases.dmi'
	worn_icon_state = "darkcase"
	material_flags = NONE
	w_class = WEIGHT_CLASS_NORMAL
	var/redeemed = FALSE

/obj/item/consultant/weapon_case/click_alt(mob/user)
	try_redeem(user)
	return CLICK_ACTION_SUCCESS

/obj/item/consultant/weapon_case/attack_self(mob/user)
	try_redeem(user)

/obj/item/consultant/weapon_case/proc/try_redeem(mob/user)
	if(redeemed || QDELETED(src))
		return
	if(!isliving(user))
		return
	var/mob/living/redeemer = user
	if(redeemer.incapacitated)
		return

	var/static/list/options
	if(!options)

		var/datum/radial_menu_choice/centcomsabre_option = new
		centcomsabre_option.image = image(icon = 'modular_zubbers/icons/obj/weapons/melee.dmi', icon_state = "cc-sheath-full")
		centcomsabre_option.info = span_boldnotice("A beautiful sabre, coming with a green leather sheath, fashioned after those granted to the Centcom Commanders. A status symbol for the true bureaucrat. For when the sword is mightier than the pen.")

		var/datum/radial_menu_choice/admiralsabre_option = new
		admiralsabre_option.image = image(icon = 'modular_zubbers/icons/obj/weapons/melee.dmi', icon_state = "admiral-sheath-full")
		admiralsabre_option.info = span_boldnotice("A beautiful sabre, coming with a black leather sheath, fashioned after those granted to Nanotrasen Admirals. A status symbol for the true bureaucrat. For when the sword is mightier than the pen.")

		var/datum/radial_menu_choice/miniegun_option = new
		miniegun_option.image = image(icon = 'icons/obj/weapons/guns/energy.dmi', icon_state = "mini")
		miniegun_option.info = span_boldnotice("The classic, the mini e-gun. Fits in your pocket, has a disabler and a lethal mode, and includes a flashlight. Perfect for the consultant who doesn't want to draw too much attention to themselves, but still wants to be prepared for anything.")

		var/datum/radial_menu_choice/verdict_option = new
		verdict_option.image = image(icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi', icon_state = "niimconsultantrevolver")
		verdict_option.info = span_boldnotice("The Verdict, a weapon reminiscent of the other Nanotrasen Armories revolvers. It's similar to the all-slavic Unica, but with a lovely nickel polish. It is, however, much weaker and lighter than one, and uses a unique .32 caliber. Comes with a holster. Now all you're missing is a fat cigar.")

		options = list(
			"Commander's Sabre Replica" = centcomsabre_option,
			"Admiral's Sabre Replica" = admiralsabre_option,
			"Miniature Energy Gun" = miniegun_option,
			"The Verdict" = verdict_option,
		)

	var/selection = show_radial_menu(redeemer, src, options, custom_check = CALLBACK(src, PROC_REF(check_redeem_menu), redeemer), radius = 38, require_near = TRUE, tooltips = TRUE)
	if(!selection || redeemed || QDELETED(src))
		return

	var/spawn_path
	switch(selection)
		if("Commander's Sabre Replica")
			spawn_path = /obj/item/storage/belt/sheath/sabre/ntc_commander
		if("Admiral's Sabre Replica")
			spawn_path = /obj/item/storage/belt/sheath/sabre/ntc_admiral
		if("Miniature Energy Gun")
			spawn_path = /obj/item/gun/energy/e_gun/mini
		if("The Verdict")
			spawn_path = /obj/item/storage/belt/holster/consultant
		else
			return

	redeemed = TRUE
	var/obj/item/chosen_item = new spawn_path(drop_location())
	redeemer.put_in_hands(chosen_item)
	balloon_alert(redeemer, "selected [LOWER_TEXT(selection)]")
	qdel(src)

/obj/item/consultant/weapon_case/proc/check_redeem_menu(mob/living/redeemer)
	if(!istype(redeemer))
		return FALSE
	if(redeemer.incapacitated)
		return FALSE
	if(QDELETED(src) || redeemed)
		return FALSE
	if(!redeemer.Adjacent(src))
		return FALSE
	return TRUE
