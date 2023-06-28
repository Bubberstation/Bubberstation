/datum/job/blueshield
	exp_required_type_department = EXP_TYPE_SECURITY
// Making the Blueshield require sec hours, NOT command hours.

/datum/outfit/job/blueshield
	id = /obj/item/card/id/advanced/silver
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	backpack_contents = list(
		/obj/item/storage/box/gunset/blueshield = 0,
	)
	r_pocket = /obj/item/melee/baton/telescopic
//Making the Blueshield have a silver ID, which cannot receive All Access by default.
