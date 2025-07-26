// Variables
/datum/species
	var/exotic_blood_color = BLOOD_COLOR_STANDARD
	var/exotic_blood_blend_mode = BLEND_MULTIPLY

/* // Greyscale Icons
/obj/effect/decal/cleanable/blood
	icon = 'modular_zzplurt/icons/effects/blood.dmi'

/obj/effect/decal/cleanable/trail_holder
	icon = 'modular_zzplurt/icons/effects/blood.dmi'

/obj/effect/decal/cleanable/blood/gibs
	icon = 'modular_zzplurt/icons/effects/blood.dmi'

/obj/effect/decal/cleanable/blood/footprints
	icon = 'modular_zzplurt/icons/effects/footprints.dmi'

/obj/effect/temp_visual/dir_setting/bloodsplatter
	icon = 'modular_zzplurt/icons/effects/blood.dmi'
*/ // Greyscale Icons

// Procs

/**
 * Returns the color of the blood on this atom
 * Arguments:
 * * original_color - The color to use if the blood color is BLOOD_COLOR_STANDARD
 * * use_default_color - If TRUE and original_color is null, returns BLOOD_COLOR_STANDARD instead
 */
/atom/proc/blood_DNA_to_color(original_color, use_default_color = FALSE)
	var/blood_color = BLOOD_COLOR_STANDARD
	if(forensics)
		blood_color = LAZYACCESS(forensics.blood_DNA, "color") || BLOOD_COLOR_STANDARD
	if(blood_color == BLOOD_COLOR_STANDARD)
		return original_color || (use_default_color ? BLOOD_COLOR_STANDARD : original_color)
	return blood_color

/atom/proc/blood_DNA_to_blend()
	if(forensics)
		if(forensics.blood_DNA && !isnull(forensics.blood_DNA["blendmode"]))
			return forensics.blood_DNA["blendmode"]
	return BLEND_MULTIPLY

/atom/proc/colored_blood_icon(icon_file)
	var/static/list/colored_blood_icons = list(
		'icons/effects/blood.dmi' = 'modular_zzplurt/icons/effects/blood.dmi',
		'icons/effects/footprints.dmi' = 'modular_zzplurt/icons/effects/footprints.dmi',
		'icons/mob/effects/dam_mob.dmi' = 'modular_zzplurt/icons/effects/dam_mob.dmi',
		'icons/mob/effects/bleed_overlays.dmi' = 'modular_zzplurt/icons/effects/bleed_overlays.dmi'
	)

	if(LAZYACCESS(forensics?.blood_DNA, "color") && LAZYACCESS(forensics?.blood_DNA, "color") != BLOOD_COLOR_STANDARD)
		return colored_blood_icons[icon_file] || icon_file
	return icon_file

//
// Changed return (Color + Blendmode)
/mob/living/get_blood_dna_list()
	. = ..()
	if(get_blood_id() != /datum/reagent/blood)
		return
	. += list("color" = BLOOD_COLOR_STANDARD, "blendmode" = BLEND_MULTIPLY)

/mob/living/carbon/get_blood_dna_list()
	. = ..()

	if(get_blood_id() != /datum/reagent/blood)
		return

	.["color"] = dna?.species?.exotic_blood_color || BLOOD_COLOR_STANDARD
	.["blendmode"] = dna?.species?.exotic_blood_blend_mode || BLEND_MULTIPLY

/mob/living/carbon/get_blood_data(blood_id)
	. = ..()
	if(blood_id != /datum/reagent/blood)
		return
	.["bloodcolor"] = dna.species.exotic_blood_color || BLOOD_COLOR_STANDARD
	.["bloodblend"] = dna.species.exotic_blood_blend_mode || BLEND_MULTIPLY

/atom/transfer_mob_blood_dna(mob/living/injected_mob)
	var/new_blood_dna = injected_mob.get_blood_dna_list()
	if(!new_blood_dna)
		return ..()
	. = ..()
	forensics.blood_DNA["color"] = new_blood_dna["color"]
	forensics.blood_DNA["blendmode"] = new_blood_dna["blendmode"]

/* Is this necessary? It just goes over the list twice
/datum/forensics/add_blood_DNA(list/blood_DNA)
	if(!length(blood_DNA))
		return
	LAZYINITLIST(src.blood_DNA)
	for(var/gene in blood_DNA)
		src.blood_DNA[gene] = blood_DNA[gene]
	for(var/color in blood_DNA) // Added this
		src.blood_DNA[color] = blood_DNA[color] // And this
	check_blood()
	return TRUE
*/

//
//
/turf/add_blood_DNA(list/blood_dna, list/datum/disease/diseases)
	. = ..()
	if(!.)
		return
	var/obj/effect/decal/cleanable/blood/splatter/blood_splatter = locate() in src
	if(!blood_splatter || !QDELETED(blood_splatter))
		return
	blood_splatter.color = blood_splatter.blood_DNA_to_color(blood_splatter.color)

/obj/effect/decal/cleanable/blood/add_blood_DNA(list/blood_DNA_to_add)
	. = ..()
	color = blood_DNA_to_color(color)
	icon = colored_blood_icon(icon)

/obj/effect/decal/cleanable/blood/dry()
	var/old_color = color
	. = ..()
	if(!.)
		return
	color = old_color == BLOOD_COLOR_STANDARD ? COLOR_GRAY : BlendRGB(blood_DNA_to_color(old_color), COLOR_GRAY, 0.5)

/datum/component/bloodysoles/feet/update_icon()
	var/original_bloody_feet = bloody_feet
	bloody_feet = mutable_appearance(parent_atom.colored_blood_icon('icons/effects/blood.dmi'), "shoeblood", SHOES_LAYER, color = parent_atom.blood_DNA_to_color(bloody_feet.color), blend_mode = parent_atom.blood_DNA_to_blend())
	. = ..()
	bloody_feet = original_bloody_feet
