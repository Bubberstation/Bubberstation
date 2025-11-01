/datum/outfit/job/hos/pre_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	backpack_contents += list(
		/obj/item/melee/baton/security/stunsword/hos/loaded = 1,
	)
