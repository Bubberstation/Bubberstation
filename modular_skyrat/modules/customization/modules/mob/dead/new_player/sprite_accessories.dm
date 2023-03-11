GLOBAL_LIST_EMPTY(cached_mutant_icon_files)

/// The flag to show that snouts should use the muzzled sprite.
#define SPRITE_ACCESSORY_USE_MUZZLED_SPRITE (1<<0)
/// The flag to show that this tail sprite can wag.
#define SPRITE_ACCESSORY_WAG_ABLE (1<<1)
/// The flag that controls whether or not this sprite accessory should force the wearer to hide its shoes.
#define SPRITE_ACCESSORY_HIDE_SHOES (1<<2)
/// The flag to that controls whether or not this sprite accessory should force worn facewear to use layers 5 (for glasses) and 4 (for masks and hats).
#define SPRITE_ACCESSORY_USE_ALT_FACEWEAR_LAYER (1<<3)

/datum/sprite_accessory
	///Unique key of an accessory. All tails should have "tail", ears "ears" etc.
	var/key = null
	///If an accessory is special, it wont get included in the normal accessory lists
	var/special = FALSE
	var/list/recommended_species
	///Which color we default to on acquisition of the accessory (such as switching species, default color for character customization etc)
	///You can also put down a a HEX color, to be used instead as the default
	var/default_color
	///Set this to a name, then the accessory will be shown in preferences, if a species can have it. Most accessories have this
	///Notable things that have it set to FALSE are things that need special setup, such as genitals
	var/generic

	/// For all the flags that you need to pass from a sprite_accessory to an organ, when it's linked to one.
	/// (i.e. passing through the fact that a snout should or shouldn't use a muzzled sprite for head worn items)
	var/flags_for_organ = NONE

	color_src = USE_ONE_COLOR

	///Which layers does this accessory affect
	var/relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER, BODY_FRONT_UNDER_CLOTHES, ABOVE_BODY_FRONT_HEAD_LAYER)

	///This is used to determine whether an accessory gets added to someone. This is important for accessories that are "None", which should have this set to false
	var/factual = TRUE

	///Use this as a type path to an organ that this sprite_accessory will be associated. Make sure the organ has 'mutantpart_info' set properly.
	var/organ_type

	///Set this to true to make an accessory appear as color customizable in preferences despite advanced color settings being off, will also prevent the accessory from being reset
	var/always_color_customizable
	///Whether the accessory can have a special icon_state to render, i.e. wagging tails
	var/special_render_case
	///Special case of whether the accessory should be shifted in the X dimension, check taur genitals for example
	var/special_x_dimension
	///Special case of whether the accessory should have a different icon, check taur genitals for example
	var/special_icon_case
	///Special case for MODsuit overlays
	var/use_custom_mod_icon
	///Special case of applying a different color
	var/special_colorize
	///Whether it has any extras to render, and their appropriate color sources
	var/extra = FALSE
	var/extra_color_src
	var/extra2 = FALSE
	var/extra2_color_src
	///If defined, the accessory will be only available to ckeys inside the list. ITS ASSOCIATIVE, ie. ("ckey" = TRUE). For speed
	var/list/ckey_whitelist
	///Whether this feature is genetic, and thus modifiable by DNA consoles
	var/genetic = FALSE
	var/uses_emissives = FALSE
	var/color_layer_names
	/// If this sprite accessory will be inaccessable if ERP config is disabled
	var/erp_accessory = FALSE

/datum/sprite_accessory/New()
	if(!default_color)
		switch(color_src)
			if(USE_ONE_COLOR)
				default_color = DEFAULT_PRIMARY
			if(USE_MATRIXED_COLORS)
				default_color = DEFAULT_MATRIXED
			else
				default_color = "#FFFFFF"
	if(name == "None")
		factual = FALSE
	if(color_src == USE_MATRIXED_COLORS && default_color != DEFAULT_MATRIXED)
		default_color = DEFAULT_MATRIXED
	if (color_src == USE_MATRIXED_COLORS)
		color_layer_names = list()
		if (!GLOB.cached_mutant_icon_files[icon])
			GLOB.cached_mutant_icon_files[icon] = icon_states(new /icon(icon))
		for (var/layer in relevent_layers)
			var/layertext = layer == BODY_BEHIND_LAYER ? "BEHIND" : (layer == BODY_ADJ_LAYER ? "ADJ" : "FRONT")
			if ("m_[key]_[icon_state]_[layertext]_primary" in GLOB.cached_mutant_icon_files[icon])
				color_layer_names["1"] = "primary"
			if ("m_[key]_[icon_state]_[layertext]_secondary" in GLOB.cached_mutant_icon_files[icon])
				color_layer_names["2"] = "secondary"
			if ("m_[key]_[icon_state]_[layertext]_tertiary" in GLOB.cached_mutant_icon_files[icon])
				color_layer_names["3"] = "tertiary"

