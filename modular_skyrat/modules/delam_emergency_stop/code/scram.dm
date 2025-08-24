#define DAMAGED_SUPERMATTER_COLOR list(1,0.1,0.2,0, 0,0.9,0.1,0, 0.1,-0.05,0.85,0, 0,0,0,0.9, 0,0,0,0)
#define BUTTON_PUSHED 0
#define BUTTON_IDLE 1
#define BUTTON_AWAKE 2
#define BUTTON_ARMED 3

/// An atmos device that uses freezing cold air to attempt an emergency shutdown of the supermatter engine
/obj/machinery/atmospherics/components/unary/delam_scram
	icon = 'modular_skyrat/modules/delam_emergency_stop/icons/scram.dmi'
	icon_state = "dispenser-idle"
	name = "\improper delamination suppression system"
	desc = "The latest model in Nakamura Engineering's line of delamination suppression systems.<br>You don't want to be in the chamber when it's activated!<br>\
		Come to think of it, CentCom would rather you didn't activate it at all.<br>These things are expensive!"
	use_power = IDLE_POWER_USE
	can_unwrench = FALSE // comedy option, what if unwrenching trying to steal it throws you into the crystal for a nice dusting
	shift_underlay_only = FALSE
	hide = TRUE
	piping_layer = PIPING_LAYER_MAX
	pipe_state = "injector"
	resistance_flags = FIRE_PROOF | FREEZE_PROOF | UNACIDABLE
	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 4
	///Rate of operation of the device (L/s)
	var/volume_rate = 175
	///weakref to our SM
	var/datum/weakref/my_sm
	///Our internal radio
	var/obj/item/radio/radio
	///The key our internal radio uses
	var/radio_key = /obj/item/encryptionkey/headset_eng
	///Radio channels, need null to actually broadcast on common, lol
	var/emergency_channel = null
	var/warning_channel = RADIO_CHANNEL_ENGINEERING
	///If someone -really- wants the SM to explode
	var/admin_disabled = FALSE

/obj/machinery/atmospherics/components/unary/delam_scram/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/atmospherics/components/unary/delam_scram/post_machine_initialize()
	. = ..()
	if(isnull(id_tag))
		id_tag = "SCRAM"

	radio = new(src)
	radio.keyslot = new radio_key
	radio.set_listening(FALSE)
	radio.recalculateChannels()

	marry_sm()
	RegisterSignal(SSdcs, COMSIG_MAIN_SM_DELAMINATING, PROC_REF(panic_time))

/obj/machinery/atmospherics/components/unary/delam_scram/Destroy()
	QDEL_NULL(radio)
	my_sm = null
	return ..()

/// Sets the weakref to the SM
/obj/machinery/atmospherics/components/unary/delam_scram/proc/marry_sm()
	my_sm = WEAKREF(GLOB.main_supermatter_engine)

/obj/machinery/atmospherics/components/unary/delam_scram/update_icon_nopipes()
	return

/**
 * The atmos code is functionally identical to /obj/machinery/atmospherics/components/unary/outlet_injector
 * However this is a hardened all-in-one unit that can't have its controls
 * tampered with like an outlet injector
*/
/obj/machinery/atmospherics/components/unary/delam_scram/process_atmos()
	..()
	if(!on || !is_operational)
		return

	var/turf/location = get_turf(loc)

	if(isclosedturf(location))
		return

	var/datum/gas_mixture/air_contents = airs[1]

	if(air_contents.temperature > 0)
		var/transfer_moles = (air_contents.return_pressure() * volume_rate) / (air_contents.temperature * R_IDEAL_GAS_EQUATION)

		if(!transfer_moles)
			return

		var/datum/gas_mixture/removed = air_contents.remove(transfer_moles)

		location.assume_air(removed)
		update_parents()

/// Signal handler for the emergency stop button/automated system
/obj/machinery/atmospherics/components/unary/delam_scram/proc/panic_time(source, trigger_reason)
	SIGNAL_HANDLER

	if(!prereq_check(source, trigger_reason))
		return

	send_warning(source, trigger_reason)

