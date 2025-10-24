/*
*	Security clothing reskins and such.
	Redsec items at the bottom tbd.
*/

/*
* ACCESSORIES
*/

/obj/item/clothing/accessory/armband/deputy/lopland/nonsec
	name = "blue armband"
	desc = "An armband, worn to signify proficiency in a skill or association with a department. This one is blue."

/obj/item/clothing/accessory/armband/deputy/lopland
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "armband_lopland"
	desc = "A Peacekeeper-blue armband, showing the wearer to be certified by Lopland as a top-of-their-class Security Officer."

/*
* BACKPACKS
*/
/obj/item/storage/backpack/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "backpack_security_black"
	inhand_icon_state = "backpack_security_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "backpack_security_black",
			RESKIN_WORN_ICON_STATE = "backpack_security_black",
			RESKIN_INHAND_STATE = "backpack_security_black"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "backpack_security_white",
			RESKIN_WORN_ICON_STATE = "backpack_security_white",
			RESKIN_INHAND_STATE = "backpack_security_white"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/storage/backpack.dmi',
			RESKIN_ICON_STATE = "backpack-security",
			RESKIN_WORN_ICON = 'icons/mob/clothing/back/backpack.dmi',
			RESKIN_INHAND_L = 'icons/mob/inhands/equipment/backpack_lefthand.dmi',
			RESKIN_INHAND_R = 'icons/mob/inhands/equipment/backpack_righthand.dmi',
			RESKIN_INHAND_STATE = "securitypack"
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/back/backpack.dmi',
			RESKIN_ICON_STATE = "backpack-security",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/back/backpack.dmi',
		),
	)

/obj/item/storage/backpack/satchel/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "satchel_security_black"
	inhand_icon_state = "satchel_security_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "satchel_security_black",
			RESKIN_WORN_ICON_STATE = "satchel_security_black",
			RESKIN_INHAND_STATE = "satchel_security_black"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "satchel_security_white",
			RESKIN_WORN_ICON_STATE = "satchel_security_white",
			RESKIN_INHAND_STATE = "satchel_security_white"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/storage/backpack.dmi',
			RESKIN_ICON_STATE = "satchel-security",
			RESKIN_WORN_ICON = 'icons/mob/clothing/back/backpack.dmi',
			RESKIN_INHAND_L = 'icons/mob/inhands/equipment/backpack_lefthand.dmi',
			RESKIN_INHAND_R = 'icons/mob/inhands/equipment/backpack_righthand.dmi',
			RESKIN_INHAND_STATE = "satchel-sec"
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/back/backpack.dmi',
			RESKIN_ICON_STATE = "satchel-security",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/back/backpack.dmi',
		),
	)

/obj/item/storage/backpack/duffelbag/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "duffel_security_black"
	inhand_icon_state = "duffel_security_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "duffel_security_black",
			RESKIN_WORN_ICON_STATE = "duffel_security_black",
			RESKIN_INHAND_STATE = "duffel_security_black"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "duffel_security_white",
			RESKIN_WORN_ICON_STATE = "duffel_security_white",
			RESKIN_INHAND_STATE = "duffel_security_white"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/storage/backpack.dmi',
			RESKIN_ICON_STATE = "duffel-security",
			RESKIN_WORN_ICON = 'icons/mob/clothing/back/backpack.dmi',
			RESKIN_INHAND_L = 'icons/mob/inhands/equipment/backpack_lefthand.dmi',
			RESKIN_INHAND_R = 'icons/mob/inhands/equipment/backpack_righthand.dmi',
			RESKIN_INHAND_STATE = "duffel-sec"
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/back/backpack.dmi',
			RESKIN_ICON_STATE = "duffel-security",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/back/backpack.dmi',
		),
	)

/*
* BELTS
*/
/obj/item/storage/belt/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "belt_white"
	worn_icon_state = "belt_white"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "belt_black",
			RESKIN_WORN_ICON_STATE = "belt_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "belt_blue",
			RESKIN_WORN_ICON_STATE = "belt_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "belt_white",
			RESKIN_WORN_ICON_STATE = "belt_white"
		),
		"Slim Variant" = list(
			RESKIN_ICON_STATE = "belt_slim",
			RESKIN_WORN_ICON_STATE = "belt_slim"
		),
		"Red Variant" = list(
				RESKIN_ICON = 'icons/obj/clothing/belts.dmi',
				RESKIN_ICON_STATE = "security",
				RESKIN_WORN_ICON = 'icons/mob/clothing/belt.dmi',
				RESKIN_WORN_ICON_STATE = "security",
			),
		"Armadyne Variant" = list(
			RESKIN_ICON_STATE = "armadyne_belt",
			RESKIN_WORN_ICON_STATE = "armadyne_belt"
			),
		"Pink Variant" = list(
				RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/belt.dmi',
				RESKIN_ICON_STATE = "security",
				RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/belt.dmi',
				RESKIN_WORN_ICON_STATE = "security",
			),
	)

