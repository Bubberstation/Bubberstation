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

/obj/item/storage/belt/security/webbing/peacekeeper/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/storage/belt/security/webbing/peacekeeper/armadyne //You two only exist because I don't want to purge you, because it'd break some stuff. Thin fucking ice.

/obj/item/storage/belt/security/webbing/peacekeeper/armadyne/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

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
		"Fake Blindfold" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "secfold",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "secfold"
		),
	)

/obj/item/clothing/glasses/hud/eyepatch/sec
	name = "security eyepatch HUD"
	desc = "Lost your eye beating an innocent clown? Thankfully your corporate overlords have made something to make up for this. May not do well against flashes."
	clothing_traits = list(TRAIT_SECURITY_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/blue
	unique_reskin = list(
		"Blue Eyepatch" = list(
			RESKIN_ICON_STATE = "hudpatch",
			RESKIN_WORN_ICON_STATE = "hudpatch"
		),
		"Red Eyepatch" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "hudpatch",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "hudpatch"
		),
		"Fake Blindfold" = list(
			RESKIN_ICON_STATE = "secfold",
			RESKIN_WORN_ICON_STATE = "secfold"
		)
	)

/obj/item/clothing/glasses/hud/eyepatch/sec/blindfold
	name = "sec blindfold HUD"
	desc = "a fake blindfold with a security HUD inside, helps you look like blind justice. This won't provide the same protection that you'd get from sunglasses."
	icon_state =  "secfold"
	base_icon_state =  "secfold"

/obj/item/clothing/glasses/hud/eyepatch/sec/blindfold/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/glasses/hud/security/night
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'

/obj/item/clothing/glasses/hud/security/night/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

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

/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga/roselia/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

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

/obj/item/clothing/head/hats/warden/red/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/head/hats/warden/drill

/obj/item/clothing/head/hats/warden/drill/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

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

/obj/item/clothing/head/hats/hos/cap/syndicate/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

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

/obj/item/clothing/gloves/kaza_ruk/sec
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

/obj/item/clothing/suit/armor/hos/trenchcoat/winter/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

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

//DETECTIVE

/obj/item/clothing/suit/cowboyvest
	name = "blonde cowboy vest"
	desc = "A white cream vest lined with... fur, of all things, for desert weather. There's a small deer head logo sewn into the vest."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "cowboy_vest"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	heat_protection = CHEST|ARMS

/obj/item/clothing/suit/jacket/det_suit/cowboyvest
	name = "blonde cowboy vest"
	desc = "A white cream vest lined with... fur, of all things, for desert weather. There's a small deer head logo sewn into the vest."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "cowboy_vest"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	heat_protection = CHEST|ARMS

//Warden's Vest
/obj/item/clothing/suit/armor/vest/warden
	uses_advanced_reskins = TRUE

/obj/item/clothing/suit/armor/vest/warden/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/warden_armor)

/datum/atom_skin/warden_armor
	abstract_type = /datum/atom_skin/warden_armor

/datum/atom_skin/warden_armor/red
	preview_name = "Red Variant"
	new_icon_state = "warden_jacket"

/datum/atom_skin/warden_armor/blue
	preview_name = "Blue Variant"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	new_icon_state = "vest_warden"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'

/datum/atom_skin/warden_armor/black
	preview_name = "Black Variant"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	new_icon_state = "peacekeeper_trench_warden"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'

/datum/atom_skin/warden_armor/edgy
	preview_name = "Edgy Variant"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	new_icon_state = "warden_syndie"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'

/datum/atom_skin/warden_armor/pink
	preview_name = "Pink Variant"
	new_icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	new_icon_state = "warden_jacket"
	new_worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'

/datum/atom_skin/warden_armor/basic
	preview_name = "Basic Warden Armor"
	new_icon = 'icons/obj/clothing/suits/armor.dmi'
	new_icon_state = "warden_alt"
	new_worn_icon = 'icons/mob/clothing/suits/armor.dmi'

