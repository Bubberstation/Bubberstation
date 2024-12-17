/datum/job/persistence // Job Define
	title = ROLE_PERSISTENCE
	policy_index = ROLE_PERSISTENCE
	akula_outfit = /datum/outfit/akula
	antagonist_restricted = TRUE

// Persistence mining rig Ghost Spawners

/obj/effect/mob_spawn/ghost_role/human/persistence
	name = "Persistence Personnel"
	use_outfit_name = TRUE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "Persistence Personnel"
	you_are_text = "You are a Syndicate operative, employed as part of a crew aboard a landcrawler. Your mission objectives are to harvest materials, build outposts, produce goods, and advance the interests of your company"
	flavour_text = "You have been deployed into enemy territory. Continue working the best you can, and keep a low profile"
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = TRUE
	computer_area = /area/ruin/space/has_grav/bubbers/persistance/service/lockers
	spawner_job_path = /datum/job/persistence
	/// If true, this spawner will give it's target exploitables access.
	var/give_exploitables = TRUE

/obj/effect/mob_spawn/ghost_role/human/persistence/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()

	if (give_exploitables)
		spawned_mob.mind?.has_exploitables_override = TRUE
		spawned_mob.mind?.handle_exploitables_menu()

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate
	name = "Syndicate Operative"
	prompt_name = "a Syndicate Operative"
	you_are_text = "You are a Syndicate operative, employed as part of a crew aboard a landcrawler."
	flavour_text = "The Syndicate managed Persistence mining rig has been deployed into enemy territory to stealthily monitor Nanotrasen assets. Your orders are to maintain the ship's integrity, perform your duties and keep a low profile while maintaining your front as a mining operation."
	important_text = "You are NOT an antagonist and the round does not center the Persistence. You MUST submit an Opfor or Adminhelp for significant interaction with the station and its crew"
	outfit = /datum/outfit/persistence/syndicate

/obj/effect/mob_spawn/ghost_role/human/persistence/command
	name = "Syndicate Command Operative"
	prompt_name = "a Syndicate leader"
	you_are_text = "you are a Syndicate Command Operative assigned to lead the SSV Persistence and guide it forward in its goals"
	flavour_text = "The Syndicate managed Persistence mining rig has been deployed into enemy territory to stealthly monitor Nanotrasen assets under the cover of a legal mining operation. Your orders are to lead the Persistence while ensuring a low profile is maintained."
	important_text = "You are a command role and held to a higher standard. You are NOT an antagonist and the round does not center around the Persistence. You MUST submit an Opfor or Adminhelp for significant interaction with the station and its crew"
	outfit = /datum/outfit/persistence/command

/obj/effect/mob_spawn/ghost_role/human/persistence/prisoner
	name = "Syndicate Hostage"
	prompt_name = "a Syndicate hostage"
	you_are_text = "You are a hostage onboard an unknown vessel"
	flavour_text = "Unaware of where you are, all you know is you are a prisoner. The plastitanium should clue you into who your captors are... as for why you're here? That's for you to know, and for us to find out."
	important_text = "You are not an antagonist. You are still bound to the Roleplay Rules regarding escalation. Syndicate personnel will throw you into lava or plasma outside if you antagonize them."
	outfit = /datum/outfit/persistence/prisoner
	computer_area = /area/ruin/space/has_grav/bubbers/persistance/sec/prison
	give_exploitables = FALSE

// crew spawners

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/service
	outfit = /datum/outfit/persistence/syndicate/service

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/janitor
	outfit = /datum/outfit/persistence/syndicate/janitor

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/enginetech
	outfit = /datum/outfit/persistence/syndicate/enginetech

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/researcher
	outfit = /datum/outfit/persistence/syndicate/researcher

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/stationmed
	outfit = /datum/outfit/persistence/syndicate/stationmed

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/brigoff
	outfit = /datum/outfit/persistence/syndicate/brigoff

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/quartermaster
	outfit = /datum/outfit/persistence/syndicate/quartermaster

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/moraleofficer
	outfit = /datum/outfit/persistence/syndicate/moraleofficer

//command spawners

/obj/effect/mob_spawn/ghost_role/human/persistence/command/masteratarms
	outfit = /datum/outfit/persistence/command/masteratarms

/obj/effect/mob_spawn/ghost_role/human/persistence/command/corporateliaison
	outfit = /datum/outfit/persistence/command/corporateliaison

/obj/effect/mob_spawn/ghost_role/human/persistence/command/admiral
	outfit = /datum/outfit/persistence/command/admiral

// Codespeak Granter

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)

/obj/effect/mob_spawn/ghost_role/human/persistence/command/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)


// Outfits --------------

/datum/outfit/persistence
	name = "Persistence"

/datum/outfit/persistence/post_equip(mob/living/carbon/human/syndicate, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = syndicate.wear_id
	if(istype(id_card))
		id_card.registered_name = syndicate.real_name
		id_card.update_label()
		id_card.update_icon()
	syndicate.apply_pref_name(/datum/preference/name/syndicate, syndicate.client)
	handlebank(syndicate)
	return ..()

//Persistence Hostage

/datum/outfit/persistence/prisoner
	name = "Persistence Syndicate Prisoner"
	uniform = /obj/item/clothing/under/rank/prisoner/syndicate
	shoes = /obj/item/clothing/shoes/sneakers/crimson
	id = /obj/item/card/id/advanced/prisoner/ds2
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/prisoner

//Persistence Roles

/datum/outfit/persistence/syndicate
	name = "Persistence Operative"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/interdyne
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/choice_beacon/syndicateoffstation = 1,
		)
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless

/datum/outfit/persistence/syndicate/service
	name = "Persistence General Staff"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/syndicatestaff
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/sharpener = 1,
		/obj/item/choice_beacon/syndicateoffstation = 1,
		)
	suit = /obj/item/clothing/suit/apron/chef
	head = /obj/item/clothing/head/soft/mime

/datum/outfit/persistence/syndicate/janitor
	name = "Persistence Sanitation Technician"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/janitor
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/choice_beacon/syndicateoffstation = 1,
		/obj/item/soap/syndie = 1,
		)
	belt = /obj/item/storage/belt/janitor/full

/datum/outfit/persistence/syndicate/enginetech
	name = "Persistence Engineer"
	uniform = /obj/item/clothing/under/syndicate/skyrat/overalls
	head = /obj/item/clothing/head/soft/sec/syndicate
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/choice_beacon/syndicateoffstation/engineer = 1,
		)
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/engineer
	glasses = /obj/item/clothing/glasses/welding/up
	belt = /obj/item/storage/belt/utility/syndicate
	gloves = /obj/item/clothing/gloves/combat

/datum/outfit/persistence/syndicate/researcher
	name = "Persistence Researcher"
	uniform = /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/researcher
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	glasses = /obj/item/clothing/glasses/sunglasses/chemical
	gloves = /obj/item/clothing/gloves/color/black
	back = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/utility/syndicate

/datum/outfit/persistence/syndicate/stationmed
	name = "Persistence Medical Officer"
	uniform = /obj/item/clothing/under/syndicate/scrubs
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/medicalofficer
	suit = /obj/item/clothing/suit/toggle/labcoat/interdyne
	belt = /obj/item/storage/belt/medical/paramedic
	gloves = /obj/item/clothing/gloves/latex/nitrile/ntrauma
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/storage/medkit/surgery = 1,
		/obj/item/choice_beacon/syndicateoffstation = 1,
		)

/datum/outfit/persistence/syndicate/brigoff
	name = "Persistence Brig Officer"
	uniform = /obj/item/clothing/under/syndicate/combat
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/brigofficer
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/bulletproof/old
	back = /obj/item/storage/backpack/security/redsec
	backpack_contents = list(
		/obj/item/flashlight/seclite = 1,
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/choice_beacon/syndicateoffstation = 1,
		)
	head = /obj/item/clothing/head/helmet/swat/ds
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/redsec
	mask = /obj/item/clothing/mask/gas/syndicate
	ears = /obj/item/radio/headset/interdyne

/datum/outfit/persistence/syndicate/quartermaster
	name = "Persistence Cargo Tech"
	uniform = /obj/item/clothing/under/syndicate/skyrat/overalls
	belt = /obj/item/storage/bag/ore
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/cargo
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/bulletproof/old
	back = /obj/item/storage/backpack/satchel/explorer
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/knife/combat/survival = 1,
		/obj/item/t_scanner/adv_mining_scanner/lesser = 1,
		/obj/item/gun/energy/recharge/kinetic_accelerator = 1,
		/obj/item/choice_beacon/syndicateoffstation = 1,
		)
	mask = /obj/item/clothing/mask/gas/syndicate
	ears = /obj/item/radio/headset/interdyne
	l_pocket = /obj/item/card/mining_point_card
	r_pocket = /obj/item/mining_voucher
	head = /obj/item/clothing/head/soft/black

/datum/outfit/persistence/syndicate/moraleofficer
	name = "Persistence Morale Officer"
	uniform = /obj/item/clothing/under/syndicate/sniper
	head = /obj/item/clothing/head/fedora
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack/satchel
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/moraleofficer
	mask = /obj/item/clothing/mask/gas/clown_hat


//gives syndicate role so turrets don't shoot operative
/datum/outfit/persistence/syndicate/post_equip(mob/living/carbon/human/syndicate)
	syndicate.faction |= ROLE_SYNDICATE
	return ..()

// Dauntless Command

/datum/outfit/persistence/command
	name = "Persistence Command Operative"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/interdyne/command
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/choice_beacon/syndicateoffstation/command = 1,
		)
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless

/datum/outfit/persistence/command/masteratarms
	name = "Persistence Master At Arms"
	uniform = /obj/item/clothing/under/syndicate/combat
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/masteratarms
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/vest/warden/syndicate
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/redsec
	back = /obj/item/storage/backpack/satchel/sec/redsec
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/choice_beacon/syndicateoffstation/maa =1,
		)
	head = /obj/item/clothing/head/hats/hos/beret/syndicate
	r_pocket = /obj/item/flashlight/seclite
	implants = list(
		/obj/item/implant/weapons_auth,
		/obj/item/implant/krav_maga
		)

/datum/outfit/persistence/command/corporateliaison
	name = "Persistence Corporate Liasion"
	uniform = /obj/item/clothing/under/syndicate/sniper
	head = /obj/item/clothing/head/fedora
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack/satchel
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/corporateliasion

/datum/outfit/persistence/command/admiral
	name = "Rig Admiral"
	uniform = /obj/item/clothing/under/rank/captain/skyrat/utility/syndicate
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/choice_beacon/syndicateoffstation/morale = 1,
		)
	head = /obj/item/clothing/head/hats/hos/cap/syndicate
	id = /obj/item/card/id/advanced/gold/generic
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/rigmanager


//gives syndicate role so turrets don't shoot operatives
/datum/outfit/persistence/command/post_equip(mob/living/carbon/human/syndicate)
	syndicate.faction |= ROLE_SYNDICATE
	return ..()
