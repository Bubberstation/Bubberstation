////// Outpost Turret, Will be used for space ruins.
/obj/item/storage/toolbox/emergency/turret/mag_fed/outpost
	name = "outpost defense turret kit"
	desc = "A deployable turret designed for outpost point defense and management of stray fauna."
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "outpost_toolbox"
	righthand_file = 'modular_skyrat/modules/magfed_turret/icons/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/magfed_turret/icons//inhands/lefthand.dmi'
	inhand_icon_state = "outpost_turretkit"
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/outpost
	mag_slots = 2
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/wt550m9
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/outpost/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/wt550m9(src)
	new /obj/item/ammo_box/magazine/wt550m9(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/outpost
	name = "\improper Outpost Point-Defense Turret"
	desc = "A deployable turret used for protection of outposts and civilian constructs."
	max_integrity = 120
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "outpost_off"
	base_icon_state = "outpost"
	shot_delay = 1.5 SECONDS
	faction = list(FACTION_TURRET)
	fragile = TRUE
	turret_frame = /obj/item/turret_assembly
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/outpost/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/outpost/malf
	name = "\improper Malfunctioning Outpost Turret"
	faction = list(FACTION_MALF_TURRET)
	shot_delay = 1 SECONDS

////// Colonist Turret. Kinda just made to be a ghost-role friendly version of the outpost turret

/obj/item/storage/toolbox/emergency/turret/mag_fed/colonist
	name = "colonist defense turret kit"
	desc = "A deployable turret designed for safety during colony construction and colonist expeditionary camps. It is chambered to fire .460 ammunition"
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "colonist_toolbox"
	righthand_file = 'modular_skyrat/modules/magfed_turret/icons/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/magfed_turret/icons//inhands/lefthand.dmi'
	inhand_icon_state = "colonist_turretkit"
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/colonist
	mag_slots = 2
	easy_deploy = TRUE
	turret_safety = TRUE
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/m45, // Most similar to sol40
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/colonist/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/colonist
	name = "\improper Colonist Point-Defense Turret"
	desc = "A deployable turret used for protection of colonists during construction or expeditionary trips. It is chambered to fire .460 ammunition"
	max_integrity = 150 //bit more health since it's meant for mobs only. Malf version is one of a kind to use.
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "colonist_off"
	base_icon_state = "colonist"
	shot_delay = 1.5 SECONDS
	quick_retract = TRUE
	faction = list(FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/colonist/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/colonist/malf
	name = "\improper Malfunctioning Colonist Point-Defense Turret"
	faction = list(FACTION_MALF_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/colonist/pre_filled

////// Spider turret. Throw-deployable turret with actual ammunition.

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider
	name = "spider offensive turret capsule"
	desc = "A throw-deployable turret capsule designed for securing areas within hostile fauna held zones. It is chambered in 4.6x30mm ammunition."
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "35_spider_toolbox"
	inhand_icon_state = "smoke" //I dont want to squash-make something. This should cover until i work something.
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	throw_speed = 2
	w_class = WEIGHT_CLASS_NORMAL // This isn't going to spawn outside of ruins/ghost roles, so it being small shouldn't be too big of a concern?
	quick_deployable = TRUE
	quick_deploy_timer = 1 SECONDS
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider
	mag_slots = 1
	turret_safety = TRUE
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/wt550m9, //same damage value as 35 sol, since it's unprintable
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/wt550m9(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider
	name = "\improper Stinger Spider Turret"
	desc = "A deployable turret used for aggressive expansion and zone defense. It is chambered to fire 4.6x30mm ammunition."
	max_integrity = 80
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "35_spider_off"
	base_icon_state = "35_spider"
	shot_delay = 1.5 SECONDS
	faction = list(FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/spider/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider/malf // for ruins from here on
	name = "\improper Malfunctioning Twin-fang Turret"
	faction = list(FACTION_MALF_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/spider/malf/pre_filled

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/malf
	name = "odd spider turret kit"
	desc = "A deployable turret kit used for aggressive expansion and zone defense. It is chambered to fire 4.6x30mm ammunition. This one seems to have some odd lights flashing on it."
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider/malf

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/malf/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/wt550m9(src)

////// Twin-Fang turret. Spider Turret's nastier cousin. Slightly less durable but more vitriol. Chambered in 4.6x30mm

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang
	name = "twin-fang offensive turret capsule"
	desc = "A throw-deployable turret capsule designed for securing areas within hostile fauna held zones. It is chambered in 4.6x30mm ammunition."
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "twin_spider_toolbox"
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider/twin_fang
	mag_slots = 1
	turret_safety = FALSE
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/wt550m9,
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/wt550m9(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider/twin_fang
	name = "\improper Twin-Fang Spider Turret"
	desc = "A deployable turret used for aggressive expansion and zone defense. It is chambered to fire 4.6x30mm ammunition."
	max_integrity = 50 // more aggressive but obviously easier to deal with.
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "twin_spider_off"
	base_icon_state = "twin_spider"
	fragile = TRUE
	turret_frame = /obj/item/turret_assembly/twin_fang
	quick_retract = TRUE
	shot_delay = 0.1 SECONDS
	burst_fire = TRUE
	burst_delay = 2 SECONDS // Keeping the DPS exactly the same with sol35 removal
	burst_volley = 2
	faction = list(FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider/twin_fang/malf
	name = "\improper Malfunctioning Twin-fang Turret"
	faction = list(FACTION_MALF_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang/malf/pre_filled

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang/malf
	name = "odd twinfang turret kit"
	desc = "A throw-deployable turret capsule designed for securing areas within hostile fauna held zones. It is chambered in .4.6x30mm ammunition. This one seems to have some odd lights flashing on it."
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider/twin_fang/malf

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang/malf/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/wt550m9(src)

////// Shotgun Turret. Surprisingly nothing new added as the firing proc will handle pellet clouds. Note however that shotgun rounds CANT smart-gun around allies.
/obj/item/storage/toolbox/emergency/turret/mag_fed/duster
	name = "duster emergent turret kit"
	desc = "A quick-deployable turret kit designed for sudden deployment in emergent situations, having warnings to \"Not stand in front of the barrel. Friendly Fire Isn't\". It is fitted to use handfuls of loose shotgun shells or M12g magazines."
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "duster_toolbox"
	righthand_file = 'modular_skyrat/modules/magfed_turret/icons/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/magfed_turret/icons//inhands/lefthand.dmi'
	inhand_icon_state = "duster_turretkit"
	easy_deploy = TRUE
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/duster
	mag_slots = 3 // Most mags dont have more than 8 rounds, and you're going to have hell getting a shotgun mag to re-fill. 24 round total.
	turret_safety = FALSE
	mag_types_allowed = list( //Easy to get actually. Quite Nice
		/obj/item/ammo_box/magazine/m12g,
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/duster/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/m12g(src)
	new /obj/item/ammo_box/magazine/m12g(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/duster
	name = "\improper Duster Emergent Turret"
	desc = "A quick-deployable turret used for emergent situations and retreating deployment, incapable of using smart-projectile targeting. It is fitted to use handfuls of loose shotgun shells or M12g magazines."
	max_integrity = 100
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "duster_off"
	base_icon_state = "duster"
	fragile = TRUE
	turret_frame = /obj/item/turret_assembly/duster
	ignore_faction = FALSE // Pellet cloud wont work with it anyways.
	quick_retract = TRUE
	shot_delay = 2 SECONDS
	faction = list(FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/duster/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/duster/malf
	name = "\improper Malfunctioning Duster Turret"
	faction = list(FACTION_MALF_TURRET)
