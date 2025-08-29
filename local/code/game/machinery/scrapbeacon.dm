#define SCRAPBEACON_DEBRIS_DAMAGE 25
#define SCRAPBEACON_IMPACT_PROBABILITY 20
#define SCRAPBEACON_COOLDOWN 20 MINUTES

/obj/machinery/scrap_beacon
	name = "scrap beacon"
	desc = "Electromagnetically pulls scrap and debris towards itself. Manually activated via a button inside the landing zone - dodging is half the fun!"
	icon = 'local/icons/obj/machines/scrap_beacon.dmi'
	icon_state = "beacon"
	anchored = TRUE
	density = TRUE
	layer = ABOVE_ALL_MOB_LAYER
	circuit = /obj/item/circuitboard/machine/scrap_beacon
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 10 // 10kw
	/// Are we currently pulling scrap in?
	var/active = FALSE
	/// How likely is any given turf going to get scrap? In percentage
	var/impact_probability = SCRAPBEACON_IMPACT_PROBABILITY
	/// Our range - not player-malleable.
	var/impact_range = 2
	/// What are we pulling in from space?
	var/scrap_path = /obj/structure/scrap/falls_when_spawned
	/// Our internal radio.
	var/obj/item/radio/radio

	COOLDOWN_DECLARE(scrap_sent_cd)

/obj/machinery/scrap_beacon/examine(mob/user)
	. = ..()
	. += span_warning("The display reads out that it has a [impact_probability]% chance of pulling in debris to any given tile.")
	if(COOLDOWN_TIMELEFT(src, scrap_sent_cd))
		. += span_warning("The status display indicates exactly [span_bold(DisplayTimeText(COOLDOWN_TIMELEFT(src, scrap_sent_cd), 2))]</b> remaining before the scrap beacon is ready again.")

/obj/machinery/scrap_beacon/Initialize(mapload) // To prevent deconstruction being used as a workaround for the cooldown. Mappers: Take this into account roundstart!
	. = ..()
	radio = new /obj/item/radio(src)
	radio.set_listening(FALSE)
	COOLDOWN_START(src, scrap_sent_cd, SCRAPBEACON_COOLDOWN)
	addtimer(CALLBACK(src, PROC_REF(announce_ready)), SCRAPBEACON_COOLDOWN)

/obj/machinery/scrap_beacon/Destroy(force)
	QDEL_NULL(radio)
	return ..()


/obj/machinery/scrap_beacon/RefreshParts()
	. = ..()
	impact_probability = SCRAPBEACON_IMPACT_PROBABILITY
	for(var/datum/stock_part/capacitor/capacitor in component_parts)
		impact_probability *= capacitor.tier

/obj/machinery/scrap_beacon/attackby(obj/item/weapon, mob/user, params)
	if(!active && default_deconstruction_screwdriver(user, icon_state, icon_state, weapon))
		return
	if(!active && default_deconstruction_crowbar(weapon))
		return
	return ..()

/obj/machinery/scrap_beacon/attack_ai(mob/user)
	return attack_hand(user)

/obj/machinery/scrap_beacon/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!COOLDOWN_FINISHED(src, scrap_sent_cd))
		balloon_alert(user, "cooling down!")
		return
	if(active)
		to_chat(user, span_warning("The [src] is already active!"))
		return
	playsound(loc, 'sound/machines/click.ogg', 15, TRUE, -3)
	log_game("[key_name(user)] has activated the [src].")
	COOLDOWN_START(src, scrap_sent_cd, SCRAPBEACON_COOLDOWN)
	start_scrap_summon()


/obj/machinery/scrap_beacon/proc/announce_ready()
	radio.set_frequency(FREQ_SCIENCE)
	radio.talk_into(src, "Thermal systems within operational parameters. Awaiting next activation.", FREQ_SCIENCE)

/obj/machinery/scrap_beacon/proc/start_scrap_summon()
	active = TRUE
	icon_state = "beacon-on"
	audible_message(span_boldwarning("An alarm blares as the [src] turns on and begins pulling debris in!"))
	playsound(loc, "sound/announcer/alarm/bloblarm.ogg", 100, 1)
	var/list/flooring_near_beacon = list()
	for(var/turf/T in RANGE_TURFS(impact_range, src))
		if(locate(/obj/structure/scrap) in T)
			continue
		if(!prob(impact_probability))
			continue
		if(!isopenturf(T))
			continue
		flooring_near_beacon += T
	flooring_near_beacon -= loc
	for(var/turf/newloc in flooring_near_beacon)
		new scrap_path(newloc)
		flooring_near_beacon -= newloc
	addtimer(CALLBACK(src, PROC_REF(end_scrap_summon)), 6 SECONDS)

/obj/machinery/scrap_beacon/proc/end_scrap_summon()
	active = FALSE
	icon_state = initial(icon_state)

#undef SCRAPBEACON_DEBRIS_DAMAGE
#undef SCRAPBEACON_IMPACT_PROBABILITY
#undef SCRAPBEACON_COOLDOWN
