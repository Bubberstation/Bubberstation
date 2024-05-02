/obj/item/gun/ballistic/automatic/ar23
	name = "\improper AR-223 'Defender' Assault Rifle"
	desc = "A bullpup full auto assault rifle chambered in .223, Ideal for defending your Managed Democracy."
	icon = 'modular_zubbers/icons/obj/reshirifle.dmi'
	icon_state = "c20r"
	inhand_icon_state = "arg"
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	worn_icon_state = "infanterie_evil"
	selector_switch_icon = TRUE
	accepted_magazine_type = /obj/item/ammo_box/magazine/m223
	fire_delay = 1.5
	burst_size = 3
	pin = /obj/item/firing_pin
	can_bayonet = FALSE
	can_suppress = TRUE
	mag_display_ammo = TRUE
	spread = 17

/obj/item/gun/ballistic/automatic/ar23/Initialize(mapload)
	.=..()
	AddComponent(/datum/component/automatic_fire, 0.4 SECONDS)

/datum/crafting_recipe/liberator_kit
	name = "Democratic Transition"
	result = /obj/item/gun/ballistic/automatic/ar23
	reqs = list(
		/obj/item/gun/ballistic/automatic/wt550/security = 1,
		/obj/item/weaponcrafting/gunkit/liberator_kit = 1,
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED

/obj/item/weaponcrafting/gunkit/liberator_kit
	name = "Democratic Transition Kit"
	desc = "Turn your peacemaker into a true liberator fitting for this sector."
