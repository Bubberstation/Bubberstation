/obj/machinery/rbmk2_sniffer
	name = "\improper RB-MK2 \"Boombox\" reactor sniffer"
	desc = "A modified air alarm designed to detect stray ionization particles, also known as a meltdown. Can be linked to nearby RB-MK2 machines by interacting with the wires."
	icon = 'modular_zubbers/icons/obj/equipment/burger_reactor.dmi'
	icon_state = "reactor_sniffer"
	base_icon_state = "reactor_sniffer"
	density = FALSE
	anchored = TRUE

	use_power = IDLE_POWER_USE

	max_integrity = 100

	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 0.05
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.02
	power_channel = AREA_USAGE_ENVIRON

	circuit = /obj/item/circuitboard/machine/rbmk2_sniffer

	var/last_meltdown = FALSE
	var/last_criticality = 0
	var/last_integrity = 100
	var/alerted_emergency_channel = FALSE

	var/list/obj/machinery/power/rbmk2/linked_reactors = list()

	resistance_flags = FIRE_PROOF

	var/radio_enabled = TRUE
	var/link_confirm = FALSE
	var/unlink_confirm = FALSE
	var/test_wire_switch = FALSE

	var/obj/item/radio/stored_radio //Internal radio.
	var/radio_key = /obj/item/encryptionkey/headset_eng //The key our internal radio uses
	var/emergency_channel = null // Need null to actually broadcast to common. Stolen from supermatter code so they know about this. lol. lmao.
	var/warning_channel = RADIO_CHANNEL_ENGINEERING


	COOLDOWN_DECLARE(radio_cooldown_integrity)

	COOLDOWN_DECLARE(radio_cooldown_criticality)


/obj/machinery/rbmk2_sniffer/Initialize(mapload, ndir, nbuild)
	. = ..()

	set_wires(new /datum/wires/rbmk2_sniffer(src))

	if(ndir)
		setDir(ndir)

	stored_radio = new(src)
	stored_radio.keyslot = new radio_key
	stored_radio.set_listening(FALSE)
	stored_radio.recalculateChannels()

	if(mapload)
		find_and_mount_on_atom()
		for(var/obj/machinery/power/rbmk2/reactor in range(10,src))
			link_reactor(null,reactor)

/obj/machinery/rbmk2_sniffer/Destroy()

	. = ..()

	for(var/obj/machinery/power/rbmk2/reactor as anything in linked_reactors)
		unlink_reactor(null,reactor)

	QDEL_NULL(stored_radio)

	qdel(wires)
	set_wires(null)

/obj/machinery/rbmk2_sniffer/proc/link_reactor(mob/user,obj/machinery/power/rbmk2/desired_reactor)

	if(linked_reactors[desired_reactor])
		if(user) balloon_alert(user, "already linked!")
		return FALSE

	linked_reactors[desired_reactor] = TRUE
	desired_reactor.linked_sniffers[src] = TRUE

	return TRUE

/obj/machinery/rbmk2_sniffer/proc/unlink_reactor(mob/user,obj/machinery/power/rbmk2/desired_reactor)

	if(!linked_reactors[desired_reactor])
		return FALSE

	linked_reactors -= desired_reactor
	desired_reactor.linked_sniffers -= src

	return TRUE

/obj/machinery/rbmk2_sniffer/examine(mob/user)

	. = ..()

	. += "It is linked to [length(linked_reactors)] reactor(s)."

	if(last_meltdown)
		. += span_danger("It is flashing red!")
	else
		. += span_notice("It is glowing a steady green.")


/obj/machinery/rbmk2_sniffer/proc/alert_radio(alert_text,bypass_cooldown=FALSE,alert_emergency_channel=FALSE,criticality=TRUE)

	if(!radio_enabled || !alert_text)
		return FALSE

	if(!bypass_cooldown) //This section of code handles cooldowns.
		if(criticality)
			if(!COOLDOWN_FINISHED(src, radio_cooldown_criticality))
				return FALSE
			COOLDOWN_START(src, radio_cooldown_criticality, (criticality >= 100 ? 15 SECONDS : 10 SECONDS))
		else
			if(!COOLDOWN_FINISHED(src, radio_cooldown_integrity))
				return FALSE
			COOLDOWN_START(src, radio_cooldown_integrity, 10 SECONDS)

	stored_radio.talk_into(src, alert_text, alert_emergency_channel ? emergency_channel : warning_channel)

	playsound(src, 'sound/effects/alert.ogg', 50, TRUE)

	return TRUE
