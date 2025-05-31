#define MCCLOUD_JET_MODE_MOVE 0.7
#define MCCLOUD_BIPED_MODE_MOVE 1.1
#define MCCLOUD_BIPED_MODE_MOVE_DISABLER 1.7

/obj/vehicle/sealed/mecha/mccloud
	desc = "An ultralight mech capable of spaceflight. Most popular with mercenaries, wanderers, and pirates; Nanotrasen has their own variation."
	name = "\improper McCloud"
	icon = 'modular_zubbers/code/modules/arris_mechs/icons/mecha.dmi'
	icon_state = "mccloud"
	base_icon_state = "mccloud"
	movedelay = MCCLOUD_BIPED_MODE_MOVE
	overclock_coeff = 1.1
	overclock_temp_danger = 3 //overclock ability makes this go crazy fast so it has to be significantly limited
	max_integrity = 150
	accesses = list(ACCESS_MECH_SCIENCE, ACCESS_MECH_SECURITY)
	armor_type = /datum/armor/mecha_mccloud
	max_temperature = 25000
	force = 25
	destruction_sleep_duration = 40
	exit_delay = 40
	wreckage = /obj/structure/mecha_wreckage/gygax
	mech_type = EXOSUIT_MODULE_GYGAX
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 4,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)
	equip_by_category = list(
		MECHA_L_ARM = null,
		MECHA_R_ARM = null,
		MECHA_UTILITY = null,// list(/obj/item/mecha_parts/mecha_equipment/thrusters/ion/mccloud),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(),
	)
	step_energy_drain = 25 //extremely high energy drain forces user to return to recharge points often

	var/jet_mode = FALSE
	//thrusters to use when not in jet mode
	var/obj/item/mecha_parts/mecha_equipment/thrusters/backup_thrusters = null
	//thrusters to use when in jet mode
	var/obj/item/mecha_parts/mecha_equipment/thrusters/ion/mccloud/jet_mode_thrusters = null
	COOLDOWN_DECLARE(cooldown_mech_mccloud_stamina_slow)

/datum/armor/mecha_mccloud
	melee = 10
	bullet = 15
	energy = 10
	fire = 40
	acid = 100

/obj/vehicle/sealed/mecha/mccloud/generate_actions()
	. = ..()
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mccloud/mech_switch_stance)
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mccloud/mech_toggle_binoculars)

/datum/action/vehicle/sealed/mecha/mccloud/mech_switch_stance
	name = "Switch mecha configuration"
	button_icon_state = "mech_overload_off"

/datum/action/vehicle/sealed/mecha/mccloud/mech_switch_stance/Trigger(trigger_flags)
	if(!..())
		return
	if(!chassis || !(owner in chassis.occupants))
		return

	var/obj/vehicle/sealed/mecha/mccloud/mccloud_chassis = chassis
	if (!istype(mccloud_chassis))
		return

	if(mccloud_chassis.jet_mode == FALSE)
		if (mccloud_chassis.can_switch_jet() == FALSE)
			mccloud_chassis.balloon_alert(owner, "atmosphere insufficient for spaceflight!")
		else
			mccloud_chassis.balloon_alert(owner, "switching to jet mode!")
			mccloud_chassis.activate_jet()
	else
		mccloud_chassis.balloon_alert(owner, "switching to biped mode!")
		mccloud_chassis.activate_biped()

/obj/vehicle/sealed/mecha/mccloud/proc/can_switch_jet()
	var/turf/T = get_turf(loc)
	if(lavaland_equipment_pressure_check(T))
		return TRUE
	return FALSE

/obj/vehicle/sealed/mecha/mccloud/proc/no_jet_environment()
	return !can_switch_jet()

/obj/vehicle/sealed/mecha/mccloud/proc/activate_jet(delay = 7)
	if(jet_mode)
		return
	if(delay != 0)
		do_after(usr, delay DECISECONDS)
	icon_state = "mccloud-jet"
	jet_mode = TRUE
	movedelay = !overclock_mode ? MCCLOUD_JET_MODE_MOVE : MCCLOUD_JET_MODE_MOVE / overclock_coeff
	mode_switch_sparks()

