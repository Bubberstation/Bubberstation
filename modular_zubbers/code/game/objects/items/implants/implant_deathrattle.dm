/datum/deathrattle_group/register(obj/item/implant/deathrattle/implant)

	. = ..()

	if(.)
		RegisterSignal(implant, COMSIG_ATOM_EMP_ACT, PROC_REF(on_emp_act))

/datum/deathrattle_group/proc/on_emp_act(obj/item/implant/deathrattle/source,severity,protection)

	SIGNAL_HANDLER

	if(!source.imp_in)
		return
	if(protection & EMP_PROTECT_SELF)
		return
	if(prob(20*severity)) //lower severity value means higher strength. doesn't make sense but that's how it is.
		return

	source.imp_in.notify_deathrattle(src,TRUE)

/datum/deathrattle_group/on_user_statchange(mob/living/owner, new_stat)

	SIGNAL_HANDLER

	if(new_stat != DEAD)
		return

	addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob/living,notify_deathrattle), src, FALSE), 10 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_DELETE_ME)

//Handle the living proc.
/mob/living/proc/notify_deathrattle(datum/deathrattle_group/deathrattle_group,emped=FALSE)

	if(!emped && stat != DEAD)
		return

	var/name = src.mind ? src.mind.name : src.real_name
	var/area = get_area_name(get_turf(src))
	// All "hearers" hear the same sound.
	var/sound = pick(
		'sound/items/knell/knell1.ogg',
		'sound/items/knell/knell2.ogg',
		'sound/items/knell/knell3.ogg',
		'sound/items/knell/knell4.ogg',
	)

	for(var/_implant in deathrattle_group.implants)
		var/obj/item/implant/deathrattle/implant = _implant

		// Skip the unfortunate soul, and any unimplanted implants
		if( (!emped && implant.imp_in == src) || !implant.imp_in)
			continue

		// Deliberately the same message framing as ghost deathrattle
		var/mob/living/recipient = implant.imp_in
		to_chat(recipient, "<i>You hear a strange, robotic voice in your head...</i> \"[span_robot("<b>[name]</b> has died at <b>[emped ? pick_list(ION_FILE, "ionarea") : area]</b>.")]\"")
		recipient.playsound_local(get_turf(recipient), sound, vol = 75, vary = FALSE, pressure_affected = FALSE, use_reverb = FALSE)
