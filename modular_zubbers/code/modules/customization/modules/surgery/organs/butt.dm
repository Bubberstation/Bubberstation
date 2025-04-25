/obj/item/organ/genital/butt
	name = "butt"
	desc = "You see a pair of asscheeks."
	icon = 'modular_zubbers/icons/obj/medical/lewdorgan/butt.dmi'
	icon_state = "butt"
	slot = ORGAN_SLOT_BUTT
	zone = BODY_ZONE_PRECISE_GROIN
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/butt
	aroused = AROUSAL_CANT

	mutantpart_key = ORGAN_SLOT_BUTT
	mutantpart_info = list(MUTANT_INDEX_NAME = "Pair", MUTANT_INDEX_COLOR_LIST = list("#FFEEBB"))

/obj/item/organ/genital/butt/get_description_string(datum/sprite_accessory/genital/gas)
	var/size_name
	switch(round(genital_size))
		if(1)
			size_name = "average"
		if(2)
			size_name = "sizable"
		if(3)
			size_name = "squeezable"
		if(4)
			size_name = "hefty"
		if(5)
			size_name = pick("massive", "very generous")
		if(6)
			size_name = pick("gigantic", "big bubbly", "enormous")
		if(7)
			size_name = pick("unfathomably large", "extreme")
		if(8)
			size_name = pick("absolute dumptruck", "humongous", "dummy thick")
		else
			size_name = "nonexistent"

	return "You see a [LOWER_TEXT(gas.icon_state)] of [size_name] asscheeks."

/obj/item/organ/genital/butt/set_size(size)
	. = ..()
	spawn(0) //set_size is called by build_from_dna.. which executes before Insert assigns owner. This gets around that
		var/obj/item/organ/genital/anus/anus = owner?.get_organ_slot(ORGAN_SLOT_ANUS) //sometimes
		if(!anus)
			return

		anus.set_size(size)

/obj/item/organ/genital/butt/get_sprite_size_string()
	. = "[genital_type]_[floor(genital_size)]"
	if(uses_skintones)
		. += "_s"

/obj/item/organ/genital/butt/build_from_dna(datum/dna/DNA, associated_key)
	uses_skin_color = DNA.features["butt_uses_skincolor"]
	set_size(DNA.features["butt_size"])

	return ..()

/obj/item/organ/genital/butt/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
	if(DNA.features["butt_uses_skintones"])
		uses_skintones = accessory.has_skintone_shading
	return ..()

/datum/bodypart_overlay/mutant/genital/butt
	feature_key = ORGAN_SLOT_BUTT
	layers = EXTERNAL_ADJACENT | EXTERNAL_FRONT

/datum/bodypart_overlay/mutant/genital/butt/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_BUTT]
