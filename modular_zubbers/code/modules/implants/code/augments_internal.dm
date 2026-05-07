//BRAIN IMPLANTS

/obj/item/organ/cyberimp/brain/wound_scanner
	name = "internal wound analyzer chip"
	desc = "A cheap implanted health monitoring chip to scan for wounds and give treatment instructions, relayed to the brain."
	slot = ORGAN_SLOT_BRAIN_AID
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "cpu_super"
	actions_types = list(/datum/action/item_action/organ_action/use/fakescanner)
	w_class = WEIGHT_CLASS_SMALL
	var/obj/item/healthanalyzer/simple/fakescanner

/obj/item/organ/cyberimp/brain/wound_scanner/Initialize(mapload)
	. = ..()
	fakescanner = new /obj/item/healthanalyzer/simple

/datum/action/item_action/organ_action/use/fakescanner
	desc = "Activate to get detailed wound treatment information relayed to your brain."

/datum/action/item_action/organ_action/use/fakescanner/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/cyberimp/brain/wound_scanner/our_scanner = target
	woundscan(owner, owner, our_scanner.fakescanner, simple_scan = TRUE)


///obj/item/healthanalyzer/simple/fakescanner
	//RegisterSignal(implant_owner, COMSIG_CARBON_SELF_CHECK_FOR_INJURIES, PROC_REF(usescanner))
		//SIGNAL_HANDLER
		///obj/item/organ/cyberimp/brain/wound_scanner/proc/usescanner


///obj/item/organ/cyberimp/brain/wound_scanner/proc/usescanner
	//woundscan(owner, owner, our_scanner.fakescanner, simple_scan = TRUE)
		//return