/obj/item/clothing/suit/armor/vest/warden/alt //un-overrides this since its sprite is TG
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'

/obj/item/clothing/suit/armor/vest/warden/alt/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

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
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/hos/hos_formal/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

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

/obj/item/clothing/under/rank/security/officer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_officer_uniform)

/datum/atom_skin/security_officer_uniform
	abstract_type = /datum/atom_skin/security_officer_uniform

/datum/atom_skin/security_officer_uniform/black
	preview_name = "Black Variant"
	new_icon_state = "security_black"

/datum/atom_skin/security_officer_uniform/blue
	preview_name = "Blue Variant"
	new_icon_state = "security_blue"

/datum/atom_skin/security_officer_uniform/white
	preview_name = "White Variant"
	new_icon_state = "security_white"

/datum/atom_skin/security_officer_uniform/sol
	preview_name = "Sol Variant"
	new_icon_state = "policealt"

/datum/atom_skin/security_officer_uniform/cadet
	preview_name = "Cadet Variant"
	new_icon_state = "policecadetalt"

/datum/atom_skin/security_officer_uniform/red
	preview_name = "Red Variant"
	new_icon_state = "rsecurity"

/datum/atom_skin/security_officer_uniform/pink
	preview_name = "Pink Variant"
	new_icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	new_icon_state = "rsecurity"
	new_worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'

/datum/atom_skin/security_officer_uniform/armadyne
	preview_name = "Armadyne Variant"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/under/centcom.dmi'
	new_icon_state = "armadyne_shirt"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom.dmi'

/datum/atom_skin/security_officer_uniform/armadyne_tac
	preview_name = "Armadyne Tac Variant"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/under/centcom.dmi'
	new_icon_state = "armadyne_tac"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom.dmi'

/datum/atom_skin/security_officer_uniform/lopland
	preview_name = "Lopland Variant"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/under/centcom.dmi'
	new_icon_state = "lopland_shirt"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom.dmi'

/datum/atom_skin/security_officer_uniform/lopland_tac
	preview_name = "Lopland Tac Variant"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/under/centcom.dmi'
	new_icon_state = "lopland_tac"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom.dmi'

/obj/item/clothing/under/rank/security/officer/formal

/obj/item/clothing/under/rank/security/officer/formal/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/officer/skirt
	alt_covers_chest = FALSE
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	uses_advanced_reskins = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/officer/skirt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_officer_skirt)

/datum/atom_skin/security_officer_skirt
	abstract_type = /datum/atom_skin/security_officer_skirt

/datum/atom_skin/security_officer_skirt/red
	preview_name = "Red Variant"
	new_icon_state = "secskirt"

/datum/atom_skin/security_officer_skirt/blue
	preview_name = "Blue Variant"
	new_icon_state = "jumpskirt_blue"

/datum/atom_skin/security_officer_skirt/black
	preview_name = "Black Variant"
	new_icon_state = "jumpskirt_black"

/datum/atom_skin/security_officer_skirt/pink
	preview_name = "Pink Variant"
	new_icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	new_icon_state = "secskirt"
	new_worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'

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

/obj/item/clothing/under/rank/security/officer/skirt/blue/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_officer_jumpskirt)

/datum/atom_skin/security_officer_jumpskirt
	abstract_type = /datum/atom_skin/security_officer_jumpskirt

/datum/atom_skin/security_officer_jumpskirt/blue
	preview_name = "Blue Variant"
	new_icon_state = "jumpskirt_blue"

/datum/atom_skin/security_officer_jumpskirt/black
	preview_name = "Black Variant"
	new_icon_state = "jumpskirt_black"

/datum/atom_skin/security_officer_jumpskirt/pink
	preview_name = "Pink Variant"
	new_icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	new_icon_state = "secskirt"
	new_worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'

