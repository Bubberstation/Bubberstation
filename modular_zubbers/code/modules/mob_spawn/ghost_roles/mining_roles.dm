/obj/effect/mob_spawn/ghost_role/human/lavaland_gasstation
	name = "Lavaland Gas Station Attendant"
	desc = "Seems like there's somebody inside, peacefully sleeping."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "a gas station worker"
	you_are_text = "You are a worker at a Lizard's Gas Station close to a mining facility."
	flavour_text = "Your employer, however, failed to realize that there are hostile megafauna and tribes in the area, so make sure that you can defend yourself. Also sell stuff to people, occasionally."
	important_text = "Do NOT let your workplace get damaged! Do not abandon it either!"
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = FALSE
	outfit = /datum/outfit/lavaland_gasstation

/datum/outfit/lavaland_gasstation
	name = "Lizard Gas Station Attendant"
	uniform = /obj/item/clothing/under/costume/lizardgas
	shoes = /obj/item/clothing/shoes/sneakers/black
	ears = /obj/item/instrument/piano_synth/headphones
	gloves = /obj/item/clothing/gloves/fingerless
	head = /obj/item/clothing/head/soft/purple
	l_pocket = /obj/item/modular_computer/pda

/obj/effect/mob_spawn/ghost_role/human/allamerican_employee
	name = "All-American Diner Employee"
	desc = "Seems like there's somebody inside, peacefully sleeping."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "a diner employee"
	you_are_text = "You are a non-descript employee for a All-American Diner joint in the middle of space."
	flavour_text = "Your employers sent you to a workplace in the middle of space, with a beacon, and teleporter. You're to help all the customers to their needs, and requests! You're the boss, make the rules!"
	important_text = "Do NOT abandon the Diner or let it get damaged!"
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = FALSE
	outfit = /datum/outfit/allamerican_employee

/datum/outfit/allamerican_employee
	name = "All-American Diner Employee"
	uniform = /obj/item/clothing/under/costume/allamerican
	suit = /obj/item/clothing/suit/apron/chef
	back = /obj/item/storage/backpack/satchel
	box = /obj/item/storage/box/survival
	shoes = /obj/item/clothing/shoes/sneakers/black
	ears = null
	gloves = /obj/item/clothing/gloves/latex
	head = /obj/item/clothing/head/soft/allamerican
	l_pocket = /obj/item/modular_computer/pda
	id = /obj/item/card/id/advanced/allamerican
	id_trim = /datum/id_trim/away/allamerican

/obj/effect/mob_spawn/ghost_role/human/allamerican_manager
	name = "All-American Diner Manager"
	desc = "Seems like there's somebody inside, peacefully sleeping."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "a diner manager"
	you_are_text = "You are a non-descript manager for a All-American Diner joint in the middle of space."
	flavour_text = "Your employers sent you to a workplace in the middle of space, with a beacon, and teleporter. You're to help all the customers to their meals, and requests until your manager says otherwise!"
	important_text = "Do NOT abandon the Diner or let it get damaged!"
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = FALSE
	outfit = /datum/outfit/allamerican_manager

/datum/outfit/allamerican_manager
	name = "All-American Diner Manager"
	uniform = /obj/item/clothing/under/costume/allamerican/manager
	suit = /obj/item/clothing/suit/misc/allamerican
	back = /obj/item/storage/backpack/satchel/leather
	belt = /obj/item/gun/energy/e_gun/mini
	neck = /obj/item/clothing/neck/tie/black/tied
	box = /obj/item/storage/box/survival
	shoes = /obj/item/clothing/shoes/laceup
	ears = null
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/soft/allamerican
	l_pocket = /obj/item/modular_computer/pda
	id = /obj/item/card/id/advanced/allamerican/manager
	id_trim = /datum/id_trim/away/allamerican/manager
