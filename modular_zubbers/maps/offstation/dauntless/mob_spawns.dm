/datum/job/dauntless // Job Define
	title = ROLE_DAUNTLESS
	policy_index = ROLE_DAUNTLESS
	akula_outfit = /datum/outfit/akula
	antagonist_restricted = TRUE

// Dauntless Ghost Spawners (Lava)

/obj/effect/mob_spawn/ghost_role/human/dauntless
	name = "Dauntless Personnel"
	use_outfit_name = TRUE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "Dauntless Personnel"
	you_are_text = "You are a syndicate Operative, employed on a top secret spy vessel hidden on lavaland"
	flavour_text = "Unfortunately, your hated enemy, Nanotrasen, has started mining in this sector. Continue working the best you can, and keep a low profile"
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = TRUE
	computer_area = /area/ruin/space/has_grav/bubbers/dauntless/service
	spawner_job_path = /datum/job/dauntless

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate
	name = "Syndicate Operative"
	prompt_name = "a Syndicate Operative"
	you_are_text = "an Operative assigned to the Syndicate Spy Vessel Dauntless, employed onboard for reasons that are yours"
	flavour_text = "The jointly managed SSV Dauntless has been assigned to stealthly monitor Nanotrasen assets. It hides on lavaland, behind rolling clouds of ash, after the destruction of DS-2. Your orders are to maintain the ship's integrity and keep a low profile."
	important_text = "You are NOT an antagonist and the round does not center the Dauntless. You MUST submit an Opfor or Adminhelp when escalating against the station and its crew"
	outfit = /datum/outfit/dauntless/syndicate

/obj/effect/mob_spawn/ghost_role/human/dauntless/command
	name = "Syndicate Command Operative"
	prompt_name = "a Syndicate leader"
	you_are_text = "a Syndicate Command Operative assigned to lead the SSV Dauntless and guide it forward in its goals"
	flavour_text = "The jointly managed SSV Dauntless has been assigned to stealthly monitor Nanotrasen assets. It hides on lavaland, behind rolling clouds of ash, after the destruction of DS-2. Your orders are help lead the Dauntless while ensuring a low profile is maintained."
	important_text = "You are a command role and maintained at a higher standard. You are NOT an antagonist and the round does not center around the Dauntless. You MUST submit an Opfor or Adminhelp when escalating against the station and its crew"
	outfit = /datum/outfit/dauntless/command

/obj/effect/mob_spawn/ghost_role/human/dauntless/prisoner
	name = "Syndicate Hostage"
	prompt_name = "a Syndicate hostage"
	you_are_text = "You are a hostage onboard an unknown syndicate vessel"
	flavour_text = "Unaware of where you are, all you know is you are a prisoner. The plastitanium should clue you into who your captors are... as for why you're here? That's for you to know, and for us to find out."
	important_text = "You are not an antagonist. You are still bound to the Roleplay Rules regarding escalation. Dauntless personnel can throw you into lava if you antagonize them."
	outfit = /datum/outfit/dauntless/prisoner
	computer_area = /area/ruin/space/has_grav/bubbers/dauntless/sec/prison

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate/service
	outfit = /datum/outfit/dauntless/syndicate/service

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate/enginetech
	outfit = /datum/outfit/dauntless/syndicate/enginetech

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate/researcher
	outfit = /datum/outfit/dauntless/syndicate/researcher

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate/stationmed
	outfit = /datum/outfit/dauntless/syndicate/stationmed

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate/brigoff
	outfit = /datum/outfit/dauntless/syndicate/brigoff

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate/miningoff
	outfit = /datum/outfit/dauntless/syndicate/miningoff

/obj/effect/mob_spawn/ghost_role/human/dauntless/command/masteratarms
	outfit = /datum/outfit/dauntless/command/masteratarms

/obj/effect/mob_spawn/ghost_role/human/dauntless/command/corporateliaison
	outfit = /datum/outfit/dauntless/command/corporateliaison

/obj/effect/mob_spawn/ghost_role/human/dauntless/command/admiral
	outfit = /datum/outfit/dauntless/command/admiral

// Dauntless Ghost Spawners (Space)

