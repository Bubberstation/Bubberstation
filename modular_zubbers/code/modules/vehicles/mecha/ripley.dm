/obj/vehicle/sealed/mecha/ripley/paddy
	///Radio used to report status on sec channels
	var/obj/item/radio/hailer/radio
	COOLDOWN_DECLARE(siren_announce_cooldown)

/obj/vehicle/sealed/mecha/ripley/paddy/Initialize(mapload)
	. = ..()
	radio = new(src)

/obj/vehicle/sealed/mecha/ripley/paddy/Destroy()
	QDEL_NULL(radio)
	. = ..()

/obj/vehicle/sealed/mecha/ripley/paddy/togglesiren(force_off = FALSE)
	var/old_siren = siren;

	..()

	var/list/drivers = return_drivers()
	if (COOLDOWN_FINISHED(src, siren_announce_cooldown) && drivers.len > 0 && siren != old_siren)
		if(siren == TRUE)
			var/turf/turf_location = get_turf(src)
			var/location = get_area_name(turf_location)
			radio.talk_into(src, "[drivers[1].name] is in hot pursuit at [location]!", RADIO_CHANNEL_SECURITY, language = /datum/language/common)
		else
			radio.talk_into(src, "[drivers[1].name] has called off their pursuit.", RADIO_CHANNEL_SECURITY, language = /datum/language/common)
			COOLDOWN_START(src, siren_announce_cooldown, 1 MINUTES)
