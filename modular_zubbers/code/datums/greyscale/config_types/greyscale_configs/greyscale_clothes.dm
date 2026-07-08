/datum/greyscale_config/cso
	name = "command stripper outfit"
	icon_file = 'modular_zubbers/icons/obj/clothing/under/captain.dmi'
	json_config = 'modular_zubbers/code/datums/greyscale/json_configs/cso.json'

/datum/greyscale_config/cso/worn
	name = "command stripper outfit (worn)"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/captain.dmi'
	json_config = 'modular_zubbers/code/datums/greyscale/json_configs/cso.json'

/datum/greyscale_config/security_uniform
	name = "Security Uniform"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	greyscale_component_style_type = /datum/greyscale_component_style/security_uniform
	greyscale_component_config_states = list("recolorable_security_uniform", "rsecurity")

/datum/greyscale_config/security_uniform/New()
	InitializeGreyscaleComponentStyleConfig()

/datum/greyscale_config/security_uniform/Refresh(loadFromDisk = FALSE)
	return RefreshGreyscaleComponentStyleConfig(loadFromDisk)

/datum/greyscale_config/security_uniform/worn
	name = "Security Uniform (Worn)"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/security.dmi'

/datum/greyscale_config/security_uniform/worn/digi
	name = "Security Uniform (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/security.dmi'

/datum/greyscale_config/security_cap
	name = "Security Cap"
	icon_file = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	greyscale_component_style_type = /datum/greyscale_component_style/security_cap
	greyscale_component_config_states = list("security_cap")

/datum/greyscale_config/security_cap/New()
	InitializeGreyscaleComponentStyleConfig()

/datum/greyscale_config/security_cap/Refresh(loadFromDisk = FALSE)
	return RefreshGreyscaleComponentStyleConfig(loadFromDisk)

/datum/greyscale_config/security_cap/worn
	name = "Security Cap (Worn)"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	greyscale_component_config_state_overrides = list(
		"security_cap" = "security_capg",
		"security_cap_accs_front" = "security_capg_accs_backing",
		"security_cap_accs_logo" = "security_capg_accs_logo",
	)

/datum/greyscale_config/gi/worn/digi
	name = "Gi (Worn, Digi)"
	icon_file = 'modular_skyrat/master_files/icons/mob/clothing/under/costume_digi.dmi'

/datum/greyscale_config/gi/worn/teshari
	name = "Gi (Worn, Teshari)"
	icon_file = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'

/datum/greyscale_config/fancy_suit/worn/digi
	name = "Fancy Suit (Worn, Digi)"
	icon_file = 'modular_skyrat/master_files/icons/mob/clothing/under/suits_digi.dmi'

/datum/greyscale_config/fancy_suit/worn/teshari
	name = "Fancy Suit (Worn, Teshari)"
	icon_file = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'

/datum/greyscale_config/jester_suit/worn/digi
	name = "Jester Suit (Worn, Digi)"
	icon_file = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian_digi.dmi'

/datum/greyscale_config/jester_suit/worn/teshari
	name = "Jester Suit (Worn, Teshari)"
	icon_file = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'

// shirts pants shorts teshari
/datum/greyscale_config/buttondown_slacks/worn/teshari
	name = "Buttondown with Slacks (Worn, Teshari)"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/slacks/worn/teshari
	name = "Slacks (Worn, Teshari)"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/shorts/worn/teshari
	name = "Shorts (Worn, Teshari)"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/jeans/worn/teshari
	name = "Jeans (Worn, Teshari)"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"
	json_config = 'code/datums/greyscale/json_configs/jeans_worn.json'

/datum/greyscale_config/jeanshorts/worn/teshari
	name = "Jean Shorts (Worn, Teshari)"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/buttondown_shorts/worn/teshari
	name = "Buttondown with Shorts (Worn, Teshari)"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/buttondown_skirt/worn/teshari
	name = "Buttondown with Skirt (Worn, Teshari)"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/kilt/worn/teshari
	name = "Kilt (Worn, Teshari)"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/buttondown_vicvest/worn/teshari
	name = "Buttondown with Double-breasted Vest (Worn, Teshari)"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/yoga_pants/worn/teshari
	name = "Yoga Pants (Worn, Teshari)"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/shortershorts/worn/teshari
	name = "Shorter Shorts (Worn, Teshari)"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/jeans_ripped/worn/teshari
	name = "Ripped Jeans (Worn, Teshari)"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/eth_tunic/worn/digi
	name = "Ethereal Tunic (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/costume_digi.dmi'

