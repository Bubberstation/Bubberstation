// To speed up the preference menu, we apply 1 filter to the entire mob
/mob/living/carbon/human/dummy/regenerate_icons()
	. = ..()
	apply_height(src, TRUE)

/mob/living/carbon/human/dummy/apply_height(image/appearance, body_area, only_apply_in_prefs = FALSE)
	if(only_apply_in_prefs)
		return ..()
