GLOBAL_LIST_EMPTY(customizable_races)

/datum/species
	mutant_bodyparts = list()
	digitigrade_customization = DIGITIGRADE_OPTIONAL // Doing this so that the legs preference actually works for everyone.
	///Self explanatory
	var/can_have_genitals = TRUE
	///A list of actual body markings on the owner of the species. Associative lists with keys named by limbs defines, pointing to a list with names and colors for the marking to be rendered. This is also stored in the DNA
	var/list/list/body_markings = list()
	///Override of the eyes icon file, used for Vox and maybe more in the future - The future is now, with Teshari using it too
	var/eyes_icon
	///How are we treated regarding processing reagents, by default we process them as if we're organic
	var/reagent_flags = PROCESS_ORGANIC
	///Whether a species can use augmentations in preferences
	var/can_augment = TRUE
	///Override for the alpha of bodyparts and mutant parts.
	var/specific_alpha = 255
	///Override for alpha value of markings, should be much lower than the above value.
	var/markings_alpha = 255
	///If a species can always be picked in prefs for the purposes of customizing it for ghost roles or events
	var/always_customizable = FALSE
	/// If a species requires the player to be a Veteran to be able to pick it.
	var/veteran_only = FALSE
	///Flavor text of the species displayed on character creation screeen
	var/flavor_text = "No description."
	///Path to BODYTYPE_CUSTOM species worn icons. An assoc list of ITEM_SLOT_X => /icon
	var/list/custom_worn_icons = list()
	///Is this species restricted from changing their body_size in character creation?
	var/body_size_restricted = FALSE

