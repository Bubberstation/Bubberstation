#define CHOICE_SUPERMATTER "Supermatter Crystal"
#define CHOICE_RBMK "RB-MK2 Reactor"

/obj/machinery/power/supermatter_crystal/Initialize(mapload)

	. = ..()

	if(mapload && is_main_engine && isturf(src.loc))
		new/obj/structure/engine_choice(src.loc)
		return INITIALIZE_HINT_QDEL

/obj/structure/engine_choice

	name = "engine choice beacon"
	desc = "A clusterfuck of wiring and components that somehow allows you to select the desired engine you want for the shift. Selection is permanent and cannot be reversed. Cannot be moved. Can be destroyed with a mulitool, with a considerable delay."

	icon = 'modular_zubbers/icons/obj/structures/engine_choice.dmi'
	icon_state = "choice"

	anchored = TRUE
	density = FALSE

	layer = TABLE_LAYER
	obj_flags = CAN_BE_HIT
	pass_flags = LETPASSTHROW

	var/used = FALSE //Safety to prevent race conditions, such as when multiple people select it at once.

	var/obj/item/radio/radio
	var/radio_key = /obj/item/encryptionkey/headset_eng
	var/channel_to_use = RADIO_CHANNEL_ENGINEERING
	var/deployment_time = 8 SECONDS

/obj/structure/engine_choice/Initialize(mapload)
	. = ..()
	radio = new(src)
	radio.keyslot = new radio_key
	radio.set_listening(FALSE)
	radio.recalculateChannels()

/obj/structure/engine_choice/Destroy()
	. = ..()
	QDEL_NULL(radio)

/obj/structure/engine_choice/attack_hand(mob/living/user, list/modifiers)

	. = ..()

	if(.)
		return

	display_options(user)


/obj/structure/engine_choice/multitool_act(mob/living/user, obj/item/multitool/tool)

	if(!can_use(user))
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

	var/turf/center_turf = get_turf(src)

	message_admins("[user] has deleted [src][ADMIN_VERBOSEJMP(center_turf)]")
	log_game("[user] has deleted [src] [AREACOORD(center_turf)]")
	user.investigate_log("deleted [src] [AREACOORD(center_turf)]", INVESTIGATE_ENGINE)

	playsound(src, SFX_SPARKS, 50, FALSE)

	qdel(src)

	return TRUE

/obj/structure/engine_choice/proc/display_options(mob/user)

	if(!can_use(user))
		return FALSE

	playsound(src, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)

	radio.talk_into(
		src,
		"[user] is currently selecting the engine type to use for the shift.",
		RADIO_CHANNEL_ENGINEERING
	)

	var/choice = tgui_input_list(user, "Which engine would you like to order?", "Select an engine!", list(CHOICE_SUPERMATTER,CHOICE_RBMK))

	if(!choice || !can_use(user))
		return FALSE

	var/turf/center_turf = get_turf(src)

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

	addtimer(CALLBACK(src, PROC_REF(do_deploy), center_turf, choice), deployment_time)


/obj/structure/engine_choice/proc/can_use(mob/user)
	if(used)
		return FALSE
	return user.can_perform_action(src, FORBID_TELEKINESIS_REACH)

/obj/structure/engine_choice/proc/do_deploy(turf/center_turf,choice)

	qdel(src)

	playsound(center_turf,'sound/effects/magic/summonitems_generic.ogg',50,FALSE)

	switch(choice)
		if(CHOICE_SUPERMATTER)
			deploy_supermatter(center_turf)
		if(CHOICE_RBMK)
			deploy_rbmk(center_turf)

/obj/structure/engine_choice/proc/deploy_rbmk(turf/center_turf)
	var/obj/machinery/rbmk2_sniffer/spawned_sniffer = new(center_turf)

	for(var/turf/side_turf in orange(1,center_turf))
		var/obj/machinery/power/rbmk2/preloaded/spawned_rbmk = new(side_turf)
		spawned_sniffer.link_reactor(null,spawned_rbmk)

	new /obj/item/paper/guides/jobs/engi/rbmk2(center_turf)

	new /obj/item/stack/cable_coil/thirty(center_turf)

	new /obj/item/paper/crumpled/rbmk2(center_turf)

	return TRUE

/obj/structure/engine_choice/proc/deploy_supermatter(turf/center_turf)
	new /obj/machinery/power/supermatter_crystal/engine(center_turf)


#undef CHOICE_SUPERMATTER
#undef CHOICE_RBMK
