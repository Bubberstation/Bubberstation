/mob/living/carbon/human/can_equip(obj/item/equip_target, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE, indirect_action = FALSE)
	if(SEND_SIGNAL(src, COMSIG_HUMAN_EQUIPPING_ITEM, equip_target, slot) == COMPONENT_BLOCK_EQUIP)
		return FALSE
	if(HAS_TRAIT_NOT_FROM(equip_target, TRAIT_NODROP, TRAIT_GLUED_ITEM) && (equip_target in held_items))
		if(!disable_warning)
			to_chat(src, span_warning("[equip_target] won't budge, it's impossible to put it on!"))
		return FALSE
	return dna.species.can_equip(equip_target, slot, disable_warning, src, bypass_equip_delay_self, ignore_equipped, indirect_action)
