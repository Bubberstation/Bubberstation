// lever-action rifle
/obj/item/gun/ballistic/rifle/boltaction/leveraction
	icon = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/sar_inc.dmi'
	icon_state = "leverrifle"
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/leveraction
	bolt_wording = "bolt"
	bolt_type = BOLT_TYPE_LOCKING
	semi_auto = FALSE
	internal_magazine = TRUE
	can_be_sawn_off = TRUE
	name = "\improper Winnfield Rifle"
	desc = "A replica of an Terran American lever-action rifle firing .40 Sol Long. Bears the distinctive cobalt mark of SAR Inc quality. Nobody's quite sure what specific model it's a replica of though..."
	sawn_desc = "you should not ever see this in real gameplay. If you do it's a bug and you should report it pretty please."
	lefthand_file = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/inhand_left.dmi'
	righthand_file = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/inhand_right.dmi'
	inhand_icon_state = "leverrifle"
	worn_icon = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/worn.dmi'
	worn_icon_state = "leverrifle"
	weapon_weight = WEAPON_HEAVY
	projectile_damage_multiplier = 1.1	//you're sacrificing capacity and firing rate, a 10% damage bonus seems reasonable

/obj/item/gun/ballistic/rifle/boltaction/leveraction/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SAR_STOCK)

/obj/item/gun/ballistic/rifle/boltaction/leveraction/examine_more(mob/user)
	. = ..()

	. += "The Winnfield Repeating Rifle was originally produced in the late \
		1800s on Terra. Originally chambered in a rifle-length .38 caliber, \
		it was widely popular amongst outlaws, thieves, and those who fought them. \
		In 2557, Solar Arms Recreations, Inc. settled upon this model of \
		Winnfield to recreate for the modern collector and enthusiast market. \
		While the exterior and most internal mechanisms are unchanged, the \
		weapon has been brought up to modern safety standards and rechambered \
		for the far more common Solar .40 cartridge."

	return .

/obj/item/gun/ballistic/rifle/boltaction/leveraction/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/shotgun/riot/sol/leverriflesawn
	icon = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/sar_inc.dmi'
	can_be_sawn_off = FALSE
	name = "\improper Sawn-Off Winnfield Rifle"
	desc = "A horribly mangled replica of an American lever-action rifle firing .40 Sol Long. The stock, barrel, and tube have been sawn down, likely for 'cool points.' Fittingly, the seal of quality burned into the stock was sawn off as well."
	icon_state = "sawnlever"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/leveraction/sawn
	weapon_weight = WEAPON_LIGHT
	w_class = WEIGHT_CLASS_NORMAL
	spread = 10
	projectile_damage_multiplier = 0.7
	lefthand_file = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/inhand_left.dmi'
	righthand_file = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/inhand_right.dmi'
	inhand_icon_state = "leverrifle_sawn"
	worn_icon = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/worn.dmi'
	worn_icon_state = "sawn"

/obj/item/gun/ballistic/shotgun/riot/sol/leverriflesawn/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SAR_NOSTOCK)

/obj/item/gun/ballistic/shotgun/riot/sol/leverriflesawn/examine_more(mob/user)
	. = ..()

	. += "The Winnfield Repeating Rifle was originally produced in the late \
		1800s on Terra. Originally chambered in a rifle-length .38 caliber, \
		it was widely popular amongst outlaws, thieves, and those who fought them. \
		In 2557, Solar Arms Recreations, Inc. settled upon this model of \
		Winnfield to recreate for the modern collector and enthusiast market. \
		While the exterior and most internal mechanisms are unchanged, the \
		weapon has been brought up to modern safety standards and rechambered \
		for the far more common Solar .40 cartridge. This one has been 'field-modified' \
		by sawing down the barrel, stock, and magazine tube to make a weapon that \
		is commonly described as 'painful to look at,' 'terrifying,' and 'a sin against nature.'"

	return .

/obj/item/gun/ballistic/rifle/boltaction/leveraction/sawoff(mob/user, obj/item/saw, handle_modifications = TRUE)
	. = ..()
	new /obj/item/gun/ballistic/shotgun/riot/sol/leverriflesawn(get_turf(loc))
	qdel(src)
	return

/obj/item/gun/ballistic/shotgun/riot/sol/leverriflesawn/rack(mob/user)
	. = ..()
	flick("sawnleverflip",src)
	return

/obj/item/gun/ballistic/rifle/boltaction/leveraction/holy
	icon_state = "rifleholy"
	name = "\improper Winnfield Rifle Custom"
	desc = "A custom-modified replica of an Terran American lever-action rifle firing .40 Sol Long. Has an integral suppressor and is advertised to have been 'machined in holy water.' Bears the distinctive cobalt mark of SAR Inc quality."
	inhand_icon_state = "holyrifle"
	worn_icon_state = "holyrifle"
	can_be_sawn_off = FALSE
	suppressed = TRUE
	can_unsuppress = FALSE

/obj/item/gun/ballistic/rifle/boltaction/leveraction/holy/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SAR_BARREL)

/obj/item/gun/ballistic/rifle/boltaction/leveraction/examine_more(mob/user)
	. = ..()

	. += "The Winnfield Repeating Rifle was originally produced in the late \
		1800s on Terra. Originally chambered in a rifle-length .38 caliber, \
		it was widely popular amongst outlaws, thieves, and those who fought them. \
		In 2557, Solar Arms Recreations, Inc. settled upon this model of \
		Winnfield to recreate for the modern collector and enthusiast market. \
		While the exterior and most internal mechanisms are unchanged, the \
		weapon has been brought up to modern safety standards and rechambered \
		for the far more common Solar .40 cartridge. This one is a variant produced \
		by SAR with a custom integrated suppressor, a metal wireframe stock, and a \
		silver finish. Supposedly 'machined with holy water' according to the pamphlet."

	return .

/obj/item/gun/ballistic/rifle/boltaction/leveraction/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")
