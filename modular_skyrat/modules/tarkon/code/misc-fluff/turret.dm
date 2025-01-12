/obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus
	name = "\improper T.I.B.S Cerberus Kit"
	desc = "A \"Tarkon Industries Blackrust Salvage\" \"Cerberus\" Turret Deployment Kit, it deploys a turret feeding from provided magazines. \
	This model comes with 3 adjustable magazine slots, supporting most commonly available magazines."
	icon = 'modular_nova/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "cerberus_toolbox"
	righthand_file = 'modular_nova/modules/tarkon/icons/mob/inhands/righthand.dmi'
	lefthand_file = 'modular_nova/modules/tarkon/icons/mob/inhands/lefthand.dmi'
	inhand_icon_state = "cerberus_turretkit"
	worn_icon_state = "cerberus_harness"
	worn_icon = 'modular_nova/modules/tarkon/icons/mob/clothing/belt.dmi'
	has_latches = FALSE
	slot_flags = ITEM_SLOT_BELT
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/cerberus //To make it more available for subtyping. LET. THEM. COOK.
	mag_slots = 3 //how many magazines can be held.
	mag_types_allowed = list( //This is a whitelist for what is allowed. Nothing else may enter.
		/obj/item/ammo_box/magazine/c35sol_pistol,
		/obj/item/ammo_box/magazine/c40sol_rifle,
		/obj/item/ammo_box/magazine/c585trappiste_pistol,
		/obj/item/ammo_box/magazine/miecz,
		/obj/item/ammo_box/magazine/lanca,
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite
	name = "\improper Tarkon Industries Hoplite Kit"
	desc = "A \"Tarkon Industries\" \"Hoplite\" Turret Deployment Kit, it deploys a turret feeding from provided magazines. \
	This model comes with 2 adjustable magazine slots, supporting most commonly available pistol-cal magazines."
	icon = 'modular_nova/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "hoplite_toolbox"
	righthand_file = 'modular_nova/modules/tarkon/icons/mob/inhands/righthand.dmi'
	lefthand_file = 'modular_nova/modules/tarkon/icons/mob/inhands/lefthand.dmi'
	inhand_icon_state = "hoplite_turretkit"
	worn_icon = 'modular_nova/modules/tarkon/icons/mob/clothing/belt.dmi'
	worn_icon_state = "hoplite_harness"
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/hoplite
	mag_slots = 2
	slot_flags = ITEM_SLOT_BELT
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/c35sol_pistol,
		/obj/item/ammo_box/magazine/c585trappiste_pistol,
		/obj/item/ammo_box/magazine/miecz,
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/c585trappiste_pistol(src)
	new /obj/item/ammo_box/magazine/c585trappiste_pistol(src)
	new /obj/item/ammo_box/magazine/c585trappiste_pistol(src)

/obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)

////// Turrets //////
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/cerberus
	name = "\improper T.I.B.S \"Cerberus\" Guardian Turret"
	desc = "A heavy-protection turret used in the Tarkon Industries Blackrust Salvage group to protect its workers in hazardous conditions."
	integrity_failure = 0
	max_integrity = 200
	icon = 'modular_nova/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "cerberus_off"
	base_icon_state = "cerberus"
	faction = list(FACTION_TARKON, FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/hoplite
	name = "\improper Tarkon Industries \"Hoplite\" Point-Defense Turret"
	desc = "A protection turret used by Tarkon Industries for civilian installation protection."
	max_integrity = 120
	icon = 'modular_nova/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "hoplite_off"
	base_icon_state = "hoplite"
	shot_delay = 15 //1.5 seconds
	faction = list(FACTION_TARKON, FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite/pre_filled
