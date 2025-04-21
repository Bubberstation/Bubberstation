/area/awaymission/wargames
	icon_state = "away"
	requires_power = TRUE
	static_lighting = FALSE

/area/awaymission/wargames/outside
	name = "Wargames Outside"
	base_lighting_alpha = 200
	base_lighting_color = "#eca1159d"

/area/awaymission/wargames/tents
	name = "Wargames Tents"
	requires_power = FALSE

/area/awaymission/wargames/cin
	requires_power = TRUE
	static_lighting = TRUE

/area/awaymission/wargames/cin/bar
	name = "Wargames CIN bar"

/area/awaymission/wargames/cin/medical
	name = "Wargames CIN Medical"

/area/awaymission/wargames/cin/armory
	name = "Wargames CIN Armory"

/area/awaymission/wargames/cin/mainhall
	name = "Wargames CIN Halls"

/area/awaymission/wargames/cin/breifing
	name = "Wargames CIN Breifing room"

/area/awaymission/wargames/cin/dorm
	name = "Wargames CIN Barracks"

/area/awaymission/wargames/cin/kitchen
	name = "Wargames CIN Kitchen"

/area/awaymission/wargames/cin/guardpost
	name = "Wargames CIN Guardpost"

/area/awaymission/wargames/cin/garage
	name = "Wargames CIN Garage"

/area/awaymission/wargames/cin/production
	name = "Wargames CIN Work Room"

/area/awaymission/wargames/cin/material
	name = "Wargames CIN Material Managment"

/area/awaymission/wargames/cin/power
	name = "Wargames CIN Power"

/area/awaymission/wargames/lizards
	name = "Wargames lizards"
	base_lighting_alpha = 200
	base_lighting_color = "#eca1159d"

/area/awaymission/wargames/cave
	name = "Wargames caves"

/area/awaymission/wargames/fishingshack
	name = "Wargames fishing"

/area/awaymission/wargames/airfield
	name = "Wargames airfield"

/area/awaymission/wargames/radiopost
	name = "Wargames radioshack"

/area/awaymission/wargames/gatewayroom
	name = "Wargames gateway room"

/obj/effect/mob_spawn/ghost_role/human/wargames_CIN
	name = "CIN Operative"
	prompt_name = "a CIN operative, on a distant jungle planet."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "psykerpod"
	outfit = /datum/outfit/cin_soldier/wargames
	you_are_text = "You are a CIN soldier posted to a remote outpost. You werent told much, besides that the locals can be violent, and to keep your base safe."
	flavour_text = "You are a CIN soldier posted to a remote outpost. Your goal is to interact with the station staff that come through the gateway and give them meaningful RP, by combat or otherwise."
	important_text = "Do not abandon your outpost."
	quirks_enabled = TRUE
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/wargames_CIN/command
	name = "CIN Operative"
	prompt_name = "a CIN operative, on a distant jungle planet."
	outfit = /datum/outfit/cin_soldier/wargames/command
	you_are_text = "You are a CIN soldier posted to a remote outpost. You werent told much, besides that the locals can be violent, and to keep your base safe."

/datum/outfit/cin_soldier/wargames
	name = "Coalition Operative"
	uniform = /obj/item/clothing/under/syndicate/rus_army/cin_surplus/forest
	suit = /obj/item/clothing/suit/armor/vest/cin_surplus_vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/fingerless
	ears = /obj/item/radio/headset/cybersun
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	head = /obj/item/clothing/head/helmet/cin_surplus_helmet/forest
	back = /obj/item/storage/backpack/industrial/cin_surplus/forest
	backpack_contents = list(
		/obj/item/storage/box/nri_survival_pack/raider,
		/obj/item/gun/ballistic/automatic/pistol/plasma_marksman,
		/obj/item/ammo_box/magazine/recharge/plasma_battery = 2,
	)
	r_hand = null
	l_hand = null
	belt = /obj/item/storage/belt/military/cin_surplus/forest
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/nri_raider/cin

/datum/outfit/cin_soldier/wargames/post_equip(mob/living/carbon/human/user, visualsOnly)
	. = ..()
	// make sure we update the ID's name
	var/obj/item/card/id/id_card = user.wear_id
	if(istype(id_card))
		id_card.registered_name = user.real_name
		id_card.update_label()

/datum/outfit/cin_soldier/wargames/command
	name = "Coalition Operative Command Staff"
	// ill make them more uniuqe later
