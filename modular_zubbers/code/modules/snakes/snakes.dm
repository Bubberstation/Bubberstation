/mob/living/basic/snake
	worn_slot_flags = ITEM_SLOT_NECK
	head_icon = 'modular_zubbers/code/modules/snakes/snakes.dmi'

/mob/living/basic/snake/Initialize(mapload, special_reagent)
	. = ..()
	AddElement(/datum/element/can_be_held)
