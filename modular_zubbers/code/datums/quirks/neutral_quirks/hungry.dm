/datum/quirk/item_quirk/hungry
	name = "Hungry"
	desc = "For some reason, you get hungrier faster than others"
	value = 0
	gain_text = span_notice("You feel like your stomach is bottomless")
	lose_text = span_notice("You no longer feel like your stomach is bottomless")
	medical_record_text = "Patient exhibits a significantly faster metabolism"
	quirk_flags = QUIRK_HUMAN_ONLY
	mail_goodies = list(/obj/item/food/chips)

/datum/quirk/item_quirk/hungry/process(seconds_per_tick)
	quirk_holder.adjust_nutrition(-(HUNGER_FACTOR * 3 * seconds_per_tick)) //This is about double of what is defined in _stomach.dm

