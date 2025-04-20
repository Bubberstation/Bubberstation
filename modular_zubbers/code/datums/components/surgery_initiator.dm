/datum/component/surgery_initiator/try_choose_surgery(mob/user, mob/living/target, datum/surgery/surgery)
	. = ..()
	if(!.)
		return

	var/list/passed_check = list()
	var/list/failed_check = list()
	var/turf/mob_turf = get_turf(target)
	var/obj/structure/table/optable/operating_table = locate(/obj/structure/table/optable, mob_turf)
	if(!isnull(operating_table))
		if(operating_table.computer?.is_operational)
			passed_check += "the operating table/computer"
		else
			passed_check += "the operating table"
			failed_check += "an operating computer"

	if(!issynthetic(target))
		if((HAS_TRAIT(target, TRAIT_ANALGESIA) && !(HAS_TRAIT(target, TRAIT_STASIS))) || target.stat == DEAD)
			passed_check += "pain management"
		else if(!(HAS_TRAIT(target, TRAIT_STASIS)))
			failed_check += "using anesthetics or painkillers"

		if(target.has_sterilizine(target))
			passed_check += "sterilizine/cryostylane"
		else
			failed_check += "using sterilizine or cryostylane"

	if(length(passed_check) > 0)
		to_chat(user, span_greenannounce("You have surgery speed bonuses from [english_list(passed_check)]!"))
	if(length(failed_check) > 0)
		to_chat(user, span_boldnotice("<b>You could increase surgery speed by [english_list(failed_check)].</b>"))

	if(!(HAS_TRAIT(target, TRAIT_ANALGESIA) || target.stat == DEAD) && !issynthetic(target))
		to_chat(user, span_bolddanger("[target] has no treatment to manage surgery pain!"))
