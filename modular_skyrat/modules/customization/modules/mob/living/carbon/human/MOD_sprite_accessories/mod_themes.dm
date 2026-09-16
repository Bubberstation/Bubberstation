// Preset colors live in code/__DEFINES/~~bubber_defines/colors.dm and map to hand-drawn textures in MOD_mask.dmi.
// Any other hex gets a tinted version of the standard pattern.

/datum/mod_theme
	/// Wether or not the MOD projects hardlight at all
	var/hardlight = TRUE
	/// Default hardlight color for suits of this theme, players can override it per suit
	var/hardlight_color = STANDARD_BLUE

//	Command
/datum/mod_theme/magnate
	hardlight_color = ROYAL_PURPLE

/datum/mod_theme/blueshield
	hardlight_color = COSMIC_BLUE

/datum/mod_theme/research
	hardlight_color = ROYAL_PURPLE

/datum/mod_theme/advanced
	hardlight_color = HAZARD_ORANGE

/datum/mod_theme/safeguard
	hardlight_color = ALERT_AMBER

/datum/mod_theme/rescue
	hardlight_color = STANDARD_BLUE

/datum/mod_theme/asset_protection
	hardlight_color = "#E8C24A"

/datum/mod_theme/policing
	hardlight_color = "#5A8DFF"


//	Crew
/datum/mod_theme/engineering
	hardlight_color = EXTRASHIELD_GREEN

/datum/mod_theme/atmospheric
	hardlight_color = EXTRASHIELD_GREEN

/datum/mod_theme/loader
	hardlight = FALSE

/datum/mod_theme/mining
	hardlight_color = STANDARD_BLUE

/datum/mod_theme/medical
	hardlight_color = STANDARD_BLUE

/datum/mod_theme/security
	hardlight_color = ALERT_AMBER

/datum/mod_theme/civilian
	hardlight_color = STANDARD_BLUE

/datum/mod_theme/prototype
	hardlight_color = HAZARD_ORANGE

/datum/mod_theme/portable_suit
	hardlight_color = STANDARD_BLUE

/datum/mod_theme/protean
	hardlight_color = "#B8C4D6"

/datum/mod_theme/entombed
	hardlight_color = STANDARD_BLUE


//	Traitor
/datum/mod_theme/contractor
	hardlight_color = CONTRACTOR_RED

/datum/mod_theme/syndicate
	hardlight_color = EVIL_GREEN

/datum/mod_theme/infiltrator
	hardlight = FALSE

/datum/mod_theme/enchanted
	hardlight_color = COSMIC_BLUE

/datum/mod_theme/ninja
	hardlight_color = EVIL_GREEN

/datum/mod_theme/elite
	hardlight_color = ALERT_AMBER

/datum/mod_theme/covert
	hardlight_color = "#8A8F99"

/datum/mod_theme/interdyne
	hardlight_color = "#3FD1B0"

/datum/mod_theme/glitch
	hardlight_color = "#6C76CF"

//	Misc.
/datum/mod_theme/apocryphal
	hardlight_color = ALERT_AMBER

/datum/mod_theme/corporate
	hardlight_color = EXTRASHIELD_GREEN

/datum/mod_theme/cosmohonk
	hardlight_color = CONTRACTOR_RED

/datum/mod_theme/chrono
	hardlight_color = "#7FE3FF"

/datum/mod_theme/frontier_colonist
	hardlight_color = "#C9A66B"

/datum/mod_theme/tarkon
	hardlight_color = "#F2B134"

/datum/mod_theme/voskhod
	hardlight_color = "#4FBF63"


// ERT
/datum/mod_theme/responsory
	hardlight_color = STANDARD_BLUE

/datum/mod_theme/frontline
	hardlight_color = ALERT_AMBER

/datum/mod_theme/marines
	hardlight_color = COSMIC_BLUE


// Debug
/datum/mod_theme/debug
	hardlight_color = COSMIC_BLUE

/datum/mod_theme/administrative
	hardlight_color = COSMIC_BLUE