/datum/species/proc/handle_mutant_bodyparts(mob/living/carbon/human/owner, forced_colour, force_update = FALSE)
	var/list/standing = list()

	var/obj/item/bodypart/head/HD = owner.get_bodypart(BODY_ZONE_HEAD)

	if(!mutant_bodyparts)
		owner.remove_overlay(BODY_BEHIND_LAYER)
		owner.remove_overlay(BODY_ADJ_LAYER)
		owner.remove_overlay(BODY_FRONT_LAYER)
		owner.remove_overlay(BODY_FRONT_UNDER_CLOTHES)
		owner.remove_overlay(ABOVE_BODY_FRONT_HEAD_LAYER)
		return

	var/list/bodyparts_to_add = list()
	var/new_renderkey = "[id]"

	for(var/key in mutant_bodyparts)
		if(!islist(mutant_bodyparts[key]) || !(mutant_bodyparts[key][MUTANT_INDEX_NAME] in GLOB.sprite_accessories[key]))
			continue
		var/datum/sprite_accessory/mutant_accessory = GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]
		if(!mutant_accessory || mutant_accessory.icon_state == "none")
			continue
		if(mutant_accessory.is_hidden(owner, HD))
			continue
		var/render_state
		if(mutant_accessory.special_render_case)
			render_state = mutant_accessory.get_special_render_state(owner)
		else
			render_state = mutant_accessory.icon_state
		new_renderkey += "-[mutant_accessory.get_special_render_key(owner)]-[render_state]"
		bodyparts_to_add[mutant_accessory] = render_state

	if(new_renderkey == owner.mutant_renderkey && !force_update)
		return
	owner.mutant_renderkey = new_renderkey

	owner.remove_overlay(BODY_BEHIND_LAYER)
	owner.remove_overlay(BODY_ADJ_LAYER)
	owner.remove_overlay(BODY_FRONT_LAYER)
	owner.remove_overlay(BODY_FRONT_UNDER_CLOTHES)
	owner.remove_overlay(ABOVE_BODY_FRONT_HEAD_LAYER)

	var/g = (owner.physique == FEMALE) ? "f" : "m"
	for(var/bodypart in bodyparts_to_add)
		var/datum/sprite_accessory/bodypart_accessory = bodypart
		var/key = bodypart_accessory.key

		var/icon_to_use
		var/x_shift
		var/render_state = bodyparts_to_add[bodypart_accessory]

		var/override_color = forced_colour
		if(!override_color && bodypart_accessory.special_colorize)
			override_color = bodypart_accessory.get_special_render_colour(owner, render_state)

		var/color_layer_list = bodypart_accessory.color_layer_names
		if(bodypart_accessory.special_icon_case)
			icon_to_use = bodypart_accessory.get_special_icon(owner, render_state)
		else
			icon_to_use = bodypart_accessory.icon

		if (bodypart_accessory.special_render_case)
			color_layer_list = list("1" = "primary", "2" = "secondary", "3" = "tertiary")

		if(bodypart_accessory.special_x_dimension)
			x_shift = bodypart_accessory.get_special_x_dimension(owner, render_state)
		else
			x_shift = bodypart_accessory.dimension_x

		if(bodypart_accessory.gender_specific)
			render_state = "[g]_[bodypart_accessory.get_special_render_key(owner)]_[render_state]"
		else
			render_state = "m_[bodypart_accessory.get_special_render_key(owner)]_[render_state]"

		for(var/layer in bodypart_accessory.relevent_layers)
			var/layertext = mutant_bodyparts_layertext(layer)
			var/list/mutable_appearance/accessories
			var/mutable_appearance/accessory_overlay = mutable_appearance(icon_to_use, layer = -layer)

			accessory_overlay.icon_state = "[render_state]_[layertext]"
			if (bodypart_accessory.color_src == USE_MATRIXED_COLORS && color_layer_list)
				accessory_overlay.icon_state = "[render_state]_[layertext]_primary"
				accessories = list()

			if(bodypart_accessory.center)
				accessory_overlay = center_image(accessory_overlay, x_shift, bodypart_accessory.dimension_y)


			if(!override_color)
				if(HAS_TRAIT(owner, TRAIT_HUSK))
					if(bodypart_accessory.color_src == USE_MATRIXED_COLORS) //Matrixed+husk needs special care, otherwise we get sparkle dogs
						accessory_overlay.color = HUSK_COLOR_LIST
					else
						accessory_overlay.color = "#AAA" //The gray husk color
				else
					switch(bodypart_accessory.color_src)
						if(USE_ONE_COLOR)
							accessory_overlay.color = mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST][1]
						if(USE_MATRIXED_COLORS)
							var/list/color_list = mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST]
							for (var/n in color_layer_list)
								var/num = text2num(n)
								var/mutable_appearance/matrixed_acce = mutable_appearance(icon_to_use, layer = -layer)
								matrixed_acce.icon_state = "[render_state]_[layertext]_[color_layer_list[n]]"
								matrixed_acce.color = color_list[num]
								matrixed_acce.alpha = specific_alpha
								if (bodypart_accessory.center)
									matrixed_acce = center_image(matrixed_acce, x_shift, bodypart_accessory.dimension_y)
								accessories += matrixed_acce
								if (mutant_bodyparts[key][MUTANT_INDEX_EMISSIVE_LIST] && mutant_bodyparts[key][MUTANT_INDEX_EMISSIVE_LIST][num])
									var/mutable_appearance/emissive_overlay = emissive_appearance_copy(matrixed_acce, owner)
									//if (bodypart_accessory.center)
									//	emissive_overlay = center_image(emissive_overlay, x_shift, bodypart_accessory.dimension_y)
									accessories += emissive_overlay
						if(MUTCOLORS)
							if(fixed_mut_color)
								accessory_overlay.color = fixed_mut_color
							else
								accessory_overlay.color = owner.dna.features["mcolor"]
						if(HAIR)
							if(hair_color == "mutcolor")
								accessory_overlay.color = owner.dna.features["mcolor"]
							else if(hair_color == "fixedmutcolor")
								accessory_overlay.color = fixed_mut_color
							else
								accessory_overlay.color = owner.hair_color
						if(FACEHAIR)
							accessory_overlay.color = owner.facial_hair_color
						if(EYECOLOR)
							accessory_overlay.color = owner.eye_color_left
			else
				accessory_overlay.color = override_color

			if (accessories)
				for (var/acces in accessories)
					standing += acces
			else
				standing += accessory_overlay

				if (mutant_bodyparts[key][MUTANT_INDEX_EMISSIVE_LIST] && mutant_bodyparts[key][MUTANT_INDEX_EMISSIVE_LIST][1])
					var/mutable_appearance/emissive_overlay = emissive_appearance_copy(accessory_overlay, owner)
					//if (bodypart_accessory.center)
					//	emissive_overlay = center_image(emissive_overlay, x_shift, bodypart_accessory.dimension_y)
					standing += emissive_overlay

			// Gets the icon_state of a single or matrix colored accessory and overlays it with a texture
			if(bodypart_accessory.use_custom_mod_icon)
				if(bodypart_accessory.color_src == USE_MATRIXED_COLORS && color_layer_list)
					var/mutable_appearance/MOD_overlay = mutable_appearance(bodypart_accessory.get_custom_mod_icon(owner), layer = -layer)
					// Pastes each of the three(primary, secondary, tertiary) accessory icon_states into one MA
					for(var/number in color_layer_list)
						MOD_overlay.add_overlay(mutable_appearance(bodypart_accessory.get_custom_mod_icon(owner), "[render_state]_[layertext]_[color_layer_list[number]]"))
					if(bodypart_accessory.center)
						MOD_overlay = center_image(MOD_overlay, x_shift, bodypart_accessory.dimension_y)
					standing += MOD_overlay
				else
					// Single color MA
					var/mutable_appearance/MOD_overlay = mutable_appearance(bodypart_accessory.get_custom_mod_icon(owner), "[render_state]_[layertext]", layer = -layer)
					if(bodypart_accessory.center)
						MOD_overlay = center_image(MOD_overlay, x_shift, bodypart_accessory.dimension_y)
					standing += MOD_overlay

			if(bodypart_accessory.hasinner)
				var/mutable_appearance/inner_accessory_overlay = mutable_appearance(bodypart_accessory.icon, layer = -layer)
				if(bodypart_accessory.gender_specific)
					inner_accessory_overlay.icon_state = "[g]_[key]inner_[bodypart_accessory.icon_state]_[layertext]"
				else
					inner_accessory_overlay.icon_state = "m_[key]inner_[bodypart_accessory.icon_state]_[layertext]"

				if(bodypart_accessory.center)
					inner_accessory_overlay = center_image(inner_accessory_overlay, bodypart_accessory.dimension_x, bodypart_accessory.dimension_y)

				standing += inner_accessory_overlay

			//Here's EXTRA parts of accessories which I should get rid of sometime TODO i guess
			if(bodypart_accessory.extra) //apply the extra overlay, if there is one
				var/mutable_appearance/extra_accessory_overlay = mutable_appearance(bodypart_accessory.icon, layer = -layer)
				if(bodypart_accessory.gender_specific)
					extra_accessory_overlay.icon_state = "[g]_[key]_extra_[bodypart_accessory.icon_state]_[layertext]"
				else
					extra_accessory_overlay.icon_state = "m_[key]_extra_[bodypart_accessory.icon_state]_[layertext]"
				if(bodypart_accessory.center)
					extra_accessory_overlay = center_image(extra_accessory_overlay, bodypart_accessory.dimension_x, bodypart_accessory.dimension_y)


				switch(bodypart_accessory.extra_color_src) //change the color of the extra overlay
					if(MUTCOLORS)
						if(fixed_mut_color)
							extra_accessory_overlay.color = fixed_mut_color
						else
							extra_accessory_overlay.color = owner.dna.features["mcolor"]
					if(MUTCOLORS2)
						extra_accessory_overlay.color = owner.dna.features["mcolor2"]
					if(MUTCOLORS3)
						extra_accessory_overlay.color = owner.dna.features["mcolor3"]
					if(HAIR)
						if(hair_color == "mutcolor")
							extra_accessory_overlay.color = owner.dna.features["mcolor3"]
						else
							extra_accessory_overlay.color = owner.hair_color
					if(FACEHAIR)
						extra_accessory_overlay.color = owner.facial_hair_color
					if(EYECOLOR)
						extra_accessory_overlay.color = owner.eye_color_left

				standing += extra_accessory_overlay

			if(bodypart_accessory.extra2) //apply the extra overlay, if there is one
				var/mutable_appearance/extra2_accessory_overlay = mutable_appearance(bodypart_accessory.icon, layer = -layer)
				if(bodypart_accessory.gender_specific)
					extra2_accessory_overlay.icon_state = "[g]_[key]_extra2_[bodypart_accessory.icon_state]_[layertext]"
				else
					extra2_accessory_overlay.icon_state = "m_[key]_extra2_[bodypart_accessory.icon_state]_[layertext]"
				if(bodypart_accessory.center)
					extra2_accessory_overlay = center_image(extra2_accessory_overlay, bodypart_accessory.dimension_x, bodypart_accessory.dimension_y)

				switch(bodypart_accessory.extra2_color_src) //change the color of the extra overlay
					if(MUTCOLORS)
						if(fixed_mut_color)
							extra2_accessory_overlay.color = fixed_mut_color
						else
							extra2_accessory_overlay.color = owner.dna.features["mcolor"]
					if(MUTCOLORS2)
						extra2_accessory_overlay.color = owner.dna.features["mcolor2"]
					if(MUTCOLORS3)
						extra2_accessory_overlay.color = owner.dna.features["mcolor3"]
					if(HAIR)
						if(hair_color == "mutcolor3")
							extra2_accessory_overlay.color = owner.dna.features["mcolor"]
						else
							extra2_accessory_overlay.color = owner.hair_color

				standing += extra2_accessory_overlay
			if (specific_alpha != 255 && !override_color)
				for (var/ov in standing)
					var/image/overlay = ov
					if (!istype(overlay.color,/list)) //check for a list because setting the alpha of the matrix colors breaks the color (the matrix alpha is set above inside the matrix)
						overlay.alpha = specific_alpha

			owner.overlays_standing[layer] += standing
			standing = list()

	owner.apply_overlay(BODY_BEHIND_LAYER)
	owner.apply_overlay(BODY_ADJ_LAYER)
	owner.apply_overlay(BODY_FRONT_LAYER)
	owner.apply_overlay(BODY_FRONT_UNDER_CLOTHES)
	owner.apply_overlay(ABOVE_BODY_FRONT_HEAD_LAYER)

