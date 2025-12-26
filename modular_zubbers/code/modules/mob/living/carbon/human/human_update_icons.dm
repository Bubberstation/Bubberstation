/mob/living/carbon/human/update_underwear()
	remove_overlay(BODY_LAYER)
	if(HAS_TRAIT(src, TRAIT_INVISIBLE_MAN))
		return

	var/list/standing = list()

	if(!HAS_TRAIT(src, TRAIT_NO_UNDERWEAR))
		// underwear
		if(underwear && !(underwear_visibility & UNDERWEAR_HIDE_UNDIES))
			var/datum/sprite_accessory/underwear/underwear_accessory = SSaccessories.underwear_list[underwear]
			var/mutable_appearance/underwear_overlay
			var/female_sprite_flags = FEMALE_UNIFORM_FULL // the default gender shaping
			if(underwear_accessory)
				var/underwear_icon_state = underwear_accessory.icon_state
				if(underwear_accessory.has_digitigrade && (bodyshape & BODYSHAPE_DIGITIGRADE))
					underwear_icon_state += "_d"
					female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY // for digi gender shaping
				if(dna.species.sexes && physique == FEMALE && underwear_accessory.gender == MALE)
					underwear_overlay = mutable_appearance(wear_female_version(underwear_icon_state, underwear_accessory.icon, female_sprite_flags), layer = -BODY_LAYER)
				else
					underwear_overlay = mutable_appearance(underwear_accessory.icon, underwear_icon_state, -BODY_LAYER)
				if(!underwear_accessory.use_static)
					underwear_overlay.color = underwear_color
				standing += underwear_overlay

		// bra
		if(bra && !(underwear_visibility & UNDERWEAR_HIDE_BRA))
			var/datum/sprite_accessory/bra/bra_accessory = SSaccessories.bra_list[bra]
			if(bra_accessory)
				var/mutable_appearance/bra_overlay = mutable_appearance(bra_accessory.icon, bra_accessory.icon_state, -BODY_LAYER)
				if(!bra_accessory.use_static)
					bra_overlay.color = bra_color
				standing += bra_overlay

		// undershirt
		if(undershirt && !(underwear_visibility & UNDERWEAR_HIDE_SHIRT))
			var/datum/sprite_accessory/undershirt/undershirt_accessory = SSaccessories.undershirt_list[undershirt]
			if(undershirt_accessory)
				var/mutable_appearance/undershirt_overlay
				if(dna.species.sexes && physique == FEMALE)
					undershirt_overlay = mutable_appearance(wear_female_version(undershirt_accessory.icon_state, undershirt_accessory.icon), layer = -BODY_LAYER)
				else
					undershirt_overlay = mutable_appearance(undershirt_accessory.icon, undershirt_accessory.icon_state, -BODY_LAYER)
				if(!undershirt_accessory.use_static)
					undershirt_overlay.color = undershirt_color
				standing += undershirt_overlay

		// socks
		if(socks && num_legs >= 2 && !dna.species.mutant_bodyparts[FEATURE_TAUR] && !(underwear_visibility & UNDERWEAR_HIDE_SOCKS))
			var/datum/sprite_accessory/socks/socks_accessory = SSaccessories.socks_list[socks]
			if(socks_accessory)
				var/mutable_appearance/socks_overlay
				var/socks_icon_state = socks_accessory.icon_state
				if(bodyshape & BODYSHAPE_DIGITIGRADE)
					socks_icon_state += "_d"
				socks_overlay = mutable_appearance(socks_accessory.icon, socks_icon_state, -BODY_LAYER)
				if(!socks_accessory.use_static)
					socks_overlay.color = socks_color
				standing += socks_overlay

	if(standing.len)
		overlays_standing[BODY_LAYER] = standing

	apply_overlay(BODY_LAYER)
