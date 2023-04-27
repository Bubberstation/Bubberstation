/*
*	Overwrites all the security icons with our own bluesec versions; this means little to no mapping/spawning conflicts!
*	(Also includes 'old' versions at the bottom of the file, for the purpose of crates/vendors/admin shenanigans. Can't remove them ENTIRELY after all!)
*/

/*
*	PLASMAMEN
*	This goes first due to simultaneously being easy to do, and complex to organize
*/

/obj/item/clothing/under/plasmaman/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/plasmaman.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/plasmaman.dmi'
	icon_state = "security_envirosuit_new"

/obj/item/clothing/under/plasmaman/security/warden
	icon_state = "warden_envirosuit_new"

/obj/item/clothing/under/plasmaman/security/head_of_security
	icon_state = "hos_envirosuit_new"

/obj/item/clothing/head/helmet/space/plasmaman/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/plasmaman_hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/plasmaman_head.dmi'
	icon_state = "security_envirohelm_new"

/obj/item/clothing/head/helmet/space/plasmaman/security/warden
	icon_state = "warden_envirohelm_new"

/obj/item/clothing/head/helmet/space/plasmaman/security/head_of_security
	icon_state = "hos_envirohelm_new"

/*
* ACCESSORIES
*/
/obj/item/clothing/accessory/armband/deputy
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "armband_lopland"

/obj/item/clothing/accessory/armband/deputy/lopland
	desc = "A Peacekeeper-blue armband, showing the wearer to be certified by Lopland as a top-of-their-class Security Officer."

/*
* BACKPACKS
*/
/obj/item/storage/backpack/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "backpack_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "backpack_black",
			RESKIN_WORN_ICON_STATE = "backpack_black"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "backpack_white",
			RESKIN_WORN_ICON_STATE = "backpack_white"
		),
	)

/obj/item/storage/backpack/satchel/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "security_satchel"

/obj/item/storage/backpack/duffelbag/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "security_duffle_blue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "security_duffle_blue",
			RESKIN_WORN_ICON_STATE = "security_duffle_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "security_duffle_white",
			RESKIN_WORN_ICON_STATE = "security_duffle_white"
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
	)

/obj/item/storage/belt/security/webbing
	uses_advanced_reskins = FALSE
	unique_reskin = NONE
	current_skin = "securitywebbing" //Prevents reskinning

/obj/item/storage/belt/security/webbing/peacekeeper //did I mention this codebase is fucking awful
	current_skin = "peacekeeper_webbing"

/obj/item/storage/belt/security/webbing/peacekeeper/armadyne
	current_skin = "armadyne_webbing"

///Enables you to quickdraw weapons from security holsters
/datum/storage/security/open_storage(datum/source, mob/user)
	var/atom/resolve_parent = parent?.resolve()
	if(!resolve_parent)
		return
	if(isobserver(user))
		show_contents(user)
		return

	if(!user.CanReach(resolve_parent))
		resolve_parent.balloon_alert(user, "can't reach!")
		return FALSE

	if(!isliving(user) || user.incapacitated())
		return FALSE

	var/obj/item/gun/gun_to_draw = locate() in real_location?.resolve()
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
	)

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	icon_state = "security_eyepatch"
	base_icon_state = "security_eyepatch"

/obj/item/clothing/glasses/hud/security/night
	icon_state = "security_hud_nv"
	glass_colour_type = /datum/client_colour/glass_colour/green

/*
* HEAD
*/

//Overrides the bulletproof helm with the older non red visor version.
/obj/item/clothing/head/helmet/alt
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'

//Standard helmet (w/ visor)
/obj/item/clothing/head/helmet/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "security_helmet"
	base_icon_state = "security_helmet"
	actions_types = list(/datum/action/item_action/toggle)
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION
	flags_cover = HEADCOVERSEYES | PEPPERPROOF
	visor_flags_cover = HEADCOVERSEYES | PEPPERPROOF
	dog_fashion = null

	///chat message when the visor is toggled down.
	var/toggle_message = "You pull the visor down on"
	///chat message when the visor is toggled up.
	var/alt_toggle_message = "You push the visor up on"
	///Can toggle?
	var/can_toggle = TRUE

/// Duplication of toggleable logic - only way to make it toggleable without worse hacks due to being in base maps.
/obj/item/clothing/head/helmet/sec/attack_self(mob/user)
	. = ..()
	if(.)
		return
	if(user.incapacitated() || !can_toggle)
		return
	up = !up
	flags_1 ^= visor_flags
	flags_inv ^= visor_flags_inv
	flags_cover ^= visor_flags_cover
	// This part is changed to work with the seclight.
	base_icon_state = "[initial(icon_state)][up ? "up" : ""]"
	update_icon_state()
	to_chat(user, span_notice("[up ? alt_toggle_message : toggle_message] \the [src]."))

	user.update_worn_head()
	if(iscarbon(user))
		var/mob/living/carbon/carbon_user = user
		carbon_user.head_update(src, forced = TRUE)

