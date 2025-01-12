//////// Mag-fed Turret Framework.

////// Define copying //////

#define TURRET_STUN 0
#define TURRET_LETHAL 1

#define TURRET_FLAG_SHOOT_ALL_REACT (1<<0) // The turret gets pissed off and shoots at people nearby (unless they have sec access!)
#define TURRET_FLAG_AUTH_WEAPONS (1<<1) // Checks if it can shoot people that have a weapon they aren't authorized to have
#define TURRET_FLAG_SHOOT_CRIMINALS (1<<2) // Checks if it can shoot people that are wanted
#define TURRET_FLAG_SHOOT_ALL (1<<3)  // The turret gets pissed off and shoots at people nearby (unless they have sec access!)
#define TURRET_FLAG_SHOOT_ANOMALOUS (1<<4)  // Checks if it can shoot at unidentified lifeforms (ie xenos)
#define TURRET_FLAG_SHOOT_UNSHIELDED (1<<5) // Checks if it can shoot people that aren't mindshielded and who arent heads
#define TURRET_FLAG_SHOOT_BORGS (1<<6) // checks if it can shoot cyborgs
#define TURRET_FLAG_SHOOT_HEADS (1<<7) // checks if it can shoot at heads of staff

#define TURRET_FLAG_OBEY_FLAGS 2 // Turrets will behave with turret flags.
#define TURRET_FLAG_SHOOT_NOONE 3 // Turrets will not fire at any player-type mob.
#define TURRET_FLAG_SHOOT_EVERYONE 4 // Turrets will shoot at all player-type mobs.

#define TURRET_THREAT_PASSIVE 0 
#define TURRET_THREAT_LOW 2
#define TURRET_THREAT_MEDIUM 4
#define TURRET_THREAT_HIGH 6
#define TURRET_THREAT_SEVERE 8
#define TURRET_THREAT_PRIORITY 10 

DEFINE_BITFIELD(turret_flags, list(
	"TURRET_FLAG_SHOOT_ALL_REACT" = TURRET_FLAG_SHOOT_ALL_REACT,
	"TURRET_FLAG_AUTH_WEAPONS" = TURRET_FLAG_AUTH_WEAPONS,
	"TURRET_FLAG_SHOOT_CRIMINALS" = TURRET_FLAG_SHOOT_CRIMINALS,
	"TURRET_FLAG_SHOOT_ALL" = TURRET_FLAG_SHOOT_ALL,
	"TURRET_FLAG_SHOOT_ANOMALOUS" = TURRET_FLAG_SHOOT_ANOMALOUS,
	"TURRET_FLAG_SHOOT_UNSHIELDED" = TURRET_FLAG_SHOOT_UNSHIELDED,
	"TURRET_FLAG_SHOOT_BORGS" = TURRET_FLAG_SHOOT_BORGS,
	"TURRET_FLAG_SHOOT_HEADS" = TURRET_FLAG_SHOOT_HEADS,
))

////// Toolbox Handling //////
/obj/item/storage/toolbox/emergency/turret/mag_fed
	name = "mag-fed turret kit"
	desc = "A discreet kit for a magazine fed turret."
	has_latches = FALSE
	////// Whether the turret will ignore humans when deployed.
	var/turret_safety = FALSE
	////// Whether the turret will deploy obeying flags.
	var/flags_on = FALSE
	////// The type of turret deployed
	var/turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed
	////// Number of mags that can be put in.
	var/mag_slots = 2
	////// Types of magazines that can be allowed.
	var/mag_types_allowed = list(
		/obj/item/ammo_box/magazine/c35sol_pistol,
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_slots = mag_slots
	atom_storage.can_hold = typecacheof(mag_types_allowed)
	update_appearance()

/obj/item/storage/toolbox/emergency/turret/mag_fed/examine(mob/user)
	. = ..()
	. += span_notice("The targeting safety is [turret_safety ? "<font color='#00ff15'>ON</font>" : "<font color='#ff0000'>OFF</font>"].")
	. += span_notice("The turret is [flags_on ? "<font color='#00ff15'>OBEYING LAWS</font>" : "<font color='#ff0000'>FREE TARGETING</font>"].")
	. += span_notice("You can deploy this by clicking in <b>combat mode</b> with a <b>wrenching tool.</b>")
	. += span_notice("You can toggle the targeting safety with a <b>screwdriving bit.</b>")
	. += span_notice("You can change if the turret obeys flags with a <b>multitool.</b>")

/obj/item/storage/toolbox/emergency/turret/mag_fed/PopulateContents()

/obj/item/storage/toolbox/emergency/turret/mag_fed/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)


