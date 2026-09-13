//Port Tarkon Outfits

/datum/outfit/tarkon
	name = "default port tarkon outfit"
	uniform = /obj/item/clothing/under/tarkon
	head = /obj/item/clothing/head/utility/welding/hat
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		)
	shoes = /obj/item/clothing/shoes/winterboots
	gloves = /obj/item/clothing/gloves/combat
	id = /obj/item/card/id/advanced/tarkon
	id_trim = /datum/id_trim/away/tarkon
	ears = /obj/item/radio/headset/tarkon
	var/backpack = /obj/item/storage/backpack/tarkon //bubber edit start
	var/satchel = /obj/item/storage/backpack/satchel/tarkon
	var/duffelbag = /obj/item/storage/backpack/duffelbag/tarkon
	var/messenger = /obj/item/storage/backpack/messenger/tarkon

/datum/outfit/tarkon/pre_equip(mob/living/carbon/human/tarkon, visuals_only = FALSE)
	if(ispath(back, /obj/item/storage/backpack)) //we just steal this from the job outfit datum.
		switch(tarkon.backpack)
			if(GBACKPACK)
				back = /obj/item/storage/backpack/tarkon //Tarkon backpack
			if(GSATCHEL)
				back = /obj/item/storage/backpack/satchel/tarkon  //Tarkon satchel
			if(GDUFFELBAG)
				back = /obj/item/storage/backpack/duffelbag/tarkon //Tarkon Duffel bag
			if(LSATCHEL)
				back = /obj/item/storage/backpack/satchel/leather //Leather Satchel
			if(GMESSENGER)
				back = /obj/item/storage/backpack/messenger //Grey messenger bag
			if(DSATCHEL)
				back = satchel //Department satchel
			if(DMESSENGER)
				back = messenger //Messenger Bags
			if(DDUFFELBAG)
				back = duffelbag //Department duffel bag
			if(DMESSENGER)
				back = messenger //Department messenger bag
			else
				back = backpack //Department backpack

	if(isplasmaman(tarkon))
		uniform = /obj/item/clothing/under/plasmaman
		gloves = /obj/item/clothing/gloves/color/plasmaman
		head = /obj/item/clothing/head/helmet/space/plasmaman
		r_hand = /obj/item/tank/internals/plasmaman/belt/full
	if(isvox(tarkon) || isvoxprimalis(tarkon))
		r_hand = /obj/item/tank/internals/nitrogen/belt/full
		mask = /obj/item/clothing/mask/breath/vox //bubber edit end

/datum/outfit/tarkon/post_equip(mob/living/carbon/human/tarkon, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = tarkon.wear_id
	if(istype(id_card))
		id_card.registered_name = tarkon.real_name
		id_card.update_label()
		id_card.update_icon()
	var/obj/item/radio/target_radio = tarkon.ears
	target_radio.set_frequency(FREQ_TARKON)
	target_radio.recalculateChannels()

	handlebank(tarkon)
	return ..()

/datum/outfit/tarkon/cargo
	name = "Port Tarkon Cargo Outfit"
	uniform = /obj/item/clothing/under/tarkon/cargo
	glasses = /obj/item/clothing/glasses/sunglasses
	id = /obj/item/card/id/advanced/tarkon/cargo
	id_trim = /datum/id_trim/away/tarkon/cargo
	l_pocket = /obj/item/mining_voucher
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/keycard/tarkon_job_supply,
		/obj/item/crowbar = 1,
		)
	skillchips = list(/obj/item/skillchip/job/miner)

/datum/outfit/tarkon/service
	name = "Port Tarkon Service Outfit"
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/advanced/tarkon/service
	id_trim = /datum/id_trim/away/tarkon/service
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/keycard/tarkon_job_service,
		/obj/item/crowbar = 1,
		)
	skillchips = list(/obj/item/skillchip/chefs_kiss, /obj/item/skillchip/intj)

