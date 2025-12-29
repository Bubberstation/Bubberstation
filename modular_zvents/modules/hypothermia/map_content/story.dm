/obj/item/keycard/important
	name = "Important story key"
	color = COLOR_RED
	max_integrity = 250
	armor_type = /datum/armor/disk_nuclear
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/keycard/important/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/stationloving, TRUE)
	SSpoints_of_interest.make_point_of_interest(src)


/obj/item/keycard/important/hypothermia
	color = COLOR_BLUE_LIGHT


/obj/item/keycard/important/hypothermia/amory_key
	name = "Zvezda heavy armory key"

/obj/item/keycard/important/hypothermia/ship_control_key
	name = "Buran helm key"
	color = COLOR_GOLD
	desc = "This is the key to the control console of the colonial-class shuttle 'Buran'. Without it, the shuttle simply cannot be launched!"

/obj/item/story_item
	name = "Important story item"
	max_integrity = 250
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

	var/important_text = "This is an important story item! Do not lose it!"

/obj/item/story_item/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/stationloving, TRUE)
	SSpoints_of_interest.make_point_of_interest(src)

/obj/item/story_item/examine(mob/user)
	. = ..()
	. += span_boldwarning(important_text)


/obj/item/story_item/hypothermia_applied_ai_core
	name = "applied AI core"
	desc = "An old positronic brain in a cracked casing. Someone scratched \"TYVOZHKA\" on it with a nail. It's barely still working."
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "spheribrain-searching"
	w_class = WEIGHT_CLASS_BULKY
	important_text = "This is the only AI module capable of controlling the colonial shuttle. Without it, the ship won't take off!"


/obj/item/story_item/hypothermia_fusion_core
	name = "depleted fusion core"
	desc = "A heavy micro-fusion core of the RBMK class. The last one in the colony. It's cold, but the containment rings are intact. Refuel it with plasma or uranium sheets — it might work again."
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "syndicate-bomb-inactive-wires"
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 20
	important_text = "Without a working fusion core, the shuttle's engines won't get power. You won't escape the planet!"

	var/refueled = FALSE

/obj/item/story_item/hypothermia_fusion_core/attackby(obj/item/W, mob/user, params)
	if(refueled)
		return ..()

	if(istype(W, /obj/item/stack/sheet/mineral/plasma))
		var/obj/item/stack/sheet/mineral/plasma/P = W
		if(P.amount >= 50)
			P.use(50)
			refueled = TRUE
			icon_state = "syndicate-bomb-active-wires"
			desc = "A heavy micro-fusion core of the RBMK class. Now operational — someone stuffed plasma sheets into it and prayed."
			visible_message(span_notice("[user] stuffs plasma sheets into [src]. The core begins to hum quietly."))
			return
		else
			balloon_alert(user, "Not enough material!")
	if(istype(W, /obj/item/stack/sheet/mineral/uranium))
		var/obj/item/stack/sheet/mineral/uranium/U = W
		if(U.amount >= 50)
			U.use(50)
			refueled = TRUE
			icon_state = "syndicate-bomb-active-wires"
			desc = "A heavy micro-fusion core of the RBMK class. Someone welded uranium plates onto it. It's dangerously heating up... but it will provide power!"
			visible_message(span_danger("[user] inserts uranium sheets into [src]. The core begins to hum quietly!"))
			return
		else
			balloon_alert(user, "Not enough material!")
	return ..()


/obj/item/story_item/hypothermia_navigation_tape
	name = "navigation tape cassette"
	desc = "A dusty magnetic tape labeled \"H1132 → EARTH\". The only copy of the jump coordinates out of this system. Without it, the autopilot will simply steer the shuttle into the sun."
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "tape_yellow"
	w_class = WEIGHT_CLASS_SMALL
	important_text = "This is the only tape with Earth's coordinates! Without it, the shuttle will fly nowhere and you'll burn up in hyperspace!"


/obj/item/story_item/hypothermia_thermal_regulator
	name = "main thermal regulator valve"
	desc = "A huge brass valve torn from the colony's thermal regulation system. Without it, the shuttle's engines will overheat and explode 30 seconds after launch."
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "valve_1"
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 15
	important_text = "A critically important thermal regulation valve! Without it, the shuttle's engines will explode half a minute into flight!"


// Shuttle template
/datum/map_template/shuttle/zvezda
	port_id = "event"
	prefix = "_maps/modular_events/"
	suffix = "buran"
	name = "Buran-class Colonial Shuttle"
	description = "A colonial shuttle of the \"Buran\" class. The only chance to escape the planet."
	width = 23
	height = 30

/obj/docking_port/mobile/buran
	name = "Buran-class Colonial Shuttle"
	shuttle_id = "event"
	width = 23
	height = 30
	movement_force = list("KNOCKDOWN" = 0,"THROW" = 0)

/obj/docking_port/stationary/zvezda_buran
	name = "Buran docking port"
	hidden = FALSE
	dir = WEST