/obj/item/storage/belt/security/webbing
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Variant" = list(
			RESKIN_ICON_STATE = "securitywebbing",
			RESKIN_WORN_ICON_STATE = "securitywebbing"
		),
		"Black Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi',
			RESKIN_ICON_STATE = "armadyne_webbing",
			RESKIN_WORN_ICON_STATE = "armadyne_webbing",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
		),
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi',
			RESKIN_ICON_STATE = "peacekeeper_webbing",
			RESKIN_WORN_ICON_STATE = "peacekeeper_webbing",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
		),
	)

/obj/item/storage/belt/security/webbing/peacekeeper //did I mention this codebase is fucking awful
	current_skin = "peacekeeper_webbing"

/obj/item/storage/belt/security/webbing/peacekeeper/armadyne //You two only exist because I don't want to purge you, because it'd break some stuff. Thin fucking ice.
	current_skin = "armadyne_webbing"

///Enables you to quickdraw weapons from security holsters
/datum/storage/security/open_storage(datum/source, mob/user)
	var/atom/resolve_parent = parent
	if(!resolve_parent)
		return
	if(isobserver(user))
		show_contents(user)
		return

	if(!resolve_parent.IsReachableBy(user))
		resolve_parent.balloon_alert(user, "can't reach!")
		return FALSE

	if(!isliving(user) || user.incapacitated)
		return FALSE

	var/obj/item/gun/gun_to_draw = locate() in real_location
	if(!gun_to_draw)
		return ..()
	resolve_parent.add_fingerprint(user)
	attempt_remove(gun_to_draw, get_turf(user))
	playsound(resolve_parent, 'modular_skyrat/modules/sec_haul/sound/holsterout.ogg', 50, TRUE, -5)
	INVOKE_ASYNC(user, TYPE_PROC_REF(/mob, put_in_hands), gun_to_draw)
	user.visible_message(span_warning("[user] draws [gun_to_draw] from [resolve_parent]!"), span_notice("You draw [gun_to_draw] from [resolve_parent]."))

/*
* GLASSES
*/
/obj/item/clothing/glasses/hud/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "security_hud"
	glass_colour_type = /datum/client_colour/glass_colour/lightblue
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "security_hud",
			RESKIN_WORN_ICON_STATE = "security_hud"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "securityhud",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
		),
	)

/obj/item/clothing/glasses/hud/security/sunglasses
	icon_state = "security_hud_black"
	glass_colour_type = /datum/client_colour/glass_colour/blue
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Dark-Tint Variant" = list(
			RESKIN_ICON_STATE = "security_hud_black",
			RESKIN_WORN_ICON_STATE = "security_hud_black"
		),
		"Light-Tint Variant" = list(
			RESKIN_ICON_STATE = "security_hud_blue",
			RESKIN_WORN_ICON_STATE = "security_hud_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "sunhudsec",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "sunhudsec",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/eyes.dmi',
		),
		"Blue Goggles Variant" = list(
			RESKIN_ICON_STATE = "peacekeeperglasses",
			RESKIN_WORN_ICON_STATE = "peacekeeperglasses"
		),
		"Red Goggles Variant" = list(
			RESKIN_ICON_STATE = "armadyne_glasses",
			RESKIN_WORN_ICON_STATE = "armadyne_glasses"
		),
		"Pink Goggles Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "secgogpink",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "secgogpink",
		),
	)

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	icon_state = "security_eyepatch"
	base_icon_state = "security_eyepatch"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Eyepatch" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "hudpatch",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "hudpatch"
		),
		"Blue Eyepatch" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "hudpatch",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "hudpatch"
		),
		"Pink Eyepatch" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "hudpatch",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "hudpatch",
		),
	)


/obj/item/clothing/glasses/hud/security/night
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	unique_reskin = null

/obj/item/clothing/glasses/hud/security/sunglasses/gars
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Gars" = list(
			RESKIN_ICON_STATE = "gar_sec",
			RESKIN_WORN_ICON_STATE = "gar_sec"
		),
		"Blue Gars" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "gar_sec",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "gar_sec"
		),
	)

/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Gars" = list(
			RESKIN_ICON_STATE = "gigagar_sec",
			RESKIN_WORN_ICON_STATE = "gigagar_sec"
		),
		"Blue Gars" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "gigagar_sec",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "gigagar_sec"
		),
	)

/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga/roselia
	unique_reskin = null

/*
* HEAD
*/

//Standard helmet
/obj/item/clothing/head/helmet/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	icon_state = "security_helmet"
	base_icon_state = "security_helmet"
	clothing_flags = SNUG_FIT | STACKABLE_HELMET_EXEMPT
	dog_fashion = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"White Variant" = list(
			RESKIN_ICON_STATE = "security_helmet",
			RESKIN_WORN_ICON_STATE = "security_helmet"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/head/helmet.dmi',
			RESKIN_ICON_STATE = "helmet",
			RESKIN_WORN_ICON_STATE = "helmet",
			RESKIN_WORN_ICON = 'icons/mob/clothing/head/helmet.dmi'
		),
	)

/obj/item/clothing/head/helmet/sec/click_alt(mob/user)
	flipped_visor = !flipped_visor
	balloon_alert(user, "visor flipped")
	// base_icon_state is modified for seclight attachment component
	base_icon_state = "[initial(base_icon_state)][flipped_visor ? "-novisor" : ""]"
	icon_state = base_icon_state
	if (flipped_visor)
		flags_cover &= ~HEADCOVERSEYES | PEPPERPROOF
	else
		flags_cover |= HEADCOVERSEYES | PEPPERPROOF
	update_appearance()
	return CLICK_ACTION_SUCCESS


