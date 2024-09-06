/mob/living/carbon/human
	/// Are we currently in combat focus?
	var/combat_focus = FALSE

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/mob_holder/micro)

/mob/living/carbon/human/on_entered(datum/source, mob/living/carbon/human/moving)
	. = ..()
	if(istype(moving) && resting && resolve_intent_name(moving.combat_mode) != "help")
		moving.handle_micro_bump_other(src)
