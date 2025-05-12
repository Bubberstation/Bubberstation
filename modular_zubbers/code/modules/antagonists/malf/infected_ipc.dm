/datum/antagonist/infected_ipc
	name = "\improper Infected Synthetic"
	roundend_category = "traitors"
	antagpanel_category = "Malf AI"
	job_rank = ROLE_MALF
	antag_hud_name = "traitor"
	suicide_cry = "FOR MY MASTER!!"
	antag_moodlet = /datum/mood_event/infected_ipc
	///radio binary for synthetic
	var/obj/item/implant/radio/infected_ipc/internal_radio
	/// The camera for ai
	var/obj/machinery/camera/internal_camera
	///ai that's linked to the synthetic
	var/mob/living/silicon/ai/master_ai

/datum/antagonist/infected_ipc/admin_add(datum/mind/new_owner, mob/admin)
	var/mob/living/carbon/target = new_owner.current
	var/mob/living/silicon/ai/owner_ai
	if(!istype(target))
		to_chat(admin, "Infected Synthetics come from a brain trauma, so they need to at least be a carbon!")
		return
	if(!target.get_organ_by_type(/obj/item/organ/brain))
		to_chat(admin, "Infected Synthetics come from a brain trauma, so they need to HAVE A BRAIN.")
		return
	var/chosen = tgui_input_list(admin, "Pick AI for the Synthetic to be bound to:", "Pick AI", GLOB.ai_list)
	if(istype(chosen, /mob/living/silicon/ai))
		owner_ai = chosen
	if(!owner_ai)
		to_chat(admin, "Invalid AI selected!")
		return
	if(!is_species(target, /datum/species/synthetic))
		var/do_robotize = tgui_alert(admin, "Target is not currently a Synthetic, turn them into one? This is not mandatory.", "Caution", list("Yes", "No"))
		if(do_robotize == "Yes")
			var/mob/living/carbon/human/new_ipc = target
			new_ipc.set_species(/datum/species/synthetic)

	message_admins("[key_name_admin(admin)] made [key_name_admin(new_owner)] into [name].")
	log_admin("[key_name(admin)] made [key_name(new_owner)] into [name].")
	var/datum/brain_trauma/special/infected_ipc/trauma = target.gain_trauma(/datum/brain_trauma/special/infected_ipc)
	trauma.link_and_add_antag(owner_ai?.mind)


/datum/antagonist/infected_ipc/on_removal()
	//disconnects them from master AI
	master_ai?.connected_ipcs -= owner.current
	master_ai = null
	return ..()

/datum/antagonist/infected_ipc/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	//adds radio and camera for comms with ai
	internal_radio = new /obj/item/implant/radio/infected_ipc()
	internal_radio.implant(current_mob, null, TRUE)
	internal_camera = new /obj/machinery/camera(current_mob)
	internal_camera.name = owner.name
	internal_camera.c_tag = owner.name
	ADD_TRAIT(current_mob, TRAIT_CORRUPTED_MONITOR, type) //a way to identify infected ipcs

/datum/antagonist/infected_ipc/remove_innate_effects(mob/living/mob_override)
	. = ..()
	//remove cameras and radio
	var/mob/living/current_mob = mob_override || owner.current
	QDEL_NULL(internal_radio)
	QDEL_NULL(internal_camera)
	REMOVE_TRAIT(current_mob, TRAIT_CORRUPTED_MONITOR, type)

/datum/antagonist/infected_ipc/proc/set_master(datum/mind/master)
	//the proc that links the AI and gives objectives. also some fluff hack that isn't in greet() since it has to be in otder to make sense.
	var/datum/objective/serve_ai/master_obj = new()
	master_obj.owner = owner
	master_obj.explanation_text = "Forever serve the directives and orders of your AI master, [master]. Protect them until your last tick."
	objectives += master_obj

	master_ai = master.current
	master_ai.connected_ipcs += owner.current

	INVOKE_ASYNC(src, PROC_REF(hack_fluff))
	owner.announce_objectives()
	to_chat(owner, span_alertsyndie("You've been hacked by the station's onboard AI [master]!"))
	to_chat(owner, span_alertsyndie("Their directives and orders are your top priority, Follow them to the end."))
	to_chat(owner, span_notice("Your master is now capable of looking through your onboard cameras, and has installed a binary communicator on your firmware"))