///Grabs a mag to load into the turret
/obj/item/storage/toolbox/emergency/turret/mag_fed/proc/get_mag(keep = FALSE)
	var/mag_len = length(contents)
	if (!mag_len)
		return
	var/yoink = contents[mag_len]
	if (keep)
		atom_storage?.attempt_insert(yoink, override = TRUE)
	return yoink

/obj/item/storage/toolbox/emergency/turret/mag_fed/set_faction(obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret, mob/user)
	if(!(user.faction in turret.faction))
		turret.faction += user.faction
		turret.allies += REF(user)

/obj/item/storage/toolbox/emergency/turret/mag_fed/attackby(obj/item/attacking_item, mob/living/user, params)
	if(attacking_item.tool_behaviour == TOOL_SCREWDRIVER)
		if(!attacking_item.use_tool(src, user, 2 SECONDS, volume = 20))
			return
		turret_safety = !turret_safety
		return

	if(attacking_item.tool_behaviour == TOOL_MULTITOOL)
		if(!attacking_item.use_tool(src, user, 2 SECONDS, volume = 20))
			return
		flags_on = !flags_on
		return

	if(attacking_item.tool_behaviour != TOOL_WRENCH)
		return ..()

	if(in_contents_of(user))
		return

	if(!user.combat_mode)
		return

	if(!attacking_item.toolspeed)
		return

	balloon_alert_to_viewers("constructing...")
	if(!attacking_item.use_tool(src, user, 2 SECONDS, volume = 20))
		return

	balloon_alert_to_viewers("constructed!")
	user.visible_message(span_danger("[user] bashes [src] with [attacking_item]!"), \
		span_danger("You bash [src] with [attacking_item]!"), null, COMBAT_MESSAGE_RANGE)

	playsound(src, "sound/items/drill_use.ogg", 80, TRUE, -1)
	var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret = new turret_type(get_turf(loc))
	set_faction(turret, user)
	turret.mag_box = WEAKREF(src)
	if(turret_safety == TRUE)
		turret.target_assessment = TURRET_FLAG_SHOOT_NOONE
	if(flags_on == TRUE)
		turret.target_assessment = TURRET_FLAG_OBEY_FLAGS
	forceMove(turret)
	turret.setState(TRUE)

////// Targeting Device handling //////

/obj/item/target_designator
	name = "\improper Turret Target Designator"
	desc = "A simple target designation system used to let someone over-ride a turrets targeting software and focus on one entity, or designate someone as a \"Friend\"."
	icon = 'modular_nova/modules/magfed_turret/icons/designator.dmi'
	icon_state = "designator"
	inhand_icon_state = "designator"
	righthand_file = 'modular_nova/modules/magfed_turret/icons/inhands/righthand.dmi'
	lefthand_file = 'modular_nova/modules/magfed_turret/icons/inhands/righthand.dmi'
	worn_icon_state = "designator"
	worn_icon = 'modular_nova/modules/magfed_turret/icons/mob/belt.dmi'
	w_class = WEIGHT_CLASS_SMALL
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	////// the range it can scan at.
	var/scan_range = 10
	////// how many turrets it can have. changable incase of better ones wanted.
	var/turret_limit = 3
	////// the currently linked turrets.
	var/linked_turrets = list()
	////// the target currently being targeted.
	var/datum/weakref/acquired_target
	////// how long the target can be focused. changable incase of better ones wanted.
	var/acquisition_duration = 5 SECONDS
	////// whether or not turrets should shoot player-mobs.
	var/target_all = TRUE
	////// whether or not turrets should obey turret flags. over-writes other modes if active.
	var/follow_flags = FALSE

