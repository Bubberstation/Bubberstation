/obj/item/clothing/accessory/pocketwatch
	name = "pocket watch"
	desc = "A fancy gold pocket watch, inspired by the popular Uair brand of Carota. Open me, you fool. Open the light and summon me and receive my majesty."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'
	worn_icon_state = "pocketwatch"
	icon_state = "pocketwatch"
	inhand_icon_state = "pocketwatch"
	var/list/spans = list("velvet")
	actions_types = list(/datum/action/item_action/hypno_whisper)

//TODO: make a component for all that various hypno stuff instead of adding it to items individually
/obj/item/clothing/accessory/pocketwatch/ui_action_click(mob/living/user, action)
	if(!isliving(user) || !can_use(user))
		return
	var/message = input(user, "Speak with a hypnotic whisper", "Whisper")
	if(QDELETED(src) || QDELETED(user) || !message || !user.can_speak())
		return
	user.whisper(message, spans = spans)


/obj/item/clothing/accessory/pocketwatch/examine(mob/user)
	. = ..()
	. += span_info("The current CST (local) time is: [station_time_timestamp()].")
	. += span_info("The current TCT (galactic) time is: [time2text(world.realtime, "hh:mm:ss")].")

/obj/item/storage/backpack/kanken //Donor item for LT3
	name = "kånken backpack"
	desc = "Classic Swedish design in hard-wearing vinylon fabric with a zip that opens the entire main compartment. Featuring a small front pocket, simple shoulder straps and handles at the top, it's made for a lifetime of use."
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	lefthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_righthand.dmi'
	worn_icon = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn_teshari.dmi'
	icon_state = "technician"
	inhand_icon_state = "technician"

/obj/item/clothing/accessory/fake/medal
	name = "plastic medal"
	desc = "Yeah nice try buddy. They won't record this one. Especially since it reads 'youre winnar!!'. Alt-Click to reskin!"
	unique_reskin = list(
			"Bronze" = "bronze",
			"Bronze Heart" = "bronze_heart",
			"Silver" = "silver",
			"Gold" = "gold",
			"Plasma" = "plasma",
			"Cargo" = "cargo",
			"Paperwork" = "medal_paperwork",
			"Medical Second Class" = "med_medal",
			"Medical First Class" = "med_medal2",
			"Atmosian" = "elderatmosian",
			"Emergency Service - General" = "emergencyservices",
			"Emergency Service - Engineering" = "emergencyservices_engi",
			"Emergency Service - Medical" = "emergencyservices_med"
	)
// Pride Pin Over-ride
/obj/item/clothing/accessory/pride
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'

	unique_reskin  = list(
	"Rainbow Pride" = "pride",
	"Bisexual Pride" = "pride_bi",
	"Pansexual Pride" = "pride_pan",
	"Asexual Pride" = "pride_ace",
	"Non-binary Pride" = "pride_enby",
	"Transgender Pride" = "pride_trans",
	"Intersex Pride" = "pride_intersex",
	"Lesbian Pride" = "pride_lesbian",
	"Man-Loving-Man / Gay Pride" = "pride_mlm",
	"Genderfluid Pride" = "pride_genderfluid",
	"Genderqueer Pride" = "pride_genderqueer",
	"Aromantic Pride" = "pride_aromantic",
)

// Dogtags
/obj/item/clothing/accessory/dogtags
	name = "Dogtags"
	desc = "Two small metal tags, connected with a thin piece of chain that hold important health information. And everything needed for a tombstone..."
	icon = 'modular_zubbers/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/accessories.dmi'
	icon_state = "dogtags"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FIRE_PROOF // its metal, and funny to leave behind when you dust.
	attachment_slot = NONE
	above_suit = TRUE


/*
Greyscaled Medals

Highly modular and customizable spriteset.
Just a note - the .jsons will NOT agree with having different amounts of components per icon.
Use the 'blank' icon to keep the medals all sorted in their correct file,
even if they have different numbers of components.

Potential future ideas:
- Tie to job hours
- Unlock in Loadout when a requirement is met (i.e. job hours, as above)
- Department medals (adding to TG's existing medal lockboxes)
*/

/*
// AWARDABLE MEDALS
// These can be pinned onto others to 'award' them, appearing in the round-end screen
*/
/obj/item/clothing/accessory/medal/bubber
	name = "medal of robustness"
	desc = "A medal dedicated to those who display robustness in many fields."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/medal/bubber"
	post_init_icon_state = "medal_robust"
	greyscale_config = /datum/greyscale_config/medals/syndicate
	greyscale_config_worn = /datum/greyscale_config/medals/syndicate/worn
	greyscale_colors = "#ffff66#990000#ffff66#990000#ffffff"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

// DS-2/Syndicate Medals
/obj/item/clothing/accessory/medal/bubber/syndicate
	name = "syndicate medal of robustness"
	desc = "A medal dedicated to true syndicate agents for robustness in many fields."
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate"
	post_init_icon_state = "medal_robust"

