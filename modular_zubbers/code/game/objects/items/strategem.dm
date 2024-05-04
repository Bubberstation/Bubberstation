//Yes, I'm for real

/obj/item/choice_beacon/stratagam_utility
	name = "Signal Radio (Utility)"
	desc = "Requesting Stratagam"
	company_source = "NanoTrasen War Department"
	company_message = span_bold("Copy that, pod calibrated and launching!")
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "radio"
	custom_premium_price = PAYCHECK_COMMAND * 8

/obj/item/choice_beacon/stratagam_utility/generate_display_names()
	var/static/list/selectable_utility_stratagam = list(
		"Medical Support" = list(/mob/living/basic/bot/medbot/stationary, /obj/item/storage/backpack/duffelbag/deforest_medkit/stocked),
		"Medical Bay Kit" = list (/obj/structure/table/optable, /obj/structure/frame/computer, /obj/item/circuitboard/computer/operating, /obj/item/storage/medkit/surgery, /obj/item/reagent_containers/cup/bottle/formaldehyde, /obj/item/reagent_containers/syringe, /obj/item/storage/toolbox/mechanical, /obj/item/stack/sheet/glass = 2, /obj/item/stack/cable_coil/thirty, /obj/item/holosign_creator/medical/treatment_zone),
		"Recharger" = list(/obj/machinery/recharger, /obj/machinery/recharger, /obj/machinery/recharger, /obj/item/inducer, /obj/item/storage/toolbox/mechanical),
	)

	return selectable_utility_stratagam

/obj/item/choice_beacon/stratagam_utility/can_use_beacon(user)
	if(!HAS_TRAIT (mob/living/user, TRAIT_MINDSHIELD))
		return ..()

/obj/item/choice_beacon/stratagam_defensive
	name = "Signal Radio (Defensive)"
	desc = "Requesting Stratagam"
	company_source = "NanoTrasen War Department"
	company_message = span_bold("Copy that, pod calibrated and launching!")
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "radio"
	custom_premium_price = PAYCHECK_COMMAND * 22

/obj/item/choice_beacon/stratagam_defensive/generate_display_names()
	var/static/list/selectable_defensive_stratagam = list(
		"Heavy Disabler Machinegun" = list(/obj/item/deployable_turret_folded/disabler, /obj/item/wrench),
		"Orbital Paddy Drop" = list(/obj/vehicle/sealed/mecha/ripley/paddy/preset, /obj/item/clothing/head/utility/hardhat/welding/dblue, /obj/item/weldingtool/largetank),
		"Portable Flashers" = list(/obj/machinery/flasher/portable, /obj/machinery/flasher/portable, /obj/machinery/flasher/portable),
		"Barricades" = list(/obj/item/storage/barricade, /obj/item/storage/barricade, /obj/item/grenade/barrier, /obj/item/grenade/barrier, /obj/item/grenade/barrier,/obj/item/door_seal, /obj/item/door_seal, /obj/item/door_seal, /obj/item/door_seal),
	)

	return selectable_defensive_stratagam

/obj/item/choice_beacon/stratagam_defensive/can_use_beacon(user)
	if(!HAS_TRAIT (mob/living/user, TRAIT_MINDSHIELD))
		return ..()

/obj/item/choice_beacon/stratagam_supply
	name = "Signal Radio (Supply)"
	desc = "Requesting Stratagam"
	company_source = "NanoTrasen War Department"
	company_message = span_bold("Copy that, pod calibrated and launching!")
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "radio"
	custom_premium_price = PAYCHECK_COMMAND * 10

/obj/item/choice_beacon/stratagam_supply/generate_display_names()
	var/static/list/selectable_supply_stratagam = list(
		"Security Modsuit Dual Pack" = list(/obj/item/mod/control/pre_equipped/security, /obj/item/mod/control/pre_equipped/security),
		"Laser Drop" = list(/obj/item/gun/energy/laser,/obj/item/gun/energy/laser,/obj/item/gun/energy/laser, , /obj/item/gun/energy/laser/carbine),
		"AutoRifle Drop" = list(/obj/item/gun/ballistic/automatic/wt550/security, /obj/item/gun/ballistic/automatic/wt550/security, /obj/item/gun/ballistic/automatic/wt550/security),
		"AutoRifle Ammo" = list(/obj/item/ammo_box/magazine/wt550m9, /obj/item/ammo_box/magazine/wt550m9, /obj/item/ammo_box/magazine/wt550m9, /obj/item/ammo_box/magazine/wt550m9, /obj/item/ammo_box/magazine/wt550m9, /obj/item/ammo_box/magazine/wt550m9),
	)

	return selectable_supply_stratagam

/obj/item/choice_beacon/stratagam_supply/can_use_beacon(user)
	if(!HAS_TRAIT (mob/living/user, TRAIT_MINDSHIELD))
		return ..()


// Stuff Here

/obj/machinery/deployable_turret/disabler
	name = "Disabler Machinegun"
	desc = "Disabler Machinegun, you can use a wrench to move this"
	projectile_type = /obj/projectile/beam/disabler/weak
	anchored = TRUE
	number_of_shots = 4
	cooldown_duration = 2 SECONDS
	spawned_on_undeploy = /obj/item/deployable_turret_folded/disabler
	can_be_undeployed = TRUE
	max_integrity = 450

/obj/item/deployable_turret_folded/disabler
	name = "folded disabler machine gun"
	desc = "A folded and unloaded heavy machine gun, ready to be deployed and used."
	icon = 'icons/obj/weapons/turrets.dmi'
	icon_state = "folded_hmg"
	inhand_icon_state = "folded_hmg"
	max_integrity = 450
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

/obj/item/deployable_turret_folded/disabler/Initialize(mapload)
	.=..()
	AddComponent(/datum/component/deployable, 5 SECONDS, /obj/machinery/deployable_turret/disabler)
