/*
*	BUBBER MODULAR OUTFITS FILE
*	PUT ANY NEW ERT OUTFITS HERE
*	OR CHANGES TO ERT HERE
*/


/datum/ert
	code = "Green"

/datum/ert/marine
	code = "Military Green"

/datum/ert/centcom_official
	code = "Gold"

/datum/ert/inquisition
	code = "Unexpected"

/datum/ert/janitor
	code = "Purple"

/datum/ert/intern
	code = "Unpaid"

/datum/ert/bounty_hunters
	code = "Bounty Orange"

/datum/ert/militia
	code = "Brown" //For cargo. Idk

/datum/ert/asset_protection
	code = "Goldstar"

/datum/outfit/centcom/asset_protection
	name = "Asset Protection"

	uniform = /obj/item/clothing/under/syndicate/sniper
	back = /obj/item/mod/control/pre_equipped/asset_protection
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	glasses = /obj/item/clothing/glasses/hud/toggle/thermal
	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	belt = /obj/item/storage/belt/security/full
	l_hand = /obj/item/gun/energy/pulse/pistol/m1911/loyalpin // if this is still bulky make it not bulky and storable on belt/back/bag/exosuit
	id = /obj/item/card/id/advanced/centcom/ert
	ears = /obj/item/radio/headset/headset_cent/alt

	skillchips = list(/obj/item/skillchip/disk_verifier)

	backpack_contents = list(/obj/item/storage/box/survival/engineer = 1,\
		/obj/item/storage/medkit/regular = 1,\
		/obj/item/storage/box/handcuffs = 1,\
		/obj/item/crowbar/power = 1, // this is their "all access" pass lmao
		)

/datum/outfit/centcom/asset_protection/post_equip(mob/living/carbon/human/person, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/radio/Radio = person.ears
	Radio.set_frequency(FREQ_CENTCOM)
	Radio.freqlock = TRUE
	var/obj/item/card/id/ID = person.wear_id
	ID.assignment = "Asset Protection"
	ID.registered_name = person.real_name
	ID.update_label()
	..()

/datum/outfit/centcom/asset_protection/leader
	name = "Asset Protection Officer"
	head = /obj/item/clothing/head/helmet/space/beret

