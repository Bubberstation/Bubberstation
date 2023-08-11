#define SPACE_TEXT num2text(rand(1,25))

/turf/closed/wall/space
	icon_state = "0"
	icon = 'modular_zubbers/icons/space/space.dmi'

/turf/closed/wall/space/Initialize(mapload)
	. = ..()
	icon_state = SPACE_TEXT

/turf/open/floor/holofloor/space/Initialize(mapload)
	icon = 'modular_zubbers/icons/space/space.dmi'
	icon_state = SPACE_TEXT
	. = ..()

/turf/open/space/
	icon = 'modular_zubbers/icons/space/space.dmi'

/turf/open/space/Initialize(mapload)
	. = ..()
	icon_state = SPACE_TEXT

#undef SPACE_TEXT
