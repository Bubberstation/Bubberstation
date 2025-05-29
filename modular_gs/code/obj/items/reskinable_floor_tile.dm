/////////////////////
// Tile reskinning //
/////////////////////
// Q: What is this?
// A: A simple function to allow you to change what tiles you place with a stack of tiles.
// Q: Why do it this way?
// A: This allows players more freedom to do beautiful-looking builds. Having five types of titanium tile would be clunky as heck.
// Q: Great! Can I use this for all floors?
// A: Unfortunately, this does not work on subtypes of plasteel and instead we must change the icon_state of these turfs instead, as the icon_regular_floor var that "saves" what type of floor a plasteel subtype turf was so once repaired...
// ... it'll go back to the floor it was instead of grey (medical floors turn white even after crowbaring the tile and putting it back). This stops changing turf_type from working.

/obj/item/stack/tile/mineral/titanium/attack_self(mob/user)
	var/static/list/choices = list(
			"Titanium" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_shuttle"),
			"Yellow Titanium" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_shuttle_yellow"),
			"Blue Titanium" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_shuttle_blue"),
			"White Titanium" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_shuttle_white"),
			"Purple Titanium" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_shuttle_purple"),
			"Titanium Tile" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_shuttle_old"),
			"Yellow Titanium Tile" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_shuttle_old_yellow"),
			"Blue Titanium Tile" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_shuttle_old_blue"),
			"White Titanium Tile" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_shuttle_old_white"),
			"Purple Titanium Tile" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_shuttle_old_purple"),
		)
	var/choice = show_radial_menu(user, src, choices, radius = 48, require_near = TRUE)
	switch(choice)
		if("Titanium")
			turf_type = /turf/open/floor/mineral/titanium
			icon_state = "tile_shuttle"
			desc = "Sleek titanium tiles."
		if("Yellow Titanium")
			turf_type = /turf/open/floor/mineral/titanium/yellow
			icon_state = "tile_shuttle_yellow"
			desc = "Sleek yellow titanium tiles."
		if("Blue Titanium")
			turf_type = /turf/open/floor/mineral/titanium/blue
			icon_state = "tile_shuttle_blue"
			desc = "Sleek blue titanium tiles."
		if("White Titanium")
			turf_type = /turf/open/floor/mineral/titanium/white
			icon_state = "tile_shuttle_white"
			desc = "Sleek white titanium tiles."
		if("Purple Titanium")
			turf_type = /turf/open/floor/mineral/titanium/purple
			icon_state = "tile_shuttle_purple"
			desc = "Sleek purple titanium tiles."
		if("Titanium Tile")
			turf_type = /turf/open/floor/mineral/titanium/old
			icon_state = "tile_shuttle_old"
			desc = "Titanium floor tiles."
		if("Yellow Titanium Tile")
			turf_type = /turf/open/floor/mineral/titanium/old/yellow
			icon_state = "tile_shuttle_old_yellow"
			desc = "Yellow titanium floor tiles."
		if("Blue Titanium Tile")
			turf_type = /turf/open/floor/mineral/titanium/old/blue
			icon_state = "tile_shuttle_old_blue"
			desc = "Blue titanium floor tiles."
		if("White Titanium Tile")
			turf_type = /turf/open/floor/mineral/titanium/old/white
			icon_state = "tile_shuttle_old_white"
			desc = "White titanium floor tiles."
		if("Purple Titanium Tile")
			turf_type = /turf/open/floor/mineral/titanium/old/purple
			icon_state = "tile_shuttle_old_purple"
			desc = "Purple titanium floor tiles."

/obj/item/stack/tile/plasteel
	desc = "Metal tiles that can be placed on top of plating. Press Z or use these to change tiles."
	icon = 'GainStation13/icons/obj/tiles.dmi'
	var/tile_reskin_mode
	tile_reskin_mode = "plasteel"

