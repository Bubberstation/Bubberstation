/obj/item/organ/cyberimp/chest/wound_scanner
	name = "internal wound analyzer"
	desc = "A cheap implanted health monitor to scan for wounds and give treatment instructions, relayed to the brain."
	slot = ORGAN_SLOT_SCANNER
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "first_aid"
	actions_types = list(/datum/action/item_action/organ_action/use/internal_wound_analyzer)
	w_class = WEIGHT_CLASS_SMALL
	give_wound_treatment_bonus = TRUE

/datum/action/item_action/organ_action/use/internal__wound_analyzer
	desc = "Activate to get detailed wound treatment information relayed to your brain."

/datum/action/item_action/organ_action/use/internal_wound_analyzer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/cyberimp/chest/wound_scanner/our_scanner = target
	if(our_scanner.organ_flags & ORGAN_FAILING)
		to_chat(owner, span_warning("Your health analyzer relays an error! It can't interface with your body in its current condition!"))
		return
	else
		woundscan(owner, owner, simple_scan = TRUE)
