/datum/hud/human/New(mob/living/carbon/human/owner)
	..()
	nutrition = new /atom/movable/screen/nutrition
	nutrition.hud = src
	infodisplay += nutrition

	hydration = new /atom/movable/screen/hydration
	hydration.hud = src
	infodisplay += hydration

/atom/movable/screen/nutrition
	name = "nutrition"
	icon = 'modular_zubbers/icons/mob/screen/screen_gen.dmi'
	icon_state = "nutrition"
	screen_loc = ui_hunger_thirst

/atom/movable/screen/nutrition/update_icon()
	. = ..()
	var/mob/living/carbon/carbon_mob = hud?.mymob
	if(!istype(carbon_mob))
		return
	switch(carbon_mob.nutrition)
		if(NUTRITION_LEVEL_FULL to INFINITY)
			icon_state = "nutrition4"
		if(NUTRITION_LEVEL_WELL_FED to NUTRITION_LEVEL_FULL)
			icon_state = "nutrition3"
		if(NUTRITION_LEVEL_FED to NUTRITION_LEVEL_WELL_FED)
			icon_state = "nutrition2"
		if(NUTRITION_LEVEL_HUNGRY to NUTRITION_LEVEL_FED)
			icon_state = "nutrition1"
		if(0 to NUTRITION_LEVEL_HUNGRY)
			icon_state = "nutrition0"


/atom/movable/screen/hydration
	name = "hydration"
	icon = 'modular_zubbers/icons/mob/screen/screen_gen.dmi'
	icon_state = "hydration"
	screen_loc = ui_hunger_thirst

/atom/movable/screen/hydration/update_icon()
	. = ..()
	var/mob/living/carbon/carbon_mob = hud?.mymob
	if(!istype(carbon_mob))
		return
	switch(carbon_mob.hydration)
		if(HYDRATION_LEVEL_FULL to INFINITY)
			icon_state = "hydration4"
		if(HYDRATION_LEVEL_WELL_HYDRATED to HYDRATION_LEVEL_FULL)
			icon_state = "hydration3"
		if(HYDRATION_LEVEL_HYDRATED to HYDRATION_LEVEL_WELL_HYDRATED)
			icon_state = "hydration2"
		if(HYDRATION_LEVEL_THIRSTY to HYDRATION_LEVEL_HYDRATED)
			icon_state = "hydration1"
		if(0 to HYDRATION_LEVEL_THIRSTY)
			icon_state = "hydration0"