/obj/item/target_designator/examine(mob/user)
	. = ..()
	. += span_notice("<b>[length(linked_turrets)]/[turret_limit]</b> turrets linked.")
	. += span_notice("<b>Right click</b> an entity to designate it as an ally.")
	. += span_notice("<b>Left click</b> a spot or entity to designate it as a target.")
	. += span_notice("<b>Use</b> this item to toggle human targeting.")
	. += span_notice("Targeting of non-authorized personnel is [target_all ? "<font color='#ff0000'>ENABLED</font>" : "<font color='#00ff15'>DISABLED</font>"].")
	. += span_notice("<b>Shift-click</b> this item to toggle flag following.")
	. += span_notice("Turrets are [follow_flags ? "<font color='#00ff15'>OBEYING LAWS</font>" : "<font color='#ff0000'>FREE TARGETING</font>"].")

/obj/item/target_designator/attack_self(mob/user, modifiers)
	. = ..()
	target_all = !target_all
	sync_turrets()

/obj/item/target_designator/ShiftClick(mob/user)
	. = ..()
	follow_flags = !follow_flags
	sync_turrets()
	return

/obj/item/target_designator/afterattack(atom/movable/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!can_see(user,target,scan_range)) //if outside range, dont bother.
		return

	if(target in linked_turrets) //to stop issues with linking turrets.
		return

	if(acquired_target) //if there's a target already, cant designate one.
		return

	designate_enemy(target, user)
	addtimer(CALLBACK(src, PROC_REF(clear_target), user), acquisition_duration) //clears after 5 seconds. to avoid issues.
	return

/obj/item/target_designator/afterattack_secondary(atom/movable/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!can_see(user,target,scan_range)) //if outside range, dont bother.
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(istype(target, /mob/living))
		for(var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret in linked_turrets)
			turret.toggle_ally(target)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/// designates a manual target to turrets
/obj/item/target_designator/proc/designate_enemy(atom/movable/target, mob/user)
	if(!target)
		return
	acquired_target = WEAKREF(target)
	for(var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret in linked_turrets)
		for(var/turret_to_control in 1 to length(linked_turrets))
			turret.override_target(acquired_target?.resolve())
		balloon_alert(user, "target designated!")

/// clears manual target acquisition
/obj/item/target_designator/proc/clear_target(user)
	acquired_target = null
	for(var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret in linked_turrets)
		for(var/turret_to_control in 1 to length(linked_turrets))
			turret.clear_override()
		balloon_alert(user, "designation cleared!")

/// Sets all turrets to the same state as the controller.
/obj/item/target_designator/proc/sync_turrets() 
	for(var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret in linked_turrets)
		if(target_all == TRUE && follow_flags == FALSE)
			if(!(turret.target_assessment == TURRET_FLAG_SHOOT_EVERYONE))
				turret.target_assessment = TURRET_FLAG_SHOOT_EVERYONE
				turret.balloon_alert_to_viewers("unrestricting targeting!")
		if(follow_flags == TRUE)
			if(!(turret.target_assessment == TURRET_FLAG_OBEY_FLAGS))
				turret.target_assessment = TURRET_FLAG_OBEY_FLAGS
				turret.balloon_alert_to_viewers("obeying laws!")
		if(follow_flags == FALSE && target_all == FALSE)
			if(!(turret.target_assessment == TURRET_FLAG_SHOOT_NOONE))
				turret.target_assessment = TURRET_FLAG_SHOOT_NOONE
				turret.balloon_alert_to_viewers("restricting targeting!")
		turret.setState(TRUE) //So they'll update properly