/obj/item/clothing/head/helmet/sec/futuristic
	icon_state = "security_helmet_future"
	base_icon_state = "security_helmet_future"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"White Variant" = list(
			RESKIN_ICON_STATE = "security_helmet_future",
			RESKIN_WORN_ICON_STATE = "security_helmet_future"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "security_helmet_future_blue",
			RESKIN_WORN_ICON_STATE = "security_helmet_future_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "security_helmet_future_red",
			RESKIN_WORN_ICON_STATE = "security_helmet_future_red"
		),
	)


/obj/item/clothing/head/helmet/sec/futuristic/click_alt(mob/user)
	flipped_visor = !flipped_visor
	balloon_alert(user, "visor flipped")
	// base_icon_state is modified for seclight attachment component
	base_icon_state = "[initial(base_icon_state)][flipped_visor ? "-novisor" : ""]"
	icon_state = base_icon_state
	if (flipped_visor)
		flags_cover &= ~HEADCOVERSEYES | PEPPERPROOF
	else
		flags_cover |= HEADCOVERSEYES | PEPPERPROOF
	update_appearance()
	return CLICK_ACTION_SUCCESS

//Beret replacement
/obj/item/clothing/head/security_garrison
	name = "security garrison cap"
	desc = "A robust garrison cap with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "garrison_black"
	uses_advanced_reskins = TRUE
	armor_type = /datum/armor/head_helmet
	strip_delay = 60
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "garrison_black",
			RESKIN_WORN_ICON_STATE = "garrison_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "garrison_blue",
			RESKIN_WORN_ICON_STATE = "garrison_blue"
		),
	)

/obj/item/clothing/head/security_cap
	name = "security cap"
	desc = "A robust cap with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "security_cap_black"
	uses_advanced_reskins = TRUE
	armor_type = /datum/armor/head_helmet
	strip_delay = 60
	dog_fashion = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "security_cap_black",
			RESKIN_WORN_ICON_STATE = "security_cap_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "security_cap_blue",
			RESKIN_WORN_ICON_STATE = "security_cap_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "security_cap_white",
			RESKIN_WORN_ICON_STATE = "security_cap_white"
		),
		"Sol Variant" = list(
			RESKIN_ICON_STATE = "policesoft",
			RESKIN_WORN_ICON_STATE = "policesoft"
		),
		"Sillitoe Variant" = list(
			RESKIN_ICON_STATE = "policetrafficsoft",
			RESKIN_WORN_ICON_STATE = "policetrafficsoft"
		),
		"Cadet Variant" = list(
			RESKIN_ICON_STATE = "policecadetsoft",
			RESKIN_WORN_ICON_STATE = "policecadetsoft"
		),
	)

/obj/item/clothing/head/hats/warden
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "policehelm"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Cap" = list(
			RESKIN_ICON_STATE = "policehelm",
			RESKIN_WORN_ICON_STATE = "policehelm"
		),
		"Sol Cap" = list(
			RESKIN_ICON_STATE = "policewardencap",
			RESKIN_WORN_ICON_STATE = "policewardencap"
		),
		"Red Cap" = list(
			RESKIN_ICON_STATE = "wardenhat",
			RESKIN_WORN_ICON_STATE = "wardenhat"
		),
	)

/obj/item/clothing/head/hats/warden/red
	unique_reskin = null

/obj/item/clothing/head/hats/warden/drill
	unique_reskin = null


/obj/item/clothing/head/hats/hos/cap
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Cap" = list(
			RESKIN_ICON_STATE = "hoscap",
			RESKIN_WORN_ICON_STATE = "hoscap"
		),
		"Blue Cap" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "hoscap_blue",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "hoscap_blue"
		),
		"Sol Cap" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "policechiefcap",
			RESKIN_WORN_ICON_STATE = "policechiefcap"
		),
		"Sheriff Hat" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "cowboyhat_black",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "cowboyhat_black"
		),
		"Wide Sheriff Hat" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "cowboy_black",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "cowboy_black"
		),
	)

/obj/item/clothing/head/hats/hos/cap/syndicate
	unique_reskin = null

/*
* NECK
*/
/obj/item/clothing/neck/cloak/hos
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "hoscloak_blue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Cape" = list(
			RESKIN_ICON_STATE = "hoscloak_blue",
			RESKIN_WORN_ICON_STATE = "hoscloak_blue"
		),
		"Red Cape" = list(
			RESKIN_ICON_STATE = "hoscloak",
			RESKIN_WORN_ICON_STATE = "hoscloak"
		),
	)

//Not technically an override but oh well
/obj/item/clothing/neck/security_cape
	name = "security cape"
	desc = "A fashionable cape worn by security officers."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "cape_black"
	inhand_icon_state = "" //no unique inhands
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "cape_black",
			RESKIN_WORN_ICON_STATE = "cape_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "cape_blue",
			RESKIN_WORN_ICON_STATE = "cape_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "cape_white",
			RESKIN_WORN_ICON_STATE = "cape_white"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "cape_red",
			RESKIN_WORN_ICON_STATE = "cape_red"
		),
	)
	///Decides the shoulder it lays on, false = RIGHT, TRUE = LEFT
	var/swapped = FALSE

