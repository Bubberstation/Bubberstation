/datum/quirk/dnr/post_add()
	quirk_holder.AddElement(/datum/element/dnr)

	return ..()

/datum/quirk/dnr/remove()
	quirk_holder.RemoveElement(/datum/element/dnr)

	return ..()

/datum/element/dnr/
	element_flags = ELEMENT_DETACH_ON_HOST_DESTROY

/datum/element/dnr/proc/apply_dnr(mob/living/holder)
	holder.ghostize()
	var/mob/dead/observer/dnr_person = holder.mind.get_ghost(even_if_they_cant_reenter = TRUE)
	dnr_person.can_reenter_corpse = FALSE
	holder.med_hud_set_status()
	dnr_person.stay_dead()
	dnr_person.log_message("had their player ([key_name(src)]) do-not-resuscitate / DNR automatically via trait.", LOG_GAME, color = COLOR_GREEN, log_globally = FALSE)
	if(!holder.has_quirk(/datum/quirk/dnr))
		holder.add_quirk(/datum/quirk/dnr)
	addtimer(CALLBACK(src, PROC_REF(cleanup), holder), 60 SECONDS)
	message_admins("[holder] has died with DNR trait & element, releasing job slot in 60 seconds.")

/datum/element/dnr/proc/cleanup(mob/living/holder) // What if they gib, though?
	var/datum/job/job_to_free = SSjob.get_job(holder.mind.assigned_role.title)
	job_to_free.current_positions--
	holder.log_message("has been released via their current body via DNR trait - ([holder])", LOG_GAME, color = COLOR_GREEN)
	holder.mind = null

/datum/element/dnr/Attach(mob/living/target)
	. = ..()
	if(!isliving(target))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_LIVING_DEATH, PROC_REF(apply_dnr))
/datum/element/dnr/Detach(mob/living/target, ...)
	. = ..()
	UnregisterSignal(target, COMSIG_LIVING_DEATH)
