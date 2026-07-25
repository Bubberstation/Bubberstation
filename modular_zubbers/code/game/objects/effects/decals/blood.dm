/obj/effect/decal/cleanable/blood
	/// The current size of the pool of blood.
	var/poolsize = 0

/// Increases the size of the blood splatter, called from add_splatter_floor
/obj/effect/decal/cleanable/blood/proc/increase_blood_pool()
	var/list/filters_adding =  list(
		filter(
				type = "drop_shadow",
				size = 4,
				color = "#ff0000",
			),
		UNLINT(filter(
				type = "outline",
				size = initial(poolsize),
				color = "#570000",
				flags = OUTLINE_SHARP,
				alpha = 64,
			))
	)
	poolsize++
	if(!length(filters))
		filters = filters_adding
	animate(
		filters[2],
		time = 16 SECONDS,
		size = clamp(poolsize/4, 0, 4),
		alpha = clamp(8 * poolsize, 64, 212)
	)

