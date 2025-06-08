/obj/item/organ/genital/taur_belly //I know, I know a this is just a copy of belly.dm code.
	name 					= "taur belly"
	desc 					= "You see a belly on their taur body."
	icon_state 				= "belly"
	icon 					= 'modular_gs/icons/obj/genitals/taur_belly/taur_belly_drake.dmi' //drake belly as placeholder
	zone 					= BODY_ZONE_CHEST // ugh... I think this is a target on a health doll
	slot 					= ORGAN_SLOT_TAUR_BELLY
	w_class 				= 3
	size 					= 0
	var/max_size			= 0
	shape 					= TAUR_BELLY_SHAPE_DEF//"taur_belly"
	var/statuscheck			= FALSE
	genital_flags 			= UPDATE_OWNER_APPEARANCE|GENITAL_CAN_TAUR
	masturbation_verb 		= "massage"
	var/sent_full_message	= TRUE //defaults to 1 since they're full to start
	var/inflatable			= FALSE
	var/size_cached			= 0
	var/prev_size			= 0
	layer_index				= TAUR_BELLY_LAYER_INDEX


/obj/item/organ/genital/taur_belly/modify_size(modifier, min = TAUR_BELLY_SIZE_DEF, max = TAUR_BELLY_SIZE_MAX)
	var/new_value = clamp(size_cached + modifier, starting_size, max)
	if(new_value == size_cached)
		return
	prev_size = size_cached
	size_cached = new_value
	size = round(size_cached)
	update()
	..()

/obj/item/organ/genital/taur_belly/update_appearance()
	//GS13
	// Default settings
	var/datum/sprite_accessory/S = GLOB.taur_belly_shapes_list[shape] //GS13 - get belly shape
	var/icon_shape_state = S ? S.icon_state : "belly"
	icon_state = "[icon_shape_state]_[size]"
	//var/icon_shape = S ? S.icon : "hyperstation/icons/obj/genitals/belly.dmi" //fallback to default belly in case we cant find a shape
	//icon = icon_shape

//  Fullnes not implemented yet
/*
	switch(owner.fullness)
		if(FULLNESS_LEVEL_BLOATED to FULLNESS_LEVEL_BEEG)
			icon = 'hyperstation/icons/obj/genitals/belly_round.dmi' //We use round belly to represent stuffedness
			icon_state = "belly_round_[size]"
		if(FULLNESS_LEVEL_BEEG to FULLNESS_LEVEL_NOMOREPLZ)
			icon = 'hyperstation/icons/obj/genitals/belly_round.dmi'
			icon_state = "belly_round_[size+1]"
		if(FULLNESS_LEVEL_NOMOREPLZ to INFINITY)
			icon = 'hyperstation/icons/obj/genitals/belly_round.dmi'
			icon_state = "belly_round_[size+2]"
*/
	if(owner)
		if(owner.dna.species.use_skintones && owner.dna.features["genitals_use_skintone"])
			if(ishuman(owner)) // Check before recasting type, although someone fucked up if you're not human AND have use_skintones somehow...
				var/mob/living/carbon/human/H = owner // only human mobs have skin_tone, which we need.
				color = SKINTONE2HEX(H.skin_tone)
				if(!H.dna.skin_tone_override)
					icon_state += "_s"
		else
			color = "#[owner.dna.features["taur_belly_color"]]"

/obj/item/organ/genital/taur_belly/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	if(D.species.use_skintones && D.features["genitals_use_skintone"])
		color = SKINTONE2HEX(H.skin_tone)
	else
		color = "#[D.features["taur_belly_color"]]"
	size = D.features["taur_belly_size"]
	max_size = D.features["max_taur_belly_size"]
	starting_size = D.features["belly_size"]
	shape = D.features["taur_belly_shape"]
	inflatable = D.features["taur_inflatable_belly"]
	toggle_visibility(D.features["taur_belly_visibility"], FALSE)