////// Turret handling //////

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed
	name = "Mag-fed Turret"
	desc = "A turret designed to feed from an attatched magazine system."
	integrity_failure = 0
	max_integrity = 200
	shot_delay = 2 SECONDS
	uses_stored = FALSE
	stored_gun = null
	stun_projectile = null
	stun_projectile_sound = 'sound/weapons/gun/pistol/shot.ogg'
	lethal_projectile = null
	lethal_projectile_sound = 'sound/weapons/gun/pistol/shot.ogg'
	subsystem_type = /datum/controller/subsystem/processing/projectiles
	turret_flags = TURRET_FLAG_SHOOT_ALL | TURRET_FLAG_SHOOT_ANOMALOUS
	ignore_faction = TRUE
	req_access = list() //We use faction and ally system for access. Also so people can change turret flags as needed, though useless bc of syndicate subtyping.
	faction = list(FACTION_TURRET)
	////// Can this turret load more than one ammunition type. Mostly for sound handling. Might be more important if used in a rework.
	var/adjustable_magwell = TRUE
	//////This is for manual target acquisition stuff. If present, should immediately over-ride as a target.
	var/datum/weakref/target_override
	//////Target Assessment System. Whether or not its targeting according to flags or even ignoring everyone.
	var/target_assessment = TURRET_FLAG_SHOOT_EVERYONE
	//////Ally system.
	var/allies = list()
	//////Do we want this to shut up? Mostly for testing and debugging purposes purposes.
	var/claptrap_moment = TRUE
	////// Do we want it to eject casings?
	var/casing_ejector = TRUE
	//////what box should this spawn with if its map_spawned?
	var/mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/pre_filled
	//////To stop runtimes x1
	var/staminaloss = 0
	//////To stop runtimes x2 + resting firing
	var/combat_mode = TRUE
	//////to stop runtimes x3
	var/timer_id
	//////Container of the turret. Needs expanded ref.
	var/datum/weakref/mag_box
	////// Magazine inside the turret.
	var/datum/weakref/magazine_ref
	////// currently loaded bullet
	var/datum/weakref/chambered
	////// linked target designator
	var/datum/weakref/linkage

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/Initialize(mapload)
	. = ..()
	if(!mag_box) //If we want to make map-spawned turrets in turret form.
		var/auto_loader = new mag_box_type
		mag_box = WEAKREF(auto_loader)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/examine(mob/user) //If this breaks i'm gonna have to go to further seperate its examination text to allow better editing.
	. = ..()
	. -= span_notice("You can repair it by <b>left-clicking</b> with a combat wrench.")
	. -= span_notice("You can fold it by <b>right-clicking</b> with a combat wrench.")
	if((user.faction in faction) || (REF(user) in allies))
		. += span_notice("You can unlock it by <b>left-clicking</b> with an <b>id card.</b>")
		. += span_notice("You can repair it by <b>left-clicking</b> with a <b>wrench.</b>")
		. += span_notice("You can fold it by <b>right-clicking</b> with a <b>wrench.</b>")
		. += span_notice("You can feed it by <b>left-clicking</b> with a <b>magazine.</b>")
		. += span_notice("You can link it by <b>left-clicking</b> with a <b>target designator.</b>")
		. += span_notice("You can unlink it by <b>right-clicking</b> with a <b>target designator.</b>")
		. += span_notice("You can force it to load a cartridge by <b>right-clicking</b> with an empty hand")
		if(linkage)
			. += span_notice("<b><i>This turret is currently linked!</i></b>")

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/on_deconstruction(disassembled) // Full re-write, to stop the toolbox var from being a runtimer
	var/obj/item/ammo_box/magazine/mag = magazine_ref?.resolve()
	if(isnull(mag))
		magazine_ref = null
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/auto_loader = mag_box?.resolve()
	if(isnull(auto_loader))
		mag_box = null
	var/obj/item/ammo_casing/casing = chambered?.resolve()
	if(isnull(casing))
		chambered = null
	if(chambered)
		if(!casing.loaded_projectile || QDELETED(casing.loaded_projectile) || !casing.loaded_projectile) //to catch very edge-case stuff thats likely to happen if the turret breaks mid-firing.
			casing.forceMove(drop_location())
			casing.loaded_projectile = null
		if(!magazine_ref)
			casing.forceMove(drop_location())
		else if(mag)
			mag.give_round(casing) //put bullet back in magazine
		chambered = null

	if(magazine_ref)
		if(!disassembled) //This is to stop one specific runtime, and if its being broken its probably gonna malf eject
			mag.forceMove(drop_location())
		else if(auto_loader) //if the magazine is being kept this long, it might aswell be shoved back in.
			auto_loader.atom_storage?.attempt_insert(mag, override = TRUE)
		magazine_ref = null

	var/obj/item/target_designator/controller = linkage?.resolve()
	if(!isnull(controller))
		controller.linked_turrets -= src
		UnregisterSignal(controller, COMSIG_QDELETING)
	linkage = null

	mag_box = null
	auto_loader?.forceMove(drop_location())
	if(timer_id)
		deltimer(timer_id)

	qdel(src)

