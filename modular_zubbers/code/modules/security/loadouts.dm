
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