// DETECTIVE
/obj/item/clothing/under/rank/security/detective/cowboy
	name = "blonde cowboy uniform"
	desc = "A blue shirt and dark jeans, with a pair of spurred cowboy boots to boot."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'	//Donator item-ish? See the /armorless one below it
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	icon_state = "cowboy_uniform"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/detective/cowboy/armorless //Donator variant, just uses the sprite.
	armor_type = /datum/armor/clothing_under

/obj/item/clothing/under/rank/security/detective/runner
	name = "runner sweater"
	desc = "<i>\"You look lonely.\"</i>"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "runner"
	can_adjust = FALSE

//Warden
/obj/item/clothing/under/rank/security/warden
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "warden_black"
	uses_advanced_reskins = TRUE

/obj/item/clothing/under/rank/security/warden/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/warden_uniform)

/datum/atom_skin/warden_uniform
	abstract_type = /datum/atom_skin/warden_uniform

/datum/atom_skin/warden_uniform/black
	preview_name = "Black Variant"
	new_icon_state = "warden_black"

/datum/atom_skin/warden_uniform/blue
	preview_name = "Blue Variant"
	new_icon_state = "peacekeeper_warden"

/datum/atom_skin/warden_uniform/sol
	preview_name = "Sol Variant"
	new_icon_state = "policewardenalt"

/datum/atom_skin/warden_uniform/red
	preview_name = "Red Variant"
	new_icon_state = "rwarden"

/datum/atom_skin/warden_uniform/pink
	preview_name = "Pink Variant"
	new_icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	new_icon_state = "rwarden"
	new_worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'

/obj/item/clothing/under/rank/security/warden/skirt
	uses_advanced_reskins = TRUE

/obj/item/clothing/under/rank/security/warden/skirt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/warden_skirt)

/datum/atom_skin/warden_skirt
	abstract_type = /datum/atom_skin/warden_skirt

/datum/atom_skin/warden_skirt/red
	preview_name = "Red Variant"
	new_icon_state = "rwarden_skirt"

/datum/atom_skin/warden_skirt/pink
	preview_name = "Pink Variant"
	new_icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	new_icon_state = "rwarden_skirt"
	new_worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'

/obj/item/clothing/under/rank/security/warden/formal

/obj/item/clothing/under/rank/security/warden/formal/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

//HoS
/obj/item/clothing/under/rank/security/head_of_security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "hos_black"
	uses_advanced_reskins = TRUE

/obj/item/clothing/under/rank/security/head_of_security/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hos_uniform)

/datum/atom_skin/hos_uniform
	abstract_type = /datum/atom_skin/hos_uniform

/datum/atom_skin/hos_uniform/black
	preview_name = "Black Variant"
	new_icon_state = "hos_black"

/datum/atom_skin/hos_uniform/blue
	preview_name = "Blue Variant"
	new_icon_state = "peacekeeper_hos"

/datum/atom_skin/hos_uniform/sol
	preview_name = "Sol Variant"
	new_icon_state = "policechiefalt"

/datum/atom_skin/hos_uniform/red
	preview_name = "Red Variant"
	new_icon_state = "rhos"

/datum/atom_skin/hos_uniform/pink
	preview_name = "Pink Variant"
	new_icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	new_icon_state = "rhos"
	new_worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'

/obj/item/clothing/under/rank/security/head_of_security/skirt
	uses_advanced_reskins = TRUE

/obj/item/clothing/under/rank/security/head_of_security/skirt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hos_skirt)

/datum/atom_skin/hos_skirt
	abstract_type = /datum/atom_skin/hos_skirt

/datum/atom_skin/hos_skirt/red
	preview_name = "Red Variant"
	new_icon_state = "rhos_skirt"

/datum/atom_skin/hos_skirt/pink
	preview_name = "Pink Variant"
	new_icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	new_icon_state = "rhos_skirt"
	new_worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'

/obj/item/clothing/under/rank/security/head_of_security/parade
	icon_state = "hos_parade_male_blue"
	uses_advanced_reskins = TRUE

