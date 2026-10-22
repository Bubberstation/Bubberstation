/datum/outfit/centcom/ert/commander
	l_hand = /obj/item/gun/energy/e_gun/stun
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/guard/medical

/datum/outfit/centcom/ert/security
	l_hand = /obj/item/gun/energy/e_gun/stun
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/guard/medical

/datum/outfit/centcom/ert/security/alert
	l_hand = /obj/item/gun/ballistic/automatic/battle_rifle
	l_pocket = /obj/item/storage/pouch/ammo
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m38 = 3)

/datum/outfit/centcom/ert/medic
	l_hand = /obj/item/gun/energy/e_gun/stun
	r_hand = /obj/item/storage/medkit/regular
	belt = /obj/item/storage/backpack/duffelbag/deforest_medkit/stocked
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/guard/medical

/datum/outfit/centcom/ert/engineer
	l_hand = /obj/item/gun/energy/e_gun/stun
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/guard/medical

///  MOD EQUIPMENT

/obj/item/mod/control/pre_equipped/responsory/commander
	additional_modules = list(/obj/item/mod/module/shooting_assistant/ert, /obj/item/mod/module/holster, /obj/item/mod/module/status_readout/operational)

/obj/item/mod/control/pre_equipped/responsory/security
	additional_modules = list(/obj/item/mod/module/shooting_assistant/ert, /obj/item/mod/module/holster, /obj/item/mod/module/status_readout/operational)

/obj/item/mod/control/pre_equipped/responsory/medic
	additional_modules = list(/obj/item/mod/module/defibrillator/combat, /obj/item/mod/module/holster, /obj/item/mod/module/status_readout/operational)

/obj/item/mod/control/pre_equipped/responsory/medic/alert
	additional_modules = /obj/item/mod/module/shooting_assistant/ert

/obj/item/mod/control/pre_equipped/responsory/engineer
	additional_modules = list(/obj/item/mod/module/holster, /obj/item/mod/module/status_readout/operational)

/obj/item/mod/control/pre_equipped/responsory/engineer/alert
	additional_modules = /obj/item/mod/module/shooting_assistant/ert

// AP

/datum/outfit/centcom/asset_protection
	name = "Asset Protection"

	uniform = /obj/item/clothing/under/rank/centcom/commander
	back = /obj/item/mod/control/pre_equipped/asset_protection
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	glasses = /obj/item/clothing/glasses/hud/toggle/thermal
	l_pocket = /obj/item/flashlight
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	belt = /obj/item/storage/belt/security/full
	l_hand = /obj/item/gun/energy/pulse/carbine/loyalpin // if this is still bulky make it not bulky and storable on belt/back/bag/exosuit
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