//Beret replacement
/obj/item/clothing/head/security_garrison
	name = "security garrison cap"
	desc = "A robust garrison cap with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "garrison_black"
	uses_advanced_reskins = TRUE
	armor_type = /datum/armor/head_security_garrison
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

//Normal Cap

/datum/armor/head_security_garrison
	melee = 30
	bullet = 25
	laser = 25
	energy = 35
	bomb = 25
	fire = 20
	acid = 50

/obj/item/clothing/head/security_cap
	name = "security cap"
	desc = "A robust cap with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "security_cap_black"
	uses_advanced_reskins = TRUE
	armor_type = /datum/armor/head_security_cap
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
	)

/datum/armor/head_security_cap
	melee = 30
	bullet = 25
	laser = 25
	energy = 35
	bomb = 25
	fire = 20
	acid = 50

/obj/item/clothing/head/hats/hos
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "hoscap_blue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Cap" = list(
			RESKIN_ICON_STATE = "hoscap_blue",
			RESKIN_WORN_ICON_STATE = "hoscap_blue"
		),
		"Sol Cap" = list(
			RESKIN_ICON_STATE = "policechiefcap",
			RESKIN_WORN_ICON_STATE = "policechiefcap"
		),
		"Sheriff Hat" = list(
			RESKIN_ICON_STATE = "cowboyhat_black",
			RESKIN_WORN_ICON_STATE = "cowboyhat_black"
		),
		"Wide Sheriff Hat" = list(
			RESKIN_ICON_STATE = "cowboy_black",
			RESKIN_WORN_ICON_STATE = "cowboy_black"
		)
	)

//Need to quickly redefine this so the icon doesnt break
/obj/item/clothing/head/hats/hos/syndicate
	icon = 'icons/obj/clothing/head/hats.dmi'
	worn_icon = 'icons/mob/clothing/head/hats.dmi'
	icon_state = "hoscap"
	current_skin = "hoscap" //Prevents reskinning

/*
* NECK
*/
/obj/item/clothing/neck/cloak/hos
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "hoscloak_blue"

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
	)

/obj/item/clothing/neck/security_cape/AltClick(mob/user)
	. = ..()
	swapped = !swapped
	to_chat(user, span_notice("You swap which arm [src] will lay over."))
	update_appearance()

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
	)

/obj/item/clothing/gloves/tackler/security	//Can't just overwrite tackler, as there's a ton of subtypes that we'd then need to account for. This is easier. MUCH easier.
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "tackle_blue"

/obj/item/clothing/gloves/krav_maga/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "fightgloves_blue"

/*
* SUITS
*/
/obj/item/clothing/suit/armor/vest/alt/sec
	name = "armored security vest"
	desc = "A Type-II-AD-P armored vest that provides decent protection against most types of damage."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "vest_white"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
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
		"Peacekeeper Variant" = list(
			RESKIN_ICON_STATE = "peacekeeper_armor",
			RESKIN_WORN_ICON_STATE = "peacekeeper"
		)
	)

/obj/item/clothing/suit/armor/hos
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//Standard Bulletproof Vest
/obj/item/clothing/suit/armor/bulletproof
	desc = "A Type-III-AD-P heavy bulletproof vest that excels in protecting the wearer against traditional projectile weaponry and explosives to a minor extent."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "vest_bulletproof"
	body_parts_covered = CHEST|GROIN|ARMS // Our sprite has groin and arm protections, so we get it too.
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//Riot Armor
/obj/item/clothing/suit/armor/riot
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'

//Warden's Vest
/obj/item/clothing/suit/armor/vest/warden
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "vest_warden"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//Security Wintercoat (and hood)
/obj/item/clothing/head/hooded/winterhood/security
	desc = "A blue, armour-padded winter hood. Definitely not bulletproof, especially not the part where your face goes." //God dammit TG stop putting color in the desc of items like this
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/winterhood.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/winterhood.dmi'
	icon_state = "winterhood_security"

/obj/item/clothing/suit/hooded/wintercoat/security
	name = "security winter coat" //TG has this as a Jacket now, so unless we update ours, this needs to be re-named as Coat
	desc = "A blue, armour-padded winter coat. It glitters with a mild ablative coating and a robust air of authority.  The zipper tab is a small <b>\"Lopland\"</b> logo."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/wintercoat.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/wintercoat.dmi'
	icon_state = "coatsecurity_winter"

/obj/item/clothing/suit/armor/hos/hos_formal
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "hosformal_blue"

/*
* UNDER
*/
//Officer
/obj/item/clothing/under/rank/security/officer
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "security_black"
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
	)

//Warden
/obj/item/clothing/under/rank/security/warden
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "warden_black"

//HoS
/obj/item/clothing/under/rank/security/head_of_security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "hos_black"

/obj/item/clothing/under/rank/security/head_of_security/parade
	icon_state = "hos_parade_male_blue"

