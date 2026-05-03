/obj/item/organ/cyberimp/chest/wound_scanner
	name = "internal wound analyzer"
	desc = "A cheap implanted health monitor to scan for wounds and give treatment instructions, relayed to the brain."
	slot = ORGAN_SLOT_SCANNER
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "first_aid"
	actions_types = list(/datum/action/item_action/organ_action/use/fakescanner)
	w_class = WEIGHT_CLASS_SMALL
	var/obj/item/healthanalyzer/simple/fakescanner

/obj/item/organ/cyberimp/chest/wound_scanner/Initialize(mapload)
	. = ..()
	fakescanner = new /obj/item/healthanalyzer/simple

/datum/action/item_action/organ_action/use/fakescanner
	desc = "Activate to get detailed wound treatment information relayed to your brain."

/datum/action/item_action/organ_action/use/fakescanner/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/cyberimp/chest/wound_scanner/our_scanner = target
	woundscan(owner, owner, our_scanner.fakescanner, simple_scan = TRUE)