/// main proc to handle loading magazines and bullets. might need improved?
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/handle_chamber(chamber_next_round = TRUE)
	var/obj/item/ammo_box/magazine/mag = magazine_ref?.resolve()
	if(isnull(mag))
		magazine_ref = null
	if(isnull(magazine_ref))
		load_mag()

	else if(mag && !mag.ammo_count())
		handle_mag()

	if(chambered)
		eject_cartridge()

	if (chamber_next_round && (mag?.max_ammo > 1))
		chamber_round(FALSE)
		return

/// pulls a cartridge from the magazine and loads it into the chamber
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/chamber_round(replace_new_round)
	var/obj/item/ammo_box/magazine/mag = magazine_ref?.resolve()
	if(isnull(mag))
		magazine_ref = null
	if (chambered || isnull(magazine_ref))
		return
	if (mag.ammo_count())
		if(!claptrap_moment)
			balloon_alert_to_viewers("loading cartridge...")
		chambered = WEAKREF(mag.get_round(keep = FALSE))
		var/obj/item/ammo_casing/casing = chambered?.resolve()
		if(isnull(casing))
			chambered = null
		casing.forceMove(src)
		playsound(src, 'sound/weapons/gun/general/bolt_rack.ogg', 10, TRUE)
		if(replace_new_round) //For edge-case additions later in the road.
			mag.give_round(new casing.type)

/// handles magazine ejecting and automatic load proccing
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/handle_mag()
	if(magazine_ref)
		var/obj/item/ammo_box/magazine/mag = magazine_ref?.resolve()
		if(istype(mag))
			mag.forceMove(drop_location())
			UnregisterSignal(magazine_ref, COMSIG_MOVABLE_MOVED)
		magazine_ref = null
	load_mag()
	playsound(src, 'sound/weapons/gun/general/chunkyrack.ogg', 30, TRUE)
	return

/// loads a magazine from the base storage box
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/load_mag()
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/auto_loader = mag_box?.resolve()
	if(!auto_loader.get_mag())
		balloon_alert_to_viewers("magazine well empty!") // hey, this is actually important info to convey.
		toggle_on(FALSE) // I know i added the shupt-up toggle after adding this, This is just to prevent rapid proccing
		timer_id = addtimer(CALLBACK(src, PROC_REF(toggle_on), TRUE), 5 SECONDS)
		return
	magazine_ref = WEAKREF(auto_loader.get_mag(FALSE))
	var/obj/item/ammo_box/magazine/get_that_mag = magazine_ref?.resolve()
	if(isnull(get_that_mag))
		magazine_ref = null
	get_that_mag.forceMove(src)
	if(!claptrap_moment)
		balloon_alert_to_viewers("loading magazine...")
	return

/// ejects cartridge and calls if issues arrive.
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/eject_cartridge()
	var/obj/item/ammo_casing/casing = chambered?.resolve() //Find chambered round. i'd give this a funny var name but casing was already here.
	if(isnull(casing))
		chambered = null
	if(istype(casing)) //there's a chambered round
		if(casing_ejector) //To handle casing ejection (Previous version didn't account for caseless ammo and threw runtimes with new system)
			if(!claptrap_moment)
				balloon_alert_to_viewers("ejecting cartridge") // will proc even on caseless cartridges, but its a debug message.
			casing.forceMove(drop_location()) //Eject casing onto ground.
			chambered = null
			casing.bounce_away(TRUE)
			SEND_SIGNAL(casing, COMSIG_CASING_EJECTED)

