/datum/material
	/// Does this wall look less "flat"?
	var/wall_shine = TRUE
	///Icon for walls which are plated with this material
	var/wall_icon = WALL_SOLID_ICON
	///Icon for walls which are plated with this material
	var/wall_shine_icon = WALL_STRIPE_SHINE_ICON
	/// Icon for painted stripes on the walls
	var/wall_stripe_icon = WALL_STRIPE_ICON
	/// Icon for painted stripes on the walls
	var/wall_stripe_shine_icon = WALL_STRIPE_SHINE_ICON
	/// Color of walls constructed with this material as their plating, will use color as a fallback if empty
	var/wall_color
	/// Type of the wall this material makes when its used as a plating, null means can't make a wall out of it.
	var/wall_type = /turf/closed/wall
	/// What do we *call* a 'wall' made out of this stuff?
	var/wall_name = "wall"
	/// Type of the false wall this material will make when used as its plating
	var/false_wall_type

/datum/material/alloy/plasteel
	wall_icon = WALL_REINFORCED_ICON
	wall_shine_icon = WALL_SHINE_REINFORCED_ICON
	wall_color = "#5e5656"

/datum/material/iron
	wall_color = "#68686e"

/datum/material/wood
	wall_icon = WALL_WOOD_ICON
	wall_stripe_icon = WALL_STRIPE_WOOD_ICON
	wall_color = "#93662C"