/// Check for admin intervention or a fault in the signal validation, we don't exactly want to fire this on accident
/obj/machinery/atmospherics/components/unary/delam_scram/proc/prereq_check(source, trigger_reason)
	if(on)
		return FALSE

	if(admin_disabled)
		investigate_log("Delam SCRAM tried to activate but an admin disabled it", INVESTIGATE_ENGINE)
		playsound(
			source = src,
			soundin = 'sound/machines/compiler/compiler-failure.ogg',
			vol = 100,
			vary = FALSE,
			extrarange = 15,
			ignore_walls = TRUE,
			use_reverb = TRUE,
			falloff_distance = 10,
		)
		radio.talk_into(src, "Suppression system fault! Unable to trigger, software integrity check failed.", warning_channel, list(SPAN_COMMAND))
		audible_message(span_danger("[src] makes a series of sad beeps. Someone has corrupted its software!"))
		return FALSE

	if(trigger_reason == SCRAM_DIVINE_INTERVENTION)
		return TRUE

	if(world.time - SSticker.round_start_time > SCRAM_TIME_RESTRICTION)
		audible_message(span_danger("[src] makes a series of sad beeps. The internal gas buffer is past its 30 minute expiry... what a feat of engineering!"))
		investigate_log("Delam SCRAM signal was received but failed precondition check. (Round time or trigger reason)", INVESTIGATE_ENGINE)
		radio.talk_into(src, "Supermatter delam suppression system fault! Unable to trigger, internal gas mix integrity check failed.", emergency_channel, list(SPAN_COMMAND))
		return FALSE

	return TRUE

/// Tells the station (they probably already know) and starts the procedure
/obj/machinery/atmospherics/components/unary/delam_scram/proc/send_warning(source, trigger_reason)
	investigate_log("Delam SCRAM was activated by [trigger_reason]", INVESTIGATE_ENGINE)
	notify_ghosts(
		"[src] has been activated!",
		source = src,
		header = trigger_reason == SCRAM_DIVINE_INTERVENTION ? "Divine Intervention" : "Mistakes Were Made",
		ghost_sound = 'sound/machines/warning-buzzer.ogg',
		notify_volume = 75,
	)

	radio.talk_into(src, "Supermatter delamination suppression system triggered!", emergency_channel, list(SPAN_COMMAND))

	// fight fire with ~~gasoline~~ freon
	addtimer(CALLBACK(src, PROC_REF(put_on_a_show)), 4 SECONDS)
	playsound(
		source = src,
		soundin = 'sound/announcer/alarm/bloblarm.ogg',
		vol = 100,
		vary = FALSE,
		extrarange = 30,
		ignore_walls = TRUE,
		use_reverb = TRUE,
		falloff_distance = 10,
	)
	power_fail(duration_min = 27, duration_max = 33)

/// Stop the delamination. Let the fireworks begin
/obj/machinery/atmospherics/components/unary/delam_scram/proc/put_on_a_show()
	var/obj/machinery/power/supermatter_crystal/engine/angry_sm = my_sm?.resolve()
	if(!angry_sm)
		return

	// Fire bell close, that nice 'are we gonna die?' rumble out far
	investigate_log("Integrity at time of suppression activation was [100 - angry_sm.damage]", INVESTIGATE_ENGINE)
	on = TRUE
	SSpersistence.delam_counter_penalty()
	alert_sound_to_playing('sound/ambience/earth_rumble/earth_rumble_distant3.ogg', override_volume = TRUE)
	update_appearance()

	// Good job at kneecapping the crystal, engineers
	// Make the crystal look cool (can escape a delam, but not puns)
	angry_sm.modify_filter(name = "ray", new_params = list(
		color = SUPERMATTER_TESLA_COLOUR,
	))
	angry_sm.color = DAMAGED_SUPERMATTER_COLOR
	angry_sm.set_light_color(SUPERMATTER_TESLA_COLOUR)
	angry_sm.update_appearance()

	// Don't vent the delam juice as it works its magic
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubby_boi in range(3, src))
		scrubby_boi.on = FALSE
		scrubby_boi.update_appearance()

	for(var/obj/machinery/atmospherics/components/unary/vent_pump/venti_boi in range(3, src))
		venti_boi.on = FALSE
		venti_boi.update_appearance()

	// Let the gas work for a few seconds to start the cooling process.
	addtimer(CALLBACK(src, PROC_REF(aftermath)), 2 SECONDS)

