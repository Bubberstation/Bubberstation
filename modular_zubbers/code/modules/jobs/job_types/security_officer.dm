/datum/job/security_officer
	total_positions = 8 //Handled in /datum/controller/occupations/proc/setup_officer_positions()
	spawn_positions = 8 //Handled in /datum/controller/occupations/proc/setup_officer_positions()

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)
	sec_antag_cap = 1.5
	akula_outfit = /datum/outfit/akula/security_officer
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)
	banned_augments = list(SEC_RESTRICTED_AUGMENTS)
	is_hand_required = TRUE
	alt_titles = list(
		"Security Officer",
		"Guard",
		"Security Guard",
		"Security Constable",
		"Peacekeeper",
		"Security Operative",
		"Security Cadet",
		"Junior Officer",
		"Security Assistant",
		"Security Specialist",
		"Defense Contractor",
	)

/datum/outfit/job/security
	suit_store = /obj/item/gun/energy/e_gun/advtaser
	glasses = /obj/item/clothing/glasses/hud/security
	backpack_contents = list(
		/obj/item/evidencebag = 1,
		/obj/item/flashlight/seclite = 1)
