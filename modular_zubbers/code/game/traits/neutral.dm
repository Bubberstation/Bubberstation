/datum/quirk/dnr/post_add()
	quirk_holder.AddElement(/datum/element/dnr)

	return ..()

/datum/quirk/dnr/remove()
	quirk_holder.RemoveElement(/datum/element/dnr)

	return ..()

/datum/element/dnr/
	element_flags = ELEMENT_DETACH_ON_HOST_DESTROY

/datum/element/dnr/proc/apply_dnr(mob/living/holder)
	if(IS_CHANGELING(holder) || IS_BLOODSUCKER(holder))
		return
	holder.ghostize()
	var/mob/dead/observer/owner_ghost = holder.get_ghost()
	if(isnull(owner_ghost))
		return
	owner_ghost.stay_dead()
	owner_ghost.log_message("had their player ([key_name(src)]) do-not-resuscitate / DNR automatically via trait.", LOG_GAME, color = COLOR_GREEN, log_globally = FALSE)

/datum/element/dnr/Attach(mob/living/target)
	. = ..()
	if(!isliving(target))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_LIVING_DEATH, PROC_REF(apply_dnr))

/datum/element/dnr/Detach(mob/living/target, ...)
	. = ..()
	UnregisterSignal(target, COMSIG_LIVING_DEATH)