/obj/effect/mob_spawn/ghost_role/human/space_dauntless
	name = "Dauntless Personnel"
	use_outfit_name = TRUE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "Dauntless Personnel"
	you_are_text = "You are a syndicate Operative, employed on a top secret spy vessel hidden located in an distant space sector"
	flavour_text = "Unfortunately, your hated enemy, Nanotrasen, has started mining in this sector. Continue working the best you can, and keep a low profile"
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = TRUE
	computer_area = /area/ruin/space/has_grav/bubbers/dauntless_space/service
	spawner_job_path = /datum/job/dauntless

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate
	name = "Syndicate Operative"
	prompt_name = "a Syndicate Operative"
	you_are_text = "an Operative assigned to the Syndicate Spy Vessel Dauntless, employed onboard for reasons that are yours"
	flavour_text = "The jointly managed SSV Dauntless has been assigned to stealthly monitor Nanotrasen assets. It hides in an distant sector of Nanotrasen's station. Your orders are to maintain the ship's integrity and keep a low profile."
	important_text = "You are NOT an antagonist and the round does not center the Dauntless. You MUST submit an Opfor or Adminhelp when escalating against the station and its crew"
	outfit = /datum/outfit/dauntless/syndicate

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/command
	name = "Syndicate Command Operative"
	prompt_name = "a Syndicate leader"
	you_are_text = "a Syndicate Command Operative assigned to lead the SSV Dauntless and guide it forward in its goals"
	flavour_text = "The jointly managed SSV Dauntless has been assigned to stealthly monitor Nanotrasen assets. It hides in an distant sector of Nanotrasen's station. Your orders are help lead the Dauntless while ensuring a low profile is maintained."
	important_text = "You are a command role and maintained at a higher standard. You are NOT an antagonist and the round does not center around the Dauntless. You MUST submit an Opfor or Adminhelp when escalating against the station and its crew"
	outfit = /datum/outfit/dauntless/command

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/prisoner
	name = "Syndicate Hostage"
	prompt_name = "a Syndicate hostage"
	you_are_text = "You are a hostage onboard an unknown syndicate vessel"
	flavour_text = "Unaware of where you are, all you know is you are a prisoner. The plastitanium should clue you into who your captors are... as for why you're here? That's for you to know, and for us to find out."
	important_text = "You are not an antagonist. You are still bound to the Roleplay Rules regarding escalation. Dauntless personnel can throw you into space if you antagonize them."
	outfit = /datum/outfit/dauntless/prisoner
	computer_area = /area/ruin/space/has_grav/bubbers/dauntless_space/sec/prison

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate/service
	outfit = /datum/outfit/dauntless/syndicate/service

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate/enginetech
	outfit = /datum/outfit/dauntless/syndicate/enginetech

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate/researcher
	outfit = /datum/outfit/dauntless/syndicate/researcher

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate/stationmed
	outfit = /datum/outfit/dauntless/syndicate/stationmed

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate/brigoff
	outfit = /datum/outfit/dauntless/syndicate/brigoff

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate/miningoff
	outfit = /datum/outfit/dauntless/syndicate/miningoff

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/command/masteratarms
	outfit = /datum/outfit/dauntless/command/masteratarms

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/command/corporateliaison
	outfit = /datum/outfit/dauntless/command/corporateliaison

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/command/admiral
	outfit = /datum/outfit/dauntless/command/admiral

// Codespeak Granter

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)

/obj/effect/mob_spawn/ghost_role/human/dauntless/command/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/command/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)

// Outfits --------------

/datum/outfit/dauntless
	name = "Dauntless"

/datum/outfit/dauntless/post_equip(mob/living/carbon/human/syndicate, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = syndicate.wear_id
	if(istype(id_card))
		id_card.registered_name = syndicate.real_name
		id_card.update_label()
		id_card.update_icon()
	syndicate.apply_pref_name(/datum/preference/name/syndicate, syndicate.client)
	handlebank(syndicate)
	return ..()

//Dauntless Hostage

/datum/outfit/dauntless/prisoner
	name = "Syndicate Prisoner"
	uniform = /obj/item/clothing/under/rank/prisoner/syndicate
	shoes = /obj/item/clothing/shoes/sneakers/crimson
	id = /obj/item/card/id/advanced/prisoner/ds2
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/prisoner

//Dauntless Roles

/datum/outfit/dauntless/syndicate
	name = "Dauntless Opporative"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/interdyne
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		)
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless

/datum/outfit/dauntless/syndicate/service
	name = "Dauntless General Staff"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/syndicatestaff
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/sharpener = 1,
		)
	suit = /obj/item/clothing/suit/apron/chef
	head = /obj/item/clothing/head/soft/mime

