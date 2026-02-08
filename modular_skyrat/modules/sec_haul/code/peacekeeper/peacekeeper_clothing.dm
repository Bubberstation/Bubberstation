// anything here is non-sec specific or is used for armadyne, which is out-of-scope

/obj/item/clothing/head/helmet/sec/terra
	name = "sol police helmet"
	desc = "A helmet to protect any officer from bludgeoning attacks, or the occasional bullet."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	icon_state = "security_helmet-novisor"
	base_icon_state = "security_helmet-novisor"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/head_helmet

/obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper
	name = "peacekeeper hud glasses"
	icon_state = "peacekeeperglasses"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'

//PEACEKEEPER ARMOR

/obj/item/clothing/suit/armor/vest/brit
	name = "high vis armored vest"
	desc = "Oi bruv, you got a loicence for that?"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "hazardbg"
	worn_icon_state = "hazardbg"

/obj/item/clothing/suit/armor/vest/brit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "zipper")

//PEACEKEEPER GLOVES
/obj/item/clothing/gloves/combat/peacekeeper
	name = "peacekeeper gloves"
	desc = "These tactical gloves are fireproof."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "peacekeeper_gloves"
	worn_icon_state = "peacekeeper"
	siemens_coefficient = 0.5
	strip_delay = 20
	cold_protection = 0
	min_cold_protection_temperature = null
	heat_protection = 0
	max_heat_protection_temperature = null
	resistance_flags = FLAMMABLE
	armor_type = /datum/armor/none
	cut_type = null

//PEACEKEEPER BELTS
/obj/item/storage/belt/security/peacekeeper
	name = "peacekeeper belt"
	desc = "This belt can hold security gear like handcuffs and flashes. It has a holster for a gun."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "peacekeeperbelt"
	worn_icon_state = "peacekeeperbelt"
	content_overlays = FALSE

/obj/item/storage/belt/security/peacekeeper/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 5
	atom_storage.set_holdable(list(
		/obj/item/melee/baton,
		/obj/item/melee/baton,
		/obj/item/grenade,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash/handheld,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_box,
		/obj/item/food/donut,
		/obj/item/knife/combat,
		/obj/item/flashlight/seclite,
		/obj/item/melee/baton/telescopic,
		/obj/item/radio,
		/obj/item/clothing/gloves,
		/obj/item/restraints/legcuffs/bola,
		/obj/item/holosign_creator/security
		))

/obj/item/storage/belt/security/peacekeeper/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	update_icon()

//BOOTS
/obj/item/clothing/shoes/jackboots/peacekeeper
	name = "peacekeeper boots"
	desc = "High speed, low drag combat boots."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "peacekeeper"
