/obj/item/clothing/suit/jacket/runner //Sprite by kay#7181 (Donater item: Kan3)
	name = "runner jacket"
	icon = 'modular_zubbers/icons/obj/clothing/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	inhand_icon_state = null
	body_parts_covered = CHEST|ARMS|GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/jacket/runner/engi //Sprite by kay#7181 (Donater item: Kan3)
	name = "engineer runner jacket"
	icon_state = "runner_engi"
	desc = ""

/obj/item/clothing/suit/jacket/runner/syndicate //Sprite by kay#7181 (Donater item: Kan3)
	name = "syndicate runner jacket"
	icon_state = "runner_syndi"
	desc = ""

/obj/item/clothing/suit/jacket/runner/winter //Sprite by kay#7181 (Donater item: Kan3)
	name = "winter runner jacket"
	icon_state = "runner_winter"
	desc = ""

/obj/item/clothing/suit/jacket/trucker
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	icon = 'modular_zubbers/icons/obj/clothing/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	desc = "Contact a coder if you see this."

/obj/item/clothing/suit/jacket/trucker/highvis //Sprites by Scuhf_
	name = "high vis trucker jacket"
	desc = "A trucker's jacket with high visibility orange and yellow stripes for warehouse work."
	icon_state = "highvis"

/obj/item/clothing/suit/jacket/trucker/ronin //ported from Citadel
	name = "ronin jacket"
	desc = "A dark leather jacket with the logo of an old Sol Chromerock band on it."
	icon_state = "ronin"

/obj/item/clothing/suit/jacket/diver //Donor item for patriot210
	name = "black divers coat"
	desc = "A dark leather jacket with the logo of an old Sol Chromerock band on it."
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	icon_state = "diver"
	worn_icon_state = "diver"
	icon = 'modular_zubbers/icons/obj/clothing/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'

/obj/item/clothing/suit/jacket/flight //Donor item for ironknight060
	name = "MA-1 flight jacket"
	desc = "Originally developed for the United States Air Force. This jacket has been lovingly passed down from airman to airman before arriving in the 26th Century. Its complete with the reversible orange interior for emergency situations as well. From what you can see on the tag, this Jacket appears to have been made in the year 1985 for the USAF, with a faint name written onto the nametag."
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	icon_state = "flight"
	worn_icon_state = "flight"
	icon = 'modular_zubbers/icons/obj/clothing/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'

/obj/item/clothing/suit/toggle/labcoat/skyrat/skyymed  //Donor item for LT3
	name = "expedition medical jacket"
	desc = "This stylish jacket is perfect for those impromptu fashion shows on the scene of an emergency. Now, you can be the brightest beacon of style while administering medical treatment! Because, after all, why save lives if you can't look fabulous while doing it?"
	icon_state = "labcoat_skyymed"
	icon = 'modular_zubbers/icons/donator/skyymed.dmi'
	worn_icon = 'modular_zubbers/icons/donator/skyymed_worn.dmi'
	armor_type = /datum/armor/toggle_labcoat
	toggle_noun = "zipper"

//Monke Station Bunnies

/obj/item/clothing/suit/jacket/tailcoat //parent type
	name = "tailcoat"
	desc = "A coat usually worn by bunny themed waiters and the like."
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat"
	greyscale_colors = "#39393f"
	greyscale_config = /datum/greyscale_config/tailcoat
	greyscale_config_worn = /datum/greyscale_config/tailcoat_worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/jacket/tailcoat/bartender
	name = "bartender's tailcoat"
	desc = "A coat usually worn by bunny themed bartenders. It has an interior holster for firearms and some extra padding for minor protection."
	icon_state = "tailcoat_bar"
	greyscale_colors = "#39393f#ffffff"
	greyscale_config = /datum/greyscale_config/tailcoat_bar
	greyscale_config_worn = /datum/greyscale_config/tailcoat_bar_worn
	armor_type = /datum/armor/suit_armor


/obj/item/clothing/suit/jacket/tailcoat/bartender/Initialize(mapload) //so bartenders can use cram their shotgun inside
	. = ..()
	allowed += list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/gun/ballistic,
		/obj/item/gun/energy,
	)