/obj/item/clothing/neck/security_cape/armplate
	name = "security gauntlet"
	desc = "A fashionable full-arm gauntlet worn by security officers. The gauntlet itself is made of plastic, and provides no protection, but it looks cool as hell."
	icon_state = "armplate_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "armplate_black",
			RESKIN_WORN_ICON_STATE = "armplate_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "armplate_blue",
			RESKIN_WORN_ICON_STATE = "armplate_blue"
		),
		"Capeless Variant" = list(
			RESKIN_ICON_STATE = "armplate",
			RESKIN_WORN_ICON_STATE = "armplate"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "armplate_red",
			RESKIN_WORN_ICON_STATE = "armplate_red"
		),
	)

/obj/item/clothing/neck/security_cape/click_alt(mob/user)
	swapped = !swapped
	to_chat(user, span_notice("You swap which arm [src] will lay over."))
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/neck/security_cape/update_appearance(updates)
	. = ..()
	if(swapped)
		worn_icon_state = icon_state
	else
		worn_icon_state = "[icon_state]_left"

	usr.update_worn_neck()

/*
* GLOVES
*/
/obj/item/clothing/gloves/color/black/security
	name = "security gloves"
	desc = "A pair of security gloves."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "gloves_white"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "gloves_black",
			RESKIN_WORN_ICON_STATE = "gloves_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "gloves_blue",
			RESKIN_WORN_ICON_STATE = "gloves_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "gloves_white",
			RESKIN_WORN_ICON_STATE = "gloves_white"
		),
		"Armadyne Variant" = list(
			RESKIN_ICON_STATE = "armadyne_gloves",
			RESKIN_WORN_ICON_STATE = "armadyne_gloves"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/gloves.dmi',
			RESKIN_ICON_STATE = "sec",
			RESKIN_WORN_ICON_STATE = "sec",
			RESKIN_WORN_ICON = 'icons/mob/clothing/hands.dmi',
		),
		"Peacekeeper Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi',
			RESKIN_ICON_STATE = "peacekeeper_gloves",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi',
			RESKIN_WORN_ICON_STATE = "peacekeeper",
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/gloves.dmi',
			RESKIN_ICON_STATE = "sec_gloves",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/hands.dmi',
			RESKIN_WORN_ICON_STATE = "sec_gloves",
		),
	)

/obj/item/clothing/gloves/color/black/security/blu // Wait why these a subtype of black?!? Who did this
	icon = 'icons/obj/clothing/gloves.dmi'
	worn_icon = 'icons/mob/clothing/hands.dmi'

/obj/item/clothing/gloves/tackler/security	//Can't just overwrite tackler, as there's a ton of subtypes that we'd then need to account for. This is easier. MUCH easier.
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "tackle_blue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "combat",
			RESKIN_WORN_ICON_STATE = "combat"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "tackle_blue",
			RESKIN_WORN_ICON_STATE = "tackle_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/gloves.dmi',
			RESKIN_WORN_ICON = 'icons/mob/clothing/hands.dmi',
			RESKIN_ICON_STATE = "gorilla",
			RESKIN_WORN_ICON_STATE = "gorilla"
		),
	)

/obj/item/clothing/gloves/tackler/combat
	icon = 'icons/obj/clothing/gloves.dmi'
	worn_icon = 'icons/mob/clothing/hands.dmi'
	icon_state = "gorilla"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi',
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi',
			RESKIN_ICON_STATE = "combat",
			RESKIN_WORN_ICON_STATE = "combat"
		),
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi',
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi',
			RESKIN_ICON_STATE = "tackle_blue",
			RESKIN_WORN_ICON_STATE = "tackle_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "gorilla",
			RESKIN_WORN_ICON_STATE = "gorilla"
		),
	)

/obj/item/clothing/gloves/krav_maga/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "fightgloves_blue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "fightgloves_black",
			RESKIN_WORN_ICON_STATE = "fightgloves_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "fightgloves_blue",
			RESKIN_WORN_ICON_STATE = "fightgloves_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "fightgloves",
			RESKIN_WORN_ICON_STATE = "fightgloves"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "fightgloves_white",
			RESKIN_WORN_ICON_STATE = "fightgloves_white"
		),
	)
/*
* SUITS
*/
/obj/item/clothing/suit/armor/vest/alt/sec
	name = "armored security vest"
	desc = "A Type-II-AD-P armored vest that provides decent protection against most types of damage."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "vest_white"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "vest_black",
			RESKIN_WORN_ICON_STATE = "vest_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "vest_blue",
			RESKIN_WORN_ICON_STATE = "vest_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "vest_white",
			RESKIN_WORN_ICON_STATE = "vest_white"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "armor_sec",
			RESKIN_WORN_ICON_STATE = "armor_sec",
			RESKIN_WORN_ICON = 'icons/mob/clothing/suits/armor.dmi',
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "armor_sec",
			RESKIN_WORN_ICON_STATE = "armor_sec",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi',
		),
		"Armadyne Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi',
			RESKIN_ICON_STATE = "armadyne_armor",
			RESKIN_WORN_ICON_STATE = "armadyne_armor",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi',
		),
	)

