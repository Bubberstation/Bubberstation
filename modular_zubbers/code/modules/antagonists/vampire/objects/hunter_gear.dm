/obj/item/clothing/suit/armor/vamphunter
	name = "vampire hunter garb"
	desc = "This worn outfit saw much use back in the day. Internal reinforcements help protect against bites and scratches."
	allowed = list(
		/obj/item/book/bible,
		/obj/item/book/kindred,
		/obj/item/food/garlic_kimchi,
		/obj/item/food/garlicbread,
		/obj/item/food/grown/garlic,
		/obj/item/reagent_containers/cup/glass/bottle/garlic_extract,
		/obj/item/reagent_containers/cup/glass/bottle/holywater,
		/obj/item/stake,
	)
	icon = 'modular_zubbers/icons/obj/antags/vampire/vamp_obj.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/vampire_hunter.dmi'
	icon_state = "monsterhunter"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor_type = /datum/armor/vamphunter_garb
	strip_delay = 8 SECONDS
	equip_delay_other = 6 SECONDS

/datum/armor/vamphunter_garb
	melee = 25
	bullet = 10
	laser = 25
	energy = 10
	acid = 45
	wound = 10

/obj/item/clothing/head/helmet/vamphunter_hat
	name = "vampire hunter hat"
	desc = "This hat saw much use back in the day."
	icon = 'modular_zubbers/icons/obj/antags/vampire/vamp_obj.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/vampire_hunter.dmi'
	icon_state = "monsterhunterhat"
	inhand_icon_state = null
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEEYES
	armor_type = /datum/armor/chaplainsuit_armor
	strip_delay = 8 SECONDS
	dog_fashion = null

/obj/item/storage/box/hero/vamphunter // I SWEAR this isn't just the chaplains stuff!!!!
	name = "Vampire Hunter Kit - 1735"
	desc = "Vampire Hunter - 1735. 
" + span_notice("The garb can hold a variety of relevant items.
Comes with a crucifix that wards against hexes, and a few premium stakes.")

/obj/item/storage/box/hero/vamphunter/PopulateContents()
	new /obj/item/clothing/suit/armor/vamphunter(src)
	new /obj/item/clothing/head/helmet/vamphunter_hat(src)
	new /obj/item/clothing/neck/crucifix(src)
	new /obj/item/stake/hardened/silver(src)
	new /obj/item/stake/hardened/silver(src)
	new /obj/item/reagent_containers/cup/glass/bottle/garlic_extract(src)

/obj/item/reagent_containers/cup/glass/bottle/garlic_extract
	name = "flask of garlic extract"
	desc = "A flask of concentrated, and sanctified garlic extract. Surely to ward off any vampires trying to bite you. Lucky for you, those don't exist... right?"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "holyflask"
	inhand_icon_state = "holyflask"
	list_reagents = list(/datum/reagent/consumable/garlic = 70, /datum/reagent/water/holywater = 30)
	drink_type = VEGETABLES
