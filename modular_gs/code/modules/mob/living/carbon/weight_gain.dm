/// Handles weight gain from digesting food/stomach contents
/obj/item/organ/stomach/proc/handle_weight_gain(mob/living/carbon/human/fatty)
	fatty.handle_fatness()
	fatty.handle_helplessness()
	// Do this later fatty.handle_modular_items()

	/* Do this later.
	switch(fatty.fullness)
		if(0 to FULLNESS_LEVEL_BLOATED)
			fatty.clear_alert("fullness")
		if(FULLNESS_LEVEL_BLOATED to FULLNESS_LEVEL_BEEG)
			fatty.throw_alert("fullness", /atom/movable/screen/alert/gs13/bloated)
		if(FULLNESS_LEVEL_BEEG to FULLNESS_LEVEL_NOMOREPLZ)
			fatty.throw_alert("fullness", /atom/movable/screen/alert/gs13/stuffed)
		if(FULLNESS_LEVEL_NOMOREPLZ to INFINITY)
			fatty.throw_alert("fullness", /atom/movable/screen/alert/gs13/beegbelly)


	var/obj/item/organ/genital/external/belly/B = fatty.getorganslot("belly")
	if(!isnull(B) && istype(B))
		B.update()
	*/

	switch(fatty.fatness)
		if(FATNESS_LEVEL_BLOB to INFINITY)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/blob)

		if(FATNESS_LEVEL_IMMOBILE to FATNESS_LEVEL_BLOB)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/immobile)

		if(FATNESS_LEVEL_BARELYMOBILE to FATNESS_LEVEL_IMMOBILE)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/barelymobile)

		if(FATNESS_LEVEL_EXTREMELY_OBESE to FATNESS_LEVEL_BARELYMOBILE)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/extremelyobese)

		if(FATNESS_LEVEL_MORBIDLY_OBESE to FATNESS_LEVEL_EXTREMELY_OBESE)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/morbidlyobese)

		if(FATNESS_LEVEL_OBESE to FATNESS_LEVEL_MORBIDLY_OBESE)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/obese)

		if(FATNESS_LEVEL_VERYFAT to FATNESS_LEVEL_OBESE)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/veryfat)

		if(FATNESS_LEVEL_FATTER to FATNESS_LEVEL_VERYFAT)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatter)

		if(FATNESS_LEVEL_FAT to FATNESS_LEVEL_FATTER)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fat)

		if(0 to FATNESS_LEVEL_FAT)
			fatty.clear_alert("fatness")