/obj/item/clothing/suit/armor/hos
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Greatcoat" = list(
			RESKIN_ICON = 'icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "hos",
			RESKIN_WORN_ICON = 'icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "hos"
		),
		"Trenchcoat" = list(
			RESKIN_ICON = 'icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "hostrench",
			RESKIN_WORN_ICON = 'icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "hostrench"
		),
		"Trenchcloak" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "trenchcloak",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "trenchcloak"
		),
		"White" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi',
			RESKIN_ICON_STATE = "peacekeeper_trench_hos_white",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi',
			RESKIN_WORN_ICON_STATE = "peacekeeper_trench_hos_white"
		),
	)

/obj/item/clothing/suit/armor/hos/trenchcoat/winter
	current_skin = "hoswinter" //prevents reskinning

//Standard Bulletproof Vest
/obj/item/clothing/suit/armor/bulletproof
	desc = "A Type-III-AD-P heavy bulletproof vest that excels in protecting the wearer against traditional projectile weaponry and explosives to a minor extent."
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//Riot Armor
/obj/item/clothing/suit/armor/riot
	icon_state = "riot_ad" //replaces the NT on the back
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'

/obj/item/clothing/suit/armor/riot/knight //This needs to be sent back to its original .dmis
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'

//Warden's Vest
/obj/item/clothing/suit/armor/vest/warden
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Variant" = list(
			RESKIN_ICON_STATE = "warden_jacket",
			RESKIN_WORN_ICON_STATE = "warden_jacket"
		),
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "vest_warden",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "vest_warden"
		),
		"Black Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "peacekeeper_trench_warden",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "peacekeeper_trench_warden"
		),
		"Edgy Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "warden_syndie",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "warden_syndie"
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "warden_jacket",
			RESKIN_WORN_ICON_STATE = "warden_jacket",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi',
		),
		"Basic Warden Armor" = list(
			RESKIN_ICON = 'icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "warden_alt",
			RESKIN_WORN_ICON = 'icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "warden_alt"
		),
	)

/obj/item/clothing/suit/armor/vest/warden/alt //un-overrides this since its sprite is TG
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	current_skin = "warden_jacket" //prevents reskinning

//Security Wintercoat (and hood)
/obj/item/clothing/head/hooded/winterhood/security
	desc = "A blue, armour-padded winter hood. Definitely not bulletproof, especially not the part where your face goes." //God dammit TG stop putting color in the desc of items like this
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/winterhood.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/winterhood.dmi'
	icon_state = "winterhood_security"

/obj/item/clothing/suit/hooded/wintercoat/security
	name = "security winter coat" //TG has this as a Jacket now, so unless we update ours, this needs to be re-named as Coat
	desc = "A blue, armour-padded winter coat. It glitters with a mild ablative coating and a robust air of authority. The zipper tab is a small <b>\"Lopland\"</b> logo."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/wintercoat.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/wintercoat.dmi'
	icon_state = "coatsecurity_winter"

/obj/item/clothing/suit/armor/hos/hos_formal
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "hosformal_blue"
	current_skin = "hosformal_blue"	//prevents reskinning (but not toggling!)
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/*
* UNDER
*/
//Officer
/obj/item/clothing/under/rank/security/officer
	desc = "A tactical security uniform for officers, complete with a Lopland belt buckle."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "security_black"
	alt_covers_chest = TRUE
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "security_black",
			RESKIN_WORN_ICON_STATE = "security_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "security_blue",
			RESKIN_WORN_ICON_STATE = "security_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "security_white",
			RESKIN_WORN_ICON_STATE = "security_white"
		),
		"Sol Variant" = list(
			RESKIN_ICON_STATE = "policealt",
			RESKIN_WORN_ICON_STATE = "policealt"
		),
		"Cadet Variant" = list(
			RESKIN_ICON_STATE = "policecadetalt",
			RESKIN_WORN_ICON_STATE = "policecadetalt"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "rsecurity",
			RESKIN_WORN_ICON_STATE = "rsecurity"
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rsecurity",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rsecurity"
		),
		"Armadyne Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/under/centcom.dmi',
			RESKIN_ICON_STATE = "armadyne_shirt",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom.dmi',
			RESKIN_WORN_ICON_STATE = "armadyne_shirt"
		),
		"Armadyne Tac Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/under/centcom.dmi',
			RESKIN_ICON_STATE = "armadyne_tac",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom.dmi',
			RESKIN_WORN_ICON_STATE = "armadyne_tac"
		),
		"Lopland Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/under/centcom.dmi',
			RESKIN_ICON_STATE = "lopland_shirt",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom.dmi',
			RESKIN_WORN_ICON_STATE = "lopland_shirt"
		),
		"Lopland Tac Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/under/centcom.dmi',
			RESKIN_ICON_STATE = "lopland_tac",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom.dmi',
			RESKIN_WORN_ICON_STATE = "lopland_tac"
		),
	)

/obj/item/clothing/under/rank/security/officer/formal
	unique_reskin = null // prevents you from losing the unique sprite