/obj/machinery/shuttle_launch_terminal
	name = "shuttle launch terminal"
	desc = "The launch terminal for the 'Buran' shuttle. It can only be activated if all critical modules are inserted and authorization is confirmed."
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer"
	density = TRUE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

	var/obj/item/story_item/hypothermia_applied_ai_core/ai_core
	var/obj/item/story_item/hypothermia_fusion_core/fusion_core
	var/obj/item/story_item/hypothermia_navigation_tape/nav_tape
	var/obj/item/story_item/hypothermia_thermal_regulator/thermal_reg

	var/ready_ai = FALSE
	var/ready_core = FALSE
	var/ready_nav = FALSE
	var/ready_therm = FALSE
	var/key_inserted = FALSE

	var/launch_time = 15 MINUTES
	var/time_left
	var/obj/docking_port/mobile/connected_port = null

	var/launching = FALSE


/obj/machinery/shuttle_launch_terminal/Initialize(mapload)
	. = ..()
	for(var/obj/docking_port/mobile/M in get_area(src))
		connected_port = M
		break

	if(!connected_port)
		stack_trace("Launch terminal placed without mobile docking port nearby!")
	add_filter("story_outline", 2, list("type" = "outline", "color" = "#fa3b3b", "size" = 1))


/obj/machinery/shuttle_launch_terminal/examine(mob/user)
	. = ..()
	check_modules()
	if(!ready_ai)
		. += span_warning("Missing applied AI core!")
	if(!ready_core)
		. += span_warning("Missing refueled fusion core!")
	if(!ready_nav)
		. += span_warning("Missing navigation tape!")
	if(!ready_therm)
		. += span_warning("Missing thermal regulator!")
	if(key_inserted)
		. += span_notice("Key inserted.")
	else
		. += span_warning("Key not inserted.")


/obj/machinery/shuttle_launch_terminal/proc/check_modules()
	ready_ai = !!ai_core
	ready_core = !!fusion_core
	ready_nav = !!nav_tape
	ready_therm = !!thermal_reg
	return ready_ai && ready_core && ready_nav && ready_therm


/obj/machinery/shuttle_launch_terminal/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/keycard/important/hypothermia/ship_control_key))
		if(key_inserted)
			to_chat(user, span_warning("The key is already inserted."))
			return

		if(!check_modules())
			to_chat(user, span_warning("Insert all critical modules first!"))
			return

		balloon_alert(user, "Initiating launch procedure!")
		visible_message(span_notice("[user] begins the launch procedure."))
		if(!do_after(user, 15 SECONDS, src))
			balloon_alert(user, "Procedure interrupted!")
			return
		balloon_alert(user, "Launching shuttle!")
		if(!user.transferItemToLoc(W, src))
			return

		key_inserted = TRUE
		to_chat(user, span_notice("You insert the key into the terminal."))
		visible_message(span_notice("[user] inserts the control key into the launch terminal."))

		start_launch_countdown(user)
		return

	if(istype(W, /obj/item/story_item/hypothermia_applied_ai_core))
		if(ai_core)
			to_chat(user, span_warning("AI core already inserted!"))
			return

		if(!user.transferItemToLoc(W, src))
			return

		ai_core = W
		to_chat(user, span_notice("You insert [W] into the terminal."))
		visible_message(span_notice("[user] inserts [W] into the terminal."))
		return

	if(istype(W, /obj/item/story_item/hypothermia_fusion_core))
		var/obj/item/story_item/hypothermia_fusion_core/core = W
		if(fusion_core)
			to_chat(user, span_warning("Fusion core already inserted!"))
			return

		if(!core.refueled)
			to_chat(user, span_warning("Fusion core is not refueled!"))
			return

		if(!user.transferItemToLoc(W, src))
			return

		fusion_core = W
		to_chat(user, span_notice("You insert [W] into the terminal."))
		visible_message(span_notice("[user] inserts [W] into the terminal."))
		return

	if(istype(W, /obj/item/story_item/hypothermia_navigation_tape))
		if(nav_tape)
			to_chat(user, span_warning("Navigation tape already inserted!"))
			return

		if(!user.transferItemToLoc(W, src))
			return

		nav_tape = W
		to_chat(user, span_notice("You insert [W] into the terminal."))
		visible_message(span_notice("[user] inserts [W] into the terminal."))
		return

	if(istype(W, /obj/item/story_item/hypothermia_thermal_regulator))
		if(thermal_reg)
			to_chat(user, span_warning("Thermal regulator already inserted!"))
			return

		if(!user.transferItemToLoc(W, src))
			return

		thermal_reg = W
		to_chat(user, span_notice("You insert [W] into the terminal."))
		visible_message(span_notice("[user] inserts [W] into the terminal."))
		return

	return ..()



