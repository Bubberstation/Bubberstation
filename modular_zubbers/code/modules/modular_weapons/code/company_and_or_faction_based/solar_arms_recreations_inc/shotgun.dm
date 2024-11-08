//lever-action shotgun
/obj/item/gun/ballistic/rifle/boltaction/levershotgun
	icon = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/sar_inc.dmi'
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
	worn_icon_state = "levershotgun"
	weapon_weight = WEAPON_HEAVY
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/shotgun_heavy.ogg'
	rack_sound = 'modular_skyrat/modules/modular_weapons/sounds/shotgun_rack.ogg'
	projectile_damage_multiplier = 1.1 //you're sacrificing firing rate, a 10% damage bonus seems reasonable
	lefthand_file = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/inhand_left.dmi'
	righthand_file = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/inhand_right.dmi'
	worn_icon = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/worn.dmi'
	inhand_icon_state = "levershotgun"

/obj/item/gun/ballistic/rifle/boltaction/levershotgun/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SAR_STOCK)

/obj/item/gun/ballistic/rifle/boltaction/levershotgun/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/rifle/boltaction/levershotgun/examine_more(mob/user)
	. = ..()

	. += "The Coltfield lever-action shotgun was originally produced in the \
		1800s on Terra. Chambered in 12 gauge shells, its use and power made \
		it widely popular amongst outlaws, thieves, and those who fought them. \
		In 2555, Solar Arms Recreations, Inc. settled upon this model of \
		Coltfield to recreate for the modern collector and enthusiast market. \
		While the exterior and most internal mechanisms are unchanged, the \
		weapon has been brought up to modern safety standards, such as the \
		modern digital firing pin and an added safety."

	return .

/obj/item/gun/ballistic/shotgun/riot/sol/levershotgunsawn
	icon = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/sar_inc.dmi'
	can_be_sawn_off = FALSE
	name = "\improper Sawn-Off Coltfield Shotgun"
	desc = "A horribly mangled replica of an American lever-action shotgun. The stock, barrel, and tube have been sawn down, likely for 'cool points.' Fittingly, the seal of quality burned into the stock was sawn off as well."
	icon_state = "sawnlevershotgun"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/levershotgun/sawn
	weapon_weight = WEAPON_LIGHT
	w_class = WEIGHT_CLASS_NORMAL
	spread = 20
	projectile_damage_multiplier = 0.7
	lefthand_file = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/inhand_left.dmi'
	righthand_file = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/inhand_right.dmi'
	inhand_icon_state = "levershotgun_sawn"
	worn_icon = 'modular_zubbers/icons/obj/weapons/guns/sar_inc/worn.dmi'
	worn_icon_state = "sawn"

/obj/item/gun/ballistic/shotgun/riot/sol/levershotgunsawn/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SAR_NOSTOCK)

/obj/item/gun/ballistic/shotgun/riot/sol/levershotgunsawn/examine_more(mob/user)
	. = ..()

	. += "The Coltfield lever-action shotgun was originally produced in the \
		1800s on Terra. Chambered in 12 gauge shells, its use and power made \
		it widely popular amongst outlaws, thieves, and those who fought them. \
		In 2555, Solar Arms Recreations, Inc. settled upon this model of \
		Coltfield to recreate for the modern collector and enthusiast market. \
		While the exterior and most internal mechanisms are unchanged, the \
		weapon has been brought up to modern safety standards, such as the \
		modern digital firing pin and an added safety. This one has been 'field-modified' \
		by sawing down the barrel, stock, and magazine tube to make a weapon that \
		is commonly described as 'painful to look at,' 'terrifying,' and 'a sin against nature.'"

	return .

/obj/item/gun/ballistic/rifle/boltaction/levershotgun/sawoff(mob/user, obj/item/saw, handle_modifications = TRUE)
	. = ..()
	new /obj/item/gun/ballistic/shotgun/riot/sol/levershotgunsawn(get_turf(loc))
	qdel(src)
	return

/obj/item/gun/ballistic/shotgun/riot/sol/levershotgunsawn/rack(mob/user)
	. = ..()
	flick("sawnlevershotgunflip",src)
	return
