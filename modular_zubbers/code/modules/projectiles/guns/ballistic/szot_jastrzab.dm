// Szot Dynamica's Smart Drift Control prototype. An ordinary Lanca with an unreasonable amount of
// money spent on making it reluctant to miss.

/// Maximum degrees a designated shot may turn PER TICK. This is not a strength dial: a target one
/// tile off the firing line needs 45 degrees of correction at one tile and only 6 at ten, so too low
/// a value cannot correct at close range at all and the shot sails past. 8 rescues a near miss at
/// realistic distances while still being nowhere near a homing missile.
#define JASTRZAB_TURN_SPEED 8
/// Deliberate scatter, in pixels, so it never lands dead centre every time
#define JASTRZAB_HOMING_SLOP_MIN 1
#define JASTRZAB_HOMING_SLOP_MAX 3
/// How far the auto lock reaches when the shooter is scoped and clicking turfs
#define JASTRZAB_SCOPED_LOCK_RANGE 2

/obj/item/gun/ballistic/automatic/lanca/jastrzab
	resistance_flags = INDESTRUCTIBLE
	name = "\improper Jastrząb Marksman Rifle"
	desc = "A rare precision variant of the Lanca battle rifle fitted with Szot Dynamica's prohibitively expensive \
		Smart Drift Control system. Its unusual targeting hardware makes small corrections to the flight of .310 \
		Strilka fired at a designated target, at the expense of a reduced firing rate. \
		Held in both hands, it paints whoever you point it at. The manual insists that Smart Drift Control presents its targeting \
		data through \"tooltips\", whatever those are supposed to be."
	icon = 'modular_zubbers/icons/obj/szot_jastrzab.dmi'
	icon_state = "jastrzab"
	greyscale_config = /datum/greyscale_config/szot_jastrzab
	greyscale_config_worn = /datum/greyscale_config/szot_jastrzab/worn
	greyscale_config_inhand_left = /datum/greyscale_config/szot_jastrzab/lefthand
	greyscale_config_inhand_right = /datum/greyscale_config/szot_jastrzab/righthand
	inhand_icon_state = "jastrzab"
	worn_icon_state = "jastrzab"
	greyscale_colors = "#787C82#1A9CAC"
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1
	accepted_magazine_type = /obj/item/ammo_box/magazine/lanca
	spawn_magazine_type = /obj/item/ammo_box/magazine/lanca/extended
	fire_delay = 1.2 SECONDS
	/// Fallback if the rifle somehow has no accent colour set
	var/sdc_fallback = "#41FFFF"
	/// The mob the current shot has been designated against, if any
	var/mob/living/designated
	/// The targeting line currently drawn, cleared when the shot resolves
	var/datum/beam/active_sight
	/// Who the rangefinder is currently painting, if anybody
	var/mob/living/painted
	/// The idle rangefinder line, distinct from the one a shot inherits
	var/datum/beam/range_sight
	/// The idle lock graphic sitting on the painted target
	var/obj/effect/temp_visual/szot_sdc_lock/range_lock

/obj/item/gun/ballistic/automatic/lanca/jastrzab/update_overlays()
	. = ..()
	if(!magazine || internal_magazine || !mag_display)
		return
	if(!magazine.ammo_count())
		. -= "[icon_state]_mag"
		. += "[icon_state]_mag_empty"

/// The targeting display is drawn in the rifle's own accent colour, so painting the gun paints the beam
/obj/item/gun/ballistic/automatic/lanca/jastrzab/proc/sdc_colour()
	var/list/parts = splittext(greyscale_colors, "#")
	return length(parts) >= 3 ? "#[parts[3]]" : sdc_fallback

/obj/item/gun/ballistic/automatic/lanca/jastrzab/Initialize(mapload)
	. = ..()
	// the Lanca parent already adds gags_recolorable; adding it again double-registers its signals
	// the screentip hover signal is the only hook that reports what the wielder is pointing at
	// without reaching into core code. it does mean the rangefinder needs screentips enabled.
	register_item_context()
	// our own scope, so the reticle is drawn in the rifle's colour from the first frame
	qdel(GetComponent(/datum/component/scope))
	AddComponent(/datum/component/scope/szot, range_modifier = 1.9)

/obj/item/gun/ballistic/automatic/lanca/jastrzab/Destroy()
	clear_paint()
	return ..()

/obj/item/gun/ballistic/automatic/lanca/jastrzab/dropped(mob/user, silent)
	. = ..()
	clear_paint()

