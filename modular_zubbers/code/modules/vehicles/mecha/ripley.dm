/obj/vehicle/sealed/mecha/ripley/paddy
	///Radio used to report status on sec channels
	var/emped = FALSE
	var/obj/item/radio/hailer/radio
	COOLDOWN_DECLARE(siren_announce_cooldown)

/obj/vehicle/sealed/mecha/ripley/paddy/Initialize(mapload)
	. = ..()
	radio = new(src)

/obj/vehicle/sealed/mecha/ripley/paddy/Destroy()
	QDEL_NULL(radio)
	. = ..()

/obj/vehicle/sealed/mecha/ripley/paddy/emp_act(severity)
	. = ..()
	if(!emped)
		emped = TRUE
		addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/vehicle/sealed/mecha/ripley/paddy, emp_reset)), 3 MINUTES)

/obj/vehicle/sealed/mecha/ripley/paddy/proc/emp_reset()
	SIGNAL_HANDLER
	emped = FALSE

/obj/vehicle/sealed/mecha/ripley/paddy/togglesiren(force_off = FALSE)
	if(force_off)
		..() //if force_off is only called when the user exits the paddy; don't bother with alerts in this context
	else
		if(emped)
			to_chat(usr, span_warning("The siren hailer malfunctions!"))
			return
		if(!istype(scanmod))
			to_chat(usr, span_warning("The Paddy's internal HUD flashes with the text 'ERR_MISSING_SCANNER'!"))
			return
		balloon_alert_to_viewers("Reporting status to Security!")
		if(!do_after(usr, 2 SECONDS, src))
			return

		..()

		var/list/drivers = return_drivers()
		if (COOLDOWN_FINISHED(src, siren_announce_cooldown) && drivers.len > 0)
			var/mob/paddy_pilot = drivers[1]
			if(istype(paddy_pilot))
				if(siren == TRUE)
					var/turf/turf_location = get_turf(src)
					var/location = get_area_name(turf_location)
					radio.talk_into(src, "[paddy_pilot.name] is in hot pursuit at [location]!", RADIO_CHANNEL_SECURITY, language = /datum/language/common)
					src.audible_message("<font color='red' size='5'><b>BACKUP REQUESTED!</b></font>")
					log_combat(paddy_pilot, src, "has called for backup")
				else
					radio.talk_into(src, "[paddy_pilot.name] has called off their pursuit.", RADIO_CHANNEL_SECURITY, language = /datum/language/common)
					COOLDOWN_START(src, siren_announce_cooldown, 1 MINUTES)
