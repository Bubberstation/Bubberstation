// All available options
// Remember these are read from:
// 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/MOD_sprite_accessories/icons/MOD_mask.dmi'

/datum/mod_theme
	/// Wether or not the MOD projects hardlight at all
	var/hardlight = TRUE
	/// The icon_state which is chosen to render as hardlight
	var/hardlight_theme = STANDARD_BLUE

//	Command
/datum/mod_theme/magnate
	hardlight_theme = ROYAL_PURPLE

/datum/mod_theme/blueshield
	hardlight_theme = COSMIC_BLUE

/datum/mod_theme/research
	hardlight_theme = ROYAL_PURPLE

/datum/mod_theme/advanced
	hardlight_theme = HAZARD_ORANGE

/datum/mod_theme/safeguard
	hardlight_theme = ALERT_AMBER

/datum/mod_theme/rescue
	hardlight_theme = STANDARD_BLUE


//	Crew
/datum/mod_theme/engineering
	hardlight_theme = EXTRASHIELD_GREEN

/datum/mod_theme/atmospheric
	hardlight_theme = EXTRASHIELD_GREEN

/datum/mod_theme/loader
	hardlight = FALSE

/datum/mod_theme/mining
	hardlight_theme = STANDARD_BLUE

/datum/mod_theme/medical
	hardlight_theme = STANDARD_BLUE

/datum/mod_theme/security
	hardlight_theme = ALERT_AMBER


//	Traitor
/datum/mod_theme/contractor
	hardlight_theme = CONTRACTOR_RED

/datum/mod_theme/syndicate
	hardlight_theme = EVIL_GREEN

/datum/mod_theme/infiltrator
	hardlight = FALSE

/datum/mod_theme/enchanted
	hardlight_theme = COSMIC_BLUE

/datum/mod_theme/ninja
	hardlight_theme = EVIL_GREEN

/datum/mod_theme/elite
	hardlight_theme = ALERT_AMBER

/*	https://github.com/Skyrat-SS13/Skyrat-tg/pull/17455
/datum/mod_theme/covert
	hardlight_theme =
*/

//	Misc.
/datum/mod_theme/apocryphal
	hardlight_theme = ALERT_AMBER

/datum/mod_theme/corporate
	hardlight_theme = EXTRASHIELD_GREEN

/datum/mod_theme/cosmohonk
	hardlight_theme = CONTRACTOR_RED


// ERT
/datum/mod_theme/responsory
	hardlight_theme = STANDARD_BLUE

/datum/mod_theme/frontline
	hardlight_theme = ALERT_AMBER

/datum/mod_theme/marines
	hardlight_theme = COSMIC_BLUE


// Debug
/datum/mod_theme/debug
	hardlight_theme = COSMIC_BLUE

/datum/mod_theme/administrative
	hardlight_theme = COSMIC_BLUE