/obj/item/clothing/under/rank/security/head_of_security/parade/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hos_parade_male)

/datum/atom_skin/hos_parade_male
	abstract_type = /datum/atom_skin/hos_parade_male

/datum/atom_skin/hos_parade_male/blue
	preview_name = "Blue Variant"
	new_icon_state = "hos_parade_male_blue"

/datum/atom_skin/hos_parade_male/red
	preview_name = "Red Variant"
	new_icon_state = "hos_parade_male"

/obj/item/clothing/under/rank/security/head_of_security/parade/female
	icon_state = "hos_parade_fem_blue"
	uses_advanced_reskins = TRUE

/obj/item/clothing/under/rank/security/head_of_security/parade/female/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hos_parade_female)

/datum/atom_skin/hos_parade_female
	abstract_type = /datum/atom_skin/hos_parade_female

/datum/atom_skin/hos_parade_female/blue
	preview_name = "Blue Variant"
	new_icon_state = "hos_parade_fem_blue"

/datum/atom_skin/hos_parade_female/red
	preview_name = "Red Variant"
	new_icon_state = "hos_parade_fem"

/obj/item/clothing/under/rank/security/head_of_security/alt
	icon_state = "hosalt_blue"
	uses_advanced_reskins = TRUE

/obj/item/clothing/under/rank/security/head_of_security/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hos_alt)

/datum/atom_skin/hos_alt
	abstract_type = /datum/atom_skin/hos_alt

/datum/atom_skin/hos_alt/blue
	preview_name = "Blue Variant"
	new_icon_state = "hosalt_blue"

/datum/atom_skin/hos_alt/red
	preview_name = "Red Variant"
	new_icon_state = "hosalt"

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt
	icon_state = "hosalt_skirt_blue"
	uses_advanced_reskins = TRUE

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hos_alt_skirt)

/datum/atom_skin/hos_alt_skirt
	abstract_type = /datum/atom_skin/hos_alt_skirt

/datum/atom_skin/hos_alt_skirt/blue
	preview_name = "Blue Variant"
	new_icon_state = "hosalt_skirt_blue"

/datum/atom_skin/hos_alt_skirt/red
	preview_name = "Red Variant"
	new_icon_state = "hosalt_skirt"

/obj/item/clothing/under/rank/security/head_of_security/peacekeeper

/obj/item/clothing/under/rank/security/head_of_security/peacekeeper/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/bunnysuit

/obj/item/clothing/under/rank/security/head_of_security/bunnysuit/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/alt/roselia

/obj/item/clothing/under/rank/security/head_of_security/alt/roselia/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/grey

/obj/item/clothing/under/rank/security/head_of_security/grey/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

// PRISONER


/// PRISONER
/obj/item/clothing/under/rank/prisoner/protcust
	name = "protective custody prisoner jumpsuit"
	desc = "A mustard coloured prison jumpsuit, often worn by former Security members, informants and former CentCom employees. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/protcust"
	greyscale_colors = "#FFB600"

/obj/item/clothing/under/rank/prisoner/skirt/protcust
	name = "protective custody prisoner jumpskirt"
	desc = "A mustard coloured prison jumpskirt, often worn by former Security members, informants and former CentCom employees. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/protcust"
	greyscale_colors = "#FFB600"

/obj/item/clothing/under/rank/prisoner/lowsec
	name = "low security prisoner jumpsuit"
	desc = "A pale, almost creamy prison jumpsuit, this one denotes a low security prisoner, things like fraud and anything white collar. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/lowsec"
	greyscale_colors = "#AB9278"

/obj/item/clothing/under/rank/prisoner/skirt/lowsec
	name = "low security prisoner jumpskirt"
	desc = "A pale, almost creamy prison jumpskirt, this one denotes a low security prisoner, things like fraud and anything white collar. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/lowsec"
	greyscale_colors = "#AB9278"