/datum/greyscale_config/eth_tunic/worn/teshari
	name = "Ethereal Tunic (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/costume_teshari.dmi'

/datum/greyscale_config/striped_dress/worn
	name = "Striped dress (Worn)"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/skirts_dresses.dmi'

/datum/greyscale_config/striped_dress/worn/digi
	name = "Striped dress (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/skirts_dresses_digi.dmi'

/datum/greyscale_config/striped_dress/worn/teshari
	name = "Striped dress (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/skirts_dresses_teshari.dmi'

/datum/greyscale_config/peacoat/worn/digi
	name = "Peacoat (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_digi.dmi'

/datum/greyscale_config/peacoat/worn/teshari
	name = "Peacoat (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_teshari.dmi'

/datum/greyscale_config/mothcoat/worn/digi
	name = "Moth Coat (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/misc_digi.dmi'

/datum/greyscale_config/mothcoat/worn/teshari
	name = "Moth Coat (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/misc_teshari.dmi'

/datum/greyscale_config/labcoat/worn/digi
	name = "Labcoat (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/labcoat_digi.dmi'

/datum/greyscale_config/winter_coat_worn_digi
	name = "Winter Coat (Worn, Digi)"
	icon_file = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_digi.dmi'
	json_config = 'modular_skyrat/modules/GAGS/json_configs/winter_coat/winter_coat_worn.json'

/datum/greyscale_config/winter_coat_worn_teshari
	name = "Winter Coat (Worn, Teshari)"
	icon_file = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_teshari.dmi'
	json_config = 'modular_skyrat/modules/GAGS/json_configs/winter_coat/winter_coat_worn.json'

/datum/greyscale_config/winter_hood/worn/teshari
	name = "Winter Coat Hood (Worn, Teshari)"
	icon_file = 'modular_skyrat/master_files/icons/donator/mob/clothing/head_teshari.dmi'

/datum/greyscale_config/winter_coats/worn/digi
	name = "Winter Coat (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/wintercoat_digi.dmi'

/datum/greyscale_config/winter_coats/worn/teshari
	name = "Winter Coat (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/wintercoat_teshari.dmi'

/datum/greyscale_config/winter_hoods/worn/teshari
	name = "Winter Coat Hood (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/winterhood_teshari.dmi'

/datum/greyscale_config/hoodie_pullover/worn/digi
	name = "Pullover Hoodie (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/wintercoat_digi.dmi'

/datum/greyscale_config/hoodie_pullover/worn/teshari
	name = "Pullover Hoodie (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/wintercoat_teshari.dmi'

/datum/greyscale_config/hoodie_pullover_hood/worn/teshari
	name = "Pullover Hood (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/winterhood_teshari.dmi'

/datum/greyscale_config/hoodie_zipup/worn/digi
	name = "Zipup Hoodie (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/wintercoat_digi.dmi'

/datum/greyscale_config/hoodie_zipup/worn/teshari
	name = "Zipup Hoodie (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/wintercoat_teshari.dmi'

/datum/greyscale_config/hoodie_zipup_hood/worn/teshari
	name = "Zipup Hood (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/winterhood_teshari.dmi'

/datum/greyscale_config/big_hoodie/worn/digi
	name = "Big Hoodie (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/dopplerhoodie_digi.dmi'

/datum/greyscale_config/big_hoodie/worn/teshari
	name = "Big Hoodie (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/dopplerhoodie_teshari.dmi'

/datum/greyscale_config/big_hoodie_hood/worn/teshari
	name = "Big Hoodie Hood (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/dopplerhoodie_teshari.dmi'

/datum/greyscale_config/twee_hoodie/worn/digi
	name = "Twee Hoodie (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/dopplerhoodie_digi.dmi'