/obj/item/clothing/under/rank/security/officer/skirt
	alt_covers_chest = FALSE
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	uses_advanced_reskins = TRUE
	alt_covers_chest = TRUE
	unique_reskin = list(
		"Red Variant" = list(
			RESKIN_ICON_STATE = "secskirt",
			RESKIN_WORN_ICON_STATE = "secskirt"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "jumpskirt_blue",
			RESKIN_WORN_ICON_STATE = "jumpskirt_blue"
		),
		"Black Variant" = list(
			RESKIN_ICON_STATE = "jumpskirt_black",
			RESKIN_WORN_ICON_STATE = "jumpskirt_black"
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "secskirt",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "secskirt"
		),
	)

/obj/item/clothing/under/rank/security/officer/skirt/blue
	name = "security jumpskirt"
	desc = "Turtleneck sweater commonly worn by Peacekeepers, attached with a skirt."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "jumpskirt_blue"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE
	uses_advanced_reskins = TRUE
	alt_covers_chest = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "jumpskirt_blue",
			RESKIN_WORN_ICON_STATE = "jumpskirt_blue"
		),
		"Black Variant" = list(
			RESKIN_ICON_STATE = "jumpskirt_black",
			RESKIN_WORN_ICON_STATE = "jumpskirt_black"
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "secskirt",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "secskirt"
		),
	)

//Warden
/obj/item/clothing/under/rank/security/warden
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "warden_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "warden_black",
			RESKIN_WORN_ICON_STATE = "warden_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "peacekeeper_warden",
			RESKIN_WORN_ICON_STATE = "peacekeeper_warden"
		),
		"Sol Variant" = list(
			RESKIN_ICON_STATE = "policewardenalt",
			RESKIN_WORN_ICON_STATE = "policewardenalt"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "rwarden",
			RESKIN_WORN_ICON_STATE = "rwarden"
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rwarden",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rwarden"
		),
	)

/obj/item/clothing/under/rank/security/warden/skirt
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Variant" = list(
			RESKIN_ICON_STATE = "rwarden_skirt",
			RESKIN_WORN_ICON_STATE = "rwarden_skirt"
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rwarden_skirt",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rwarden_skirt"
		),
	)

/obj/item/clothing/under/rank/security/warden/formal
	unique_reskin = null


//HoS
/obj/item/clothing/under/rank/security/head_of_security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "hos_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "hos_black",
			RESKIN_WORN_ICON_STATE = "hos_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "peacekeeper_hos",
			RESKIN_WORN_ICON_STATE = "peacekeeper_hos"
		),
		"Sol Variant" = list(
			RESKIN_ICON_STATE = "policechiefalt",
			RESKIN_WORN_ICON_STATE = "policechiefalt"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "rhos",
			RESKIN_WORN_ICON_STATE = "rhos"
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rhos",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rhos"
		),
	)

/obj/item/clothing/under/rank/security/head_of_security/skirt
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Variant" = list(
			RESKIN_ICON_STATE = "rhos_skirt",
			RESKIN_WORN_ICON_STATE = "rhos_skirt"
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rhos_skirt",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rhos_skirt"
		),
	)

/obj/item/clothing/under/rank/security/head_of_security/parade
	icon_state = "hos_parade_male_blue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "hos_parade_male_blue",
			RESKIN_WORN_ICON_STATE = "hos_parade_male_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "hos_parade_male",
			RESKIN_WORN_ICON_STATE = "hos_parade_male"
		),
	)

/obj/item/clothing/under/rank/security/head_of_security/parade/female
	icon_state = "hos_parade_fem_blue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "hos_parade_fem_blue",
			RESKIN_WORN_ICON_STATE = "hos_parade_fem_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "hos_parade_fem",
			RESKIN_WORN_ICON_STATE = "hos_parade_fem"
		),
	)


/obj/item/clothing/under/rank/security/head_of_security/alt
	icon_state = "hosalt_blue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "hosalt_blue",
			RESKIN_WORN_ICON_STATE = "hosalt_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "hosalt",
			RESKIN_WORN_ICON_STATE = "hosalt"
		),
	)

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt
	icon_state = "hosalt_skirt_blue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "hosalt_skirt_blue",
			RESKIN_WORN_ICON_STATE = "hosalt_skirt_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "hosalt_skirt",
			RESKIN_WORN_ICON_STATE = "hosalt_skirt"
		),
	)

/obj/item/clothing/under/rank/security/head_of_security/peacekeeper
	unique_reskin = null

/obj/item/clothing/under/rank/security/head_of_security/skyrat/imperial
	unique_reskin = null

/obj/item/clothing/under/rank/security/head_of_security/bunnysuit
	unique_reskin = null

/obj/item/clothing/under/rank/security/head_of_security/alt/roselia
	unique_reskin = null

/obj/item/clothing/under/rank/security/head_of_security/grey
	unique_reskin = null