/obj/item/clothing/under/rank/prisoner/highsec
	name = "high risk prisoner jumpsuit"
	desc = "A bright red prison jumpsuit, depending on who sees it, either a badge of honour or a sign to avoid. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/highsec"
	greyscale_colors = "#FF3400"

/obj/item/clothing/under/rank/prisoner/skirt/highsec
	name = "high risk prisoner jumpskirt"
	desc = "A bright red prison jumpskirt, depending on who sees it, either a badge of honour or a sign to avoid. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/highsec"
	greyscale_colors = "#FF3400"

/obj/item/clothing/under/rank/prisoner/supermax
	name = "supermax prisoner jumpsuit"
	desc = "A dark crimson red prison jumpsuit, for the worst of the worst, or the Clown. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/supermax"
	greyscale_colors = "#992300"

/obj/item/clothing/under/rank/prisoner/skirt/supermax
	name = "supermax prisoner jumpskirt"
	desc = "A dark crimson red prison jumpskirt, for the worst of the worst, or the Clown. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/supermax"
	greyscale_colors = "#992300"

/obj/item/clothing/under/rank/prisoner/classic
	name = "classic prisoner jumpsuit"
	desc = "A black and white striped jumpsuit, like something out of a movie."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/costume.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/costume_digi.dmi'
	icon_state = "prisonerclassic"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/prisoner/syndicate
	name = "syndicate prisoner jumpsuit"
	desc = "A crimson red jumpsuit worn by syndicate captives. Its sensors have been shorted out."
	icon_state = "/obj/item/clothing/under/rank/prisoner/syndicate"
	greyscale_colors = "#992300"
	has_sensor = FALSE

/obj/item/clothing/under/rank/prisoner/skirt/syndicate
	name = "syndicate prisoner jumpskirt"
	desc = "A crimson red jumpskirt worn by syndicate captives. Its sensors have been shorted out."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/syndicate"
	greyscale_colors = "#992300"
	has_sensor = FALSE

/obj/item/clothing/under/rank/prisoner/syndicate/station
	name = "syndicate prisoner jumpsuit"
	desc = "A dark blood red prison jumpsuit, for the known Syndicate captives, valuable targets to CentCom and interrogation. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/syndicate/station"
	greyscale_colors = "#5c0000ff"

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

/obj/item/clothing/shoes/jackboots/sec/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_skyrat/master_files/sound/effects/footstep1.ogg'=1,'modular_skyrat/master_files/sound/effects/footstep2.ogg'=1, 'modular_skyrat/master_files/sound/effects/footstep3.ogg'=1), 100)
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_jackboots)

/datum/atom_skin/security_jackboots
	abstract_type = /datum/atom_skin/security_jackboots

/datum/atom_skin/security_jackboots/blue_trim
	preview_name = "Blue-Trimmed Variant"
	new_icon_state = "security_boots"

/datum/atom_skin/security_jackboots/white_trim
	preview_name = "White-Trimmed Variant"
	new_icon_state = "security_boots_white"

/datum/atom_skin/security_jackboots/full_white
	preview_name = "Full White Variant"
	new_icon_state = "security_boots_fullwhite"

/datum/atom_skin/security_jackboots/red
	preview_name = "Red Variant"
	new_icon = 'icons/obj/clothing/shoes.dmi'
	new_icon_state = "jackboots_sec"
	new_worn_icon = 'icons/mob/clothing/feet.dmi'

/datum/atom_skin/security_jackboots/pink
	preview_name = "Pink Variant"
	new_icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	new_icon_state = "jackboots_sec"
	new_worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'

/datum/atom_skin/security_jackboots/armadyne
	preview_name = "Armadyne Variant"
	new_icon_state = "armadyne_boots"

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

/obj/item/clothing/glasses/hud/security/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/glasses/hud/security/sunglasses/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "sunhudsec"
	glass_colour_type = /datum/client_colour/glass_colour/darkred