/datum/sprite_accessory/proc/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	return FALSE

/datum/sprite_accessory/proc/get_special_render_state(mob/living/carbon/human/H)
	return null

/datum/sprite_accessory/proc/get_special_render_key(mob/living/carbon/human/owner)
	return key

/datum/sprite_accessory/proc/get_special_render_colour(mob/living/carbon/human/H, passed_state)
	return null

/datum/sprite_accessory/proc/get_special_icon(mob/living/carbon/human/H, passed_state)
	return null

/datum/sprite_accessory/proc/get_special_x_dimension(mob/living/carbon/human/H, passed_state)
	return 0

// A proc for accessories which have 'use_custom_mod_icon' set to TRUE
/datum/sprite_accessory/proc/get_custom_mod_icon(mob/living/carbon/human/owner)
	return null

/datum/sprite_accessory/proc/get_default_color(list/features, datum/species/pref_species) //Needs features for the color information
	var/list/colors
	switch(default_color)
		if(DEFAULT_PRIMARY)
			colors = list(features["mcolor"])
		if(DEFAULT_SECONDARY)
			colors = list(features["mcolor2"])
		if(DEFAULT_TERTIARY)
			colors = list(features["mcolor3"])
		if(DEFAULT_MATRIXED)
			colors = list(features["mcolor"], features["mcolor2"], features["mcolor3"])
		if(DEFAULT_SKIN_OR_PRIMARY)
			if(pref_species && pref_species.use_skintones)
				colors = list(features["skin_color"])
			else
				colors = list(features["mcolor"])
		else
			colors = list(default_color)

	return colors

/datum/sprite_accessory/moth_markings
	key = "moth_markings"
	generic = "Moth markings"

/datum/sprite_accessory/moth_antennae/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/spines
	key = "spines"
	generic = "Spines"
	icon = 'modular_skyrat/master_files/icons/mob/mutant_bodyparts.dmi'
	special_render_case = TRUE
	default_color = DEFAULT_SECONDARY
	recommended_species = list(SPECIES_LIZARD, SPECIES_UNATHI, SPECIES_LIZARD_ASH, SPECIES_LIZARD_SILVER)
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER)
	genetic = TRUE