/datum/greyscale_config/twee_hoodie/worn/teshari
	name = "Twee Hoodie (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/dopplerhoodie_teshari.dmi'

/datum/greyscale_config/twee_hoodie_hood/worn/teshari
	name = "Twee Hoodie Hood (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/dopplerhoodie_teshari.dmi'

/datum/greyscale_config/wellworn_shirt/worn/digi
	name = "Well-Worn Shirt (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_digi.dmi'

/datum/greyscale_config/wellworn_shirt/worn/teshari
	name = "Well-Worn Shirt (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_teshari.dmi'

/datum/greyscale_config/wellworn_shirt_skub/worn/digi
	name = "Well-Worn Shirt (Skub)(Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_digi.dmi'

/datum/greyscale_config/wellworn_shirt_skub/worn/teshari
	name = "Well-Worn Shirt (Skub)(Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_teshari.dmi'

/datum/greyscale_config/wellworn_shirt_graphic/worn/digi
	name = "Well-Worn Shirt (Graphic)(Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_digi.dmi'

/datum/greyscale_config/wellworn_shirt_graphic/worn/teshari
	name = "Well-Worn Shirt (Graphic)(Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_teshari.dmi'

/datum/greyscale_config/wornout_shirt_graphic/worn/digi
	name = "Worn-Out Shirt (Graphic)(Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_digi.dmi'

/datum/greyscale_config/wornout_shirt_graphic/worn/teshari
	name = "Worn-Out Shirt (Graphic)(Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_teshari.dmi'

/datum/greyscale_config/messyworn_shirt_graphic/worn/digi
	name = "Messy Shirt (Graphic (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_digi.dmi'

/datum/greyscale_config/messyworn_shirt_graphic/worn/teshari
	name = "Messy Shirt (Graphic (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_teshari.dmi'

/datum/greyscale_config/jester_shoes/worn/digi
	name = "Jester Shoes (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'

/datum/greyscale_config/jester_shoes/worn/teshari
	name = "Jester Shoes (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

/datum/greyscale_config/overalls/worn/teshari
	name = "Overalls (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/utility_teshari.dmi'

//GRAYSCALE MAID COSTUME - TESHARI

/datum/greyscale_config/bubber_maid_neck_cover/worn/teshari
	name = "Maid Neck Cover (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/neck/neck_teshari.dmi'

/datum/greyscale_config/bubber_maid_arm_covers/worn/teshari
	name = "Maid Arm Covers (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/gloves/gloves_teshari.dmi'

/datum/greyscale_config/bubber_maid_costume/worn/teshari
	name = "Maid Costume (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/costume_teshari.dmi'

/datum/greyscale_config/bubber_maid_headband/worn/teshari
	name = "Maid Headband (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/costume_teshari.dmi'

// new maid outfit - teshari

/datum/greyscale_config/maid/worn/teshari
	name = "Maid Uniform (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/costume_teshari.dmi'

/datum/greyscale_config/maid_headband/worn/teshari
	name = "Maid Headband (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/costume_teshari.dmi'

/datum/greyscale_config/cloak/boat/worn/teshari
	name = "Boatcloak (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/neck/neck_teshari.dmi'

/datum/greyscale_config/cloak/shroud/worn/teshari
	name = "Shroud (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/neck/neck_teshari.dmi'

/datum/greyscale_config/cableknit_sweater/worn/teshari
	name = "Cableknit Sweater (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/skirts_dresses_teshari.dmi'

/datum/greyscale_config/trek/worn/teshari
	name = "Trek Uniform (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/costume_teshari.dmi'

/datum/greyscale_config/primitive_catgirl_boots/worn/digi
	name = "Primitive Winter Boots (Worn, Digi)"
	icon_file = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'

/datum/greyscale_config/primitive_catgirl_boots/worn/teshari
	name = "Primitive Winter Boots (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

/datum/greyscale_config/ties/worn/teshari
	name = "Ties (Worn, Teshari)"
	icon_file = 'modular_zubbers/icons/mob/clothing/neck/neck_teshari.dmi'