/// Hover handler. Paints anybody living the wielder rests the cursor on.
/obj/item/gun/ballistic/automatic/lanca/jastrzab/add_item_context(obj/item/source, list/context, atom/target, mob/living/user)
	// the Lanca family has no wield component; a heavy weapon simply refuses to fire with the other
	// hand full, so the rangefinder uses the same test the trigger does
	var/obj/item/bodypart/other_hand = user.has_hand_for_held_index(user.get_inactive_hand_index())
	if(user.get_inactive_held_item() || !other_hand || user.get_active_held_item() != src)
		clear_paint()
		return NONE
	if(!isliving(target) || target == user || !can_see(user, target, 20))
		clear_paint()
		return NONE
	// a shot already has a lock on this target, so painting would stack a second readout on it
	if(!QDELETED(active_sight))
		return NONE
	paint_target(target, user)
	return NONE

/// Draws or refreshes the idle rangefinder on a target
/obj/item/gun/ballistic/automatic/lanca/jastrzab/proc/paint_target(mob/living/target, mob/living/user)
	if(painted == target)
		return
	clear_paint()
	painted = target
	range_lock = new(get_turf(target), target, sdc_colour())
	range_lock.watch_shooter(src, target)
	range_sight = user.Beam(target, icon = 'icons/obj/weapons/guns/projectiles_tracer.dmi', \
		icon_state = "pixelbeam_greyscale", beam_color = sdc_colour(), time = 1 MINUTES, maxdistance = 20)

/// Drops the rangefinder again
/obj/item/gun/ballistic/automatic/lanca/jastrzab/proc/clear_paint()
	// no fade here: a lingering ghost lock doubles up the moment a new one is drawn
	QDEL_NULL(range_lock)
	QDEL_NULL(range_sight)
	painted = null

/obj/item/gun/ballistic/automatic/lanca/jastrzab/examine_more(mob/user)
	. = ..()

	. += "Smart Drift Control worked. That was never the difficulty. Trials returned hit rates that embarrassed \
		every other rifle Szot Dynamica had ever fielded, and the evaluation board's report is remembered chiefly for \
		the sentence in which it observed that the targeting package cost rather more than the rifle, the magazines, \
		the ammunition, and a considerable portion of the soldier carrying them."

	. += "The procurement program died of arithmetic rather than of failure. Surviving examples come from evaluation \
		units, specialist issue, and the collections of procurement officers who were unusually well connected and \
		unusually relaxed about paperwork."

	return .

/// Tears down the targeting line the moment the shot stops existing
/obj/item/gun/ballistic/automatic/lanca/jastrzab/proc/shot_landed(datum/source)
	SIGNAL_HANDLER
	QDEL_NULL(active_sight)

/// Works out what the shot has been designated against, if anything
/obj/item/gun/ballistic/automatic/lanca/jastrzab/proc/find_designation(atom/target, mob/living/user)
	if(isliving(target))
		return target
	// while scoped the cursor resolves to turfs, so the package does the picking for us
	if(!isturf(target) || !user.client)
		return null
	if(isnull(locate(/atom/movable/screen/fullscreen/cursor_catcher/scope) in user.client.screen))
		return null
	return locate(/mob/living) in range(JASTRZAB_SCOPED_LOCK_RANGE, target)

/obj/item/gun/ballistic/automatic/lanca/jastrzab/before_firing(atom/target, mob/user)
	. = ..()
	designated = null
	var/obj/projectile/shot = chambered?.loaded_projectile
	if(isnull(shot))
		return

	var/mob/living/mark = find_designation(target, user)
	if(isnull(mark) || mark == user)
		return
	designated = mark
	shot.homing_turn_speed = JASTRZAB_TURN_SPEED
	shot.homing_inaccuracy_min = JASTRZAB_HOMING_SLOP_MIN
	shot.homing_inaccuracy_max = JASTRZAB_HOMING_SLOP_MAX
	shot.set_homing_target(mark)
	// PASSMOB is deliberately NOT used here. It makes a projectile ignore every mob except its
	// `original`, and `original` is overwritten by ready_proj after before_firing has run, so the
	// designated target was being treated as a bystander: the shot passed through it and then homed
	// into whatever was behind. Hitting the thing you aimed at matters more than ignoring bystanders.

	// the rangefinder is already pointing at them, so the shot takes it over rather than duplicating it
	var/obj/effect/temp_visual/szot_sdc_lock/lock
	if(painted == mark && range_lock)
		lock = range_lock
		range_lock = null
		painted = null
		QDEL_NULL(range_sight)
	else
		lock = new(get_turf(mark), mark, sdc_colour())
	lock.follow(shot)
	// the beam must originate from the shooter: a gun in a backpack or a hand has no turf of its own,
	// and Beam() ends up forceMoving its segments to nowhere
	var/datum/beam/sight = user.Beam(mark, icon = 'icons/obj/weapons/guns/projectiles_tracer.dmi', \
		icon_state = "pixelbeam_greyscale", beam_color = sdc_colour(), time = 5 SECONDS, maxdistance = 20)
	// and it lives exactly as long as the shot does
	RegisterSignal(shot, COMSIG_QDELETING, PROC_REF(shot_landed))
	active_sight = sight

