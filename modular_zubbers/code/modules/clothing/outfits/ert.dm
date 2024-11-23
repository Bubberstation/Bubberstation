/datum/outfit/centcom/ert/commander/alert
	l_hand = /obj/item/gun/energy/modular_laser_rifle

/datum/outfit/centcom/ert/security/alert
	l_hand = /obj/item/gun/energy/modular_laser_rifle
	back =  /obj/item/mod/control/pre_equipped/responsory/security/alert
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/ammo_box/magazine/smartgun_drum = 2,
	)

//SMARTGUN EQIPPED SECURITY MOD
/obj/item/mod/control/pre_equipped/responsory/security/alert
	additional_module = /obj/item/mod/module/smartgun/marines

/datum/outfit/centcom/ert/medic/alert
	r_hand = /obj/item/gun/energy/modular_laser_rifle

/datum/outfit/centcom/ert/engineer/alert
	l_hand = /obj/item/gun/energy/modular_laser_rifle

/datum/outfit/centcom/private_security
	name = "Nanotrasen Private Security ERT Officer"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/private_security
	uniform = /obj/item/clothing/under/rank/security/nanotrasen
	suit = /obj/item/clothing/suit/armor/vest
	back = /obj/item/storage/backpack/satchel/sec/redsec
	box = /obj/item/storage/box/survival/centcom
	belt = /obj/item/storage/belt/security/redsec/full
	ears = /obj/item/radio/headset/headset_cent
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/redsec
	head = /obj/item/clothing/head/helmet/swat/nanotrasen
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	gloves = /obj/item/clothing/gloves/tackler/combat/classic
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/ammo_box/magazine/m45
	l_hand = /obj/item/gun/ballistic/automatic/wt550
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 1,
		/obj/item/ammo_box/magazine/wt550m9 = 3,
	)

/datum/outfit/centcom/private_security/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/W = H.wear_id
	W.registered_name = H.real_name
	W.update_label()
	W.update_icon()
	return ..()

/datum/outfit/centcom/private_security/commander
	name = "Nanotrasen Private Security ERT Commander"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/private_security/commander
	uniform = /obj/item/clothing/under/rank/security/nanotrasen/hr
	suit = /obj/item/clothing/suit/armor/vest
	back = /obj/item/storage/backpack/satchel/sec/redsec/gold
	box = /obj/item/storage/box/survival/centcom
	belt = /obj/item/storage/belt/security/webbing/peacekeeper/armadyne/privatesec/full
	ears = /obj/item/radio/headset/headset_cent/commander
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/redsec
	head = /obj/item/clothing/head/beret/commander
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	shoes = /obj/item/clothing/shoes/combat/swat
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/gun/energy/e_gun/mini
	l_hand = /obj/item/gun/ballistic/automatic/ar
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/shield/riot/tele = 1,
		/obj/item/gun/ballistic/automatic/pistol/m45a5 = 1,
		/obj/item/ammo_box/magazine/m223 = 3,
		/obj/item/ammo_box/magazine/m45a5 = 1,
	)