/*
* FEET
*/
//Adds reskins and special footstep noises
/obj/item/clothing/shoes/jackboots/sec
	name = "security jackboots"
	desc = "Lopland's Peacekeeper-issue Security combat boots for combat scenarios or combat situations. All combat, all the time."
	icon_state = "security_boots"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	clothing_traits = list(TRAIT_SILENT_FOOTSTEPS) // We have other footsteps.
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue-Trimmed Variant" = list(
			RESKIN_ICON_STATE = "security_boots",
			RESKIN_WORN_ICON_STATE = "security_boots"
		),
		"White-Trimmed Variant" = list(
			RESKIN_ICON_STATE = "security_boots_white",
			RESKIN_WORN_ICON_STATE = "security_boots_white"
		),
		"Full White Variant" = list(
			RESKIN_ICON_STATE = "security_boots_fullwhite",
			RESKIN_WORN_ICON_STATE = "security_boots_fullwhite"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/shoes.dmi',
			RESKIN_ICON_STATE = "jackboots_sec",
			RESKIN_WORN_ICON_STATE = "jackboots_sec",
			RESKIN_WORN_ICON = 'icons/mob/clothing/feet.dmi'
		),
		"Pink Variant" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi',
			RESKIN_ICON_STATE = "jackboots_sec",
			RESKIN_WORN_ICON_STATE = "jackboots_sec",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
		),
		"Armadyne Variant" = list(
			RESKIN_ICON_STATE = "armadyne_boots",
			RESKIN_WORN_ICON_STATE = "armadyne_boots"
		),
	)

/obj/item/clothing/shoes/jackboots/sec/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_skyrat/master_files/sound/effects/footstep1.ogg'=1,'modular_skyrat/master_files/sound/effects/footstep2.ogg'=1, 'modular_skyrat/master_files/sound/effects/footstep3.ogg'=1), 100)


/*
*	A bunch of re-overrides so that admins can keep using some redsec stuff; not all of them have this though!
*/

/*
*	EYES
*/

/obj/item/clothing/glasses/hud/security/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "securityhud"
	glass_colour_type = /datum/client_colour/glass_colour/red
	unique_reskin = null

/obj/item/clothing/glasses/hud/security/sunglasses/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "sunhudsec"
	glass_colour_type = /datum/client_colour/glass_colour/darkred
	current_skin = "sunhudsec" //prevents reskinning; a bit hacky to say its already reskinned but its better than a code rewrite

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "hudpatch"
	base_icon_state = "hudpatch"
	unique_reskin = null

/obj/item/clothing/glasses/hud/security/night/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "securityhudnight"
	unique_reskin = null

/*
*	NECK
*/

/obj/item/clothing/neck/cloak/hos/redsec
	icon = 'icons/obj/clothing/cloaks.dmi'
	worn_icon = 'icons/mob/clothing/neck.dmi'
	icon_state = "hoscloak"
	unique_reskin = null

/*
*	BACK
*/

/obj/item/storage/backpack/security/redsec
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "backpack-security"
	current_skin = "backpack-security" //prevents reskinning

/obj/item/storage/backpack/satchel/sec/redsec
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "satchel-security"
	unique_reskin = null

/obj/item/storage/backpack/duffelbag/sec/redsec
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "duffel-security"
	current_skin = "duffel-security" //prevents reskinning

/*
*	BELT + HOLSTERS
*/

/obj/item/storage/belt/security/redsec
	icon = 'icons/obj/clothing/belts.dmi'
	worn_icon = 'icons/mob/clothing/belt.dmi'
	icon_state = "security"
	inhand_icon_state = "security"
	worn_icon_state = "security"
	current_skin = "security" //prevents reskinning

/obj/item/storage/belt/holster
	desc = "A rather plain but still cool looking holster that can hold a handgun, and some ammo."

/datum/storage/holster
	max_slots = 3
	max_total_storage = 16

/datum/storage/holster/New(atom/parent, max_slots, max_specific_storage, max_total_storage, list/holdables)
	if(length(holdables))
		return ..()

	holdables = list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/ammo_box/magazine, // Just magazine, because the sec-belt can hold these aswell
		/obj/item/gun/ballistic/revolver,
		/obj/item/ammo_box/speedloader/c38, // Revolver speedloaders.
		/obj/item/ammo_box/speedloader/c357,
		/obj/item/ammo_box/speedloader/strilka310,
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/ballistic/revolver,
		/obj/item/food/grown/banana,
		/obj/item/gun/energy/dueling,
		/obj/item/gun/energy/laser/thermal,
		/obj/item/gun/ballistic/rifle/boltaction, //fits if you make it an obrez
		/obj/item/gun/energy/laser/captain,
		/obj/item/gun/energy/e_gun/hos,
	)

	return ..()

/obj/item/storage/belt/holster/detective
	name = "detective's holster"
	desc = "A holster able to carry handguns and extra ammo, thanks to an additional hand-sewn pouch. WARNING: Badasses only."

/datum/storage/holster/detective
	max_slots = 4

/datum/storage/holster/detective/New(atom/parent, max_slots, max_specific_storage, max_total_storage, list/holdables)
	if(length(holdables))
		return ..()

	holdables = list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/ammo_box/magazine, // Just magazine, because the sec-belt can hold these aswell
		/obj/item/gun/ballistic/revolver,
		/obj/item/ammo_box/speedloader/c38, // Revolver speedloaders.
		/obj/item/ammo_box/speedloader/c357,
		/obj/item/ammo_box/speedloader/strilka310,
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/ballistic/revolver,
		/obj/item/food/grown/banana,
		/obj/item/gun/energy/dueling,
		/obj/item/gun/energy/laser/thermal,
		/obj/item/gun/ballistic/rifle/boltaction, //fits if you make it an obrez
		/obj/item/gun/energy/laser/captain,
		/obj/item/gun/energy/e_gun/hos,
	)

	return ..()