/datum/species
	///What accessories can a species have aswell as their default accessory of such type e.g. "frills" = "Aquatic". Default accessory colors is dictated by the accessory properties and mutcolors of the specie
	var/list/default_mutant_bodyparts = list()
	var/list/genitals_list = list(ORGAN_SLOT_VAGINA, ORGAN_SLOT_WOMB, ORGAN_SLOT_TESTICLES, ORGAN_SLOT_BREASTS, ORGAN_SLOT_ANUS, ORGAN_SLOT_PENIS)

/datum/species/New()
	. = ..()
	if(can_have_genitals)
		for(var/genital in genitals_list)
			default_mutant_bodyparts[genital] = "None"

/datum/species/dullahan
	mutant_bodyparts = list()

/datum/species/human/felinid
	mutant_bodyparts = list()
	default_mutant_bodyparts = list("tail" = "Cat", "ears" = "Cat")

/datum/species/human
	mutant_bodyparts = list()
	default_mutant_bodyparts = list("ears" = "None", "tail" = "None", "wings" = "None")

/datum/species/mush
	mutant_bodyparts = list()

/datum/species/vampire
	mutant_bodyparts = list()

/datum/species/plasmaman
	mutant_bodyparts = list()
	can_have_genitals = FALSE
	can_augment = FALSE

