// Hey! Listen! Update \config\jungleruinblacklist.txt with your new ruins!
// has_ceiling = TRUE for any ruin without any external tiles.
// If your ruin has external tiles, you can't have a ceiling atm. A mapping helper for this'll be in soon:tm:.

/// Surface ///
/datum/map_template/ruin/jungle
	ruin_type = ZTRAIT_JUNGLE_RUINS
	prefix = "_maps/RandomRuins/JungleRuins/"
	default_area = /area/taeloth/unexplored
	cost = 1
	allow_duplicates = FALSE

/datum/map_template/ruin/jungle/luna
	id = "surface_luna"
	suffix = "surface_luna.dmm"
	name = "JungleSurface-Ruin LUNA"
	description = "The dream of a dead dreamer."
	cost = 0
	always_place = TRUE

/datum/map_template/ruin/jungle/deadorgone
	id = "surface_deadorgone"
	suffix = "surface_deadorgone.dmm"
	name = "JungleSurface-Ruin Dead Or Gone"
	description = "Everyone is dead or gone. The story is over."

/datum/map_template/ruin/jungle/trilogy
	id = "surface_trilogy"
	suffix = "surface_trilogy.dmm"
	name = "JungleSurface-Ruin Trilogy"
	description = "They have to sell out at some point, right? If the sequel does well, raise them a third, make a box set... bam. Millions."

/datum/map_template/ruin/jungle/bloodzone
	id = "surface_bloodzone"
	suffix = "surface_bloodzone.dmm"
	name = "JungleSurface-Ruin Bloodworking Site"
	description = "For some asinine reason, a lot of blood donor clinics closed when cloning was outlawed. This is one of those."

/datum/map_template/ruin/jungle/fountain
	name = "JungleSurface-Ruin Fountain Hall"
	id = "jungle_fountain"
	description = "The fountain has a warning on the side. DANGER: May have undeclared side effects that only become obvious when implemented."
	prefix = "_maps/RandomRuins/AnywhereRuins/"
	suffix = "fountain_hall.dmm"

/// Caves ///

/datum/map_template/ruin/jungle_cave
	ruin_type = ZTRAIT_JUNGLE_CAVE_RUINS
	prefix = "_maps/RandomRuins/JungleRuins/"
	default_area = /area/taeloth/underground/unexplored
	cost = 1
	allow_duplicates = FALSE

/datum/map_template/ruin/jungle_cave/generator_right_here
	id = "caves_generator_right_here"
	suffix = "caves_generator_right_here.dmm"
	name = "JungleCave-Ruin Generator, Right Here!"
	description = "I knew transferring to power recovery was a fuckin' bad idea. I'm going back to scouting, on god!"

/datum/map_template/ruin/jungle_cave/hut
	id = "caves_hut"
	suffix = "caves_hut.dmm"
	name = "JungleCave-Ruin Underground Hut"
	description = "Maybe it'll have a neat trinket or accessory?"

/datum/map_template/ruin/jungle_cave/trilogy_research
	id = "caves_trilogy_research"
	suffix = "caves_trilogy_research.dmm"
	name = "JungleCave-Ruin Trilogy (Research Department)"
	description = "We tried making millions; didn't quite work out. Something else had better marketshare."