/// The valiant little machine falls apart, one time use only!
/obj/machinery/atmospherics/components/unary/delam_scram/proc/goodbye_friends()
	// good job buddy, sacrificing yourself for the greater good
	playsound(
		source = src,
		soundin = 'sound/machines/compiler/compiler-failure.ogg',
		vol = 100,
		vary = FALSE,
		extrarange = 15,
		ignore_walls = TRUE,
		use_reverb = TRUE,
		falloff_distance = 10,
	)
	visible_message(span_danger("[src] beeps a sorrowful melody and collapses into a pile of twisted metal and foam!"), blind_message = span_danger("[src] beeps a sorrowful melody!"))
	deconstruct(FALSE)

/// Drain the internal energy, if the crystal damage is above 100 we heal it a bit. Not much, but should be good to let them recover.
/obj/machinery/atmospherics/components/unary/delam_scram/proc/aftermath()
	var/obj/machinery/power/supermatter_crystal/engine/damaged_sm = my_sm?.resolve()
	if(!damaged_sm)
		return

	damaged_sm.name = "partially delaminated supermatter crystal"
	damaged_sm.desc = "This crystal has seen better days, the glow seems off and the shards look brittle. Central says it's still \"relatively safe.\" They'd never lie to us, right?"
	damaged_sm.explosion_power += 5 // if you fuck up again, yeesh
	for(var/current_gas_mix as anything in damaged_sm.current_gas_behavior)
		var/datum/sm_gas/gas_mix = damaged_sm.current_gas_behavior[current_gas_mix]
		if(istype(gas_mix, /datum/sm_gas/freon))
			gas_mix.heat_resistance += 0.4
			continue
		gas_mix.heat_modifier += 1.5
		gas_mix.heat_resistance -= 0.4

	damaged_sm.internal_energy = 0
	for(var/obj/machinery/power/energy_accumulator/tesla_coil/zappy_boi in range(3, src))
		zappy_boi.stored_energy = 0

/obj/machinery/atmospherics/components/unary/delam_scram/Initialize(mapload)
	. = ..()
	var/datum/gas_mixture/delam_juice = new
	delam_juice.add_gases(/datum/gas/freon)
	delam_juice.gases[/datum/gas/freon][MOLES] = 7000 // enough to stop most delams, but not the really big fuckups
	delam_juice.temperature = 170 // 170K -103c
	airs[1] = delam_juice

/// A big red button you can smash to stop the supermatter engine, oh how tempting!
/obj/machinery/button/delam_scram
	name = "\proper the supermatter emergency stop button"
	desc = "Your last hope to try and save the crystal during a delamination.<br>\
		While it is indeed a big red button, pressing it outside of an emergency \
		will probably get the engineering department out for your blood."
	icon = 'modular_skyrat/modules/delam_emergency_stop/icons/scram.dmi'
	can_alter_skin = FALSE
	silicon_access_disabled = TRUE
	resistance_flags = FREEZE_PROOF | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	use_power = NO_POWER_USE
	light_color = LIGHT_COLOR_INTENSE_RED
	light_power = 0.7
	///one use only!
	var/button_stage = BUTTON_IDLE
	///our internal radio
	var/obj/item/radio/radio
	///radio key
	var/radio_key = /obj/item/encryptionkey/headset_eng
	COOLDOWN_DECLARE(scram_button)

/obj/machinery/button/delam_scram/Initialize(mapload)
	. = ..()
	radio = new(src)
	radio.keyslot = new radio_key
	radio.set_listening(FALSE)
	radio.recalculateChannels()

