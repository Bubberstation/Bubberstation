/// tl;dr, /tg/ has jungle dirt apply a goofy slowdown that's only apropriate usecase is in one (1) lavaland ruin
/// every time rimpoint has been picked on a populated round someone takes it upon themselves to KILL all the dirt tiles because of this,
/// and IMO that ruins the aesthetic over something small and stupid. To keep their speed consistent with grass; we're overriding to
/// match grass' slowdown directly, to futureproof just slightly.
/// We're also setting the baseturfs to be self-referential as a futureproofing thingamajig. Overrides what /tg/ made them in chasms.

/turf/open/misc/dirt
	icon = EFFIGY_TURFS_ICON_FILE
	baseturfs = /turf/open/misc/dirt

/turf/open/misc/dirt/jungle
	baseturfs = /turf/open/misc/dirt/jungle
	slowdown = /turf/open/misc/grass/jungle::slowdown

/turf/open/misc/dirt/jungle/dark
	baseturfs = /turf/open/misc/dirt/jungle/dark

/turf/open/misc/dirt/dark
	baseturfs = /turf/open/misc/dirt/dark

/// this one is even a fuckin' dupe of jungle/dark but lol
/turf/open/misc/dirt/dark/jungle
	baseturfs = /turf/open/misc/dirt/dark/jungle
	slowdown = /turf/open/misc/grass/jungle::slowdown

/turf/open/misc/dirt/jungle/wasteland
	icon = EFFIGY_TURFS_ICON_FILE
	baseturfs = /turf/open/misc/dirt/jungle/wasteland
