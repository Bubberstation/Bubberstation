//Yes, I'm for real

/obj/item/choice_beacon/strategem_utility
	name = "Signal Radio (Utility)"
	desc = "Requesting Strategem"
	company_source = "NanoTrasen War Department"
	company_message = span_bold("Copy that, pod calibrated and launching!")
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "radio"

/obj/item/choice_beacon/strategem_utility/generate_display_names()
	var/static/list/selectable_utility_strategem = list(
		"Medical Support" = list(/mob/living/basic/bot/medbot/stationary, /obj/item/storage/backpack/duffelbag/deforest_medkit/stocked),
		"Medical Bay Kit" = list (/obj/structure/table/optable, /obj/item/construction/rcd/loaded, /obj/item/circuitboard/computer/operating, /obj/item/storage/medkit/surgery, /obj/item/reagent_containers/cup/bottle/formaldehyde, /obj/item/reagent_containers/syringe, /obj/item/storage/toolbox/mechanical),
		"Security Modsuit Dual Pack" = list(/obj/item/mod/control/pre_equipped/security, /obj/item/mod/control/pre_equipped/security),
		"Laser Drop" = list (/obj/item/gun/energy/laser, /obj/item/gun/energy/laser, /obj/item/gun/energy/laser, /obj/item/gun/energy/laser/carbine),
		"Recharger" = list(/obj/machinery/recharger, /obj/machinery/recharger, /obj/machinery/recharger, /obj/item/inducer),
	)

	return selectable_utility_strategem

/obj/item/choice_beacon/strategem_defensive
	name = "Signal Radio (Defensive)"
	desc = "Requesting Strategem"
	company_source = "NanoTrasen War Department"
	company_message = span_bold("Copy that, pod calibrated and launching!")
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "radio"

/obj/item/choice_beacon/strategem_defensive/generate_display_names()
	var/static/list/selectable_defensive_strategem = list(
		"Heavy Disabler Nest" = /obj/machinery/deployable_turret/disabler,
		"Orbital Paddy Drop" = list(/obj/vehicle/sealed/mecha/ripley/paddy/preset, /obj/item/clothing/head/utility/hardhat/welding/dblue, /obj/item/weldingtool/largetank),
		"Portable Flashers" = list(/obj/machinery/flasher/portable, /obj/machinery/flasher/portable, /obj/machinery/flasher/portable),
		"Barricades" = list(/obj/item/storage/barricade, /obj/item/storage/barricade, /obj/item/grenade/barrier, /obj/item/grenade/barrier, /obj/item/grenade/barrier,/obj/item/door_seal, /obj/item/door_seal, /obj/item/door_seal, /obj/item/door_seal),
	)

	return selectable_defensive_strategem

// Stuff Here

/obj/machinery/deployable_turret/disabler
	name = "Disabler Machinegun"
	projectile_type = /obj/projectile/beam/disabler/weak
	anchored = TRUE
	number_of_shots = 3
	cooldown_duration = 1 SECONDS
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