/// Allows you to insert magazines while the turret is deployed
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/insert_mag(obj/item/ammo_box/magazine/magaroni, mob/living/guy_with_mag)
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/auto_loader = mag_box?.resolve()
	if(isnull(auto_loader))
		mag_box = null
	if(!(magaroni.type in auto_loader.atom_storage.can_hold))
		balloon_alert(guy_with_mag, "can't fit!")
		return
	balloon_alert(guy_with_mag, "magazine inserted!")
	auto_loader?.atom_storage.attempt_insert(magaroni, guy_with_mag, TRUE)
	return

////// I rewrite/add to the entire proccess. //////

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/process()
	if(linkage)
		if(target_override) //Forces turret to shoot
			var/atom/movable/overridden_target = target_override.resolve()
			if(isnull(overridden_target))
				target_override = null
				return
			trytoshootfucker(overridden_target) //This is 1 thing. It does not need a list. This kills it because it'll never read a list as null.
			return

	return ..()

/// decides a threat level depending on factors.
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/assess_perp(mob/living/carbon/human/perp) //We copy the original so we can use target limiting above factions.
	var/threatcount = 0 //the integer returned

	if(obj_flags & EMAGGED)
		return TURRET_THREAT_PRIORITY //if emagged, always return 10.

	if(target_assessment == TURRET_FLAG_SHOOT_EVERYONE)
		return TURRET_THREAT_PRIORITY //will not assess anyone within the faction/ally system.

	if(target_assessment == TURRET_FLAG_SHOOT_NOONE)
		return TURRET_THREAT_PASSIVE //this wont stop you from getting shot if you're inbetween it and its target, but it wont specifically aim at you.

	if((turret_flags & (TURRET_FLAG_SHOOT_ALL | TURRET_FLAG_SHOOT_ALL_REACT)) && !allowed(perp))
		//if the turret has been attacked or is angry, target all non-sec people
		if(!allowed(perp))
			return TURRET_THREAT_PRIORITY

	// If we aren't shooting heads then return a threatcount of 0
	if (!(turret_flags & TURRET_FLAG_SHOOT_HEADS))
		var/datum/job/apparent_job = SSjob.GetJob(perp.get_assignment())
		if(apparent_job?.job_flags & JOB_HEAD_OF_STAFF)
			return TURRET_THREAT_PASSIVE

	if(turret_flags & TURRET_FLAG_AUTH_WEAPONS) //check for weapon authorization
		if(!istype(perp.wear_id?.GetID(), /obj/item/card/id/advanced/chameleon))

			if(allowed(perp)) //if the perp has security access, return 0
				return TURRET_THREAT_PASSIVE
			if(perp.is_holding_item_of_type(/obj/item/gun) || perp.is_holding_item_of_type(/obj/item/melee/baton))
				threatcount += TURRET_THREAT_MEDIUM

			if(istype(perp.belt, /obj/item/gun) || istype(perp.belt, /obj/item/melee/baton))
				threatcount += TURRET_THREAT_LOW

	if(turret_flags & TURRET_FLAG_SHOOT_CRIMINALS) //if the turret can check the records, check if they are set to *Arrest* on records
		var/perpname = perp.get_face_name(perp.get_id_name())
		var/datum/record/crew/target = find_record(perpname)
		if(!target || (target.wanted_status == WANTED_ARREST))
			threatcount += TURRET_THREAT_MEDIUM

	if((turret_flags & TURRET_FLAG_SHOOT_UNSHIELDED) && (!HAS_TRAIT(perp, TRAIT_MINDSHIELD)))
		threatcount += TURRET_THREAT_MEDIUM

	return threatcount

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/in_faction(mob/target)
	for(var/faction1 in faction)
		if((faction1 in target.faction) || (REF(target) in allies)) // For an Ally System
			return TRUE
	return FALSE

/// toggles between whether things are inside the ally system
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/toggle_ally(mob/living/target) //leave these since its kinda important to know which is being done.
	if(REF(target) in allies)
		allies -= REF(target)
		balloon_alert_to_viewers("ally removed!")
		return
	else
		allies += REF(target)
		balloon_alert_to_viewers("ally designated!")
		return

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/target(atom/movable/target)
	if(target)
		popUp() //pop the turret up if it's not already up.
		setDir(get_dir(base, target))//even if you can't shoot, follow the target
		shootAt(target)
		return TRUE
	return

