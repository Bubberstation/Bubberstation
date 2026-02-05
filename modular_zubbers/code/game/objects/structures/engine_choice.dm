#define CHOICE_SUPERMATTER "Supermatter Crystal"
#define CHOICE_RBMK "RB-MK2 Reactor"

/obj/machinery/power/supermatter_crystal/Initialize(mapload)

	. = ..()

	if(mapload && is_main_engine && isturf(src.loc))
		new/obj/machinery/engine_choice(src.loc)
		return INITIALIZE_HINT_QDEL

/obj/machinery/engine_choice

	name = "engine choice beacon"
	desc = "A clusterfuck of wiring and components that somehow allows you to select the desired engine you want for the shift. \
	Selection is permanent and cannot be reversed after deployment. Can be destroyed with a mulitool, with a considerable delay."

	icon = 'modular_zubbers/icons/obj/structures/engine_choice.dmi'
	icon_state = "choice"

	anchored = TRUE
	density = FALSE

	move_resist = INFINITY //some really fucking strong duct tape

	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	layer = TABLE_LAYER
	obj_flags = CAN_BE_HIT
	pass_flags = LETPASSTHROW

	use_power = NO_POWER_USE
	idle_power_usage = 0
	active_power_usage = 0
	static_power_usage = 0

	obj_flags = DANGEROUS_POSSESSION | IGNORE_DENSITY | NO_DEBRIS_AFTER_DECONSTRUCTION

	var/obj/item/radio/radio
	var/radio_key = /obj/item/encryptionkey/headset_eng
	var/channel_to_use = RADIO_CHANNEL_ENGINEERING
	var/deployment_time = 8 SECONDS

	var/deployment_timer_id

/obj/machinery/engine_choice/Initialize(mapload)
	. = ..()
	radio = new(src)
	radio.keyslot = new radio_key
	radio.set_listening(FALSE)
	radio.recalculateChannels()

/obj/machinery/engine_choice/Destroy()
	. = ..()
	QDEL_NULL(radio)

//Helper interaction for if we can interact with this (called before and after menu selection).
/obj/machinery/engine_choice/proc/can_use(mob/user)
	if(QDELETED(src) || QDESTROYING(src))
		return FALSE
	return user.can_perform_action(src, FORBID_TELEKINESIS_REACH)

/obj/machinery/engine_choice/interact(mob/user)
	display_options(user)

/obj/machinery/engine_choice/multitool_act(mob/living/user, obj/item/multitool/tool)

	if(!can_use(user))
		return TRUE

	if(deployment_timer_id)
		return TRUE

	playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, FALSE)

	radio.talk_into(
		src,
		"[user] is currently removing [src]. If this is not intentional, please contact security.",
		RADIO_CHANNEL_ENGINEERING
	)

	if(!do_after(user, 15 SECONDS, target=src))
		return TRUE

	if(!can_use(user))
		return TRUE

	if(deployment_timer_id)
		return TRUE

	var/turf/center_turf = get_turf(src)

	message_admins("[user] has deleted [src][ADMIN_VERBOSEJMP(center_turf)]")
	log_game("[user] has deleted [src] [AREACOORD(center_turf)]")
	user.investigate_log("deleted [src] [AREACOORD(center_turf)]", INVESTIGATE_ENGINE)

	playsound(src, SFX_SPARKS, 50, FALSE)

	qdel(src)

	return TRUE

/obj/machinery/engine_choice/proc/display_options(mob/user)

	if(!can_use(user))
		return FALSE

	var/turf/center_turf = get_turf(src)

	if(deployment_timer_id) //Timer already exists to deploy.
		playsound(src, 'sound/machines/terminal_alert_short.ogg', 50, FALSE)
		radio.talk_into(
			src,
			"Deployment operation canceled by [user].",
			RADIO_CHANNEL_ENGINEERING
		)
		deltimer(deployment_timer_id)
		deployment_timer_id = null
		message_admins("[user] has canceled the engine type to be used for the shift [ADMIN_VERBOSEJMP(center_turf)]")
		log_game("[user] has canceled the  engine type to be used for the shift [AREACOORD(center_turf)]")
		user.investigate_log("canceled the  engine type to be used for the shift [AREACOORD(center_turf)]", INVESTIGATE_ENGINE)
		return FALSE

	playsound(src, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)

	radio.talk_into(
		src,
		"[user] is currently selecting the engine type to use for the shift.",
		RADIO_CHANNEL_ENGINEERING
	)

	var/choice = tgui_input_list(user, "Which engine would you like to order?", "Select an engine!", list(CHOICE_SUPERMATTER,CHOICE_RBMK))

	if(!choice || !can_use(user) || deployment_timer_id)
		return FALSE

	//Deployment time!

	message_admins("[user] has selected engine type \"[choice]\" to be used for the shift [ADMIN_VERBOSEJMP(center_turf)]")
	log_game("[user] has selected engine type \"[choice]\" to be used for the shift [AREACOORD(center_turf)]")
	user.investigate_log("selected engine type \"[choice]\" to be used for the shift [AREACOORD(center_turf)]", INVESTIGATE_ENGINE)

	radio.talk_into(
		src,
		"[user] has selected option \"[choice]\" to be used for the shift! Stay clear of the deployment zone! ETA: [deployment_time/10] seconds!",
		RADIO_CHANNEL_ENGINEERING
	)

	playsound(src, SFX_SPARKS, 50, FALSE)

	new /obj/effect/temp_visual/telegraphing/big(center_turf, deployment_time)

	deployment_timer_id = addtimer(CALLBACK(src, PROC_REF(do_deploy), center_turf, choice), deployment_time,  TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_STOPPABLE |  TIMER_DELETE_ME)

/obj/machinery/engine_choice/proc/do_deploy(turf/center_turf,choice)

	qdel(src)

	playsound(center_turf,'sound/effects/magic/summonitems_generic.ogg',50,FALSE)

	switch(choice)
		if(CHOICE_SUPERMATTER)
			deploy_supermatter(center_turf)
		if(CHOICE_RBMK)
			deploy_rbmk(center_turf)

//RB-MK2
/obj/machinery/engine_choice/proc/deploy_rbmk(turf/center_turf)

	var/obj/machinery/rbmk2_sniffer/spawned_sniffer = new(center_turf)
	for(var/turf/side_turf in orange(1,center_turf))
		var/obj/machinery/power/rbmk2/preloaded/spawned_rbmk = new(side_turf)
		spawned_sniffer.link_reactor(null,spawned_rbmk)

	new /obj/item/paper/guides/jobs/engi/rbmk2(center_turf)
	new /obj/item/stack/cable_coil/thirty(center_turf)
	new /obj/item/paper/crumpled/rbmk2(center_turf)

//Supermatter
/obj/machinery/engine_choice/proc/deploy_supermatter(turf/center_turf)
	new /obj/machinery/power/supermatter_crystal/engine(center_turf)


#undef CHOICE_SUPERMATTER
#undef CHOICE_RBMK
