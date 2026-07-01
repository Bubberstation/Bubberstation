/datum/reagent/fuel/oil/smithing
	name = "Smithing Oil"
	description = "A specialized type of oil with various blacksmithing applications, from quenching hot metal, to enhancing the hardness of blades and armor. Has a very high burning point, unless it's exposed to fire..."
	color = "#2D2D2D"
	taste_description = "oil"
	burning_temperature = 6000
	burning_volume = 0.05
	chemical_flags = NONE
	addiction_types = null
	default_container = /obj/effect/decal/cleanable/blood/splatter/oil

/obj/item/reagent_containers/cup/jerrycan/smithing_oil
	name = "Jarnsmiour Blacksteel Foundation-brand smithing oil"
	cap_type = "red"
	desc = "Jarnsmiour Blacksteel's finest smithing oil; a favored ingredient of the intergalactic spacesmith's union, thanks to its ability to enhance the inherrent capabilities of nearly every form of metal."
	list_reagents = list(/datum/reagent/fuel/oil/smithing = 200)
