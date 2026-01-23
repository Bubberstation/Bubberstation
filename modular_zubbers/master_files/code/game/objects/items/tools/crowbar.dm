/obj/item/crowbar/power/paramedic
	desc = "An advanced version of the jaws of life, primarily to be used by paramedics to recover the injured and the recently deceased. Rather than a cutting arm, this tool has a bonesetting apparatus. \
		Cannot access certain high security areas due to safety concerns."

	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.6 // Faster to provide an incentive to actually carry this thing instead of normal jaws

	custom_materials = list( // BUBBER EDIT - Materials changes to try to reflect normal size
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.50,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2.00,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.25,
	)
