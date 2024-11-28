/datum/component/surgery_initiator/try_choose_surgery(mob/user, mob/living/target, datum/surgery/surgery)
	. = ..()
	if(!.)
		return

	var/list/passed_check = list()
	var/list/failed_check = list()
	var/turf/mob_turf = get_turf(target)
	var/area/patient_area = get_area(target)
	var/obj/structure/table/optable/operating_table = locate(/obj/structure/table/optable, mob_turf)
	if(!isnull(operating_table))
		passed_check += "the operating table"
		operating_table.blood_check()
	else
		failed_check += "using an operating table"

	if(istype(patient_area, /area/station/medical/surgery))
		passed_check += "the surgery area"
	else
		failed_check += "using a surgery room"

	if(patient_area.clean_medical)
		passed_check += "a clean room"
	else
		failed_check += "cleaning the blood off the floor"

	if(target.has_sterilizine(target))
		passed_check += "sterilizine/cryostylane"
	else
		failed_check += "using sterilizine or cryostylane"

	if(length(passed_check) > 0)
		to_chat(user, span_greenannounce("You have surgery speed bonuses from [english_list(passed_check)]!"))
	if(length(failed_check) > 0)
		to_chat(user, span_info("<b>You could increase surgery speed by [english_list(failed_check)].</b>"))