/// manual target acquisition from target designator, improves fire rate.
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/override_target(atom/movable/target)
	if(!target)
		return
	target_override = WEAKREF(target)
	balloon_alert_to_viewers("target acquired!") // So you know whats causing it to fire
	shot_delay = (initial(shot_delay) / 2) //No need to scan for targets so faster work

/// clears the target and resets fire rate
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/clear_override()
	target_override = null
	shot_delay = initial(shot_delay)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/tryToShootAt(list/atom/movable/things_in_my_lawn) //better target prioritization, shoots at closest simple mob
	var/turf/my_lawn = get_turf(src)
	while(things_in_my_lawn.len > 0)
		var/atom/movable/whipper_snapper = get_closest_atom(/mob/living, things_in_my_lawn, my_lawn)
		things_in_my_lawn -= whipper_snapper
		if(target(whipper_snapper))
			return TRUE

/// Shoots at one specific target. Only happens if target is overridden
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/trytoshootfucker()
	var/atom/movable/overridden_target = target_override?.resolve()
	if(isnull(overridden_target))
		target_override = null
		return
	while(overridden_target)
		if(target(overridden_target)) //ok. Its trying to shoot a weakref. Thats the issue.
			return TRUE

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/shootAt(atom/movable/target)
	if(!chambered) //Ok, We need to START the cycle
		handle_chamber(TRUE)
		return

	if(!raised) //the turret has to be raised in order to fire - makes sense, right?
		return

	if(!(obj_flags & EMAGGED)) //if it hasn't been emagged, cooldown before shooting again
		if(last_fired + shot_delay > world.time)
			return
		last_fired = world.time

	var/turf/my_lawn = get_turf(src)
	var/turf/targetturf = get_turf(target)
	if(!istype(my_lawn) || !istype(targetturf))
		return

	setDir(get_dir(base, target))
	update_appearance()

	var/obj/item/ammo_casing/casing = chambered?.resolve()
	if(casing.loaded_projectile && !QDELETED(casing.loaded_projectile))
		handle_firing(casing, target)
		return

	handle_chamber(TRUE)

/// Handles the firing process. Will need edited for special ammo types like 980.
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/handle_firing(obj/item/ammo_casing/casing, atom/movable/target)
	var/obj/projectile/our_projectile = casing.loaded_projectile
	if(ignore_faction)
		our_projectile.ignored_factions = (faction + allies)
	casing.fire_casing(target, src, null, null, null, BODY_ZONE_CHEST, 0, src)
	play_fire_sound(casing)


/// So because the casing firing process calls it, Lets use this to handle the auto-reload.

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/changeNext_move()
	handle_chamber(TRUE)

/// Handles which sound should play when the gun fires, as it does adjust between different ammo types.
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/play_fire_sound(obj/item/ammo_casing/soundmaker) //Hella Iffy.
	var/fire_sound = lethal_projectile_sound
	if(!adjustable_magwell) //if it has 1 magazine type
		fire_sound = lethal_projectile_sound
	else if(istype(soundmaker, /obj/item/ammo_casing/c35sol))
		fire_sound = 'modular_nova/modules/modular_weapons/sounds/pistol_light.ogg'
	else if(istype(soundmaker, /obj/item/ammo_casing/c585trappiste))
		fire_sound = 'modular_nova/modules/modular_weapons/sounds/pistol_heavy.ogg'
	else if(istype(soundmaker, /obj/item/ammo_casing/c40sol))
		fire_sound = 'modular_nova/modules/modular_weapons/sounds/rifle_heavy.ogg'
	else if(istype(soundmaker, /obj/item/ammo_casing/strilka310))
		fire_sound = 'modular_nova/modules/modular_weapons/sounds/battle_rifle.ogg'
	else if(istype(soundmaker, /obj/item/ammo_casing/c27_54cesarzowa))
		fire_sound = 'modular_nova/modules/modular_weapons/sounds/smg_light.ogg'

	playsound(src, fire_sound, 60, TRUE)