/obj/vehicle/sealed/mecha/mccloud/proc/activate_biped(delay = 7)
	if(!jet_mode)
		return
	if(delay != 0)
		do_after(usr, delay DECISECONDS)
	icon_state = "mccloud"
	jet_mode = FALSE
	movedelay = !overclock_mode ? MCCLOUD_BIPED_MODE_MOVE : MCCLOUD_BIPED_MODE_MOVE / overclock_coeff
	mode_switch_sparks()

/obj/vehicle/sealed/mecha/mccloud/proc/mode_switch_sparks()
	var/spark_directions = list(NORTHWEST, NORTHEAST, SOUTHEAST, SOUTHWEST)
	for(var/sdir in spark_directions)
		var/obj/effect/particle_effect/E = new /obj/effect/particle_effect/sparks(get_turf(src))
		E.dir = sdir
		step(E, sdir)
		QDEL_IN(E, 5)

/datum/action/vehicle/sealed/mecha/mccloud/mech_toggle_binoculars
	name = "Toggle scope vision"
	button_icon_state = "mech_damtype_brute"

/obj/vehicle/sealed/mecha/mccloud/vehicle_move(direction, forcerotate = FALSE)
	if(!jet_mode)
		return ..()
	else
		return jet_move(direction, forcerotate)

///Edit of parent's mech movement. Simply overriding it and adding stuff at the end isn't great cause plane movement is incapable of certain types of movement.
/obj/vehicle/sealed/mecha/mccloud/proc/jet_move(direction, forcerotate)
	if(!COOLDOWN_FINISHED(src, cooldown_vehicle_move))
		return FALSE
	COOLDOWN_START(src, cooldown_vehicle_move, movedelay)
	if(completely_disabled)
		return FALSE
	if(!direction)
		return FALSE
	if(ismovable(loc)) //Mech is inside an object, tell it we moved
		var/atom/loc_atom = loc
		return loc_atom.relaymove(src, direction)
	var/obj/machinery/portable_atmospherics/canister/internal_tank = get_internal_tank()
	if(internal_tank?.connected_port)
		if(TIMER_COOLDOWN_FINISHED(src, COOLDOWN_MECHA_MESSAGE))
			to_chat(occupants, "[icon2html(src, occupants)][span_warning("Unable to move while connected to the air system port!")]")
			TIMER_COOLDOWN_START(src, COOLDOWN_MECHA_MESSAGE, 2 SECONDS)
		return FALSE

	if(!use_energy(step_energy_drain))
		if(TIMER_COOLDOWN_FINISHED(src, COOLDOWN_MECHA_MESSAGE))
			to_chat(occupants, "[icon2html(src, occupants)][span_warning("Insufficient power to move!")]")
			TIMER_COOLDOWN_START(src, COOLDOWN_MECHA_MESSAGE, 2 SECONDS)
		return FALSE
	if(lavaland_only && is_mining_level(z))
		if(TIMER_COOLDOWN_FINISHED(src, COOLDOWN_MECHA_MESSAGE))
			to_chat(occupants, "[icon2html(src, occupants)][span_warning("Invalid Environment.")]")
			TIMER_COOLDOWN_START(src, COOLDOWN_MECHA_MESSAGE, 2 SECONDS)
		return FALSE

	var/olddir = dir
	var/keyheld = FALSE
	if(strafe)
		for(var/mob/driver as anything in return_drivers())
			if(driver.client?.keys_held["Alt"])
				keyheld = TRUE
				break

	//force direction change if user moves > 45 degrees away from facing direction, or if the direction is reversed, or if typical mech direction switch logic
	if((angle2dir_cardinal(drift_handler?.drifting_loop?.angle) != dir || dir == REVERSE_DIR(direction) || (!strafe || forcerotate || keyheld)) && (dir != direction))
		setDir(direction)
		if(!(mecha_flags & QUIET_TURNS))
			playsound(src, turnsound, 40, TRUE)
		if(keyheld || !pivot_step) //If we pivot step, we don't return here so we don't just come to a stop
			return TRUE
	jet_mode_thruster_effects(direction)
	newtonian_move(dir2angle(direction), FALSE, 0, 9 NEWTONS, 18 NEWTONS, FALSE)
	if(strafe)
		setDir(olddir)
	if(no_jet_environment())
		activate_biped(3 SECONDS)

