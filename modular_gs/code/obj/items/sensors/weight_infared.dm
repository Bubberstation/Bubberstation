/obj/item/assembly/infra/fat
	name = "fatness infrared emitter"
	desc = "Emits a visible or invisible beam and is triggered when the beam is interrupted. This one checks if the person tripping it is above or below a certain level of fatness."

	var/fatness_to_trigger = 0
	var/trigger_below = FALSE

/obj/item/assembly/infra/fat/examine(mob/user)
	. = ..()
	. += "<span class='notice'>The infrared trigger is set to trigger when the target is [trigger_below?"above":"below"] being [get_fatness_level_name(fatness_to_trigger)].</span>"

/obj/item/assembly/infra/fat/ui_interact(mob/user)//TODO: change this this to the wire control panel
	if(!is_secured(user))
		return

	user.set_machine(src)
	var/dat = "<TT><B>Fatness Infrared Laser</B></TT>"
	dat += "<BR><B>Status</B>: [on ? "<A href='?src=[REF(src)];state=0'>On</A>" : "<A href='?src=[REF(src)];state=1'>Off</A>"]"
	dat += "<BR><B>Visibility</B>: [visible ? "<A href='?src=[REF(src)];visible=0'>Visible</A>" : "<A href='?src=[REF(src)];visible=1'>Invisible</A>"]"
	dat += "<BR><B>Fatness level to trigger:</B><A href='?src=[REF(src)];fatness_to_trigger=1'>[get_fatness_level_name(fatness_to_trigger)]</A>"
	dat += "<BR><B>Trigger above or below the target fatness level:</B><A href='?src=[REF(src)];trigger_below=1'>[trigger_below ? "Below" : "Above"]</A>"
	dat += "<BR><BR><A href='?src=[REF(src)];refresh=1'>Refresh</A>"
	dat += "<BR><BR><A href='?src=[REF(src)];close=1'>Close</A>"
	user << browse(dat, "window=infra")
	onclose(user, "infra")
	return

/obj/item/assembly/infra/fat/Topic(href, href_list)
	..()
	if(href_list["trigger_below"])
		trigger_below = !(trigger_below)
		update_icon()
		refreshBeam()
	if(href_list["fatness_to_trigger"])
		var/fatness_type = input(usr,
			"What level of fatness do you wish to alert above/under at?",
			src, "None") as null|anything in list(
			"None", "Fat", "Fatter", "Very Fat", "Obese", "Morbidly Obese", "Extremely Obese", "Barely Mobile", "Immobile", "Blob")
		if(!fatness_type)
			return		

		var/fatness_amount = 0	
		switch(fatness_type)
			if("Fat")
				fatness_amount = FATNESS_LEVEL_FAT
			if("Fatter")
				fatness_amount = FATNESS_LEVEL_FATTER 
			if("Very Fat")
				fatness_amount = FATNESS_LEVEL_VERYFAT
			if("Obese")
				fatness_amount = FATNESS_LEVEL_OBESE
			if("Morbidly Obese")
				fatness_amount = FATNESS_LEVEL_MORBIDLY_OBESE
			if("Extremely Obese")
				fatness_amount = FATNESS_LEVEL_EXTREMELY_OBESE
			if("Barely Mobile")
				fatness_amount = FATNESS_LEVEL_BARELYMOBILE
			if("Immobile")
				fatness_amount = FATNESS_LEVEL_IMMOBILE
			if("Blob")
				fatness_amount = FATNESS_LEVEL_BLOB
			
		fatness_to_trigger = fatness_amount	
		update_icon()
		refreshBeam()

/obj/item/assembly/infra/fat/trigger_beam(atom/movable/AM, turf/location)
	var/mob/living/carbon/crossed_fatty = AM
	if(!istype(crossed_fatty))
		return FALSE

	if(trigger_below && (crossed_fatty.fatness >= fatness_to_trigger))
		return FALSE

	if(!trigger_below && (crossed_fatty.fatness < fatness_to_trigger))
		return FALSE

	return ..() // I love using inheritence so much.