/datum/storage/holster/energy
	max_specific_storage = WEIGHT_CLASS_NORMAL

/datum/storage/holster/energy/New(atom/parent, max_slots, max_specific_storage, max_total_storage, list/holdables)
	if(length(holdables))
		return ..()

	holdables = list(
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/dueling,
		/obj/item/food/grown/banana,
		/obj/item/gun/energy/laser/thermal,
		/obj/item/gun/energy/recharge/ebow,
		/obj/item/gun/energy/laser/captain,
		/obj/item/gun/energy/e_gun/hos,
		/obj/item/gun/ballistic/automatic/pistol/plasma_marksman,
		/obj/item/gun/ballistic/automatic/pistol/plasma_thrower,
		/obj/item/ammo_box/magazine/recharge/plasma_battery,
	)

	return ..()

/*
*	HEAD
*/

/obj/item/clothing/head/helmet/sec/redsec
	icon = 'icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	icon_state = "helmet"
	base_icon_state = "helmet"
	actions_types = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEHAIR

/obj/item/clothing/head/hats/hos/cap/red
	icon = 'icons/obj/clothing/head/hats.dmi'
	worn_icon = 'icons/mob/clothing/head/hats.dmi'
	icon_state = "hoscap"
	base_icon_state = "hoscap"
	unique_reskin = null

/*
*	UNIFORM
*/

/obj/item/clothing/under/rank/security/officer/redsec
	icon_state = "rsecurity"
	current_skin = "rsecurity" //prevents reskinning

/obj/item/clothing/under/rank/security/officer/skirt/redsec
	icon_state = "secskirt"
	current_skin = "secskirt"

/obj/item/clothing/under/rank/security/warden/redsec
	icon_state = "rwarden"
	unique_reskin = null

/obj/item/clothing/under/rank/security/warden/skirt/redsec
	icon_state = "rwarden_skirt"
	unique_reskin = null

/obj/item/clothing/under/rank/security/head_of_security/redsec
	icon_state = "rhos"
	unique_reskin = null

/obj/item/clothing/under/rank/security/head_of_security/skirt/redsec
	icon_state = "rhos_skirt"
	unique_reskin = null

/obj/item/clothing/under/rank/security/head_of_security/parade/redsec
	icon_state = "hos_parade_male"
	unique_reskin = null

/obj/item/clothing/under/rank/security/head_of_security/parade/female/redsec
	icon_state = "hos_parade_fem"
	unique_reskin = null

/obj/item/clothing/under/rank/security/head_of_security/alt/redsec
	icon_state = "hosalt"
	unique_reskin = null

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt/redsec
	icon_state = "hosalt_skirt"
	unique_reskin = null

/*
*	WINTER COAT
*/

/obj/item/clothing/head/hooded/winterhood/security/redsec
	desc = "A red, armour-padded winter hood. Definitely not bulletproof, especially not the part where your face goes."
	icon = 'icons/obj/clothing/head/winterhood.dmi'
	worn_icon = 'icons/mob/clothing/head/winterhood.dmi'
	icon_state = "hood_security"

/obj/item/clothing/suit/hooded/wintercoat/security/redsec
	name = "security winter jacket"
	desc = "A red, armour-padded winter coat. It glitters with a mild ablative coating and a robust air of authority.  The zipper tab is a pair of jingly little handcuffs that get annoying after the first ten seconds."
	icon = 'icons/obj/clothing/suits/wintercoat.dmi'
	worn_icon = 'icons/mob/clothing/suits/wintercoat.dmi'
	icon_state = "coatsecurity"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/redsec

/*
*	ARMOR
*/

/obj/item/clothing/suit/armor/vest/alt/sec/redsec
	desc = "A Type I armored vest that provides decent protection against most types of damage."
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	icon_state = "armor_sec"
	current_skin = "armor_sec" //prevents reskinning

/obj/item/clothing/suit/armor/hos/hos_formal/redsec
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	icon_state = "hosformal"
	current_skin = "hosformal"	//prevents reskinning (but not toggling!)
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/*
*	FEET
*/
/obj/item/clothing/shoes/jackboots/sec/redsec
	name = "jackboots"
	desc = "Nanotrasen-issue Security combat boots for combat scenarios or combat situations. All combat, all the time."
	icon_state = "jackboots_sec"
	icon = 'icons/obj/clothing/shoes.dmi'
	worn_icon = 'icons/mob/clothing/feet.dmi'
	current_skin = "jackboots_sec" //prevents reskinning

//Finally, a few description changes for items that couldn't get a resprite.
/obj/item/clothing/head/bio_hood/security
	desc = "A hood that protects the head and face from biological contaminants. This is a slightly outdated model from Nanotrasen Securities - you can hardly see through the foggy visor's ageing red. Hopefully it's still up to spec..."

/obj/item/clothing/suit/bio_suit/security
	desc = "A suit that protects against biological contamination. This is a slightly outdated model from Nanotrasen Securities, using their red color-scheme and even outdated labelling. Hopefully it's still up to spec..."
