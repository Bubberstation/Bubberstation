/turf/open/floor/glass
	var/scrape_below = FALSE

/turf/open/floor/glass/LateInitialize(mapload)
	. = ..()
	if(scrape_below)
		//Stolen from icebox code.
		var/turf/T = GET_TURF_BELOW(src)
		if(ismineralturf(T))
			T.ScrapeAway(1,CHANGETURF_INHERIT_AIR)

/turf/open/floor/glass/scrape_below
	scrape_below = TRUE

/turf/open/floor/glass/reinforced/scrape_below
	scrape_below = TRUE

/turf/open/floor/glass/plasma/scrape_below
	scrape_below = TRUE

/turf/open/floor/glass/reinforced/plasma/scrape_below
	scrape_below = TRUE