/datum/outfit/tarkon/sci
	name = "Port Tarkon Science Outfit"
	uniform = /obj/item/clothing/under/tarkon/sci
	glasses = /obj/item/clothing/glasses/hud/diagnostic
	id = /obj/item/card/id/advanced/tarkon/sci
	id_trim = /datum/id_trim/away/tarkon/sci
	r_pocket = /obj/item/stock_parts/power_store/cell/high
	l_pocket = /obj/item/card/id/away/tarkonrobo
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/keycard/tarkon_job_rnd,
		)
	skillchips = list(/obj/item/skillchip/job/roboticist)


/datum/outfit/tarkon/med
	name = "Port Tarkon Medical Outfit"
	uniform = /obj/item/clothing/under/tarkon/med
	glasses = /obj/item/clothing/glasses/hud/health
	id = /obj/item/card/id/advanced/tarkon/med
	id_trim = /datum/id_trim/away/tarkon/med
	neck = /obj/item/clothing/neck/stethoscope
	l_pocket = /obj/item/healthanalyzer
	r_pocket = /obj/item/stack/medical/suture/medicated
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/keycard/tarkon_job_med,
		)
	skillchips = list(/obj/item/skillchip/entrails_reader)


/datum/outfit/tarkon/engi
	name = "Port Tarkon Engineering Outfit"
	uniform = /obj/item/clothing/under/tarkon/eng
	glasses = /obj/item/clothing/glasses/meson/engine/tray
	id = /obj/item/card/id/advanced/tarkon/engi
	id_trim = /datum/id_trim/away/tarkon/eng
	neck = /obj/item/clothing/neck/security_cape/tarkon
	l_hand = /obj/item/inducer
	l_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	r_pocket = /obj/item/stack/cable_coil
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/keycard/tarkon_job_engi,
		)
	skillchips = list(/obj/item/skillchip/job/engineer)

/datum/outfit/tarkon/sec
	name = "Port Tarkon Security Outfit"
	uniform = /obj/item/clothing/under/tarkon/sec
	glasses = /obj/item/clothing/glasses/hud/security/redsec
	gloves = /obj/item/clothing/gloves/tackler/combat
	neck = /obj/item/clothing/neck/security_cape/tarkon
	id = /obj/item/card/id/advanced/tarkon/sec
	id_trim = /datum/id_trim/away/tarkon/sec
	l_pocket = /obj/item/melee/baton/telescopic
	r_pocket = /obj/item/grenade/barrier
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/keycard/tarkon_job_sec,
		)
	skillchips = list(/obj/item/skillchip/chameleon/reload)

/datum/outfit/tarkon/ensign //jack of all trades, master of none, spent all his credits, every last one
	name = "Port Tarkon Ensigns Outfit"
	uniform = /obj/item/clothing/under/tarkon/com
	ears = /obj/item/radio/headset/tarkon/command
	id = /obj/item/card/id/advanced/tarkon/ensign
	id_trim = /datum/id_trim/away/tarkon/ensign
	neck = /obj/item/clothing/neck/security_cape/tarkon
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/keycard/tarkon_job_ensign,
		)
	skillchips = list(/obj/item/skillchip/chameleon/reload)

/datum/outfit/tarkon/director //Look at me, I'm the director now.
	name = "Port Tarkon Director's Outfit"
	uniform = /obj/item/clothing/under/tarkon/com
	ears = /obj/item/radio/headset/tarkon/command
	id = /obj/item/card/id/advanced/tarkon/director
	id_trim = /datum/id_trim/away/tarkon/director
	neck = /obj/item/clothing/neck/security_cape/tarkon
	r_pocket = /obj/item/card/id/away/tarkonrobo
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/keycard/tarkon_job_command,
		)
	skillchips = list(/obj/item/skillchip/chameleon/reload)

/datum/outfit/tarkon/loot
	name = "Dead Tarkon Ensigns Outfit"
	uniform = /obj/item/clothing/under/tarkon/com
	ears = /obj/item/radio/headset/tarkon/command
	id = /obj/item/card/id/advanced/tarkon/ensign
	id_trim = /datum/id_trim/away/tarkon/ensign
	neck = /obj/item/clothing/neck/security_cape/tarkon
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/mod/control/pre_equipped/tarkon
	backpack_contents = list(/obj/item/trench_tool)
