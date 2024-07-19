/datum/species/New()
	var/list/extra_offset_features = list(
		OFFSET_UNDERWEAR = list(0,0),
		OFFSET_SOCKS = list(0,0),
		OFFSET_SHIRT = list(0,0),
		OFFSET_WRISTS = list(0,0)
	)
	LAZYADD(offset_features, extra_offset_features)
	. = ..()