/obj/item/clothing/accessory/medal/bubber/syndicate/espionage
	name = "syndicate medal of espionage"
	desc = "A medal dedicated to those who have proven themselves capable at covert operations."
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/espionage"
	post_init_icon_state = "medal_espi"

/obj/item/clothing/accessory/medal/bubber/syndicate/interrogation
	name = "syndicate medal of interrogation"
	desc = "A medal dedicated to those who have proven themselves capable at interrogating even the most resilient members of an enemy corporation."
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/interrogation"
	post_init_icon_state = "medal_inter"

/obj/item/clothing/accessory/medal/bubber/syndicate/intelligence
	name = "syndicate medal of intelligence"
	desc = "A medal dedicated to agents of particular talent at both gathering information on competetors (in ways both subtle and overt) and protecting \
	their own employers' confidentiality."
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/intelligence"
	post_init_icon_state = "medal_intel"

/obj/item/clothing/accessory/medal/bubber/syndicate/diligence
	name = "syndicate medal of diligence"
	desc = "A medal dedicated to a rarer agent, one who doesn't rush in; this is for agents who, through patient observation and strategizing, seize the \
	perfect moment to act. Like our emblematic snake, they wait to strike until the enemy shows their throat, and deliver the perfect killing blow."
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/diligence"
	post_init_icon_state = "medal_dili"

/obj/item/clothing/accessory/medal/bubber/syndicate/communications
	name = "syndicate medal of communication"
	desc = "A medal dedicated to those whom have proven themselves as capable counter-communications specialists."
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/communications"
	post_init_icon_state = "medal_comms"

/*
// ACCESSORY MEDALS
// These ones are purely cosmetic attachments
*/

/obj/item/clothing/accessory/bubber/acc_medal
	name = "circle medal"
	desc = "You shouldn't have this, make a bug report!"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal"
	post_init_icon_state = "medal_alt"
	greyscale_config = /datum/greyscale_config/medals/circle
	greyscale_config_worn = /datum/greyscale_config/medals/circle/worn
	greyscale_colors = "#9900cc#ffffff#9900cc#ff99ff#ffffff"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

/*
// Circle Medals
// The default acc_medal is already the 'alt_circle' and defines our configs
*/
/obj/item/clothing/accessory/bubber/acc_medal/circle
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/circle"
	post_init_icon_state = "medal"

/obj/item/clothing/accessory/bubber/acc_medal/circle/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/circle/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/circle/hollow
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/circle/hollow"
	post_init_icon_state = "medal_hollow"

/obj/item/clothing/accessory/bubber/acc_medal/circle/hollow/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/circle/hollow/bar_ribbon"
	post_init_icon_state = "medal_hollow_bar_ribbon"

/*
// Shield Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/shield
	name = "shield medal"
	desc = "A regular everyday medal."
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/shield"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/shield
	greyscale_config_worn = /datum/greyscale_config/medals/shield/worn

/obj/item/clothing/accessory/bubber/acc_medal/shield/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/shield/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/shield/hollow
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/shield/hollow"
	post_init_icon_state = "medal_hollow"

/*
// Bar Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/bar
	name = "bar medal"
	desc = "A regular everyday medal."
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/bar"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/bar
	greyscale_config_worn = /datum/greyscale_config/medals/bar/worn

/obj/item/clothing/accessory/bubber/acc_medal/bar/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/bar/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/bar/hollow
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/bar/hollow"
	post_init_icon_state = "medal_hollow"

/*
// Heart Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/heart
	name = "heart medal"
	desc = "A regular everyday medal."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/heart"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/heart
	greyscale_config_worn = /datum/greyscale_config/medals/heart/worn

/obj/item/clothing/accessory/bubber/acc_medal/heart/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/heart/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/heart/special
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/heart/special"
	post_init_icon_state = "medal_special"

/obj/item/clothing/accessory/bubber/acc_medal/heart/special/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/heart/special/bar_ribbon"
	post_init_icon_state = "medal_special_bar_ribbon"

/*
// Crown Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/crown
	name = "crown medal"
	desc = "A regular everyday medal."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/crown"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/crown
	greyscale_config_worn = /datum/greyscale_config/medals/crown/worn

/obj/item/clothing/accessory/bubber/acc_medal/crown/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/crown/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/crown/hollow
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/crown/hollow"
	post_init_icon_state = "medal_hollow"

/obj/item/clothing/accessory/bubber/acc_medal/crown/hollow/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/crown/hollow/bar_ribbon"
	post_init_icon_state = "medal_hollow_bar_ribbon"

/*
// Special Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/glowcrystal
	name = "glowcrystal necklace"
	desc = "A glowing rock strung from a necklace, a token of gratitude similar to a medal."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/glowcrystal"
	post_init_icon_state = "necklace_crystal"
	greyscale_config = /datum/greyscale_config/medals/glow
	greyscale_config_worn = /datum/greyscale_config/medals/glow/worn
	greyscale_colors = "#7effff"
	unique_reskin = list(
		"Crystal" = "necklace_crystal",
		"Bar" = "necklace_bar",
		"Hollow Bar" = "necklace_bar_hollow",
		"Diamond" = "necklace_diamond",
		"Hollow Diamond" = "necklace_diamond_hollow",
		"Shard" = "necklace_shard",
		"Hollow Shard" = "necklace_shard_hollow",
		"Triangle" = "necklace_triangle",
		"Hollow Triangle" = "necklace_triangle_hollow",
		"Circle" = "necklace_circle",
	)

/*
// Rank pins
*/
/obj/item/clothing/accessory/bubber/acc_medal/rankpin
	name = "rank pin"
	desc = "A pin used to display accomplishments, advancements, or otherwise earned recognition."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/rankpin"
	post_init_icon_state = "star"
	greyscale_config = /datum/greyscale_config/medals/rank_pins
	greyscale_config_worn = /datum/greyscale_config/medals/rank_pins/worn
	greyscale_colors = "#FFFFFF"

