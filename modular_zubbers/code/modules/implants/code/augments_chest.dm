/obj/item/organ/cyberimp/chest/wound_scanner
	name = "internal wound analyzer"
	desc = "A cheap implanted health monitor to scan for wounds and give treatment instructions, relayed to the brain."
	slot = ORGAN_SLOT_SCANNER
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "first_aid"
	actions_types = list(/datum/action/item_action/organ_action/use/internal_wound_analyzer)
	w_class = WEIGHT_CLASS_SMALL
	mode = SCANNER_NO_MODE

/datum/action/item_action/organ_action/use/internal__wound_analyzer
	desc = "Activate to get detailed wound treatment information relayed to your brain."

/datum/action/item_action/organ_action/use/internal_wound_analyzer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/cyberimp/chest/scanner/our_scanner = target
		woundscan(user, scanning, src, simple_scan = TRUE)
