/datum/quirk/bloodloss_dusting
	name = "Dusting Sickness"
	desc = "If you run out of blood to the point where a normal person would die, you turn to dust."
	value = -8
	gain_text = span_danger("You start to worry even more about running out of blood.")
	lose_text = span_notice("You feel like running out of blood isn't /quite/ as scary.")
	medical_record_text = "Patient's body has an extreme reaction to bloodloss to the point of crumbling to dust. Keeping blood levels steady recommended."
	icon = FA_ICON_DROPLET_SLASH

/datum/quirk/bloodloss_dusting/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_HUMAN_ON_HANDLE_BLOOD, PROC_REF(on_change_blood))

/datum/quirk/bloodloss_dusting/proc/on_change_blood(mob/living/carbon/human/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER
	if(!istype(source))
		return
	if(source.blood_volume < BLOOD_VOLUME_SURVIVE)
		to_chat(quirk_holder, span_danger("You ran out of blood!"))
		quirk_holder.investigate_log("has been dusted by a lack of blood. Caused by [src.name] quirk", INVESTIGATE_DEATHS)
		quirk_holder.dust()

/datum/quirk/bloodloss_dusting/remove()
	UnregisterSignal(quirk_holder, COMSIG_HUMAN_ON_HANDLE_BLOOD)
