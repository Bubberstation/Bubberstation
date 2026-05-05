/**
 * ## DANGEROUS ORGAN REMOVAL ELEMENT
 *
 * Makes the organ explode when removed (potentially surgically!).
 * That's about it.
 */
/datum/element/dangerous_organ_removal
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2

	/// whether the removal needs to be surgical for it to explode. If you're adding more modes, just pass the signal directly instead
	var/surgical
	/// whether the removal causes the organ to qdel
	var/annihilate

/datum/element/dangerous_organ_removal/Attach(datum/target, surgical = FALSE, annihilate = TRUE) //BUBBER EDIT - Adds new variable to make organ not qdel
	. = ..()
	if(!isorgan(target))
		return ELEMENT_INCOMPATIBLE

	src.surgical = surgical
	src.annihilate = annihilate

	if(surgical)
		RegisterSignal(target, COMSIG_ORGAN_SURGICALLY_REMOVED, PROC_REF(on_removal))
	else
		RegisterSignal(target, COMSIG_ORGAN_REMOVED, PROC_REF(on_removal))

/datum/element/dangerous_organ_removal/Detach(datum/source)
	. = ..()

	UnregisterSignal(source, list(COMSIG_ORGAN_SURGICALLY_REMOVED, COMSIG_ORGAN_REMOVED))

/datum/element/dangerous_organ_removal/proc/on_removal(obj/item/organ/source, mob/living/user, mob/living/carbon/old_owner, target_zone, obj/item/tool)
	SIGNAL_HANDLER

	if(surgical && source.organ_flags & (ORGAN_FAILING|ORGAN_EMP))
		return
	if(user?.Adjacent(source))
		source.audible_message("[source] explodes on [user]'s face!")
		user.take_bodypart_damage(15)
	else
		source.audible_message("[source] explodes into tiny pieces!")

	explosion(source, light_impact_range = 1, explosion_cause = source)
	//BUBBER EDIT - if it doesn't qdel, set it to take all its health in damage
	//qdel(source)
	if(annihilate)
		qdel(source)
	else
		source.set_organ_damage(source.maxHealth)
	//EDIT END
