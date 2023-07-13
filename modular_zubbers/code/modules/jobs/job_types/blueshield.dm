/datum/job/blueshield
	description = "Protect the Heads of Staff and get your hands dirty so they can keep theirs clean."
	supervisors = "All Command Staff and Central Command when applicable"
	exp_required_type_department = EXP_TYPE_SECURITY
	departments_list = list(
		/datum/job_department/command,
	)
// Making the Blueshield require sec hours, NOT command hours.
//Blueshield is also now ONLY command.

/datum/outfit/job/blueshield
	id = /obj/item/card/id/advanced/silver
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	backpack_contents = list()
	l_pocket = /obj/item/knife/combat
//Making the Blueshield have a silver ID, which cannot receive All Access by default.

/obj/structure/closet/secure_closet/blueshield/New()
	.=..()
	new /obj/item/storage/secure/briefcase(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/gun/energy/laser/hellgun/blueshield(src)
	new /obj/item/clothing/suit/hooded/wintercoat/skyrat/blueshield(src)
	new /obj/item/storage/medkit/tactical/blueshield(src)