/obj/machinery/button/delam_scram/Destroy()
	QDEL_NULL(radio)
	return ..()

/obj/machinery/button/delam_scram/screwdriver_act(mob/living/user, obj/item/tool)
	return TRUE

/obj/machinery/button/delam_scram/emag_act(mob/user)
	return

/// Proc for arming the red button, it hasn't been pushed yet
/obj/machinery/button/delam_scram/attack_hand(mob/user, list/modifiers)
	. = ..()
	if((machine_stat & BROKEN))
		return

	if(!COOLDOWN_FINISHED(src, scram_button))
		balloon_alert(user, "on cooldown!")
		return

	if(!validate_suppression_status())
		playsound(
			source = src.loc,
			soundin = 'sound/machines/buzz/buzz-sigh.ogg',
			vol = 50,
			vary = FALSE,
			extrarange = 7,
			falloff_distance = 7,
		)
		audible_message(span_danger("[src] makes a sad buzz and goes dark. Did someone activate it already?")) // Look through the window, buddy
		burn_out()
		return

	if(.)
		return

	// Give them a cheeky instructions card. But only one! If you lost it, question your engineering prowess in this moment
	if(button_stage == BUTTON_IDLE)
		visible_message(span_danger("A plastic card falls out of [src]!"))
		user.put_in_hands(new /obj/item/paper/paperslip/corporate/fluff/delam_procedure(get_turf(user)))
		button_stage = BUTTON_AWAKE
		return

	if(button_stage != BUTTON_AWAKE)
		return

	COOLDOWN_START(src, scram_button, 15 SECONDS)
	button_stage = BUTTON_ARMED // You thought you could sneak this one by your coworkers?
	update_appearance()
	radio.talk_into(src, "Supermatter delamination suppression system armed!", RADIO_CHANNEL_ENGINEERING, list(SPAN_COMMAND))
	visible_message(span_danger("[user] swings open the plastic cover on [src]!"))

	// Let the admins know someone's fucked up
	message_admins("[ADMIN_LOOKUPFLW(user)] just uncovered [src].")
	investigate_log("[key_name(user)] uncovered [src].", INVESTIGATE_ENGINE)

	confirm_action(user)

/// Confirms with the user that they really want to push the red button. Do it, you won't!
/obj/machinery/button/delam_scram/proc/confirm_action(mob/user, list/modifiers)
	if(tgui_alert(usr, "Are you really sure that you want to push this?", "It looked scarier on HBO.", list("No", "Yes")) != "Yes")
		button_stage = BUTTON_AWAKE
		visible_message(span_danger("[user] slowly closes the plastic cover on [src]!"))
		update_appearance()
		return

	// Make scary sound and flashing light
	playsound(
		source = src,
		soundin = 'sound/machines/high_tech_confirm.ogg',
		vol = 50,
		vary = FALSE,
		extrarange = 7,
		ignore_walls = TRUE,
		use_reverb = TRUE,
		falloff_distance = 7,
	)
	button_stage = BUTTON_PUSHED
	visible_message(span_danger("[user] smashes [src] with their hand!"))
	message_admins("[ADMIN_LOOKUPFLW(user)] pushed [src]!")
	investigate_log("[key_name(user)] pushed [src]!", INVESTIGATE_ENGINE)
	if(world.time - SSticker.round_start_time > SCRAM_TIME_RESTRICTION)
		playsound(
			source = src.loc,
			soundin = 'sound/machines/compiler/compiler-failure.ogg',
			vol = 50,
			vary = FALSE,
			extrarange = 7,
			falloff_distance = 7,
		)
		audible_message(span_danger("[src] makes a series of sad beeps. Looks like it's all on you to save the day!"))
		burn_out()
		return

	// No going back now!
	flick_overlay_view("[base_icon_state]-overlay-active", 20 SECONDS)
	SEND_GLOBAL_SIGNAL(COMSIG_MAIN_SM_DELAMINATING, SCRAM_TRIGGER_PUSHED)

	// Temporarily let anyone escape the engine room before it becomes spicy
	for(var/obj/machinery/door/airlock/escape_route in range(7, src))
		if(istype(escape_route, /obj/machinery/door/airlock/command))
			continue

		INVOKE_ASYNC(escape_route, TYPE_PROC_REF(/obj/machinery/door/airlock, temp_emergency_exit), 45 SECONDS)