/obj/item/clothing/glasses/hud/security/sunglasses/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "hudpatch"
	base_icon_state = "hudpatch"

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/glasses/hud/security/night/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "securityhudnight"

/obj/item/clothing/glasses/hud/security/night/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/*
*	NECK
*/

/obj/item/clothing/neck/cloak/hos/redsec
	icon = 'icons/obj/clothing/cloaks.dmi'
	worn_icon = 'icons/mob/clothing/neck.dmi'
	icon_state = "hoscloak"

/obj/item/clothing/neck/cloak/hos/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/*
*	BACK
*/

/obj/item/storage/backpack/security/redsec
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "backpack-security"

/obj/item/storage/backpack/security/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/storage/backpack/satchel/sec/redsec
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "satchel-security"

/obj/item/storage/backpack/satchel/sec/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/storage/backpack/duffelbag/sec/redsec
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "duffel-security"

/obj/item/storage/backpack/duffelbag/sec/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/*
*	BELT + HOLSTERS
*/

/obj/item/storage/belt/security/redsec
	icon = 'icons/obj/clothing/belts.dmi'
	worn_icon = 'icons/mob/clothing/belt.dmi'
	icon_state = "security"
	inhand_icon_state = "security"
	worn_icon_state = "security"

/obj/item/storage/belt/security/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

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

/obj/item/clothing/head/hats/hos/cap/red/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/*
*	UNIFORM
*/

/obj/item/clothing/under/rank/security/officer/redsec
	icon_state = "rsecurity"

/obj/item/clothing/under/rank/security/officer/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/officer/skirt/redsec
	icon_state = "secskirt"

/obj/item/clothing/under/rank/security/officer/skirt/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/warden/redsec
	icon_state = "rwarden"

/obj/item/clothing/under/rank/security/warden/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/warden/skirt/redsec
	icon_state = "rwarden_skirt"

/obj/item/clothing/under/rank/security/warden/skirt/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/redsec
	icon_state = "rhos"

/obj/item/clothing/under/rank/security/head_of_security/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/skirt/redsec
	icon_state = "rhos_skirt"

/obj/item/clothing/under/rank/security/head_of_security/skirt/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/parade/redsec
	icon_state = "hos_parade_male"

/obj/item/clothing/under/rank/security/head_of_security/parade/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/parade/female/redsec
	icon_state = "hos_parade_fem"

/obj/item/clothing/under/rank/security/head_of_security/parade/female/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/alt/redsec
	icon_state = "hosalt"

/obj/item/clothing/under/rank/security/head_of_security/alt/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt/redsec
	icon_state = "hosalt_skirt"

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

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

/obj/item/clothing/suit/armor/vest/alt/sec/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/obj/item/clothing/suit/armor/hos/hos_formal/redsec
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	icon_state = "hosformal"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/hos/hos_formal/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

/*
*	FEET
*/
/obj/item/clothing/shoes/jackboots/sec/redsec
	name = "jackboots"
	desc = "Nanotrasen-issue Security combat boots for combat scenarios or combat situations. All combat, all the time."
	icon_state = "jackboots_sec"
	icon = 'icons/obj/clothing/shoes.dmi'
	worn_icon = 'icons/mob/clothing/feet.dmi'

/obj/item/clothing/shoes/jackboots/sec/redsec/Initialize(mapload)
	. = ..()
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(reskin_component)
		qdel(reskin_component)

//Finally, a few description changes for items that couldn't get a resprite.
/obj/item/clothing/head/bio_hood/security
	desc = "A hood that protects the head and face from biological contaminants. This is a slightly outdated model from Nanotrasen Securities - you can hardly see through the foggy visor's ageing red. Hopefully it's still up to spec..."

/obj/item/clothing/suit/bio_suit/security
	desc = "A suit that protects against biological contamination. This is a slightly outdated model from Nanotrasen Securities, using their red color-scheme and even outdated labelling. Hopefully it's still up to spec..."