/obj/item/clothing/under/rank/security/head_of_security/parade/female
	icon_state = "hos_parade_fem_blue"

/obj/item/clothing/under/rank/security/head_of_security/alt
	icon_state = "hosalt_blue"

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt
	icon_state = "hosalt_skirt_blue"

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
	)

/obj/item/clothing/shoes/jackboots/sec/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_skyrat/master_files/sound/effects/footstep1.ogg'=1,'modular_skyrat/master_files/sound/effects/footstep2.ogg'=1, 'modular_skyrat/master_files/sound/effects/footstep3.ogg'=1), 100)

//
// This code overrides security's jumpskirt preference, as we're not going to be giving them jumpskirts
//
/datum/outfit/job/security/pre_equip(mob/living/carbon/human/affected_mob)
	if(affected_mob.jumpsuit_style == PREF_SKIRT)
		to_chat(affected_mob, span_alertwarning("Lopland Peacekeeper uniforms don't include a skirt variant! You've been equipped with a jumpsuit instead."))
		affected_mob.jumpsuit_style = PREF_SUIT
	. = ..()

/datum/outfit/job/hos/pre_equip(mob/living/carbon/human/affected_mob)
	if(affected_mob.jumpsuit_style == PREF_SKIRT)
		to_chat(affected_mob, span_alertwarning("Lopland Peacekeeper uniforms don't include a skirt variant! You've been equipped with a jumpsuit instead."))
		affected_mob.jumpsuit_style = PREF_SUIT
	. = ..()

/datum/outfit/job/warden/pre_equip(mob/living/carbon/human/affected_mob)
	if(affected_mob.jumpsuit_style == PREF_SKIRT)
		to_chat(affected_mob, span_alertwarning("Lopland Peacekeeper uniforms don't include a skirt variant! You've been equipped with a jumpsuit instead."))
		affected_mob.jumpsuit_style = PREF_SUIT
	. = ..()

//PDA Greyscale Overrides
/obj/item/modular_computer/pda/security
	greyscale_colors = "#2B356D#1E1E1E"

/obj/item/modular_computer/pda/detective
	greyscale_colors = "#90714F#1E1E1E"

/obj/item/modular_computer/pda/warden
	greyscale_colors = "#2F416E#1E1E1E#ACACAC"

/obj/item/modular_computer/pda/heads/hos
	greyscale_colors = "#2B356D#1E1E1E"

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

/obj/item/clothing/glasses/hud/security/sunglasses/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "sunhudsec"
	glass_colour_type = /datum/client_colour/glass_colour/darkred
	current_skin = "sunhudsec"	//prevents reskinning; a bit hacky to say its already reskinned but its better than a code rewrite

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "hudpatch"
	base_icon_state = "hudpatch"

/obj/item/clothing/glasses/hud/security/night/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "securityhudnight"

/*
*	NECK
*/

/obj/item/clothing/neck/cloak/hos/redsec
	icon = 'icons/obj/clothing/cloaks.dmi'
	worn_icon = 'icons/mob/clothing/neck.dmi'
	icon_state = "hoscloak"

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

/obj/item/storage/backpack/duffelbag/sec/redsec
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "duffel-security"
	current_skin = "duffel-security" //prevents reskinning

/*
*	BELT
*/

/obj/item/storage/belt/security/redsec
	icon = 'icons/obj/clothing/belts.dmi'
	worn_icon = 'icons/mob/clothing/belt.dmi'
	icon_state = "security"
	inhand_icon_state = "security"
	worn_icon_state = "security"
	current_skin = "security"	//prevents reskinning

/*
*	HEAD
*/

/obj/item/clothing/head/helmet/sec/redsec
	icon = 'icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	icon_state = "helmet"
	base_icon_state = "helmet"
	actions_types = null
	can_toggle = FALSE
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEHAIR

/*
*	UNIFORM
*/

/obj/item/clothing/under/rank/security/officer/redsec
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	icon_state = "rsecurity"
	current_skin = "rsecurity"	//prevents reskinning

/obj/item/clothing/under/rank/security/warden/redsec
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	icon_state = "rwarden"

/obj/item/clothing/under/rank/security/head_of_security/redsec
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	icon_state = "rhos"

/obj/item/clothing/under/rank/security/head_of_security/parade/redsec
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	icon_state = "hos_parade_male"

/obj/item/clothing/under/rank/security/head_of_security/parade/female/redsec
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	icon_state = "hos_parade_fem"

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

/*
*	FEET
*/
/obj/item/clothing/shoes/jackboots/sec/redsec
	name = "jackboots"
	desc = "Nanotrasen-issue Security combat boots for combat scenarios or combat situations. All combat, all the time."
	icon_state = "jackboots_sec"
	icon = 'icons/obj/clothing/shoes.dmi'
	worn_icon = 'icons/mob/clothing/feet.dmi'
	current_skin = "jackboots_sec"	//prevents reskinning