/datum/species/ethereal
	mutant_bodyparts = list()
	can_have_genitals = FALSE
	can_augment = FALSE

/datum/species/pod
	name = "Primal Podperson"
	always_customizable = TRUE

/datum/species/randomize_features(mob/living/carbon/human/human_mob)
	return

/datum/species/proc/get_random_mutant_bodyparts(list/features) //Needs features to base the colour off of
	var/list/mutantpart_list = list()
	var/list/bodyparts_to_add = default_mutant_bodyparts.Copy()
	if(CONFIG_GET(flag/disable_erp_preferences))
		for(var/genital in genitals_list)
			bodyparts_to_add.Remove(genital)
	for(var/key in bodyparts_to_add)
		var/datum/sprite_accessory/SP
		if(bodyparts_to_add[key] == ACC_RANDOM)
			SP = random_accessory_of_key_for_species(key, src)
		else
			SP = GLOB.sprite_accessories[key][bodyparts_to_add[key]]
			if(!SP)
				CRASH("Cant find accessory of [key] key, [bodyparts_to_add[key]] name, for species [id]")
		var/list/color_list = SP.get_default_color(features, src)
		var/list/final_list = list()
		final_list[MUTANT_INDEX_NAME] = SP.name
		final_list[MUTANT_INDEX_COLOR_LIST] = color_list
		mutantpart_list[key] = final_list

	return mutantpart_list

