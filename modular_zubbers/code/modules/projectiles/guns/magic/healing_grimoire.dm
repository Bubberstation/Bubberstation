/obj/item/gun/magic/healing_grimoire
	name = "Healing Grimoire"
	desc = "An entry-level Grimoire of healing incantation, you must have it on your belt to channel it's healing powers, all volumes will self destroy after reaching central command for safety reasons."
	icon = 'icons/obj/service/library.dmi'
	icon_state ="book"
	worn_icon_state = "book"
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL // equipeable in belt slot and in hand, not in pocket
	actions_types = list(/datum/action/cooldown/spell/pointed/healing_light) // gives actions whenever you have the item on "you", hands, belt, clothe, pockets whats have you.
	action_slots = ITEM_SLOT_BELT // limit how the action is given, for instance here the grimoire need to be in the belt slot to give the action.