/datum/outfit/dauntless/syndicate/enginetech
	name = "Dauntless Engineer"
	uniform = /obj/item/clothing/under/syndicate/skyrat/overalls
	head = /obj/item/clothing/head/soft/sec/syndicate
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		)
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/enginetechnician
	glasses = /obj/item/clothing/glasses/welding/up
	belt = /obj/item/storage/belt/utility/syndicate
	gloves = /obj/item/clothing/gloves/combat

/datum/outfit/dauntless/syndicate/researcher
	name = "Dauntless Researcher"
	uniform = /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/researcher
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	glasses = /obj/item/clothing/glasses/sunglasses/chemical
	gloves = /obj/item/clothing/gloves/color/black
	back = /obj/item/storage/backpack/satchel

/datum/outfit/dauntless/syndicate/stationmed
	name = "Dauntless Medical Officer"
	uniform = /obj/item/clothing/under/syndicate/scrubs
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/medicalofficer
	suit = /obj/item/clothing/suit/toggle/labcoat/interdyne
	belt = /obj/item/storage/belt/medical/paramedic
	gloves = /obj/item/clothing/gloves/latex/nitrile/ntrauma
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/storage/medkit/surgery = 1,
		)

/datum/outfit/dauntless/syndicate/brigoff
	name = "Dauntless Brig Officer"
	uniform = /obj/item/clothing/under/syndicate/combat
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/brigofficer
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/bulletproof/old
	back = /obj/item/storage/backpack/security/redsec
	backpack_contents = list(
		/obj/item/flashlight/seclite = 1,
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		)
	head = /obj/item/clothing/head/helmet/swat/ds
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/redsec
	mask = /obj/item/clothing/mask/gas/syndicate
	ears = /obj/item/radio/headset/interdyne

/datum/outfit/dauntless/syndicate/miningoff
	name = "Dauntless Mining Officer"
	uniform = /obj/item/clothing/under/syndicate/skyrat/overalls
	belt = /obj/item/storage/bag/ore
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/miner
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/bulletproof/old
	back = /obj/item/storage/backpack/satchel/explorer
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/knife/combat/survival = 1,
		/obj/item/t_scanner/adv_mining_scanner/lesser = 1,
		/obj/item/gun/energy/recharge/kinetic_accelerator = 1,
		/obj/item/storage/toolbox/guncase/skyrat/pistol = 1,
		)
	mask = /obj/item/clothing/mask/gas/syndicate
	ears = /obj/item/radio/headset/interdyne
	l_pocket = /obj/item/card/mining_point_card
	r_pocket = /obj/item/mining_voucher
	head = /obj/item/clothing/head/soft/black

/datum/outfit/dauntless/syndicate/post_equip(mob/living/carbon/human/syndicate)
	syndicate.faction |= ROLE_SYNDICATE
	return ..()

// Dauntless Command

/datum/outfit/dauntless/command
	name = "Dauntless Command Operative"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/interdyne/command
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		)
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless

/datum/outfit/dauntless/command/masteratarms
	name = "Dauntless Master At Arms"
	uniform = /obj/item/clothing/under/syndicate/combat
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/masteratarms
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/vest/warden/syndicate
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/redsec
	back = /obj/item/storage/backpack/satchel/sec/redsec
	head = /obj/item/clothing/head/hats/hos/beret/syndicate
	r_pocket = /obj/item/flashlight/seclite
	implants = list(
		/obj/item/implant/weapons_auth,
		/obj/item/implant/krav_maga
		)

/datum/outfit/dauntless/command/corporateliaison
	name = "Syndicate Corporate Liasion"
	uniform = /obj/item/clothing/under/syndicate/sniper
	head = /obj/item/clothing/head/fedora
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack/satchel
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/corporateliasion

/datum/outfit/dauntless/command/admiral
	name = "Ship Admiral"
	uniform = /obj/item/clothing/under/rank/captain/skyrat/utility/syndicate
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	back = /obj/item/storage/backpack/satchel
	belt = /obj/item/gun/ballistic/automatic/pistol/aps
	head = /obj/item/clothing/head/hats/hos/cap/syndicate
	id = /obj/item/card/id/advanced/gold/generic
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/stationadmiral

/datum/outfit/dauntless/command/post_equip(mob/living/carbon/human/syndicate)
	syndicate.faction |= ROLE_SYNDICATE
	return ..()