/obj/item/stack/tile/plasteel/attack_self(mob/user)
	var/static/list/choices = list(
			"Plasteel" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_plasteel"),
			"White Plasteel" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_white"),
			"Dark Plasteel" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_dark"),
			"Chapel Flooring" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_chapel"),
			"Shower" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_shower"),
			"Freezer" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_freezer"),
			"Kitchen" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_kitchen"),
			"Grimy" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_grimy"),
			"Solar Panel" = image(icon = 'GainStation13/icons/obj/tiles.dmi', icon_state = "tile_solar"),
		)
	var/choice = show_radial_menu(user, src, choices, radius = 48, require_near = TRUE)
	switch(choice)
		if("Plasteel")
			turf_type = /turf/open/floor/plasteel
			icon_state = "tile_plasteel"
			desc = "Metal floor tiles."
			tile_reskin_mode = "plasteel"
		if("White Plasteel")
			turf_type = /turf/open/floor/plasteel/white
			icon_state = "tile_white"
			desc = "White metal floor tiles."
			tile_reskin_mode = "white plasteel"
		if("Dark Plasteel")
			turf_type = /turf/open/floor/plasteel/dark
			icon_state = "tile_dark"
			desc = "Dark metal floor tiles."
			tile_reskin_mode = "dark plasteel"
		if("Chapel Flooring")
			turf_type = /turf/open/floor/plasteel/chapel
			icon_state = "tile_chapel"
			desc = "Those very dark floor tiles you find in the chapel a lot."
			tile_reskin_mode = "chapel"
		if("Shower")
			turf_type = /turf/open/floor/plasteel/showroomfloor
			icon_state = "tile_shower"
			desc = "Tiles for showers, bathrooms and wetrooms."
			tile_reskin_mode = "shower"
		if("Freezer")
			turf_type = /turf/open/floor/plasteel/freezer
			icon_state = "tile_freezer"
			desc = "High-grip flooring for walk-in freezers and chillers."
			tile_reskin_mode = "freezer"
		if("Kitchen")
			turf_type = /turf/open/floor/plasteel/cafeteria
			icon_state = "tile_kitchen"
			desc = "Chequered pattern plasteel tiles."
			tile_reskin_mode = "kitchen"
		if("Grimy")
			turf_type = /turf/open/floor/plasteel/grimy
			icon_state = "tile_grimy"
			desc = "I'm sure it'll look nice somewhere?"
			tile_reskin_mode = "grimy"
		if("Solar Panel")
			turf_type = /turf/open/floor/plasteel/airless/solarpanel
			icon_state = "tile_solar"
			desc = "Flooring usually placed below solar panels. Using this indoors is an intergalactic fashion crime."
			tile_reskin_mode = "solar"

/turf/open/floor/plasteel/attackby(obj/item/reskinstack, mob/user, params)
	if(istype(reskinstack, /obj/item/stack/tile/plasteel))
		var/obj/item/stack/tile/plasteel/hitfloor = reskinstack
		switch(hitfloor.tile_reskin_mode)
			if("plasteel")
				icon_state = "floor"
				icon_regular_floor = "floor"
			if("white plasteel")
				icon_state = "white"
				icon_regular_floor = "white"
			if("dark plasteel")
				icon_state = "darkfull"
				icon_regular_floor = "darkfull"
			if("chapel")
				icon_state = "chapel_alt"
				icon_regular_floor = "chapel_alt"
			if("shower")
				icon_state = "showroomfloor"
				icon_regular_floor = "showroomfloor"
			if("freezer")
				icon_state = "freezerfloor"
				icon_regular_floor = "freezerfloor"
			if("kitchen")
				icon_state = "cafeteria"
				icon_regular_floor = "cafeteria"
			if("grimy")
				icon_state = "grimy"
				icon_regular_floor = "grimy"
			if("solar")
				icon_state = "solarpanel"
				icon_regular_floor = "solarpanel"
			else return
