/proc/create_portal_pair(turf/source, turf/destination, _lifespan = 300, accuracy = 0, newtype = /obj/effect/portal)
	if(!istype(source) || !istype(destination))
		return
	var/turf/actual_destination = get_teleport_turf(destination, accuracy)
	var/obj/effect/portal/P1 = new newtype(source, _lifespan, null, FALSE, null)
	var/obj/effect/portal/P2 = new newtype(actual_destination, _lifespan, P1, TRUE, null)
	if(!istype(P1) || !istype(P2))
		return
	playsound(P1, SFX_PORTAL_CREATED, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	playsound(P2, SFX_PORTAL_CREATED, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	P1.link_portal(P2)
	P1.hardlinked = TRUE
	return list(P1, P2)

/obj/effect/portal
	name = "portal"
	desc = "Looks unstable. Best to test it with the clown."
	icon = 'icons/obj/anomaly.dmi'
	icon_state = "portal"
	anchored = TRUE
	density = TRUE // dense for receiving bumbs
	layer = HIGH_OBJ_LAYER
	light_system = COMPLEX_LIGHT
	light_range = 3
	light_power = 1
	light_on = TRUE
	light_color = COLOR_BLUE_LIGHT
	/// Are mechs able to enter this portal?
	var/mech_sized = FALSE
	/// A reference to another "linked" destination portal
	var/obj/effect/portal/linked
	/// Requires a linked portal at all times. Destroy if there's no linked portal, if there is destroy it when this one is deleted.
	var/hardlinked = TRUE
	/// What teleport channel does this portal use?
	var/teleport_channel = TELEPORT_CHANNEL_BLUESPACE
	/// For when a portal needs a hard target and isn't to be linked.
	var/turf/hard_target
	/// Do we teleport anchored objects?
	var/allow_anchored = FALSE
	/// What precision value do we pass to do_teleport (how far from the target destination we will pop out at).
	var/innate_accuracy_penalty = 0
	/// Used to track how often sparks should be output. Might want to turn this into a cooldown.
	var/last_effect = 0
	/// Does this portal bypass teleport restrictions? like TRAIT_NO_TELEPORT and NOTELEPORT flags.
	var/force_teleport = FALSE
	/// Does this portal create spark effect when teleporting?
	var/sparkless = TRUE
	/// If FALSE, the wibble filter will not be applied to this portal (only a visual effect).
	var/wibbles = TRUE

/obj/effect/portal/anom
	name = "wormhole"
	icon = 'icons/obj/anomaly.dmi'
	icon_state = "anom"
	layer = RIPPLE_LAYER
	plane = ABOVE_GAME_PLANE
	mech_sized = TRUE
	teleport_channel = TELEPORT_CHANNEL_WORMHOLE
	light_on = FALSE
	wibbles = FALSE

/obj/effect/portal/Move(newloc)
	for(var/T in newloc)
		if(istype(T, /obj/effect/portal))
			return FALSE
	return ..()

// Prevents portals spawned by jaunter/handtele from floating into space when relocated to an adjacent tile.
/obj/effect/portal/newtonian_move(inertia_angle, instant = FALSE, start_delay = 0, drift_force = 0, controlled_cap = null)
	return TRUE

/obj/effect/portal/attackby(obj/item/W, mob/user, list/modifiers, list/attack_modifiers)
	if(user && Adjacent(user))
		teleport(user)
		return TRUE

/obj/effect/portal/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(HAS_TRAIT(mover, TRAIT_NO_TELEPORT) && !force_teleport)
		return TRUE

/obj/effect/portal/Bumped(atom/movable/bumper)
	teleport(bumper)

/obj/effect/portal/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(Adjacent(user))
		teleport(user)


/obj/effect/portal/attack_robot(mob/living/user)
	if(Adjacent(user))
		teleport(user)

/obj/effect/portal/Initialize(mapload, _lifespan = 0, obj/effect/portal/_linked, automatic_link = FALSE, turf/hard_target_override)
	. = ..()
	GLOB.portals += src
	if(!istype(_linked) && automatic_link)
		. = INITIALIZE_HINT_QDEL
		CRASH("Somebody fucked up.")
	if(_lifespan > 0)
		addtimer(CALLBACK(src, PROC_REF(expire)), _lifespan, TIMER_DELETE_ME)
	link_portal(_linked)
	hardlinked = automatic_link
	if(isturf(hard_target_override))
		hard_target = hard_target_override
	if(wibbles)
		apply_wibbly_filters(src)

/obj/effect/portal/proc/expire()
	playsound(loc, SFX_PORTAL_CLOSE, 50, FALSE, SHORT_RANGE_SOUND_EXTRARANGE)
	qdel(src)

/obj/effect/portal/singularity_pull(atom/singularity, current_size)
	return

/obj/effect/portal/singularity_act()
	return

/obj/effect/portal/proc/link_portal(obj/effect/portal/newlink)
	linked = newlink

/obj/effect/portal/Destroy()
	GLOB.portals -= src
	if(hardlinked && !QDELETED(linked))
		QDEL_NULL(linked)
	else
		linked = null
	return ..()

/obj/effect/portal/attack_ghost(mob/dead/observer/ghost)
	if(!teleport(ghost, force = TRUE))
		return ..()
	return BULLET_ACT_FORCE_PIERCE

/obj/effect/portal/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit)
	if (!teleport(hitting_projectile, force = TRUE))
		return ..()
	return BULLET_ACT_FORCE_PIERCE

/obj/effect/portal/proc/teleport(atom/movable/moving, force = FALSE)
	if(!force && (!istype(moving) || iseffect(moving) || (ismecha(moving) && !mech_sized) || (!isobj(moving) && !ismob(moving)))) //Things that shouldn't teleport.
		return
	var/turf/real_target = get_link_target_turf()
	if(!istype(real_target))
		return FALSE

	if(!force && (!ismecha(moving) && !isprojectile(moving) && moving.anchored && !allow_anchored))
		return
	var/no_effect = FALSE
	if(last_effect == world.time || sparkless)
		no_effect = TRUE
	else
		last_effect = world.time
	var/turf/start_turf = get_turf(moving)
	if(do_teleport(moving, real_target, innate_accuracy_penalty, no_effects = no_effect, channel = teleport_channel, forced = force_teleport))
		if(isprojectile(moving))
			var/obj/projectile/proj = moving
			proj.ignore_source_check = TRUE
		new /obj/effect/temp_visual/portal_animation(start_turf, src, moving)
		playsound(start_turf, SFX_PORTAL_ENTER, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		playsound(real_target, SFX_PORTAL_ENTER, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		return TRUE
	return FALSE

/obj/effect/portal/proc/get_link_target_turf()
	var/turf/real_target
	if(!istype(linked) || QDELETED(linked))
		if(hardlinked)
			qdel(src)
		if(!istype(hard_target) || QDELETED(hard_target))
			hard_target = null
			return
		else
			real_target = hard_target
			linked = null
	else
		real_target = get_turf(linked)
	return real_target

/obj/effect/portal/permanent
	name = "permanent portal"
	desc = "An unwavering portal that will never fade."
	hardlinked = FALSE // dont qdel my portal nerd
	force_teleport = TRUE // force teleports because they're a mapmaker tool
	var/id // var edit or set id in map editor
	var/event_maptext = ""

/obj/effect/portal/permanent/Initialize(mapload)
	. = ..()
	maptext = MAPTEXT(event_maptext)

/obj/effect/portal/permanent/green
	color = "green"
	maptext_width = 64
	maptext_y = 30


/obj/effect/portal/permanent/green/grocery
	id = "grocery_green"

/obj/effect/portal/permanent/green/grocery/toward
	name = "Grocery"
	event_maptext = "Grocery"

/obj/effect/portal/permanent/green/grocery/from
	name = "Green Kitchen"

/obj/effect/portal/permanent/green/hospital
	id = "hospital_green"

/obj/effect/portal/permanent/green/hospital/toward
	name = "Hospital"
	event_maptext = "Hospital"

/obj/effect/portal/permanent/green/hospital/from
	name = "Green Kitchen"

/obj/effect/portal/permanent/green/zoo
	id = "zoo_green"
	maptext_x = 8

/obj/effect/portal/permanent/green/zoo/toward
	name = "Zoo"
	event_maptext = "Zoo"

/obj/effect/portal/permanent/green/zoo/from
	name = "Green Kitchen"

/obj/effect/portal/permanent/green/farm
	id = "farm_green"
	maptext_x = 5

/obj/effect/portal/permanent/green/farm/toward
	name = "Farm"
	event_maptext = "Farm"

/obj/effect/portal/permanent/green/farm/from
	name = "Green Kitchen"

/obj/effect/portal/permanent/green/lavaland
	id = "lava_green"
	maptext_x = -4

/obj/effect/portal/permanent/green/lavaland/toward
	name = "Lavaland"
	event_maptext = "Lavaland"

/obj/effect/portal/permanent/green/lavaland/from
	name = "Green Kitchen"

/obj/effect/portal/permanent/green/jungle
	id = "jungle_green"
	maptext_x = 2

/obj/effect/portal/permanent/green/jungle/toward
	name = "Jungle"
	event_maptext = "Jungle"

/obj/effect/portal/permanent/green/jungle/from
	name = "Green Kitchen"

/obj/effect/portal/permanent/red
	color = "red"
	maptext_width = 64
	maptext_y = 30

/obj/effect/portal/permanent/red/grocery
	id = "grocery_red"

/obj/effect/portal/permanent/red/grocery/toward
	name = "Grocery"
	event_maptext = "Grocery"

/obj/effect/portal/permanent/red/grocery/from
	name = "Red Kitchen"

/obj/effect/portal/permanent/red/hospital
	id = "hospital_red"

/obj/effect/portal/permanent/red/hospital/toward
	name = "Hospital"
	event_maptext = "Hospital"

/obj/effect/portal/permanent/red/hospital/from
	name = "Red Kitchen"

/obj/effect/portal/permanent/red/zoo
	id = "zoo_red"
	maptext_x = 8

/obj/effect/portal/permanent/red/zoo/toward
	name = "Zoo"
	event_maptext = "Zoo"

/obj/effect/portal/permanent/red/zoo/from
	name = "Red Kitchen"

/obj/effect/portal/permanent/red/farm
	id = "farm_red"
	maptext_x = 5

/obj/effect/portal/permanent/red/farm/toward
	name = "Farm"
	event_maptext = "Farm"

/obj/effect/portal/permanent/red/farm/from
	name = "Red Kitchen"

/obj/effect/portal/permanent/red/lavaland
	id = "lava_red"
	maptext_x = -4

/obj/effect/portal/permanent/red/lavaland/toward
	name = "Lavaland"
	event_maptext = "Lavaland"

/obj/effect/portal/permanent/red/lavaland/from
	name = "Red Kitchen"

/obj/effect/portal/permanent/red/jungle
	id = "jungle_red"
	maptext_x = 2

/obj/effect/portal/permanent/red/jungle/toward
	name = "Jungle"
	event_maptext = "Jungle"

/obj/effect/portal/permanent/red/jungle/from
	name = "Red Kitchen"

/obj/effect/portal/permanent/blue
	maptext_width = 64
	maptext_y = 30

/obj/effect/portal/permanent/blue/grocery
	id = "grocery_blue"

/obj/effect/portal/permanent/blue/grocery/toward
	name = "Grocery"
	event_maptext = "Grocery"

/obj/effect/portal/permanent/blue/grocery/from
	name = "Blue Kitchen"

/obj/effect/portal/permanent/blue/hospital
	id = "hospital_blue"

/obj/effect/portal/permanent/blue/hospital/toward
	name = "Hospital"
	event_maptext = "Hospital"

/obj/effect/portal/permanent/blue/hospital/from
	name = "Blue Kitchen"

/obj/effect/portal/permanent/blue/zoo
	id = "zoo_blue"
	maptext_x = 8

/obj/effect/portal/permanent/blue/zoo/toward
	name = "Zoo"
	event_maptext = "Zoo"

/obj/effect/portal/permanent/blue/zoo/from
	name = "Blue Kitchen"

/obj/effect/portal/permanent/blue/farm
	id = "farm_blue"
	maptext_x = 5

/obj/effect/portal/permanent/blue/farm/toward
	name = "Farm"
	event_maptext = "Farm"

/obj/effect/portal/permanent/blue/farm/from
	name = "Blue Kitchen"

/obj/effect/portal/permanent/blue/lavaland
	id = "lava_blue"
	maptext_x = -4

/obj/effect/portal/permanent/blue/lavaland/toward
	name = "Lavaland"
	event_maptext = "Lavaland"

/obj/effect/portal/permanent/blue/lavaland/from
	name = "Blue Kitchen"

/obj/effect/portal/permanent/blue/jungle
	id = "jungle_blue"
	maptext_x = 2

/obj/effect/portal/permanent/blue/jungle/toward
	name = "Jungle"
	event_maptext = "Jungle"

/obj/effect/portal/permanent/blue/jungle/from
	name = "Blue Kitchen"

/obj/effect/portal/permanent/proc/set_linked()
	if(!id)
		return
	for(var/obj/effect/portal/permanent/P in GLOB.portals - src)
		if(P.id == id)
			P.linked = src
			linked = P
			break

/obj/effect/portal/permanent/teleport(atom/movable/moving, force = FALSE)
	set_linked() // update portal links
	. = ..()

/obj/effect/portal/permanent/one_way // doesn't have a return portal, can have multiple exits, /obj/effect/landmark/portal_exit to mark them
	name = "one-way portal"
	desc = "You get the feeling that this might not be the safest thing you've ever done."

/obj/effect/portal/permanent/one_way/set_linked()
	if(!id)
		return
	var/list/possible_turfs = list()
	for(var/obj/effect/landmark/portal_exit/PE in GLOB.landmarks_list)
		if(PE.id == id)
			var/turf/T = get_turf(PE)
			if(T)
				possible_turfs |= T
	if(possible_turfs.len)
		hard_target = pick(possible_turfs)

/obj/effect/portal/permanent/one_way/one_use
	name = "one-use portal"
	desc = "This is probably the worst decision you'll ever make in your life."

/obj/effect/portal/permanent/one_way/one_use/teleport(atom/movable/moving, force = FALSE)
	. = ..()
	if (. && !isdead(moving))
		expire()

/**
 * Animation used for transitioning atoms which are teleporting somewhere via a portal
 *
 * To use, pass it the atom doing the teleporting and the atom that is being teleported in init.
 */
/obj/effect/temp_visual/portal_animation
	duration = 0.25 SECONDS

/obj/effect/temp_visual/portal_animation/Initialize(mapload, atom/portal, atom/movable/teleporting)
	. = ..()
	if(isnull(portal) || isnull(teleporting))
		return

	appearance = teleporting.appearance
	dir = teleporting.dir
	layer = portal.layer + 0.01
	alpha = teleporting.alpha
	animate(src, pixel_x = (portal.x * 32) - (x * 32), pixel_y = (portal.y * 32) - (y * 32), alpha = 0, time = duration)
