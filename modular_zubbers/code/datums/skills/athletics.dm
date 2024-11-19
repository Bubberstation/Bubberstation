/datum/skill/athletics
	/// How much bigger your mob becomes per level (these effects don't stack together)
	var/static/size_boost = list(0, 1/16, 1/8, 3/16, 2/8, 3/8, 4/8)

	skill_item_path = /obj/item/clothing/gloves/boxing/golden

/datum/skill/athletics/New()
	. = ..()
	levelUpMessages[SKILL_LEVEL_NOVICE] = span_nicegreen("I am just getting started on my [name] journey! I think I should be able to identify other people who are working to improve their body by sight.")

/datum/skill/athletics/level_gained(datum/mind/mind, new_level, old_level, silent)
    . = ..()

    var/old_gym_size = RESIZE_DEFAULT_SIZE + size_boost[old_level]
    var/new_gym_size = RESIZE_DEFAULT_SIZE + size_boost[new_level]

    if(mind.current)
        mind.current.update_transform(new_gym_size / old_gym_size)

/datum/skill/athletics/level_lost(datum/mind/mind, new_level, old_level, silent)
    . = ..()
    if(old_level >= SKILL_LEVEL_NOVICE && new_level < SKILL_LEVEL_NOVICE)
        REMOVE_TRAIT(mind, TRAIT_EXAMINE_FITNESS, SKILL_TRAIT)

    var/old_gym_size = RESIZE_DEFAULT_SIZE + size_boost[old_level]
    var/new_gym_size = RESIZE_DEFAULT_SIZE + size_boost[new_level]

    if(mind.current)
        mind.current.update_transform(new_gym_size / old_gym_size)