/obj/item/clothing/accessory/bubber/acc_medal/rankpin/bar
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/rankpin/bar"
	post_init_icon_state = "bar"

/obj/item/clothing/accessory/bubber/acc_medal/rankpin/two_bar
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/rankpin/two_bar"
	post_init_icon_state = "two_bar"

/*
// Neckpins
*/
/obj/item/clothing/accessory/bubber/acc_medal/neckpin
	name = "\improper NT company neckpin"
	desc = "A pin specially dedicated to show loyalty to your company!"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin"
	post_init_icon_state = "ntpin"
	greyscale_config = /datum/greyscale_config/medals/neckpins
	greyscale_config_worn = /datum/greyscale_config/medals/neckpins/worn
	greyscale_colors = "#FFFFFF#CCCED1"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/centcom
	name = "\improper Central Command neckpin"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/centcom"
	post_init_icon_state = "ccpin"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/solfed
	name = "\improper Solfed neckpin"
	desc = "A pin specially dedicated to show loyalty to your federation!"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/solfed"
	post_init_icon_state = "sfpin"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/solfed911
	name = "\improper Solfed 911 neckpin"
	desc = "A pin specially dedicated to show loyalty to your federation!"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/solfed911"
	post_init_icon_state = "911pin"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/solfed811
	name = "\improper Solfed 811 neckpin"
	desc = "A pin specially dedicated to show loyalty to your federation!"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/solfed811"
	post_init_icon_state = "811pin"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/syndicate
	name = "\improper Syndicate neckpin"
	desc = "A pin specially dedicated to show loyalty to the Syndicate!"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/syndicate"
	post_init_icon_state = "syndipin"
	greyscale_colors = "#262626#9c0000"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/interdyne
	name = "\improper Interdyne neckpin"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/interdyne"
	post_init_icon_state = "ippin"
	greyscale_colors = "#FFFFFF#3aba1e"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/porttarkon
	name = "\improper Port Tarkon neckpin"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/porttarkon"
	post_init_icon_state = "ptpin"

/*
// Military Bar Ribbons
*/
/obj/item/clothing/accessory/bubber/military_ribbon
	name = "military ribbon"
	desc = "An average military ribbon"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/military_ribbon"
	post_init_icon_state = "ribbon1"
	greyscale_config = /datum/greyscale_config/medals/military_ribbon
	greyscale_config_worn = /datum/greyscale_config/medals/military_ribbon/worn
	greyscale_colors = "#ff0000#04ff00#0008ff"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/accessory/bubber/military_ribbon/two
	icon_state = "/obj/item/clothing/accessory/bubber/military_ribbon/two"
	post_init_icon_state = "ribbon2"

/obj/item/clothing/accessory/bubber/military_ribbon/three
	icon_state = "/obj/item/clothing/accessory/bubber/military_ribbon/three"
	post_init_icon_state = "ribbon3"

/*
// Ribbons
*/
/obj/item/clothing/accessory/bubber/ribbon
	name = "ribbon"
	desc = "A normal everyday ribbon."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon"
	post_init_icon_state = "ribbon1"
	greyscale_config = /datum/greyscale_config/medals/color_ribbon
	greyscale_config_worn = /datum/greyscale_config/medals/color_ribbon/worn
	greyscale_colors = "#ffffff#664200#fff700"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/accessory/bubber/ribbon/ribbon_slash
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_slash"
	post_init_icon_state = "ribbon2"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_arrup
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_arrup"
	post_init_icon_state = "ribbon3"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_line
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_line"
	post_init_icon_state = "ribbon4"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_dual
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_dual"
	post_init_icon_state = "ribbon5"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_flat
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_flat"
	post_init_icon_state = "ribbon6"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_twotone
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_twotone"
	post_init_icon_state = "ribbon7"

