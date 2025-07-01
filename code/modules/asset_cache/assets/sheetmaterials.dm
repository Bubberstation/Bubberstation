/datum/asset/spritesheet_batched/sheetmaterials
	name = "sheetmaterials"

/datum/asset/spritesheet_batched/sheetmaterials/create_spritesheets()
	// GS13 EDIT - for allowing the ore silo to see calorite
	// also this needs to be first so we could use bubber sprites
	insert_all_icons("", 'modular_gs/icons/obj/stack_objects.dmi')
	// GS13 END EDIT
	insert_all_icons("", 'icons/obj/stack_objects.dmi')

