/obj/item/clothing/suit/bluetag
	name = "blue laser tag armor"
	desc = "A piece of plastic armor. It has sensors that react to red light." //Lasers are concentrated light
	icon_state = "bluetag"
	icon = 'icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	inhand_icon_state = null
	blood_overlay_type = "armor"
	body_parts_covered = CHEST
	allowed = list (/obj/item/gun/energy/laser/bluetag)
	resistance_flags = NONE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/bluetag/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(when_equipped))
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(when_dropped))

/obj/item/clothing/suit/bluetag/proc/when_equipped(mob/equipper, slot)
	SIGNAL_HANDLER
	to_chat(equipper, span_yellow("DEBUG: Adding Component."))
	if (slot != ITEM_SLOT_OCLOTHING)
		return
	var/mob/living/carbon/human/wearer = equipper
	wearer.AddComponent(/datum/component/lasertag)
	var/datum/component/lasertag/comp = wearer.GetComponent(/datum/component/lasertag)
	comp.team_color = "blue"
	comp.lasertag_granters += src

/obj/item/clothing/suit/bluetag/proc/when_dropped(mob/living/user)
	. = ..()
	var/mob/living/carbon/human/wearer = user
	var/datum/component/lasertag/comp = wearer.GetComponent(/datum/component/lasertag)
	if (comp.should_delete(src))
		to_chat(wearer, span_yellow("DEBUG: Removed Component."))
		qdel(comp)

/obj/item/clothing/suit/redtag
	name = "red laser tag armor"
	desc = "A piece of plastic armor. It has sensors that react to blue light."
	icon_state = "redtag"
	icon = 'icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	inhand_icon_state = null
	blood_overlay_type = "armor"
	body_parts_covered = CHEST
	allowed = list (/obj/item/gun/energy/laser/redtag)
	resistance_flags = NONE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/redtag/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(when_equipped))
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(when_dropped))

/obj/item/clothing/suit/redtag/proc/when_equipped(mob/equipper, slot)
	SIGNAL_HANDLER
	to_chat(equipper, span_yellow("DEBUG: Adding Component."))
	if (slot != ITEM_SLOT_OCLOTHING)
		return
	var/mob/living/carbon/human/wearer = equipper
	wearer.AddComponent(/datum/component/lasertag)
	var/datum/component/lasertag/comp = wearer.GetComponent(/datum/component/lasertag)
	comp.team_color = "red"
	comp.lasertag_granters += src


/obj/item/clothing/suit/redtag/proc/when_dropped(mob/living/user)
	. = ..()
	var/mob/living/carbon/human/wearer = user
	var/datum/component/lasertag/comp = wearer.GetComponent(/datum/component/lasertag)
	if (comp.should_delete(src))
		to_chat(wearer, span_yellow("DEBUG: Removed Component."))
		qdel(comp)
