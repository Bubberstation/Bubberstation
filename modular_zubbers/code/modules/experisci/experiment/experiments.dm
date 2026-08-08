//scan shadekin

/datum/experiment/scanning/people/open_minds
	name = "Human Field Research: Connected Minds"
	description = "We need data on the effects of extra-sensory communication in organisms. Scan some samples of humanoid organisms which can think out loud."
	performance_hint = "Such capabilities can be induced with genetic infusion, or finding the right person."
	required_traits_desc = "extra-sensory communication"
	required_count = 2

/datum/experiment/scanning/people/open_minds/is_valid_scan_target(mob/living/carbon/human/check)
	. = ..()
	if (!.)
		return

	//check for genetics telepathy
	if(check.dna.check_mutation(/datum/mutation/telepathy))
		return TRUE

	//check for shadekin organs
	var/obj/item/organ/ears/shadekin/ears = check.get_organ_slot(ORGAN_SLOT_EARS)
	var/obj/item/organ/tongue/shadekin/tongue = check.get_organ_slot(ORGAN_SLOT_TONGUE)

	if(istype(ears) || istype(tongue))
		return TRUE

	return FALSE
