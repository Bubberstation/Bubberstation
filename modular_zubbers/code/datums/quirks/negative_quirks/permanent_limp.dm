/datum/quirk/permanent_limp
	name = "Permanent Limp"
	desc = "One of your legs has a permanent limp."
	icon = FA_ICON_PERSON_CANE
	value = -3
	gain_text = "You start to walk with a limp"
	lose_text = "Your limp is cured"
	medical_record_text = "Patient has an untreatable impairment in motive capability in the lower extremities."
	hardcore_value = 2
	mail_goodies = list(/obj/item/cane/crutch)

/datum/quirk_constant_data/permanent_limp
	associated_typepath = /datum/quirk/permanent_limp
	customization_options = list(/datum/preference/choiced/permanent_limp)

/datum/quirk/permanent_limp/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/limp_type = GLOB.permanent_limp_choice[client_source?.prefs?.read_preference(/datum/preference/choiced/permanent_limp)]
	var/datum/wound/perm_limp/limp = new limp_type()
	if(limp.limb_to_apply_to == "Right")
		for(var/obj/item/bodypart/leg/right/right_leg in human_holder.bodyparts)
			limp.apply_wound(right_leg, TRUE)
			continue
	if(limp.limb_to_apply_to == "Left")
		for(var/obj/item/bodypart/leg/left/left_leg in human_holder.bodyparts)
			limp.apply_wound(left_leg, TRUE)
			continue

/datum/quirk/permanent_limp/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	for(var/obj/item/bodypart/leg/right/right_leg in human_holder.bodyparts)
		var/datum/wound/perm_limp/limp = right_leg.get_wound_type(/datum/wound/perm_limp)
		if(limp)
			limp.remove_wound()
	for(var/obj/item/bodypart/leg/left/left_leg in human_holder.bodyparts)
		var/datum/wound/perm_limp/limp = left_leg.get_wound_type(/datum/wound/perm_limp)
		if(limp)
			limp.remove_wound()
