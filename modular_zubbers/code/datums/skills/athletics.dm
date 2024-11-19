/datum/skill/athletics
	/// How much bigger your mob becomes per level (these effects don't stack together)
	var/static/size_boost = list(0, 1/16, 1/8, 3/16, 2/8, 3/8, 4/8)
/datum/skill/athletics/level_gained(datum/mind/mind, new_level, old_level, silent)
	. = ..()

	if(!mind.athletics_size_scaling) // Check if scaling is enabled
		return

	var/old_gym_size = RESIZE_DEFAULT_SIZE + size_boost[old_level]
	var/new_gym_size = RESIZE_DEFAULT_SIZE + size_boost[new_level]

	if(mind.current)
		mind.current.update_transform(new_gym_size / old_gym_size)

/datum/skill/athletics/level_lost(datum/mind/mind, new_level, old_level, silent)
	. = ..()

	if(!mind.athletics_size_scaling) // Check if scaling is enabled
		return

	var/old_gym_size = RESIZE_DEFAULT_SIZE + size_boost[old_level]
	var/new_gym_size = RESIZE_DEFAULT_SIZE + size_boost[new_level]

	if(mind.current)
		mind.current.update_transform(new_gym_size / old_gym_size)