/datum/species/proc/get_random_body_markings(list/features) //Needs features to base the colour off of
	return list()

/datum/species/proc/handle_body(mob/living/carbon/human/species_human)
	species_human.remove_overlay(BODY_LAYER)
	var/height_offset = species_human.get_top_offset() // From high changed by varying limb height
	var/list/standing = list()

	var/obj/item/bodypart/head/HD = species_human.get_bodypart(BODY_ZONE_HEAD)

	if(HD && !(HAS_TRAIT(species_human, TRAIT_HUSK)))
		// lipstick
		if(species_human.lip_style && (LIPS in species_traits))
			var/mutable_appearance/lip_overlay = mutable_appearance('icons/mob/species/human/human_face.dmi', "lips_[species_human.lip_style]", -BODY_LAYER)
			lip_overlay.color = species_human.lip_color
			if(OFFSET_FACE in species_human.dna.species.offset_features)
				lip_overlay.pixel_x += species_human.dna.species.offset_features[OFFSET_FACE][1]
				lip_overlay.pixel_y += species_human.dna.species.offset_features[OFFSET_FACE][2]
			lip_overlay.pixel_y += height_offset
			standing += lip_overlay

		// eyes
		if(!(NOEYESPRITES in species_traits))
			var/obj/item/organ/internal/eyes/eye_organ = species_human.getorganslot(ORGAN_SLOT_EYES)
			var/mutable_appearance/no_eyeslay

			var/add_pixel_x = 0
			var/add_pixel_y = 0
			//cut any possible vis overlays
			if(length(body_vis_overlays))
				SSvis_overlays.remove_vis_overlay(species_human, body_vis_overlays)

			if(OFFSET_FACE in species_human.dna.species.offset_features)
				add_pixel_x = species_human.dna.species.offset_features[OFFSET_FACE][1]
				add_pixel_y = species_human.dna.species.offset_features[OFFSET_FACE][2]

			add_pixel_y += height_offset

			if(!eye_organ)
				no_eyeslay = mutable_appearance('icons/mob/species/human/human_face.dmi', "eyes_missing", -BODY_LAYER)
				no_eyeslay.pixel_x += add_pixel_x
				no_eyeslay.pixel_y += add_pixel_y
				standing += no_eyeslay
			else
				eye_organ.refresh(call_update = FALSE)

			if(!no_eyeslay)
				for(var/mutable_appearance/eye_overlay in eye_organ.generate_body_overlay(species_human))
					eye_overlay.pixel_y += height_offset
					standing += eye_overlay
					if(eye_organ.is_emissive)
						var/mutable_appearance/eye_emissive = emissive_appearance_copy(eye_overlay, species_human)
						eye_emissive.pixel_x += species_human.dna.species.offset_features[OFFSET_FACE][1]
						eye_emissive.pixel_y += species_human.dna.species.offset_features[OFFSET_FACE][2]
						standing += eye_emissive

		// blush
		if (HAS_TRAIT(species_human, TRAIT_BLUSHING)) // Caused by either the *blush emote or the "drunk" mood event
			var/mutable_appearance/blush_overlay = mutable_appearance('icons/mob/species/human/human_face.dmi', "blush", -BODY_ADJ_LAYER) //should appear behind the eyes
			blush_overlay.color = COLOR_BLUSH_PINK
			standing += blush_overlay

	//Underwear, Undershirts & Socks
	if(!(NO_UNDERWEAR in species_traits))
		if(species_human.underwear && !(species_human.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
			var/datum/sprite_accessory/underwear/underwear = GLOB.underwear_list[species_human.underwear]
			var/mutable_appearance/underwear_overlay
			if(underwear)
				var/icon_state = underwear.icon_state
				if(underwear.has_digitigrade && (bodytype & BODYTYPE_DIGITIGRADE))
					icon_state += "_d"
				underwear_overlay = mutable_appearance(underwear.icon, icon_state, -BODY_LAYER)
				if(!underwear.use_static)
					underwear_overlay.color = species_human.underwear_color
				standing += underwear_overlay

		if(species_human.undershirt && !(species_human.underwear_visibility & UNDERWEAR_HIDE_SHIRT))
			var/datum/sprite_accessory/undershirt/undershirt = GLOB.undershirt_list[species_human.undershirt]
			if(undershirt)
				var/mutable_appearance/undershirt_overlay
				if(species_human.dna.species.sexes && species_human.gender == FEMALE)
					undershirt_overlay = wear_female_version(undershirt.icon_state, undershirt.icon, BODY_LAYER)
				else
					undershirt_overlay = mutable_appearance(undershirt.icon, undershirt.icon_state, -BODY_LAYER)
				if(!undershirt.use_static)
					undershirt_overlay.color = species_human.undershirt_color
				standing += undershirt_overlay

		if(species_human.socks && species_human.num_legs >= 2 && !(mutant_bodyparts["taur"]) && !(species_human.underwear_visibility & UNDERWEAR_HIDE_SOCKS))
			var/datum/sprite_accessory/socks/socks = GLOB.socks_list[species_human.socks]
			if(socks)
				var/mutable_appearance/socks_overlay
				var/icon_state = socks.icon_state
				if((bodytype & BODYTYPE_DIGITIGRADE))
					icon_state += "_d"
				socks_overlay = mutable_appearance(socks.icon, icon_state, -BODY_LAYER)
				if(!socks.use_static)
					socks_overlay.color = species_human.socks_color
				standing += socks_overlay

	if(standing.len)
		species_human.overlays_standing[BODY_LAYER] = standing

	species_human.apply_overlay(BODY_LAYER)
	handle_mutant_bodyparts(species_human)

//I wag in death
/datum/species/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()

/*
*	TAIL WAGGING
*/

/datum/species/proc/can_wag_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/obj/item/organ/external/tail/T = H.getorganslot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(!T)
		return FALSE
	if(T.can_wag)
		return TRUE
	return FALSE

/datum/species/proc/is_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/obj/item/organ/external/tail/T = H.getorganslot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(!T)
		return FALSE
	return T.wagging

/datum/species/proc/start_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return
	var/obj/item/organ/external/tail/T = H.getorganslot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(!T)
		return FALSE
	T.wagging = TRUE
	H.update_body()

/datum/species/proc/stop_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return
	var/obj/item/organ/external/tail/T = H.getorganslot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(!T)
		return
	T.wagging = FALSE
	H.update_body()

/datum/species/regenerate_organs(mob/living/carbon/C, datum/species/old_species, replace_current = TRUE, list/excluded_zones, visual_only = FALSE)
	. = ..()
	var/robot_organs = (ROBOTIC_DNA_ORGANS in C.dna.species.species_traits)
	for(var/key in C.dna.mutant_bodyparts)
		if(!islist(C.dna.mutant_bodyparts[key]) || !(C.dna.mutant_bodyparts[key][MUTANT_INDEX_NAME] in GLOB.sprite_accessories[key]))
			continue
		var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][C.dna.mutant_bodyparts[key][MUTANT_INDEX_NAME]]
		if(SA?.factual && SA.organ_type)
			var/obj/item/organ/path = new SA.organ_type
			path.sprite_accessory_flags = SA.flags_for_organ
			path.relevant_layers = SA.relevent_layers
			if(robot_organs)
				path.status = ORGAN_ROBOTIC
				path.organ_flags |= ORGAN_SYNTHETIC
			var/obj/item/organ/oldorgan = C.getorganslot(path.slot)
			if(oldorgan)
				oldorgan.Remove(C,TRUE)
				QDEL_NULL(oldorgan)
			path.build_from_dna(C.dna, key)
			path.Insert(C, 0, FALSE)


/datum/species/proc/spec_revival(mob/living/carbon/human/H)
	return

/// Gets a list of all customizable races on roundstart.
/proc/get_customizable_races()
	RETURN_TYPE(/list)

	if (!GLOB.customizable_races.len)
		GLOB.customizable_races = generate_customizable_races()

	return GLOB.customizable_races

/**
 * Generates races available to choose in character setup at roundstart, yet not playable on the station.
 *
 * This proc generates which species are available to pick from in character setup.
 */
/proc/generate_customizable_races()
	var/list/customizable_races = list()

	for(var/species_type in subtypesof(/datum/species))
		var/datum/species/species = new species_type
		if(species.always_customizable)
			customizable_races += species.id
			qdel(species)

	return customizable_races