/datum/sprite_accessory/spines/is_hidden(mob/living/carbon/human/wearer, obj/item/bodypart/bodypart)
	var/obj/item/organ/external/tail/tail = wearer.getorganslot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(!wearer.w_uniform && !wearer.wear_suit)
		return FALSE
	//	Can hide if wearing uniform
	if(key in wearer.try_hide_mutant_parts)
		return TRUE
	if(wearer.wear_suit)
	//	Exception for MODs
		if(istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
			return FALSE
	else if(!tail \
			|| (wearer.wear_suit \
				&& (wearer.wear_suit.flags_inv & HIDETAIL \
				|| wearer.wear_suit.flags_inv & HIDESPINE) \
			)
		)
		return TRUE

/datum/sprite_accessory/spines/get_special_render_state(mob/living/carbon/human/H)
	var/obj/item/organ/external/tail/tail = H.getorganslot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(tail && tail.wag_flags & WAG_WAGGING)
		return "[icon_state]_wagging"
	return icon_state

/datum/sprite_accessory/caps
	key = "caps"
	generic = "Caps"

/datum/sprite_accessory/body_markings
	key = "body_markings"
	generic = "Body Markings"
	default_color = DEFAULT_TERTIARY

/datum/sprite_accessory/legs
	key = "legs"
	generic = "Leg Type"
	color_src = null
	genetic = TRUE

/datum/sprite_accessory/socks
	icon = 'modular_skyrat/master_files/icons/mob/clothing/underwear.dmi'
	use_static = TRUE
/datum/sprite_accessory/socks/socks_norm
	name = "Normal (Greyscale)"
	icon_state = "white_norm"
	use_static = null

/datum/sprite_accessory/socks/stirrups_norm
	name = "Normal Stirrups (Greyscale)"
	icon_state = "socks_norm-stir"
	use_static = null

/datum/sprite_accessory/socks/socks_short
	name = "Short (Greyscale)"
	icon_state = "white_short"
	use_static = null


/datum/sprite_accessory/socks/socks_knee
	name = "Knee-high (Greyscale)"
	icon_state = "white_knee"
	use_static = null

/datum/sprite_accessory/socks/stirrups_knee
	name = "Knee-high Stirrups"
	icon_state = "socks_knee-stir"
	use_static = null

/datum/sprite_accessory/socks/striped_knee
	name = "Knee-high - Striped"
	icon_state = "striped_knee"
	use_static = null

/datum/sprite_accessory/socks/thin_knee
	name = "Knee-high - Thin"
	icon_state = "thin_knee"
	use_static = null

/datum/sprite_accessory/socks/socks_thigh
	name = "Thigh-high (Greyscale)"
	icon_state = "white_thigh"
	use_static = null

/datum/sprite_accessory/socks/stirrups_thigh
	name = "Thigh-high Stirrups (Greyscale)"
	icon_state = "socks_thigh-stir"
	use_static = null

/datum/sprite_accessory/socks/striped_thigh
	name = "Thigh-high (Striped)"
	icon_state = "striped_thigh"
	use_static = null

/datum/sprite_accessory/socks/striped_thigh/stirrups
	name = "Thigh-high (Striped Stirrups)"
	icon_state = "striped_thigh-stir"
	use_static = null

/datum/sprite_accessory/socks/leggings/stirrups/gym
	name = "Thigh-high Stirrups (black with stripe)"
	icon_state = "leggings-stir-black"
	use_static = TRUE

/datum/sprite_accessory/socks/bee_thigh
	name = "Thigh-high - Bee (Old)"
	icon_state = "bee_thigh_old"

/datum/sprite_accessory/socks/bee_knee
	name = "Knee-high - Bee (Old)"
	icon_state = "bee_knee_old"

/datum/sprite_accessory/socks/christmas_norm
	name = "Normal - Christmas"
	icon_state = "christmas_norm"

/datum/sprite_accessory/socks/candycaner_norm
	name = "Normal - Red Candy Cane"
	icon_state = "candycaner_norm"

/datum/sprite_accessory/socks/candycaneg_norm
	name = "Normal - Green Candy Cane"
	icon_state = "candycaneg_norm"

/datum/sprite_accessory/socks/christmas_knee
	name = "Knee-High - Christmas"
	icon_state = "christmas_knee"

/datum/sprite_accessory/socks/candycaner_knee
	name = "Knee-High - Red Candy Cane"
	icon_state = "candycaner_knee"

/datum/sprite_accessory/socks/candycaneg_knee
	name = "Knee-High - Green Candy Cane"
	icon_state = "candycaneg_knee"

/datum/sprite_accessory/socks/christmas_thigh
	name = "Thigh-high - Christmas"
	icon_state = "christmas_thigh"

/datum/sprite_accessory/socks/candycaner_thigh
	name = "Thigh-high - Red Candy Cane"
	icon_state = "candycaner_thigh"

/datum/sprite_accessory/socks/candycaneg_thigh
	name = "Thigh-high - Green Candy Cane"
	icon_state = "candycaneg_thigh"

/datum/sprite_accessory/socks/rainbow_thigh
	name = "Thigh-high - Rainbow"
	icon_state = "rainbow_thigh"

/datum/sprite_accessory/socks/rainbow_knee
	name = "Knee-high - Rainbow"
	icon_state = "rainbow_knee"

/datum/sprite_accessory/socks/rainbow_knee/stirrups
	name = "Knee-high - Rainbow Stirrups"
	icon_state = "rainbow_knee-stir"

/datum/sprite_accessory/socks/rainbow_thigh/stirrups
	name = "Thigh-high - Rainbow Stirrups"
	icon_state = "rainbow_thigh-stir"

/datum/sprite_accessory/socks/fishnet_thigh_sr //TG has one, but this one matches with several tops that I'll get whined to if I change soooo
	name = "Thigh-high - Fishnet"
	icon_state = "fishnet"

/datum/sprite_accessory/socks/fishnet_thigh/alt
	name = "Thigh-high - Fishnet (Greyscale)"
	icon_state = "fishnet_alt"
	use_static = null

/datum/sprite_accessory/socks/pantyhose/stirrups
	name = "Pantyhose Stirrups"
	icon_state = "pantyhose-stir"
	use_static = null

/datum/sprite_accessory/socks/pantyhose_ripped
	name = "Pantyhose - Ripped"
	icon_state = "pantyhose_ripped"
	use_static = null

/datum/sprite_accessory/socks/pantyhose_ripped/stirrups
	name = "Pantyhose - Ripped Stirrups"
	icon_state = "pantyhose_ripped-stir"
	use_static = null

/datum/sprite_accessory/socks/stockings_ripped
	name = "Stockings - Ripped"
	icon_state = "stockings_ripped"

/datum/sprite_accessory/socks/leggings
	name = "Leggings"
	icon_state = "leggings"
	use_static = null

/datum/sprite_accessory/socks/leggings/stirrups
	name = "Leggings - Stirrups"
	icon_state = "leggings-stir"
	use_static = null

/datum/sprite_accessory/socks/leggings/latex
	name = "Socks - Latex"
	icon_state = "socks_latex"
	use_static = TRUE
	erp_accessory = TRUE

/datum/sprite_accessory/underwear
	icon = 'modular_skyrat/master_files/icons/mob/clothing/underwear.dmi'
	///Whether the underwear uses a special sprite for digitigrade style (i.e. briefs, not panties). Adds a "_d" suffix to the icon state
	var/has_digitigrade = FALSE
	///Whether this underwear includes a top (Because gender = FEMALE doesn't actually apply here.). Hides breasts, nothing more.
	var/hides_breasts = FALSE

/datum/sprite_accessory/underwear/male_bee
	name = "Boxers - Bee"
	icon_state = "bee_shorts"
	has_digitigrade = TRUE
	gender = MALE
	use_static = TRUE

/datum/sprite_accessory/underwear/female_beekini
	name = "Panties - Bee-kini"
	icon_state = "panties_bee-kini"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/panties
	name = "Panties"
	icon_state = "panties"
	gender = FEMALE

/datum/sprite_accessory/underwear/fishnet_lower
	name = "Panties - Fishnet"
	icon_state = "fishnet_lower"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/fishnet_lower/alt
	name = "Panties - Fishnet (Greyscale)"
	icon_state = "fishnet_lower_alt"
	use_static = null

/datum/sprite_accessory/underwear/female_beekini
	name = "Panties - Bee-kini"
	icon_state = "panties_bee-kini"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/female_commie
	name = "Panties - Commie"
	icon_state = "panties_commie"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/female_usastripe
	name = "Panties - Freedom"
	icon_state = "panties_assblastusa"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/female_kinky
	name = "Panties - Kinky Black"
	icon_state = "panties_kinky"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/panties_uk
	name = "Panties - UK"
	icon_state = "panties_uk"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/panties_neko
	name = "Panties - Neko"
	icon_state = "panties_neko"
	gender = FEMALE

/datum/sprite_accessory/underwear/panties_slim
	name = "Panties - Slim"
	icon_state = "panties_slim"
	gender = FEMALE

/datum/sprite_accessory/underwear/striped_panties
	name = "Panties - Striped"
	icon_state = "striped_panties"
	gender = FEMALE

/datum/sprite_accessory/underwear/panties_swimsuit
	name = "Panties - Swimsuit"
	icon_state = "panties_swimming"
	gender = FEMALE

/datum/sprite_accessory/underwear/panties_thin
	name = "Panties - Thin"
	icon_state = "panties_thin"
	gender = FEMALE

/datum/sprite_accessory/underwear/swimsuit_red
	name = "Swimsuit, One Piece - Red"
	icon_state = "swimming_red"
	gender = FEMALE
	use_static = TRUE
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/swimsuit
	name = "Swimsuit, One Piece - Black"
	icon_state = "swimming_black"
	gender = FEMALE
	use_static = TRUE
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/swimsuit_blue
	name = "Swimsuit, One Piece - Striped Blue"
	icon_state = "swimming_blue"
	gender = FEMALE
	use_static = TRUE
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/thong
	name = "Thong"
	icon_state = "thong"
	gender = FEMALE

/datum/sprite_accessory/underwear/thong_babydoll
	name = "Thong - Alt"
	icon_state = "thong_babydoll"
	gender = FEMALE

/datum/sprite_accessory/underwear/chastbelt
	name = "Chastity Belt"
	icon_state = "chastbelt"
	use_static = TRUE
	erp_accessory = TRUE

/datum/sprite_accessory/underwear/chastcage
	name = "Chastity Cage"
	icon_state = "chastcage"
	use_static = null
	erp_accessory = TRUE

/datum/sprite_accessory/underwear/latex
	name = "Panties - Latex"
	icon_state = "panties_latex"
	use_static = TRUE
	erp_accessory = TRUE

/datum/sprite_accessory/undershirt/lizared
	name = "LIZARED Top"
	icon_state = "lizared_top"
	use_static = TRUE

/datum/sprite_accessory/underwear/lizared
	name = "LIZARED Underwear"
	icon_state = "lizared"
	use_static = TRUE
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/boyshorts
	name = "Boyshorts"
	icon_state = "boyshorts"
	has_digitigrade = TRUE
	gender = FEMALE

/*
	Adding hides_breasts to TG underwears where applicable
*/
/datum/sprite_accessory/underwear/female_bikini
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/female_lace
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/female_bralette
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/female_sport
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/female_strapless
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/female_babydoll
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/swimsuit_onepiece
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/swimsuit_strapless_onepiece
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/swimsuit_twopiece
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/swimsuit_strapless_twopiece
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/swimsuit_stripe
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/swimsuit_halter
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/female_white_neko
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/female_black_neko
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/female_uk
	hides_breasts = TRUE

/*
	End of adding hides_breasts to TG stuff, start of adding has_digitigrade to TG stuff
*/
/datum/sprite_accessory/underwear/male_boxers
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_stripe
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_midway
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_longjohns
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_hearts
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_commie
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_usastripe
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_uk
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/female_sport
    has_digitigrade = TRUE

/*
	End of adding has_digitigrade to TG stuff
*/

/datum/sprite_accessory/undershirt
	icon = 'modular_skyrat/master_files/icons/mob/clothing/underwear.dmi'
	use_static = TRUE
	///Whether this underwear includes a bottom (For Leotards and the likes)
	var/hides_groin = FALSE

/datum/sprite_accessory/undershirt/tanktop_alt
	name = "Tank Top - Alt"
	icon_state = "tanktop_alt"
	use_static = null

/datum/sprite_accessory/undershirt/tanktop_midriff
	name = "Tank Top - Midriff"
	icon_state = "tank_midriff"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/tanktop_midriff_alt
	name = "Tank Top - Midriff Halterneck"
	icon_state = "tank_midriff_alt"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/tankstripe
	name = "Tank Top - Striped"
	icon_state = "tank_stripes"
	use_static = TRUE

/datum/sprite_accessory/undershirt/tank_top_sun
	name = "Tank top - Sun"
	icon_state = "tank_sun"
	use_static = TRUE

/datum/sprite_accessory/undershirt/babydoll
	name = "Baby-Doll"
	icon_state = "babydoll"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/bra
	name = "Bra"
	icon_state = "bra"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/bra_alt
	name = "Bra - Alt"
	icon_state = "bra_alt"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/bra_thin
	name = "Bra - Thin"
	icon_state = "bra_thin"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/bra_kinky
	name = "Bra - Kinky Black"
	icon_state = "bra_kinky"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/bra_freedom
	name = "Bra - Freedom"
	icon_state = "bra_assblastusa"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/bra_commie
	name = "Bra - Commie"
	icon_state = "bra_commie"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/bra_beekini
	name = "Bra - Bee-kini"
	icon_state = "bra_bee-kini"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/bra_uk
	name = "Bra - UK"
	icon_state = "bra_uk"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/bra_neko
	name = "Bra - Neko"
	icon_state = "bra_neko"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/halterneck_bra
	name = "Bra - Halterneck"
	icon_state = "halterneck_bra"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/sports_bra
	name = "Bra, Sports"
	icon_state = "sports_bra"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/sports_bra_alt
	name = "Bra, Sports - Alt"
	icon_state = "sports_bra_alt"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/bra_strapless
	name = "Bra, Strapless"
	icon_state = "bra_strapless"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/bra_latex
	name = "Bra, Latex"
	icon_state = "bra_latex"
	gender = FEMALE
	use_static = TRUE
	erp_accessory = TRUE

/datum/sprite_accessory/undershirt/striped_bra
	name = "Bra - Striped"
	icon_state = "striped_bra"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/sarashi
	name = "Bra - Sarashi"
	icon_state = "bandages"
	gender = NEUTER
	use_static = null

/datum/sprite_accessory/undershirt/fishnet_sleeves
	name = "Fishnet - Sleeved"
	icon_state = "fishnet_sleeves"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/fishnet_sleeves/alt
	name = "Fishnet - Sleeved (Greyscale)"
	icon_state = "fishnet_sleeves_alt"
	use_static = null

/datum/sprite_accessory/undershirt/fishnet_base
	name = "Fishnet - Sleeveless"
	icon_state = "fishnet_body"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/fishnet_base/alt
	name = "Fishnet - Sleeveless (Greyscale)"
	icon_state = "fishnet_body_alt"
	use_static = null

/datum/sprite_accessory/undershirt/swimsuit
	name = "Swimsuit Top"
	icon_state = "bra_swimming"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/corset
	name = "Corset"
	icon_state = "corset"
	gender = FEMALE
	use_static = TRUE
	hides_groin = TRUE

/datum/sprite_accessory/undershirt/chastbra
	name = "Chastity Bra"
	icon_state = "chastbra"
	gender = FEMALE
	use_static = TRUE
	erp_accessory = TRUE

/datum/sprite_accessory/undershirt/pasties
	name = "Pasties"
	icon_state = "pasties"
	gender = FEMALE
	use_static = null
	erp_accessory = TRUE

/datum/sprite_accessory/undershirt/pasties_alt
	name = "Pasties - Alt"
	icon_state = "pasties_alt"
	gender = FEMALE
	use_static = null
	erp_accessory = TRUE

/datum/sprite_accessory/undershirt/shibari
	name = "Shibari"
	icon_state = "shibari"
	gender = FEMALE
	use_static = null
	erp_accessory = TRUE

/datum/sprite_accessory/undershirt/shibari_sleeves
	name = "Shibari Sleeves"
	icon_state = "shibari_sleeves"
	gender = FEMALE
	use_static = null
	erp_accessory = TRUE

/datum/sprite_accessory/undershirt/bulletclub //4 life
	name = "Shirt - Black Skull"
	icon_state = "shirt_bc"
	gender = NEUTER

/datum/sprite_accessory/undershirt/striped
	name = "Shirt - Black Stripes"
	icon_state = "longstripe"
	gender = NEUTER
	use_static = TRUE

/datum/sprite_accessory/undershirt/striped/blue
	name = "Shirt - Blue Stripes"
	icon_state = "longstripe_blue"

/datum/sprite_accessory/undershirt/binder
	name = "Binder"
	icon_state = "binder"
	gender = MALE
	use_static = null

/datum/sprite_accessory/undershirt/binder/strapless
	name = "Binder - Strapless"
	icon_state = "binder_strapless"

/datum/sprite_accessory/undershirt/turtleneck
	name = "Sweater - Turtleneck"
	icon_state = "turtleneck"
	use_static = null
	gender = NEUTER

/datum/sprite_accessory/undershirt/turtleneck/smooth
	name = "Sweater - Smooth Turtleneck"
	icon_state = "turtleneck_smooth"

/datum/sprite_accessory/undershirt/turtleneck/sleeveless
	name = "Sweater - Sleeveless Turtleneck"
	icon_state = "turtleneck_sleeveless"

/datum/sprite_accessory/undershirt/offshoulder
	name = "Shirt - Off-Shoulder"
	icon_state = "one_arm"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/buttondown
	name = "Shirt - Buttondown"
	icon_state = "buttondown"
	gender = NEUTER
	use_static = null

/datum/sprite_accessory/undershirt/buttondown/short_sleeve
	name = "Shirt - Short Sleeved Buttondown"
	icon_state = "buttondown_short"

/datum/sprite_accessory/undershirt/leotard
	name = "Shirt - Leotard"
	icon_state = "leotard"
	gender = FEMALE
	use_static = null
	hides_groin = TRUE

/datum/sprite_accessory/undershirt/leotard/turtleneck
	name = "Shirt - Turtleneck Leotard"
	icon_state = "leotard_turtleneck"

/datum/sprite_accessory/undershirt/leotard/turtleneck/sleeveless
	name = "Shirt - Turtleneck Leotard Sleeveless"
	icon_state = "leotard_turtleneck_sleeveless"
