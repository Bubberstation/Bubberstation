//Handles giving all the security jobs their bodycams.

/datum/outfit/job/hos
	backpack_contents = list(
		/obj/item/evidencebag = 1,
		/obj/item/flashlight/seclite = 1,
		/obj/item/modular_computer/pda/heads/hos = 1,
		/obj/item/choice_beacon/head_of_security = 1,
		/obj/item/bodycam_upgrade = 1,
		)

/datum/outfit/job/detective
	backpack_contents = list(
		/obj/item/detective_scanner = 1,
		/obj/item/melee/baton = 1,
		/obj/item/storage/box/evidence = 1,
		/obj/item/flashlight/seclite = 1,
		/obj/item/bodycam_upgrade = 1,
		)

/datum/outfit/job/security
	backpack_contents = list(
		/obj/item/evidencebag = 1,
		/obj/item/flashlight/seclite = 1,
		/obj/item/modular_computer/pda/security = 1,
		/obj/item/bodycam_upgrade = 1,
		)

/datum/outfit/job/warden
	backpack_contents = list(
		/obj/item/evidencebag = 1,
		/obj/item/modular_computer/pda/warden = 1,
		/obj/item/flashlight/seclite = 1,
		/obj/item/bodycam_upgrade = 1,
		)

/datum/outfit/job/security_medic
	backpack_contents = list(
		/obj/item/storage/box/gunset/firefly = 1,
		/obj/item/bodycam_upgrade = 1,
		)

/datum/outfit/job/corrections_officer
	backpack_contents = list(
	/obj/item/melee/baton/security/loaded/departmental/prison,
	/obj/item/restraints/handcuffs = 2,
	/obj/item/clothing/mask/whistle,
	/obj/item/gun/energy/disabler,
	/obj/item/bodycam_upgrade = 1,
	)

/datum/outfit/job/science_guard
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/science = 1,
		/obj/item/storage/box/gunset/pepperball = 1,
		/obj/item/bodycam_upgrade = 1,
	)

/datum/outfit/job/orderly
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/medical = 1,
		/obj/item/storage/box/gunset/pepperball = 1,
		/obj/item/bodycam_upgrade = 1,
	)

/datum/outfit/job/engineering_guard
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/engineering = 1,
		/obj/item/storage/box/gunset/pepperball = 1,
		/obj/item/bodycam_upgrade = 1,
	)

/datum/outfit/job/customs_agent
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/cargo = 1,
		/obj/item/storage/box/gunset/pepperball = 1,
		/obj/item/bodycam_upgrade = 1,
	)

/datum/outfit/job/bouncer
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/service = 1,
		/obj/item/storage/box/gunset/pepperball = 1,
		/obj/item/bodycam_upgrade = 1,
		)

//Handles Ordering bodycams

/datum/supply_pack/security/body_cameras
	name = "Body Camera Crate"
	desc = "Four standard body cameras."
	cost = CARGO_CRATE_VALUE * 3 //SKYRAT EDIT 3 -> 5
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/bodycam_upgrade = 4)
	crate_name = "body camera crate"

