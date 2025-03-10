/obj/machinery/public_nanite_chamber
	name = "public nanite chamber"
	desc = "A device that can rapidly implant cloud-synced nanites without an external operator."
	circuit = /obj/item/circuitboard/machine/public_nanite_chamber
	icon = 'icons/obj/machines/bci_implanter.dmi'
	icon_state = "bci_implanter"
	base_icon_state = "bci_implanter"
	layer = ABOVE_WINDOW_LAYER
	use_power = IDLE_POWER_USE
	anchored = TRUE
	density = TRUE
	idle_power_usage = 50
	active_power_usage = 300

	var/cloud_id = 1
	var/locked = FALSE
	var/breakout_time = 1200
	var/busy = FALSE
	var/busy_icon_state
	var/message_cooldown = 0

/obj/machinery/public_nanite_chamber/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	occupant_typecache = GLOB.typecache_living

/obj/machinery/public_nanite_chamber/RefreshParts()
	. = ..()
	var/obj/item/circuitboard/machine/public_nanite_chamber/board = circuit
	if(board)
		cloud_id = board.cloud_id

/obj/machinery/public_nanite_chamber/proc/set_busy(status, working_icon)
	busy = status
	busy_icon_state = working_icon
	update_appearance()

/obj/machinery/public_nanite_chamber/proc/inject_nanites(mob/living/attacker)
	if(machine_stat & (NOPOWER|BROKEN))
		return
	if((machine_stat & MAINT) || panel_open)
		return
	if(!occupant || busy)
		return

	var/locked_state = locked
	locked = TRUE

	//TODO OMINOUS MACHINE SOUNDS
	set_busy(TRUE, "[initial(icon_state)]_raising")
	addtimer(CALLBACK(src, .proc/set_busy, TRUE, "[initial(icon_state)]_active"),20)
	addtimer(CALLBACK(src, .proc/set_busy, TRUE, "[initial(icon_state)]_falling"),60)
	addtimer(CALLBACK(src, .proc/complete_injection, locked_state, attacker),80)

/obj/machinery/public_nanite_chamber/proc/complete_injection(locked_state, mob/living/attacker)
	//TODO MACHINE DING
	locked = locked_state
	set_busy(FALSE)
	if(!occupant)
		return
	if(attacker)
		occupant.investigate_log("was injected with nanites with cloud ID [cloud_id] by [key_name(attacker)] using [src] at [AREACOORD(src)].", INVESTIGATE_NANITES)
		log_combat(attacker, occupant, "injected", null, "with nanites via [src]")
	occupant.AddComponent(/datum/component/nanites, 75, cloud_id)

/obj/machinery/public_nanite_chamber/proc/change_cloud(mob/living/attacker)
	if(machine_stat & (NOPOWER|BROKEN))
		return
	if((machine_stat & MAINT) || panel_open)
		return
	if(!occupant || busy)
		return

	var/locked_state = locked
	locked = TRUE

	set_busy(TRUE, "[initial(icon_state)]_raising")
	addtimer(CALLBACK(src, .proc/set_busy, TRUE, "[initial(icon_state)]_active"),20)
	addtimer(CALLBACK(src, .proc/set_busy, TRUE, "[initial(icon_state)]_falling"),40)
	addtimer(CALLBACK(src, .proc/complete_cloud_change, locked_state, attacker),60)

/obj/machinery/public_nanite_chamber/proc/complete_cloud_change(locked_state, mob/living/attacker)
	locked = locked_state
	set_busy(FALSE)
	if(!occupant)
		return
	if(attacker)
		occupant.investigate_log("had their nanite cloud ID changed into [cloud_id] by [key_name(attacker)] using [src] at [AREACOORD(src)].", INVESTIGATE_NANITES)
	SEND_SIGNAL(occupant, COMSIG_NANITE_SET_CLOUD, cloud_id)

