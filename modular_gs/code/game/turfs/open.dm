// /turf/open
// 	plane = FLOOR_PLANE
// 	var/slowdown = 0 //negative for faster, positive for slower

// 	var/postdig_icon_change = FALSE
// 	var/postdig_icon
// 	var/wet

// 	var/footstep = null
// 	var/barefootstep = null
// 	var/clawfootstep = null
// 	var/heavyfootstep = null

// leaving this helper for remembering vars - Sono

///////////////////////////////// GS13 OPEN TURFS ///////////////////////////////

/turf/open/indestructible/chocolate
	name = "chocolate floor"
	desc = "A rather tasty floor, hopefully it does not ruin your shoes."
	icon = 'Gainstation13/icons/turf/floor_candy.dmi'
	icon_state = "choclit_2"


/turf/open/indestructible/bubblegum
	name = "bubblegum floor"
	desc = "A rather tasty floor, hopefully it does not ruin your shoes."
	icon = 'Gainstation13/icons/turf/floor_candy.dmi'
	icon_state = "floor_pinkgum"

/turf/open/candyfloor
	name = "candy grass"
	desc = "This weird grass smells of cinnamon and liquorice."
	icon = 'Gainstation13/icons/turf/floor_candy.dmi'
	icon_state = "candyfloor"

/turf/open/chocolateriver
	gender = PLURAL
	name = "liquid chocolate"
	desc = "This is probably used for some kind of huge fountain."
	icon = 'Gainstation13/icons/turf/floor_candy.dmi'
	icon_state = "chocwater"
	slowdown = 1
	bullet_sizzle = TRUE
	bullet_bounce_sound = null //needs a splashing sound one day.

	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER

/turf/open/floor/carpet/gato //GS13
	icon = 'GainStation13/icons/turf/carpet_gato.dmi'
	floor_tile = /obj/item/stack/tile/carpet/gato
	canSmoothWith = list(/turf/open/floor/carpet/gato)

/obj/item/stack/tile/carpet/gato //GS13
	icon = 'GainStation13/icons/obj/tiles.dmi'
	name = "gato-themed carpet"
	icon_state = "tile-carpet-gato"
	turf_type = /turf/open/floor/carpet/gato