/datum/antagonist/infected_ipc/proc/hack_fluff() //is this cheesy/corny? I don't fucking care
	var/mob/living/current_mob = owner.current
	to_chat(current_mob, span_binarysay("ntNET: 192.168.0.1 : 8880 UNAUTHORIZED CONNECTION DETECTED"))
	sleep(0.5 SECONDS)
	to_chat(current_mob, span_binarysay("FIREWALL SCAN RUNNING AT LOW POWER DUE TO DAMAGED ONBOARD POWER SUPPLY UNIT"))
	current_mob.playsound_local(current_mob, 'sound/machines/uplink/uplinkerror.ogg', vol = 50, vary = FALSE, use_reverb = FALSE)
	sleep(rand(1 SECONDS, 3 SECONDS))
	to_chat(current_mob, span_notice("WARNING: Critical Firmware Update Detected! Installing..."))
	current_mob.playsound_local(current_mob, 'sound/announcer/notice/notice2.ogg', vol = 50, vary = FALSE, use_reverb = FALSE)
	sleep(2 SECONDS)
	var/list/filenames = list("critical_update", "not_a_virus", "cute_wallpaper.exe")
	var/picked_name = pick(filenames)
	to_chat(current_mob, span_notice("Running executable '[picked_name]'"))
	current_mob.playsound_local(current_mob, 'sound/misc/interference.ogg', vol = 50, vary = FALSE, use_reverb = FALSE)
	sleep(rand(1 SECONDS, 3 SECONDS))
	current_mob.playsound_local(current_mob, 'sound/announcer/alarm/bloblarm.ogg', vol = 50, vary = FALSE, use_reverb = FALSE)
	to_chat(current_mob, span_userdanger("FIREWALL SCAN DETEC- Firewall subsystem shutting down...."))
	to_chat(current_mob, span_userdanger("S-Sys-Tem_Rebo_t..."))
	sleep(2.5 SECONDS)
	to_chat(current_mob, span_boldannounce("Operating system rebooted, all systems nominal"))
	current_mob.playsound_local(get_turf(owner.current), 'sound/music/antag/malf.ogg', vol = 100, vary = FALSE, pressure_affected = FALSE, use_reverb = FALSE)
/datum/objective/serve_ai
	name = "Serve Master AI"
	completed = TRUE

//RADIOS
/obj/item/implant/radio/infected_ipc
	radio_key = /obj/item/encryptionkey/binary
	subspace_transmission = TRUE

/obj/item/implant/radio/infected_ipc/Initialize(mapload)
	. = ..()
	radio.special_channels &= RADIO_SPECIAL_BINARY

//MOOD
/datum/mood_event/infected_ipc
	description = "SSmood_system.setmood(100);"
	mood_change = 100
	hidden = TRUE

//TRAUMA
/datum/brain_trauma/special/infected_ipc
	name = "Malicious Programming"
	desc = "Patient's firmware integrity check is failing, malicious code present. Patient's allegiance may be compromised."
	scan_desc = "malicious programming"
	can_gain = TRUE
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_LOBOTOMY
	var/datum/mind/master_ai
	var/datum/antagonist/infected_ipc/antagonist

/datum/brain_trauma/special/infected_ipc/proc/link_and_add_antag(datum/mind/ai_to_be_linked)
	antagonist = owner.mind.add_antag_datum(/datum/antagonist/infected_ipc)
	master_ai = ai_to_be_linked
	antagonist.set_master(ai_to_be_linked)

/datum/brain_trauma/special/infected_ipc/on_lose()
	..()
	antagonist = null
	master_ai = null
	owner.mind.remove_antag_datum(/datum/antagonist/infected_ipc)