/// When the button is pushed but it's too late to save you!
/obj/machinery/button/delam_scram/proc/burn_out()
	if(!(machine_stat & BROKEN))
		src.desc += span_warning("The light is off, indicating it is not currently functional.")
		set_machine_stat(machine_stat | BROKEN)
		update_appearance()

/obj/machinery/button/delam_scram/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][skin]"
	if(button_stage == BUTTON_ARMED)
		icon_state += "-armed"
	else if(button_stage == BUTTON_PUSHED)
		icon_state += "-armed"
	else if(machine_stat & (NOPOWER|BROKEN))
		icon_state += "-nopower"

/obj/machinery/power/emitter/post_machine_initialize()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_MAIN_SM_DELAMINATING, PROC_REF(emergency_stop))

/obj/machinery/power/emitter/proc/emergency_stop()
	SIGNAL_HANDLER

	var/area/my_area = get_area(src)
	if(!istype(my_area, /area/station/engineering))
		return

	active = FALSE
	update_appearance()

/obj/item/paper/paperslip/corporate/fluff/delam_procedure/Initialize(mapload)
	name = "NT-approved delam emergency procedure"
	desc = "Now you're a REAL engineer!"
	return ..()

/obj/item/paper/paperslip/corporate/fluff/delam_procedure/examine(mob/user)
	. = ..()
	ui_interact(user)

/obj/item/paper/paperslip/corporate/fluff/delam_procedure/attackby(obj/item/attacking_item, mob/living/user, params)
	// Enable picking paper up by clicking on it with the clipboard or folder
	if(istype(attacking_item, /obj/item/clipboard) || istype(attacking_item, /obj/item/folder) || istype(attacking_item, /obj/item/paper_bin))
		attacking_item.attackby(src, user)
		return

	ui_interact(user)
	return ..()

/obj/item/paper/paperslip/corporate/fluff/delam_procedure/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DelamProcedure")
		ui.autoupdate = FALSE
		ui.open()

/obj/structure/sign/delam_procedure
	name = "Safety Moth - Delamination Emergency Procedure"
	desc = "This informational sign uses Safety Moth™ to tell the viewer how to use the emergency stop button if the Supermatter Crystal is delaminating."
	icon = 'modular_skyrat/modules/delam_emergency_stop/icons/scram.dmi'
	icon_state = "moff-poster"
	pixel_y = 4
	armor_type = /datum/armor/sign_delam
	anchored = TRUE

/datum/armor/sign_delam
	melee = 60
	acid = 70
	fire = 90

/obj/structure/sign/delam_procedure/examine(mob/user)
	. = ..()
	ui_interact(user)

/obj/structure/sign/delam_procedure/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DelamProcedure")
		ui.autoupdate = FALSE
		ui.open()

/obj/structure/sign/delam_procedure/ui_status(mob/user)
	if(user.is_blind())
		return UI_CLOSE

	return ..()

/// Resets the safety incident display internal counter back to -1 (delam event happened)
/datum/controller/subsystem/persistence/proc/delam_counter_penalty()
	rounds_since_engine_exploded = round(rounds_since_engine_exploded * 0.5)
	for(var/obj/machinery/incident_display/sign as anything in GLOB.map_incident_displays)
		sign.update_delam_count(rounds_since_engine_exploded)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/atmospherics/components/unary/delam_scram, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/delam_procedure, 32)

#undef DAMAGED_SUPERMATTER_COLOR
#undef BUTTON_PUSHED
#undef BUTTON_IDLE
#undef BUTTON_AWAKE
#undef BUTTON_ARMED
