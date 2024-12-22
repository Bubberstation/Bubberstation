/datum/hud
	var/atom/movable/screen/thirst

/datum/hud/Destroy()
	. = ..()
	thirst = null

/atom/movable/screen/thirst
	name = "thirst"
	icon_state = "hungerbar"
	base_icon_state = "hungerbar"
	screen_loc = ui_thirst
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	/// What state of thirst are we in?
	VAR_PRIVATE/state = THIRST_STATE_FINE
	/// What icon do we show by the bar
	var/food_icon = 'icons/obj/drinks/mixed_drinks.dmi'
	/// What icon state do we show by the bar
	var/food_icon_state = "four_bit"
	/// The image shown by the bar.
	VAR_PRIVATE/image/food_image

/atom/movable/screen/thirst/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	var/mob/living/thirst = hud_owner?.mymob
	if(!istype(thirst))
		return

	if(!ishuman(thirst) || CONFIG_GET(flag/disable_human_mood))
		screen_loc = ui_mood

	food_image = image(icon = food_icon, icon_state = food_icon_state, pixel_x = -5)
	food_image.plane = plane
	food_image.appearance_flags |= KEEP_APART
	food_image.add_filter("simple_outline", 2, outline_filter(1, COLOR_BLACK, OUTLINE_SHARP))
	underlays += food_image

	SetInvisibility(INVISIBILITY_ABSTRACT, name)
	update_appearance()

/atom/movable/screen/thirst/proc/update_thirst_state()
	var/mob/living/thirst = hud?.mymob
	if(!istype(thirst))
		return

	if(HAS_TRAIT(thirst, TRAIT_NOTHIRST) || !thirst.get_organ_slot(ORGAN_SLOT_STOMACH))
		state = THIRST_STATE_FINE
		return

	switch(thirst.water_level)
		if(THIRST_LEVEL_THRESHOLD to INFINITY)
			state = THIRST_STATE_FINE
		if(THIRST_LEVEL_QUENCHED to THIRST_LEVEL_VERY_QUENCHED)
			state = THIRST_STATE_FINE
		if(THIRST_LEVEL_THIRSTY to THIRST_LEVEL_BIT_THIRSTY)
			state = THIRST_STATE_HUNGRY
		if(0 to THIRST_LEVEL_PARCHED)
			state = THIRST_STATE_STARVING

/atom/movable/screen/thirst/update_appearance(updates)
	var/old_state = state
	update_thirst_state() // Do this before we call all the other update procs
	. = ..()
	if(state == old_state) // Let's not be wasteful
		return
	if(state == THIRST_STATE_FINE)
		SetInvisibility(INVISIBILITY_ABSTRACT, name)
		return

	else if(invisibility)
		RemoveInvisibility(name)

	if(state == THIRST_STATE_STARVING)
		if(!get_filter("thirst_outline"))
			add_filter("thirst_outline", 1, list("type" = "outline", "color" = "#FF0033", "alpha" = 0, "size" = 2))
			animate(get_filter("thirst_outline"), alpha = 200, time = 1.5 SECONDS, loop = -1)
			animate(alpha = 0, time = 1.5 SECONDS)

	else if(get_filter("thirst_outline"))
		remove_filter("thirst_outline")

	// Update color of the food
	underlays -= food_image
	food_image.color = state == THIRST_STATE_FAT ? COLOR_DARK : null
	underlays += food_image

/atom/movable/screen/thirst/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][state]"
