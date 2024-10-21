/obj/item/organ/external/genital/penis/get_sprite_size_string()
	if(aroused != AROUSAL_FULL && sheath != SHEATH_NONE)
		return ..()

	var/size_affix
	var/measured_size = max(floor(genital_size), 1)
	var/is_erect = !!aroused
	switch(measured_size)
		if(1 to 6)
			size_affix = "1"
		if(7 to 11)
			size_affix = "2"
		if(12 to 36)
			size_affix = "3"
		if(37 to 48)
			size_affix = "4"
		else
			size_affix = "5"

	. = "[genital_type]_[size_affix]_[is_erect]"
	if(uses_skintones)
		. += "_s"
