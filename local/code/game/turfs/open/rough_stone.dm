/turf/open/misc/rough_stone
	gender = PLURAL
	name = "rough stone"
	desc = "Stone. Perhaps also rock; if you ask nicely."
	icon = 'local/icons/turf/floors/rough_stone.dmi'
	icon_state = "roughstone0"
	baseturfs = /turf/open/misc/rough_stone
	planetary_atmos = TRUE
	tiled_dirt = FALSE
	rust_resistance = RUST_RESISTANCE_ORGANIC

// Do not use the basetype on any maps that aren't jungles & ESPECIALLY not inside
/turf/open/misc/rough_stone/station
	name = "rough stone flooring"
	desc = "For that \"I got kidnapped by a band of kobolds, but my dog is a busdriver working in Arizona!\" aesthetic."
	baseturfs = /turf/open/floor/plating
	planetary_atmos = FALSE

/turf/open/misc/rough_stone/Initialize(mapload)
	. = ..()
	if(prob(15))
		icon_state = "roughstone[rand(0, 3)]"
