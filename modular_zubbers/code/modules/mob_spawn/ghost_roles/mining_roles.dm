/obj/effect/mob_spawn/ghost_role/human/lavaland_gasstation
	name = "Gas Station Attendant"
	desc = "Seems like there's somebody inside, peacefully sleeping."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "a gas station worker"
	you_are_text = "You are a worker at a Lizard's Gas Station close to a mining facility."
	flavour_text = "Your employer, however, failed to realize that there are hostile megafauna and tribes in the area, so make sure that you can defend yourself. Also sell stuff to people, occasionally."
	important_text = "Do NOT let your workplace get damaged! Do not abandon it either!"
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = TRUE
	outfit = /datum/outfit/lavaland_gasstation
	allow_custom_character = ALL

/datum/outfit/lavaland_gasstation
	name = "Lizard Gas Station Attendant"
	uniform = /obj/item/clothing/under/costume/lizardgas
	shoes = /obj/item/clothing/shoes/sneakers/black
	ears = /obj/item/instrument/piano_synth/headphones
	gloves = /obj/item/clothing/gloves/fingerless
	head = /obj/item/clothing/head/soft/purple
	l_pocket = /obj/item/modular_computer/pda
	id = /obj/item/card/id/advanced/lizardgas

/datum/outfit/lavaland_gasstation/post_equip(mob/living/carbon/human/clerk, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = clerk.wear_id
	if(istype(id_card))
		id_card.registered_name = clerk.real_name
		id_card.update_label()
		id_card.update_icon()
	handlebank(clerk)
	return ..()

/datum/outfit/hermit
	backpack_contents = list(/obj/item/research_paper = 1)

/datum/outfit/hermit/post_equip(mob/living/carbon/human/hermit, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	hermit.mind?.teach_crafting_recipe(/datum/crafting_recipe/research_paper)
	to_chat(hermit, span_notice("You learn the recipe for the <b>research paper</b>, giving you the ability to craft everything from nothing."))

/// Manager and departmental ID additions
#define ROLE_LZGAS "Lizard Gas Station Manager"

/obj/effect/mob_spawn/ghost_role/human/lavaland_gasstation/manager
	name = "Gas Station Manager"
	prompt_name = "a gas station manager"
	outfit = /datum/outfit/lavaland_gasstation/manager
	you_are_text = "You are the branch manager of a Lizard's Gas Station close to a mining facility."
	flavour_text = "Years of working at Lizard's Gas finally paid off, and you been promoted to a Branch Manager! Sadly, your employer, failed to realize that there are hostile megafauna and tribes in the area, so make sure that you can defend yourself and your employees. Also sell stuff to people, occasionally."
	important_text = "Care for your employees, they are irreplaceable! Do NOT let your workplace get damaged! Do not abandon it either! Being the manager, you are held to a higher standard."

/datum/outfit/lavaland_gasstation/manager
	name = "Lizard Gas Station Manager"
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/knife/combat/survival = 1,
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 1,
		/obj/item/ammo_box/magazine/m45 = 3,
		)

/obj/item/card/id/faction_budget/lizgas
	department_ID = ACCOUNT_LIZ
	department_name = ACCOUNT_LIZ_NAME
	icon_state = "srv_budget" // Green just like our lizard.

#undef ROLE_LZGAS
