#define BASE_DISCONNECT_DAMAGE 40


/obj/machinery/netpod
	name = "netpod"

	base_icon_state = "netpod"
	circuit = /obj/item/circuitboard/machine/netpod
	desc = "A link to the netverse. It has an assortment of cables to connect yourself to a virtual domain."
	icon = 'icons/obj/machines/bitrunning.dmi'
	icon_state = "netpod"
	max_integrity = 300
	obj_flags = BLOCKS_CONSTRUCTION
	state_open = TRUE
	interaction_flags_mouse_drop = NEED_HANDS | NEED_DEXTERITY

	/// Whether we have an ongoing connection
	var/connected = FALSE
	/// A player selected outfit by clicking the netpod
	var/datum/outfit/netsuit = /datum/outfit/job/bitrunner
	/// Holds this to see if it needs to generate a new one
	var/datum/weakref/avatar_ref
	/// The linked quantum server
	var/datum/weakref/server_ref
	/// The amount of brain damage done from force disconnects
	var/disconnect_damage
	/// Static list of outfits to select from
	var/list/cached_outfits = list()
	/// Determines our ID for what bitrunning machinery we're linked to.
	var/bitrunning_id = "DEFAULT"
	/// Is this a trapped pod, ie. doesn't move damage to the host and revives you if you die?
	var/trapped = FALSE
	/// If trapped, how long does it take to break out?
	var/breakout_time = 10 SECONDS
	/// What account do we pay out to for Security pods?
	var/datum/bank_account/payout_account


/obj/machinery/netpod/post_machine_initialize()
	. = ..()

	disconnect_damage = BASE_DISCONNECT_DAMAGE
	find_server()

	RegisterSignal(src, COMSIG_ATOM_TAKE_DAMAGE, PROC_REF(on_damage_taken))
	RegisterSignal(src, COMSIG_MACHINERY_POWER_LOST, PROC_REF(on_power_loss))
	RegisterSignals(src, list(COMSIG_QDELETING,	COMSIG_MACHINERY_BROKEN),PROC_REF(on_broken))

	register_context()
	update_appearance()


/obj/machinery/netpod/Destroy()
	. = ..()

	QDEL_LIST(cached_outfits)


/obj/machinery/netpod/examine(mob/user)
	. = ..()

	if(isnull(server_ref?.resolve()))
		. += span_infoplain("It's not connected to anything.")
		. += span_infoplain("Netpods must be built within 4 tiles of a server.")
		return

	if(!isobserver(user))
		. += span_infoplain("Drag yourself into the pod to engage the link.")
		. += span_infoplain("It has limited resuscitation capabilities. Remaining in the pod can heal some injuries.")
		. += span_infoplain("It has a security system that will alert the occupant if it is tampered with.")

	if(isnull(occupant))
		. += span_infoplain("It's currently unoccupied.")
		return

	. += span_infoplain("It's currently occupied by [occupant].")

	if(isobserver(user))
		. += span_notice("As an observer, you can click this netpod to jump to its avatar.")
		return

	. += span_notice("It can be pried open with a crowbar, but its safety mechanisms will alert the occupant.")


/obj/machinery/netpod/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "Select Outfit"
		return CONTEXTUAL_SCREENTIP_SET

	if(istype(held_item, /obj/item/crowbar) && occupant)
		context[SCREENTIP_CONTEXT_LMB] = "Pry Open"
		return CONTEXTUAL_SCREENTIP_SET


/obj/machinery/netpod/update_icon_state()
	if(!is_operational)
		icon_state = base_icon_state
		return ..()

	if(state_open)
		icon_state = base_icon_state + "_open_active"
		return ..()

	if(panel_open)
		icon_state = base_icon_state + "_panel"
		return ..()

	icon_state = base_icon_state + "_closed"
	if(occupant)
		icon_state += "_active"

	return ..()


/obj/machinery/netpod/mouse_drop_receive(mob/target, mob/user, params)
	var/mob/living/carbon/player = user

	if(!ismob(target) || !iscarbon(player) || !is_operational || !state_open || player.buckled)
		return

	if(trapped)
		var/mob/living/carbon/human/prisoner = target
		var/mob/living/carbon/human/security = user
		var/obj/machinery/quantum_server/our_server = server_ref?.resolve()
		if(!isnull(our_server))
			our_server.radio.talk_into(our_server, "[security] has placed [prisoner] in [src].", our_server.radio_channel_to_use)
			var/no_payout = FALSE
			if(prisoner == security)
				our_server.radio.talk_into(our_server, "ERROR: User entering [src] on their own; no payout will be provided.", our_server.radio_channel_to_use)
				no_payout = TRUE
			if(!no_payout && HAS_TRAIT(prisoner, TRAIT_MINDSHIELD))
				our_server.radio.talk_into(our_server, "ERROR: User entering [src] has a mindshield; no payout will be provided.", our_server.radio_channel_to_use)
				no_payout = TRUE
			if(!isnull(GLOB.manifest.general))
				for(var/datum/record/crew/record as anything in GLOB.manifest.general)
					if(record.name == target.name)
						record.wanted_status = WANTED_PRISONER
						break
			if(!no_payout)
				var/datum/bank_account/account = security.get_bank_account()
				if(isnull(account))
					return
				payout_account = account
	close_machine(target)


/obj/machinery/netpod/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!state_open && user == occupant && !trapped)
		container_resist_act(user)


/obj/machinery/netpod/attack_ghost(mob/dead/observer/our_observer)
	var/our_target = avatar_ref?.resolve()
	if(isnull(our_target) || !our_observer.orbit(our_target))
		return ..()


/// When the server is upgraded, drops brain damage a little
/obj/machinery/netpod/proc/on_server_upgraded(obj/machinery/quantum_server/source)
	SIGNAL_HANDLER

	disconnect_damage = BASE_DISCONNECT_DAMAGE * (1 - source.servo_bonus)


#undef BASE_DISCONNECT_DAMAGE

/obj/machinery/netpod/prisoner
	name = "torment nexus pod"
	desc = "After an unsuccessful commercial launch, Nanotrasen purchased the rights to the Torment Nexus as a form of new workplace behavioral adjustment program for \
	misbehaving crewmembers. Critics say that this is just like Greg Orville's book, Twenty Five Eighty Four."
	bitrunning_id = BITRUNNER_DOMAIN_SECURITY
	trapped = TRUE

/obj/machinery/netpod/prisoner/solo_1
	name = "torment nexus #1 pod"
	bitrunning_id = "solo_nexus_1"

/obj/machinery/netpod/prisoner/solo_2
	name = "torment nexus #2 pod"
	bitrunning_id = "solo_nexus_2"

/obj/machinery/netpod/prisoner/solo_3
	name = "torment nexus #3 pod"
	bitrunning_id = "solo_nexus_3"

/obj/machinery/netpod/prisoner/coop
	name = "co-operative torment nexus pod"
	bitrunning_id = "coop_nexus"
