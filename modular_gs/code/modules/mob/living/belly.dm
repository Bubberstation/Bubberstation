/obj/item/organ/genital/external/belly //I know, I know a belly aint a genital. but it is in the sake of code.
	name 					= "belly"
	desc 					= "You see a belly on their midsection."
	icon_state 				= "belly"
	icon 					= 'hyperstation/icons/obj/genitals/belly.dmi'
	zone 					= BODY_ZONE_CHEST
	slot 					= ORGAN_SLOT_BELLY
	w_class 				= 3
	size 					= 0
	var/max_size			= 0
	shape 					= DEF_BELLY_SHAPE
	var/statuscheck			= FALSE
	genital_flags 			= UPDATE_OWNER_APPEARANCE
	masturbation_verb 		= "massage"
	var/sent_full_message	= TRUE //defaults to 1 since they're full to start
	var/inflatable			= FALSE //For inflation connoisseurs
	var/size_cached			= 0
	var/prev_size			= 0
	layer_index = BELLY_LAYER_INDEX

/obj/item/organ/genital/external/belly/modify_size(modifier, min = BELLY_SIZE_DEF, max = BELLY_SIZE_MAX)
	var/new_value = clamp(size_cached + modifier, starting_size, max)
	if(new_value == size_cached)
		return
	prev_size = size_cached
	size_cached = new_value
	size = round(size_cached)
	update()
	..()

/obj/item/organ/genital/external/belly/update_appearance()
	//GS13 - Port Stuffed states
	// Default settings
	var/datum/sprite_accessory/S = GLOB.belly_shapes_list[shape] //GS13 - get belly shape
	var/icon_shape_state = S ? S.icon_state : "belly" //fallback to default belly in case we cant find a shape
	icon_state = "belly_[icon_shape_state]_[size]"
	var/icon_shape = S ? S.icon : "hyperstation/icons/obj/genitals/belly.dmi" //fallback to default belly in case we cant find a shape
	icon = icon_shape

	// Change belly sprite and size based on current fullness
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

	if(owner)
		if(owner.dna.species.use_skintones && owner.dna.features["genitals_use_skintone"])
			if(ishuman(owner)) // Check before recasting type, although someone fucked up if you're not human AND have use_skintones somehow...
				var/mob/living/carbon/human/H = owner // only human mobs have skin_tone, which we need.
				color = SKINTONE2HEX(H.skin_tone)
				if(!H.dna.skin_tone_override)
					icon_state += "_s"
		else
			color = "#[owner.dna.features["belly_color"]]"

/obj/item/organ/genital/external/belly/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	if(D.species.use_skintones && D.features["genitals_use_skintone"])
		color = SKINTONE2HEX(H.skin_tone)
	else
		color = "#[D.features["belly_color"]]"
	size = D.features["belly_size"]
	max_size = D.features["max_belly_size"]
	starting_size = D.features["belly_size"]
	shape = D.features["belly_shape"]
	inflatable = D.features["inflatable_belly"]
	toggle_visibility(D.features["belly_visibility"], FALSE)


