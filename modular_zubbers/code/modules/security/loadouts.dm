
/datum/outfit/job/security
	suit_store = /obj/item/flashlight/seclite
	backpack_contents = list(
		/obj/item/evidencebag = 1,
		/obj/item/security_voucher/primary = 1,
		/obj/item/security_voucher/utility = 1 // BUBBER EDIT ADDITION
		)

/datum/outfit/job/corrections_officer
	suit_store = /obj/item/flashlight/seclite
	backpack_contents = list(/obj/item/melee/baton/security/loaded/departmental/prison,
	/obj/item/restraints/handcuffs = 2,
	/obj/item/clothing/mask/whistle,
	/obj/item/security_voucher/primary = 1,
	/obj/item/security_voucher/utility = 1
	)

/datum/outfit/job/warden
	suit_store = /obj/item/flashlight/seclite
	backpack_contents = list(
	/obj/item/evidencebag = 1,
	/obj/item/security_voucher/primary = 1,
	/obj/item/security_voucher/utility = 1
	)

/datum/outfit/job/hos
	suit_store = /obj/item/gun/energy/e_gun //BUBBER EDIT - REVERTS SKYRAT REMOVAL
	backpack_contents = list(
		/obj/item/evidencebag = 1,
		/obj/item/melee/baton/security/loaded/hos = 1,
		/obj/item/security_voucher/utility = 1
		)

/datum/outfit/job/detective
	backpack_contents = list(
		/obj/item/detective_scanner = 1,
		/obj/item/melee/baton = 1,
		/obj/item/storage/box/evidence = 1,
		/obj/item/flashlight/seclite = 1, // BUBBER EDIT ADDITION
		/obj/item/security_voucher/utility = 1
		)
