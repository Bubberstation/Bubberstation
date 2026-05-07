//BRAIN IMPLANTS

/obj/item/organ/cyberimp/brain/wound_scanner
	name = "internal wound analyzer chip"
	desc = "A simple implanted health monitoring chip to scan for wounds and give treatment instructions, relayed to the brain."
	slot = ORGAN_SLOT_BRAIN_AID
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "cpu_super"
	w_class = WEIGHT_CLASS_SMALL
	var/obj/item/healthanalyzer/simple/fakescanner
	COOLDOWN_DECLARE(rescan_timer)

/obj/item/organ/cyberimp/brain/wound_scanner/Initialize(mapload)
	. = ..()
	fakescanner = new /obj/item/healthanalyzer/simple

/obj/item/organ/cyberimp/brain/wound_scanner/on_mob_insert(mob/living/carbon/receiver)
	. = ..()
	RegisterSignal(receiver, COMSIG_CARBON_SELF_CHECK_FOR_INJURIES, PROC_REF(usescanner))

/obj/item/organ/cyberimp/brain/wound_scanner/on_mob_remove(mob/living/carbon/implant_owner)
	. = ..()
	UnregisterSignal(implant_owner, COMSIG_CARBON_SELF_CHECK_FOR_INJURIES)


/obj/item/organ/cyberimp/brain/wound_scanner/proc/usescanner(mob/living/carbon/user, rescan_timer)
	SIGNAL_HANDLER
	if(!COOLDOWN_FINISHED(src, rescan_timer))
		return
	woundscan(owner, owner, fakescanner, simple_scan = TRUE)
	COOLDOWN_START(src, rescan_timer, 15 SECONDS)

