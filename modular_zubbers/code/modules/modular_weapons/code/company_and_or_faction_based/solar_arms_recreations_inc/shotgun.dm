/obj/item/gun/ballistic/rifle/boltaction/levershotgun
	icon = 'modular_zubbers/icons/obj/weapons/guns/sar_inc.dmi'
	icon_state = "levershotgun"
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/levershotgun
	bolt_wording = "bolt"
	bolt_type = BOLT_TYPE_LOCKING
	semi_auto = FALSE
	internal_magazine = TRUE
	can_be_sawn_off = TRUE
	name = "\improper Coltfield Shotgun"
	desc = "A replica of a classic Terran American lever-action shotgun firing 12 gauge shells. Bears the distinctive cobalt mark of SAR Inc quality. Nobody's quite sure what specific model it's a replica of though..."
	sawn_desc = "You should not see this! Please report this if you see it in normal gameplay because it is a bug!!"
	inhand_icon_state = "null"
	worn_icon_state = "null"
	weapon_weight = WEAPON_HEAVY

/obj/item/gun/ballistic/rifle/boltaction/levershotgun/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SAR_STOCK)

/obj/item/gun/ballistic/rifle/boltaction/levershotgun/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

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

/obj/item/gun/ballistic/shotgun/riot/sol/levershotgunsawn
	icon = 'modular_zubbers/icons/obj/weapons/guns/sar_inc.dmi'
	can_be_sawn_off = FALSE
	name = "\improper Sawn-Off Replica Lever-Action Shotgun"
	desc = "A horribly mangled replica of an American lever-action shotgun. The stock, barrel, and tube have been sawn down, likely for 'cool points.' Fittingly, the seal of quality burned into the stock was sawn off as well."
	icon_state = "sawnlevershotgun"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/levershotgun/sawn
	weapon_weight = WEAPON_LIGHT
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/ballistic/shotgun/riot/sol/levershotgunsawn/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SAR_NOSTOCK)

/obj/item/gun/ballistic/rifle/boltaction/levershotgun/sawoff(mob/user, obj/item/saw, handle_modifications = TRUE)
	. = ..()
	new /obj/item/gun/ballistic/shotgun/riot/sol/levershotgunsawn(get_turf(loc))
	qdel(src)
	return

/obj/item/gun/ballistic/shotgun/riot/sol/levershotgunsawn/rack(mob/user)
	. = ..()
	flick("sawnlevershotgunflip",src)
	return
