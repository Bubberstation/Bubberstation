/obj/effect/mob_spawn/ghost_role/human/fugitive/spacepol/galfed
	name = "police pod"
	desc = "A small sleeper typically used to put people to sleep for briefing on the mission."
	prompt_name = "a GalFed police officer"
	you_are_text = "I am a member of the Galactic Federation Police!"
	flavour_text = "Justice has arrived. We must capture those fugitives lurking on that station!"
	back_story = HUNTER_PACK_GALFEDCOPS
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = FALSE
	outfit = /datum/outfit/spacepol/galfed
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/obj/effect/mob_spawn/ghost_role/human/fugitive/spacepol/galfed/chief
	name = "police pod"
	desc = "A small sleeper typically used to put people to sleep for briefing on the mission."
	prompt_name = "a GalFed police chief"
	you_are_text = "I am the chief of the Galactic Federation Police!"
	flavour_text = "Justice has arrived. We must capture those fugitives lurking on that station!"
	back_story = HUNTER_PACK_GALFEDCOPS
	outfit = /datum/outfit/spacepol/galfed/chief
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/datum/outfit/spacepol/galfed
	name = "GalFed Police Officer"
	uniform = /obj/item/clothing/under/rank/security/officer/galfed
	suit = null
	belt = /obj/item/gun/ballistic/automatic/pistol/sol
	head = /obj/item/clothing/head/hats/warden/police/galfed
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	shoes = /obj/item/clothing/shoes/combat
	mask = /obj/item/clothing/mask/gas/sechailer/swat/spacepol
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_galfed/alt
	l_pocket = /obj/item/ammo_box/magazine/c35sol_pistol
	r_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/galfed
	id_trim = /datum/id_trim/bounty_hunter/police/galfed

/datum/outfit/spacepol/galfed/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return
	var/obj/item/card/id/W = H.wear_id
	W.registered_name = H.real_name
	W.update_label()
	W.update_icon()

/datum/outfit/spacepol/galfed/chief
	name = "GalFed Police Chief"
	uniform = /obj/item/clothing/under/rank/security/officer/galfed/chief
	suit = /obj/item/clothing/suit/armor/bulletproof/galfed/chief
	belt = /obj/item/gun/ballistic/automatic/pistol/sol
	head = /obj/item/clothing/head/hats/warden/police/galfed/chief
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	shoes = /obj/item/clothing/shoes/combat
	mask = /obj/item/clothing/mask/gas/sechailer/swat/spacepol
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_galfed/alt/chief
	l_pocket = /obj/item/ammo_box/magazine/c35sol_pistol
	r_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/galfed
	id_trim = /datum/id_trim/bounty_hunter/police/galfed/chief

/datum/id_trim/bounty_hunter/police/galfed
	assignment = "GalFed Police Officer"
	trim_state = "trim_warden"
	department_color = COLOR_CENTCOM_BLUE
	subdepartment_color = COLOR_SECURITY_RED

	access = list(ACCESS_HUNTER)

/datum/id_trim/bounty_hunter/police/galfed/chief
	assignment = "GalFed Police Chief"
	trim_state = "trim_captain"
	department_color = COLOR_CENTCOM_BLUE
	subdepartment_color = COLOR_SECURITY_RED

	access = list(ACCESS_HUNTER)