/obj/machinery/shuttle_launch_terminal/proc/start_launch_countdown(mob/user)
	if(launching)
		return

	launching = TRUE
	time_left = launch_time

	priority_announce("Shuttle launch sequence initiated. Launch in 15 minutes.", "Priority Alert", 'sound/effects/alert.ogg')

	addtimer(CALLBACK(src, PROC_REF(announce_remaining), 10), launch_time - 10 MINUTES)
	addtimer(CALLBACK(src, PROC_REF(announce_remaining), 5), launch_time - 5 MINUTES)
	addtimer(CALLBACK(src, PROC_REF(announce_remaining), 3), launch_time - 3 MINUTES)
	addtimer(CALLBACK(src, PROC_REF(announce_remaining), 1), launch_time - 1 MINUTES)
	addtimer(CALLBACK(src, PROC_REF(launch_shuttle)), launch_time)

	if(istype(SSround_events?.active_event, /datum/full_round_event/hypothermia))
		var/datum/full_round_event/hypothermia/hypo = SSround_events.active_event
		hypo.on_buran_startup()

/obj/machinery/shuttle_launch_terminal/proc/announce_remaining(minutes)
	priority_announce("Shuttle launch in [minutes] minute[minutes > 1 ? "s" : ""].", "Priority Alert", 'sound/effects/alert.ogg')
	if(minutes <= 1)
		var/message = "The shuttle is almost launched, just a little more and I'll survive!"
		for(var/mob/living/player in GLOB.alive_player_list)
			if(ishuman(player))
				to_chat(player, span_boldnotice(message))

/obj/machinery/shuttle_launch_terminal/proc/launch_shuttle()
	priority_announce("WARNING! WARNING! STARTUP SEQUENCE COMPLETED. STARTING THE SHUTTLE!", "Priority Alert", 'sound/effects/alert.ogg')
	connected_port.destination = null
	connected_port.mode = SHUTTLE_IGNITING
	connected_port.setTimer(connected_port.ignitionTime)

	if(istype(SSround_events?.active_event, /datum/full_round_event/hypothermia))
		var/datum/full_round_event/hypothermia/hypo = SSround_events.active_event
		hypo.on_buran_launch()

/obj/item/climbing_hook/emergency/safeguard
	name = "safeguard climbing hook"
	desc = "An emergency climbing hook that automatically deploys when falling into a chasm, pulling the user to safety but causing injury."
	icon_state = "climbingrope_s"
	slot_flags = ITEM_SLOT_BELT
	var/attempting = FALSE	// To prevent infinite loops


/obj/item/climbing_hook/emergency/safeguard/examine(mob/user)
	. = ..()
	. += span_warning("[name] should be worn on the belt to save the wearer from falling!")

/obj/item/climbing_hook/emergency/safeguard/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_BELT && isliving(user))
		RegisterSignal(user, COMSIG_MOVABLE_CHASM_DROPPED, PROC_REF(on_chasm_drop))

/obj/item/climbing_hook/emergency/safeguard/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, COMSIG_MOVABLE_CHASM_DROPPED)

/obj/item/climbing_hook/emergency/safeguard/proc/on_chasm_drop(mob/living/user, turf/chasm_turf)
	SIGNAL_HANDLER
	if(user.stat == DEAD || attempting)
		return
	attempting = TRUE
	addtimer(CALLBACK(src, PROC_REF(try_rescue), user, chasm_turf), 0)
	return COMPONENT_NO_CHASM_DROP

/obj/item/climbing_hook/emergency/safeguard/proc/try_rescue(mob/living/user, turf/chasm_turf)
	var/list/possible_turfs = list()
	for(var/turf/T in orange(2, chasm_turf))
		if(!T.density && !T.GetComponent(/datum/component/chasm) && isopenturf(T))
			possible_turfs += T
	if(!length(possible_turfs))
		drop_back(user, chasm_turf)
		return
	var/turf/safe_turf = pick(possible_turfs)
	if(!safe_turf)
		drop_back(user, chasm_turf)
		return
	rescue_user(user, chasm_turf, safe_turf)
	attempting = FALSE

/obj/item/climbing_hook/emergency/safeguard/proc/rescue_user(mob/living/user, turf/chasm_turf, turf/safe_turf)
	chasm_turf.Beam(safe_turf, icon_state = "zipline_hook", time = 1 SECONDS)
	playsound(user, 'sound/items/weapons/zipline_fire.ogg', 50)
	chasm_turf.visible_message(span_warning("A climbing rope shoots out from [user] and latches onto [safe_turf]! [user] is pulled to safety!"))
	user.take_bodypart_damage(20)
	user.forceMove(safe_turf)
	user.Paralyze(5 SECONDS)
	var/datum/component/chasm/chasm_comp = chasm_turf.GetComponent(/datum/component/chasm)
	chasm_comp?.falling_atoms -= WEAKREF(user)

/obj/item/climbing_hook/emergency/safeguard/proc/drop_back(mob/living/user, turf/chasm_turf)
	attempting = FALSE
	var/datum/component/chasm/chasm_comp = chasm_turf.GetComponent(/datum/component/chasm)
	chasm_comp?.drop(user)