/obj/machinery/public_nanite_chamber/update_icon_state()
	//running and someone in there
	if(occupant)
		icon_state = busy ? busy_icon_state : "[base_icon_state]_occupied"
		return ..()
	//running
	icon_state = "[base_icon_state][state_open ? "_open" : null]"
	return ..()

/obj/machinery/public_nanite_chamber/update_overlays()
	. = ..()
	if((machine_stat & MAINT) || panel_open)
		. += "maint"
		return
	if(machine_stat & (NOPOWER|BROKEN))
		return

	if(busy || locked)
		. += "red"
		if(locked)
			. += "bolted"
		return
	. += "green"

/obj/machinery/public_nanite_chamber/proc/toggle_open(mob/user)
	if(panel_open)
		to_chat(user, span_notice("Close the maintenance panel first."))
		return

	if(state_open)
		close_machine(null, user)
		return

	else if(locked)
		to_chat(user, span_notice("The bolts are locked down, securing the door shut."))
		return

	open_machine()

/obj/machinery/public_nanite_chamber/container_resist_act(mob/living/user)
	if(!locked)
		open_machine()
		return
	if(busy)
		return
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(span_notice("You see [user] kicking against the door of [src]!"), \
		span_notice("You lean on the back of [src] and start pushing the door open... (this will take about [DisplayTimeText(breakout_time)].)"), \
		span_hear("You hear a metallic creaking from [src]."))
	if(do_after(user,(breakout_time), target = src))
		if(!user || user.stat != CONSCIOUS || user.loc != src || state_open || !locked || busy)
			return
		locked = FALSE
		user.visible_message(span_warning("[user] successfully broke out of [src]!"), \
			span_notice("You successfully break out of [src]!"))
		open_machine()

/obj/machinery/public_nanite_chamber/close_machine(mob/living/carbon/user, density_to_set = TRUE)
	if(!state_open)
		return FALSE

	..()

	. = TRUE

	addtimer(CALLBACK(src, .proc/try_inject_nanites, user), 3 SECONDS) //If someone is shoved in give them a chance to get out before the injection starts

/obj/machinery/public_nanite_chamber/proc/try_inject_nanites(mob/living/attacker)
	if(occupant)
		var/mob/living/L = occupant
		if(SEND_SIGNAL(L, COMSIG_HAS_NANITES))
			var/datum/component/nanites/nanites = L.GetComponent(/datum/component/nanites)
			if(nanites && nanites.cloud_id != cloud_id)
				change_cloud(attacker)
			return
		if(CAN_HAVE_NANITES(L))
			inject_nanites(attacker)

/obj/machinery/public_nanite_chamber/open_machine(drop = TRUE, density_to_set = FALSE)
	. = ..()
	if(state_open)
		return FALSE

	..()

	return TRUE

/obj/machinery/public_nanite_chamber/relaymove(mob/living/user, direction)
	if(user.stat || locked)
		if(message_cooldown <= world.time)
			message_cooldown = world.time + 50
			to_chat(user, span_warning("[src]'s door won't budge!"))
		return
	open_machine()

/obj/machinery/public_nanite_chamber/attackby(obj/item/I, mob/user, params)
	if(!occupant && default_deconstruction_screwdriver(user, icon_state, icon_state, I))//sent icon_state is irrelevant...
		update_appearance()//..since we're updating the icon here, since the scanner can be unpowered when opened/closed
		return

	if(default_pry_open(I))
		return

	if(default_deconstruction_crowbar(I))
		return

	return ..()

/obj/machinery/public_nanite_chamber/interact(mob/user)
	toggle_open(user)

/obj/machinery/public_nanite_chamber/mouse_drop_receive(mob/living/M, mob/user, params)
	if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH | SILENT_ADJACENCY) || !iscarbon(M))
		return
	if(close_machine(M, user))
		log_combat(user, M, "inserted", null, "into [src].")
	add_fingerprint(user)
