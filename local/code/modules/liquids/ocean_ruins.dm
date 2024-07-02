// Hey! Listen! Update \config\oceanruinblacklist.txt with your new ruins!

/datum/map_template/ruin/ocean
	ruin_type = ZTRAIT_OCEAN_RUINS
	prefix = "_maps/RandomRuins/OceanRuins/"
	cost = 1
	allow_duplicates =  FALSE

/datum/map_template/ruin/ocean/fissure
	name = "Ocean-Ruin Thermal Fissure"
	id = "ocean-fissure"
	description = "A tear in the ocean."
	suffix = "ocean_fissure.dmm"
	allow_duplicates = TRUE

/datum/map_template/ruin/ocean/fissure/diag
	name = "Ocean-Ruin Horizontal Thermal Fissure"
	id = "ocean-fissure-diag"
	description = "A horizontal tear in the ocean."
	suffix = "ocean_fissure_diag.dmm"
	allow_duplicates = TRUE

/datum/map_template/ruin/ocean/bubble_rally
	name = "Ocean-Ruin Bubble Rally"
	id = "ocean-bubble-rally"
	description = "As it turns out; there IS a market for bubble enthusiasts. Seems these ones bit off more they could chew."
	suffix = "ocean_bubble_rally.dmm"

/datum/map_template/ruin/ocean/skeleton
	name = "Ocean-Ruin Skeleton"
	id = "ocean-skeleton"
	description = "Sleepin' with the fishies..."
	suffix = "ocean_skeleton.dmm"

//Some copypastas ahead, but it's how our ruins spawning system works

/datum/map_template/ruin/trench
	ruin_type = ZTRAIT_TRENCH_RUINS
	prefix = "_maps/RandomRuins/OceanRuins/"

/datum/map_template/ruin/trench/biolab_research
	name = "Trench-Ruin Biolab Research Station"
	id = "trench-biolab"
	description = "Biolab in the ocean."
	suffix = "trench_bioweapon_lab.dmm"
	cost = 3
	allow_duplicates = FALSE

/datum/map_template/ruin/trench/fissure
	name = "Trench-Ruin Thermal Fissure"
	id = /datum/map_template/ruin/ocean/fissure::id
	description = /datum/map_template/ruin/ocean/fissure::description
	suffix = /datum/map_template/ruin/ocean/fissure::suffix
	cost = /datum/map_template/ruin/ocean/fissure::cost

/datum/map_template/ruin/trench/fissure/diag
	name = "Trench-Ruin Horizontal Thermal Fissure"
	id = /datum/map_template/ruin/ocean/fissure/diag::id
	description = /datum/map_template/ruin/ocean/fissure/diag::description
	suffix = /datum/map_template/ruin/ocean/fissure/diag::suffix
