/datum/element/soapbox
	/// The person standing on parent
	var/list/speakers = list()
	/// List of spans we add to the speaker
	var/list/voicespan = list(SPAN_SOAPBOX)

/datum/element/soapbox/Attach(atom/movable/box)
	. = ..()
	RegisterSignal(box, COMSIG_ATOM_ENTERED, PROC_REF(GiveSoapbox))
	RegisterSignal(box, COMSIG_ATOM_EXITED, PROC_REF(TakeSoapbox))
/datum/element/soapbox/Detach(atom/movable/box)
	. = ..()
	for(var/mob/living/speaker as anything in speakers)
		TakeSoapbox(src, speaker)
	UnregisterSignal(box, COMSIG_ATOM_ENTERED)
	UnregisterSignal(box, COMSIG_ATOM_EXITED)

/datum/element/soapbox/proc/GiveSoapbox(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER
	if(!isliving(arrived))
		return
	var/obj/structure/closet/crate/soapbox = source
	speakers += arrived
	if(!soapbox.opened)
		RegisterSignal(arrived, COMSIG_MOB_SAY, PROC_REF(soapbox_speech))

/datum/element/soapbox/proc/TakeSoapbox(datum/source, atom/movable/gone)
	SIGNAL_HANDLER
	speakers -= gone
	UnregisterSignal(gone, COMSIG_MOB_SAY)

/datum/element/soapbox/proc/soapbox_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	speech_args[SPEECH_SPANS] |= voicespan
