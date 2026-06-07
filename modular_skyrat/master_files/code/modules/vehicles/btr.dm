/obj/vehicle/sealed/mecha/btr
	desc = "HOLY SHIT IS THAT A FUCKING BTR?."
	name = "\improper BTR"
	icon = 'modular_skyrat/master_files/icons/obj/vehicles/btr.dmi'
	icon_state = "BTR_clean"
	base_icon_state = "BTR_cleanr"
	movedelay = 10
	max_integrity = 2000
	armor_type = /datum/armor/mecha_btr
	max_temperature = 60000
	destruction_sleep_duration = 100
	exit_delay = 80
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	accesses = list(ACCESS_CENT_SPECOPS)
	wreckage = /obj/structure/mecha_wreckage/marauder
	mecha_flags = IS_ENCLOSED | HAS_LIGHTS
	mech_type = EXOSUIT_MODULE_MARAUDER
	force = 100
	bumpsmash = TRUE
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 5,
		MECHA_POWER = 1,
		MECHA_ARMOR = 3,
	)
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmgtwentymilimeter,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/tank_cannon,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiemp_armor_booster/clandestine, /obj/item/mecha_parts/mecha_equipment/armor/anticcw_armor_booster, /obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster),
	)

/datum/armor/mecha_btr
	melee = 100
	bullet = 80
	laser = 70
	energy = 0
	bomb = 60
	fire = 100
	acid = 100

/obj/vehicle/sealed/mecha/btr/generate_actions()
	. = ..()
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mech_zoom)

///realistically its gas powered but meh
/obj/vehicle/sealed/mecha/marauder/loaded/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/infinite(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/datum/action/vehicle/sealed/mecha/mech_zoom
	name = "Zoom"
	button_icon_state = "mech_zoom_off"

/datum/action/vehicle/sealed/mecha/mech_zoom/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	if(!owner.client || !chassis || !(owner in chassis.occupants))
		return
	chassis.zoom_mode = !chassis.zoom_mode
	button_icon_state = "mech_zoom_[chassis.zoom_mode ? "on" : "off"]"
	chassis.log_message("Toggled zoom mode.", LOG_MECHA)
	to_chat(owner, "[icon2html(chassis, owner)]<font color='[chassis.zoom_mode?"blue":"red"]'>Zoom mode [chassis.zoom_mode?"en":"dis"]abled.</font>")
	if(chassis.zoom_mode)
		owner.client.view_size.setTo(4.5)
		SEND_SOUND(owner, sound('sound/vehicles/mecha/imag_enh.ogg', volume=50))
	else
		owner.client.view_size.resetToDefault()
	build_all_button_icons()

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmgtwentymilimeter
	name = "Oerlikon"
	desc = "A weapon for a heavy vehicle, can be mounted on a mech but, you get the feeling "
	icon_state = "mecha_uac2"
	equip_cooldown = 10
	projectile = /obj/projectile/bullet/mm20x138
	projectiles = 300
	projectiles_cache = 300
	projectiles_cache_max = 1200
	projectiles_per_shot = 3
	variance = 6
	randomspread = 1
	projectile_delay = 2
	harmful = TRUE
	ammo_type = /obj/item/ammo_casing/mm20x138

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/tank_cannon
	name = "\improper Tank cannon"
	desc = "A weapon for a tank, the entire tank barrel, firing mechanism and loading mechanism, how you are holding it, is a mystery that will never be solved."
	icon_state = "mecha_missilerack"
	projectile = /obj/projectile/bullet/rocket/srm
	fire_sound = 'sound/items/weapons/gun/general/cannon.ogg'
	ammo_type = MECHA_AMMO_MISSILE_SRM