/obj/item/clothing/suit/jacket/tailcoat/syndicate
	name = "suspicious tailcoat"
	desc = "A oddly intimidating coat usually worn by bunny themed assassins. It's reinforced with some extremely flexible lightweight alloy. How much did they pay for this?"
	icon_state = "tailcoat_syndi"
	armor_type = /datum/armor/wintercoat_syndicate
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null


/obj/item/clothing/suit/jacket/tailcoat/syndicate/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/gun/ballistic,
		/obj/item/gun/energy,
		/obj/item/restraints/handcuffs,
		/obj/item/knife/combat,
		/obj/item/melee/baton,
	)

/obj/item/clothing/suit/jacket/tailcoat/syndicate/fake
	armor_type = /datum/armor/none

/obj/item/clothing/suit/wizrobe/magician //Not really a robe but it's MAGIC
	name = "magician's tailcoat"
	desc = "A magnificent, gold-lined tailcoat that seems to radiate power."
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_wiz"
	inhand_icon_state = null
	flags_inv = null

/obj/item/clothing/suit/jacket/tailcoat/centcom
	name = "Centcom tailcoat"
	desc = "An official coat usually worn by bunny themed executives. The inside is lined with comfortable yet tasteful bunny fluff."
	icon_state = "tailcoat_centcom"
	armor_type = /datum/armor/armor_centcom_formal_nt_consultant
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null


/obj/item/clothing/suit/jacket/tailcoat/british
	name = "british flag tailcoat"
	desc = "A tailcoat emblazoned with the Union Jack. Perfect attire for teatime."
	icon_state = "tailcoat_brit"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null


/obj/item/clothing/suit/jacket/tailcoat/communist
	name = "really red tailcoat"
	desc = "A red tailcoat emblazoned with a golden star. The official uniform of the Bunny Waiter Union."
	icon_state = "tailcoat_communist"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/usa
	name = "stars tailcoat"
	desc = "A vintage coat worn by the 5th bunny battalion during the Revolutionary War. Smooth-bore musket not included."
	icon_state = "tailcoat_stars"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/plasmaman
	name = "purple tailcoat"
	desc = "A purple coat that looks to be the same purple used in several plasmaman evirosuits."
	icon_state = "tailcoat_plasma"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/armor/vest/capcarapace/tailcoat_captain
	name = "captain's tailcoat"
	desc = "A nautical coat usually worn by bunny themed captains. It’s reinforced with genetically modified armored blue rabbit fluff."
	icon_state = "captain"
	inhand_icon_state = null
	icon = 'monkestation/icons/obj/clothing/costumes/bunnysprites/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/bunnysprites/tailcoats_worn.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null

/obj/item/clothing/suit/jacket/tailcoat/quartermaster
	name = "quartermaster's tailcoat"
	desc = "A fancy brown coat worn by bunny themed quartermasters. The gold accents show everyone who's in charge."
	icon_state = "qm"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/cargo
	name = "cargo tailcoat"
	desc = "A simple brown coat worn by bunny themed cargo technicians. Significantly less stripy than the quartermasters."
	icon_state = "cargo_tech"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/miner
	name = "explorer tailcoat"
	desc = "An adapted explorer suit worn by bunny themed shaft miners. It has attachment points for goliath plates but comparatively little armor."
	icon_state = "explorer"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|ARMS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	armor_type = /datum/armor/tailcoat_miner
	allowed = list(
		/obj/item/flashlight,
		/obj/item/gun/energy/recharge/kinetic_accelerator,
		/obj/item/mining_scanner,
		/obj/item/pickaxe,
		/obj/item/resonator,
		/obj/item/storage/bag/ore,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/tank/internals,
		)
	resistance_flags = FIRE_PROOF
	clothing_traits = list(TRAIT_SNOWSTORM_IMMUNE)

/datum/armor/tailcoat_miner
	melee = 30
	bullet = 10
	laser = 10
	energy = 20
	bomb = 50
	fire = 50
	acid = 50
/obj/item/clothing/suit/jacket/tailcoat/miner/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate)