#undef JASTRZAB_TURN_SPEED
#undef JASTRZAB_HOMING_SLOP_MIN
#undef JASTRZAB_HOMING_SLOP_MAX
#undef JASTRZAB_SCOPED_LOCK_RANGE

// The lock graphic. Sits on the target and reports the range until the shot resolves.

/obj/effect/temp_visual/szot_sdc_lock
	name = "targeting lock"
	icon = 'modular_zubbers/icons/effects/szot_sdc.dmi'
	icon_state = "sdc_lock"
	greyscale_config = /datum/greyscale_config/szot_sdc
	greyscale_colors = "#41FFFF"
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1
	layer = ABOVE_MOB_LAYER
	randomdir = FALSE
	duration = 1 MINUTES
	/// Who we are drawn over
	var/mob/living/marked
	/// The shot we are reporting on
	var/obj/projectile/watching
	/// Or, before a shot exists, the rifle doing the ranging
	var/atom/ranging_from

/obj/effect/temp_visual/szot_sdc_lock/Initialize(mapload, mob/living/mark, lock_colour)
	. = ..()
	marked = mark
	set_greyscale(list(lock_colour || greyscale_colors))
	if(marked)
		follow_marked()

/// Keeps the lock sitting on whoever it is watching
/obj/effect/temp_visual/szot_sdc_lock/proc/follow_marked()
	if(QDELETED(marked))
		return
	var/turf/spot = get_turf(marked)
	if(spot && loc != spot)
		forceMove(spot)
	pixel_x = marked.pixel_x
	pixel_y = marked.pixel_y

/obj/effect/temp_visual/szot_sdc_lock/Destroy(force)
	STOP_PROCESSING(SSfastprocess, src)
	if(marked)
		marked = null
	watching = null
	ranging_from = null
	return ..()

/// Reports range from the wielder while nothing has been fired yet
/obj/effect/temp_visual/szot_sdc_lock/proc/watch_shooter(obj/item/gun/rifle, mob/living/mark)
	ranging_from = rifle
	START_PROCESSING(SSfastprocess, src)
	update_readout()

/// Attaches the lock to a shot so it can report range and clear itself when the shot resolves
/obj/effect/temp_visual/szot_sdc_lock/proc/follow(obj/projectile/shot)
	watching = shot
	ranging_from = null
	RegisterSignal(shot, COMSIG_QDELETING, PROC_REF(shot_resolved))
	START_PROCESSING(SSfastprocess, src)
	update_readout()

/// Clears the lock the moment the shot it was watching stops existing
/obj/effect/temp_visual/szot_sdc_lock/proc/shot_resolved(datum/source)
	SIGNAL_HANDLER
	watching = null
	qdel(src)

/obj/effect/temp_visual/szot_sdc_lock/process(seconds_per_tick)
	if(QDELETED(marked) || (QDELETED(watching) && QDELETED(ranging_from)))
		qdel(src)
		return PROCESS_KILL
	follow_marked()
	update_readout()

/// One tile reads as one metre, which the camera defines already assume
/obj/effect/temp_visual/szot_sdc_lock/proc/update_readout()
	if(QDELETED(marked))
		return
	var/atom/source = watching || ranging_from
	if(QDELETED(source))
		return
	// one tile reads as one metre; a decimal keeps the number visibly working at station ranges
	// "to" is a DM keyword and "range" is a builtin proc, so neither can be a local name here
	var/turf/source_turf = get_turf(source)
	var/turf/target_turf = get_turf(marked)
	var/metres = round(sqrt((source_turf.x - target_turf.x) ** 2 + (source_turf.y - target_turf.y) ** 2), 0.01)
	// padded to four digits so the readout always reads like an instrument doing work
	var/readout = num2text(metres, 4)
	maptext = MAPTEXT("<span style='color: [greyscale_colors]; font-size: 6px'>[readout]M</span>")
	maptext_width = 40
	maptext_x = -2
	maptext_y = 20
