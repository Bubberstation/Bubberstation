/datum/outfit/solfed_bitrun
	name = "Bitrunning SolFed Marine"

	uniform = /obj/item/clothing/under/sol_peacekeeper
	head = null
	mask = /obj/item/clothing/mask/gas/half_mask
	gloves = /obj/item/clothing/gloves/frontier_colonist
	suit = null
	shoes = /obj/item/clothing/shoes/jackboots/frontier_colonist
	back = /obj/item/storage/backpack/industrial/frontier_colonist
	glasses = null
	ears = /obj/item/radio/headset/headset_faction/bowman
	id = /obj/item/card/id/advanced/terragov
	r_hand = null
	l_hand = null
	backpack_contents = null
	belt = null
	id_trim = /datum/id_trim/solfed_bitrun

/datum/outfit/solfed_bitrun/post_equip(mob/living/carbon/human/user, visualsOnly)
	. = ..()
	// make sure we update the ID's name too
	var/obj/item/card/id/id_card = user.wear_id
	if(istype(id_card))
		id_card.registered_name = user.real_name
		id_card.update_label()

/datum/id_trim/solfed_bitrun
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "SolFed Marine"
	trim_state = "trim_solfed"

/datum/outfit/cin_soldier_corpse
	name = "Coalition Operative Corpse"
	uniform = /obj/item/clothing/under/syndicate/rus_army/cin_surplus/forest
	suit = /obj/item/clothing/suit/armor/vest/cin_surplus_vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/fingerless
	ears = /obj/item/radio/headset/cybersun
	mask = /obj/item/clothing/mask/balaclava
	head = /obj/item/clothing/head/helmet/cin_surplus_helmet/forest
	back = /obj/item/storage/backpack/industrial/cin_surplus/forest
	belt = /obj/item/storage/belt/military/cin_surplus/forest
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/nri/ancient_milsim

/datum/outfit/cin_soldier_player
	name = "Coalition Operative SNPC"
	uniform = /obj/item/clothing/under/syndicate/rus_army/cin_surplus/forest
	suit = /obj/item/clothing/suit/armor/vest/cin_surplus_vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/fingerless
	ears = /obj/item/radio/headset/cybersun
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/armadyne
	mask = /obj/item/clothing/mask/balaclava
	head = /obj/item/clothing/head/helmet/cin_surplus_helmet/forest
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/plasma_marksman,
		/obj/item/ammo_box/magazine/recharge/plasma_battery = 3,
	)
	r_hand = null
	l_hand = null
	l_pocket = /obj/item/storage/pouch/ammo
	belt = /obj/item/storage/belt/military/cin_surplus/forest
	id = /obj/item/card/id/advanced/centcom/ert/nri
	id_trim = /datum/id_trim/nri/ancient_milsim

/datum/outfit/cin_soldier_player/post_equip(mob/living/carbon/human/user, visualsOnly)
	. = ..()
	user.remove_faction(FACTION_NEUTRAL)
	user.add_faction(ROLE_SYNDICATE)

	var/callsign = pick(GLOB.callsigns_nri)
	var/number = pick(GLOB.phonetic_alphabet_numbers)
	user.fully_replace_character_name(null, "[callsign] [number]")

	// make sure we update the ID's name too
	var/obj/item/card/id/id_card = user.wear_id
	if(istype(id_card))
		id_card.registered_name = user.real_name
		id_card.update_label()

/datum/id_trim/nri/ancient_milsim
	assignment = "CIN Operative"
