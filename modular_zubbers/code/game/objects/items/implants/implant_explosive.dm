/obj/item/implant/explosive/anti_theft
	name = "explosive anti-theft implant"
	delay = 4.5 SECONDS
	panic_beep_sound = FALSE
	actions_types = null
	explosion_light = 2
	explosion_heavy = 0
	explosion_devastate = 0
	allow_multiple = FALSE

/obj/item/implant/explosive/anti_theft/timed_explosion()

	imp_in.visible_message(span_warning("[imp_in] starts vibrating ominously!"))
	imp_in.Shake(pixelshiftx = 0.5, pixelshifty = 0.5, delay)
	imp_in.Paralyze(delay*4) //Just in case...

	notify_ghosts(
		"[imp_in] is about to detonate their explosive implant!",
		source = src,
		action = NOTIFY_ORBIT,
		flashwindow = FALSE,
		ghost_sound = 'sound/machines/warning-buzzer.ogg',
		header = "Imma bout to bust!",
		notify_volume = 75
	)

	var/turf/T = get_turf(imp_in)
	playsound(T, 'modular_zubbers/sound/misc/bomb_implant_countdown.ogg', 50, FALSE, extra_range = 3 + explosion_light + explosion_heavy + explosion_devastate)

	addtimer(CALLBACK(src, PROC_REF(explode)), delay)

/obj/item/implant/explosive/anti_theft/explode()
	explosion(src, devastation_range = explosion_devastate, heavy_impact_range = explosion_heavy, light_impact_range = explosion_light, flame_range = explosion_light, flash_range = explosion_light, explosion_cause = src)
	if(imp_in)
		imp_in.investigate_log("has been hard-gibbed by an explosive anti-theft implant.", INVESTIGATE_DEATHS)
		imp_in.gib(TRUE, TRUE, TRUE)
	qdel(src)


/obj/item/implant/explosive/anti_theft/removed(mob/living/source, silent = FALSE, special = FALSE)

	. = ..()

	if(source && !special)
		var/turf/boomturf = get_turf(source)
		if(boomturf)
			message_admins("[ADMIN_LOOKUPFLW(source)] automatically activated their [name] at [ADMIN_VERBOSEJMP(boomturf)], with cause of attempted implant removal.")
			explode()
			if(!QDELETED(source))
				source.gib(TRUE, TRUE, TRUE)

/obj/item/implanter/anti_theft
	name = "implanter (explosive anti-theft)"
	imp_type = /obj/item/implant/explosive/anti_theft