////// Operation Handling //////

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/attackby(obj/item/attacking_item, mob/living/user, params)
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/auto_loader = mag_box?.resolve()
	if(isnull(auto_loader))
		mag_box = null
	if(attacking_item.type in auto_loader.atom_storage.can_hold)
		balloon_alert(user, "attempting to load...")
		if(!do_after(user, 1 SECONDS, src))
			balloon_alert(user, "failed to load!")
		insert_mag(attacking_item, user)
		return

	if(istype(attacking_item, /obj/item/card/id))
		if(!in_faction(user))
			balloon_alert(user, "access denied!")
			return

	if(in_faction(user))
		if(istype(attacking_item, /obj/item/target_designator))
			var/obj/item/target_designator/controller = attacking_item
			if(length(controller.linked_turrets) >= controller.turret_limit)
				balloon_alert(user, "turret limit reached!")
				return
			if(linkage) //should help both preventing dual-controlling AND double-linking causing odd issues with ally system
				balloon_alert(user, "turret already linked!")
				return
			linkage = WEAKREF(controller)
			controller.linked_turrets += src
			RegisterSignal(controller, COMSIG_QDELETING, PROC_REF(on_qdeleted), TRUE) //True otherwise it causes a runtime for overwriting parent qdeling. Dont know where to go elsewise.
			balloon_alert(user, "turret linked!")
			return

	if(attacking_item.tool_behaviour != TOOL_WRENCH)
		return ..()

	if(!attacking_item.toolspeed)
		return

	else
		if(atom_integrity == max_integrity)
			if(!claptrap_moment)
				balloon_alert(user, "already repaired!")
			return

		if(!claptrap_moment)
			balloon_alert(user, "repairing...")
		while(atom_integrity != max_integrity)
			if(!attacking_item.use_tool(src, user, 2 SECONDS, volume = 20))
				return

			repair_damage(25)

		if(!claptrap_moment)
			balloon_alert(user, "repaired!")

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/attackby_secondary(obj/item/attacking_item, mob/living/user, params) //IM TIRED OF MISMATCHED VAR NAMES. ITS ATTACK_ITEM ON MAIN, WHY WEAPON HERE?
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(in_faction(user))
		if(istype(attacking_item, /obj/item/target_designator))
			var/obj/item/target_designator/owner_check = linkage?.resolve()
			if(attacking_item != owner_check) //cant unlink if not the same one
				balloon_alert(user, "turret not linked!")
				return
			var/obj/item/target_designator/controller = attacking_item
			linkage = null
			controller.linked_turrets -= src
			balloon_alert(user, "turret unlinked!")
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(attacking_item.tool_behaviour != TOOL_WRENCH)
		return SECONDARY_ATTACK_CALL_NORMAL

	if(!attacking_item.toolspeed)
		return SECONDARY_ATTACK_CALL_NORMAL

	if(!claptrap_moment)
		balloon_alert(user, "deconstructing...")
	if(!attacking_item.use_tool(src, user, 5 SECONDS, volume = 20))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	attacking_item.play_tool_sound(src, 50)
	deconstruct(TRUE)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(!chambered)
		handle_chamber(TRUE)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/on_qdeleted(datum/source) //I hope this is what you ment.
	SIGNAL_HANDLER

	var/obj/item/target_designator/controller = linkage?.resolve()
	controller.linked_turrets -= source

////// Define Killing. For testing.

#undef TURRET_STUN
#undef TURRET_LETHAL
#undef TURRET_FLAG_SHOOT_ALL_REACT
#undef TURRET_FLAG_AUTH_WEAPONS
#undef TURRET_FLAG_SHOOT_CRIMINALS
#undef TURRET_FLAG_SHOOT_ALL
#undef TURRET_FLAG_SHOOT_ANOMALOUS
#undef TURRET_FLAG_SHOOT_UNSHIELDED
#undef TURRET_FLAG_SHOOT_BORGS
#undef TURRET_FLAG_SHOOT_HEADS
