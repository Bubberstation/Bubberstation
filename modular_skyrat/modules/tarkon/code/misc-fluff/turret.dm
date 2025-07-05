/obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus
	name = "\improper T.I.B.S Cerberus Kit"
	desc = "A \"Tarkon Industries Blackrust Salvage\" \"Cerberus\" Turret Deployment Kit, it deploys a turret feeding from provided magazines. \
	This model comes with 3 adjustable magazine slots, supporting most commonly available magazines."
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "cerberus_toolbox"
	righthand_file = 'modular_skyrat/modules/tarkon/icons/mob/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/tarkon/icons/mob/inhands/lefthand.dmi'
	inhand_icon_state = "cerberus_turretkit"
	worn_icon_state = "cerberus_harness"
	worn_icon = 'modular_skyrat/modules/tarkon/icons/mob/clothing/belt.dmi'
	has_latches = FALSE
	slot_flags = ITEM_SLOT_BELT
	easy_deploy = TRUE
	easy_deploy_timer = 1.5 SECONDS
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/cerberus //To make it more available for subtyping. LET. THEM. COOK.
	mag_slots = 3 //how many magazines can be held.
	mag_types_allowed = list( //This is a whitelist for what is allowed. Nothing else may enter.
		/obj/item/ammo_box/magazine/m9mm,
		/obj/item/ammo_box/magazine/m45, // Near-matching DPS replacement
		/obj/item/ammo_box/magazine/c585trappiste_pistol,
		/obj/item/ammo_box/magazine/miecz,
		/obj/item/ammo_box/magazine/lanca,
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite
	name = "\improper Tarkon Industries Hoplite Kit"
	desc = "A \"Tarkon Industries\" \"Hoplite\" Turret Deployment Kit, it deploys a turret feeding from provided magazines. \
	This model comes with 2 adjustable magazine slots, supporting 4.6x30mm magazines as well as Cesarzowa and Trappiste."
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "hoplite_toolbox"
	righthand_file = 'modular_skyrat/modules/tarkon/icons/mob/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/tarkon/icons/mob/inhands/lefthand.dmi'
	inhand_icon_state = "hoplite_turretkit"
	worn_icon = 'modular_skyrat/modules/tarkon/icons/mob/clothing/belt.dmi'
	worn_icon_state = "hoplite_harness"
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/hoplite
	mag_slots = 2
	slot_flags = ITEM_SLOT_BELT
	easy_deploy = TRUE
	easy_deploy_timer = 1.5 SECONDS
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/wt550m9, //Matching DPS replacement
		/obj/item/ammo_box/magazine/c585trappiste_pistol,
		/obj/item/ammo_box/magazine/miecz,
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)

/obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)

////// Turrets //////
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/cerberus
	name = "\improper T.I.B.S \"Cerberus\" Guardian Turret"
	desc = "A heavy-protection turret used in the Tarkon Industries Blackrust Salvage group to protect its workers in hazardous conditions."
	integrity_failure = 0
	max_integrity = 200
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "cerberus_off"
	base_icon_state = "cerberus"
	faction = list(FACTION_TARKON, FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/hoplite
	name = "\improper Tarkon Industries \"Hoplite\" Point-Defense Turret"
	desc = "A protection turret used by Tarkon Industries for civilian installation protection."
	max_integrity = 120
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "hoplite_off"
	base_icon_state = "hoplite"
	shot_delay = 15 //1.5 seconds
	faction = list(FACTION_TARKON, FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite/pre_filled

/obj/item/turret_assembly/cerberus
	name = "cerberus plate assembly"
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "cerberus_assembly"
	desc = "A set of assembly parts for a magazine-fed turret, requiring a receiver, servo and sensor along with construction. This one is for a \"Cerberus\" model turret type."
	design = /obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus

/obj/item/turret_assembly/hoplite
	name = "hoplite plate assembly"
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "hoplite_assembly"
	desc = "A set of assembly parts for a magazine-fed turret, requiring a receiver, servo and sensor along with construction. This one is for a \"Hoplite\" model turret type."
	design = /obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite
