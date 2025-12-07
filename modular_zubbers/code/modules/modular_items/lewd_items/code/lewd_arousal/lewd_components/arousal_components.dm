/datum/component/change_arousal_on_life/Initialize(...)
	. = ..()
	if (!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_LIVING_LIFE, PROC_REF(on_life))

/datum/component/change_arousal_on_life/proc/on_life()
	//the actual meat that makes your meat rise
	SIGNAL_HANDLER
	var/mob/living/carbon/human/humanoid = parent
	if (humanoid.arousal + 5 < humanoid.arousal_goal)
		humanoid.adjust_arousal(5)
	else if (humanoid.arousal < humanoid.arousal_goal)
		humanoid.adjust_arousal(1)
	if (humanoid.arousal_goal == AROUSAL_MINIMUM)
		qdel(src)
