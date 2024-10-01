/datum/component/synthlaws
	var/mob/living/carbon/synth = parent
/datum/component/synthlaws/Initialize(...)
	if(!iscarbon(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/silicon/robot/brain_borg = new(src)
	brain_borg.real_name = synth.real_name