/obj/vehicle/sealed/mecha/mccloud/proc/jet_mode_thruster_effects(movement_dir)
	var/obj/effect/particle_effect/E = new /obj/effect/particle_effect/ion_trails(get_turf(src))
	E.dir = REVERSE_DIR(movement_dir)
	step(E, REVERSE_DIR(movement_dir))
	QDEL_IN(E, 5)

/obj/vehicle/sealed/mecha/mccloud/can_z_move(direction, turf/start, turf/destination, z_move_flags = ZMOVE_FLIGHT_FLAGS, mob/living/rider)
	. = ..()
	if(!.)
		return
	if(occupants.len > 0 && (z_move_flags & ZMOVE_CAN_FLY_CHECKS) && direction == UP)
		if(jet_mode)
			return TRUE
		else
			if(z_move_flags & ZMOVE_FEEDBACK)
				to_chat(rider, span_warning("[src] needs to be in jet mode to fly upwards."))
			return FALSE

//if the mccloud is in jet mode then always newtonian drift in space
/obj/vehicle/sealed/mecha/mccloud/Process_Spacemove(movement_dir = 0, continuous_move = FALSE)
	if(jet_mode)
		return FALSE
	else
		return ..()

//leaving the mech switches to biped mode before doing so
/obj/vehicle/sealed/mecha/mccloud/mob_exit(mob/M, silent = FALSE, randomstep = FALSE, forced = FALSE)
	activate_biped(0 DECISECONDS)
	..()

//mech slows down when hit by a disabler
/obj/vehicle/sealed/mecha/mccloud/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit)
	..()
	if(hitting_projectile.damage_type == STAMINA)
		stamina_damage(hitting_projectile)

/obj/vehicle/sealed/mecha/mccloud/proc/stamina_damage(obj/projectile/hitting_projectile)
	if(!jet_mode && COOLDOWN_FINISHED(src, cooldown_mech_mccloud_stamina_slow))
		movedelay = !overclock_mode ? MCCLOUD_BIPED_MODE_MOVE_DISABLER : MCCLOUD_BIPED_MODE_MOVE_DISABLER / overclock_coeff
		addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/vehicle/sealed/mecha/mccloud, stamina_reset)), hitting_projectile.damage DECISECONDS)

/obj/vehicle/sealed/mecha/mccloud/proc/stamina_reset()
	if(jet_mode)
		movedelay = !overclock_mode ? MCCLOUD_JET_MODE_MOVE : MCCLOUD_JET_MODE_MOVE / overclock_coeff
	else
		movedelay = !overclock_mode ? MCCLOUD_BIPED_MODE_MOVE : MCCLOUD_BIPED_MODE_MOVE / overclock_coeff

///bumping things as the jet mode should damage the jet
/obj/vehicle/sealed/mecha/mccloud/Bump(atom/bumped_thing)
	. = ..()

	if(!jet_mode)
		return

	if(drift_handler.drift_force < 5)
		return

	var/bumped_damage = drift_handler.drift_force * 5
	var/self_damage = drift_handler.drift_force * 3

	//if the bumped thing is a mech, that mech should be able to brace for impact
	//given that it's piloted and facing the right direction
	if(istype(bumped_thing, /obj/vehicle/sealed/mecha))
		var/obj/vehicle/sealed/mecha/bumped_mech = bumped_thing
		if(bumped_mech.occupants.len > 0 && angle2dir_cardinal(drift_handler.drifting_loop.angle) == REVERSE_DIR(bumped_mech.dir))
			visible_message(span_danger("[bumped_mech] braces for impact against [src]!"))
			bumped_damage = bumped_damage * 0.3

	take_damage(self_damage, BRUTE, 0, 0)
	force = bumped_damage
	mech_melee_attack(src, bumped_thing)

	playsound(src, 'sound/effects/bang.ogg', 40, TRUE)
