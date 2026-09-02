// The stock scope component raises a fullscreen overlay whose artwork is red, and it is created and
// drawn in the same tick, so tinting it afterwards always shows one red frame. This clones the zoom
// step to raise our own overlay instead, meaning the stock red sprite is never displayed at all.

/atom/movable/screen/fullscreen/cursor_catcher/scope/szot
	icon = 'modular_zubbers/icons/hud/szot_sdc_scope.dmi'
	/// Colour the reticle is drawn in, handed over by the rifle before it is shown
	var/reticle_colour = "#41FFFF"

/atom/movable/screen/fullscreen/cursor_catcher/scope/szot/assign_to_mob(mob/new_owner, range_modifier)
	. = ..()
	color = reticle_colour

/datum/component/scope/szot

/datum/component/scope/szot/zoom(mob/user)
	if(isnull(user.client))
		return
	if(HAS_TRAIT(user, TRAIT_USER_SCOPED))
		user.balloon_alert(user, "already zoomed!")
		return
	user.playsound_local(parent, 'sound/items/weapons/scope.ogg', 75, TRUE)
	tracker = user.overlay_fullscreen("scope", /atom/movable/screen/fullscreen/cursor_catcher/scope/szot, isgun(parent))
	var/atom/movable/screen/fullscreen/cursor_catcher/scope/szot/marker = tracker
	if(istype(marker))
		var/obj/item/gun/ballistic/automatic/lanca/jastrzab/rifle = parent
		marker.reticle_colour = istype(rifle) ? rifle.sdc_colour() : marker.reticle_colour
	tracker.assign_to_mob(user, range_modifier)
	tracker_owner_ckey = user.ckey
	if(user.is_holding(parent))
		RegisterSignals(user, list(COMSIG_MOB_SWAP_HANDS, COMSIG_QDELETING), PROC_REF(stop_zooming))
		RegisterSignal(user, COMSIG_ATOM_ENTERING, PROC_REF(on_enter_new_loc))
	else
		RegisterSignal(user, COMSIG_QDELETING, PROC_REF(stop_zooming))
		RegisterSignal(user, COMSIG_ATOM_ENTERING, PROC_REF(on_enter_new_loc))
		var/static/list/capacity_signals = list(
			COMSIG_LIVING_STATUS_KNOCKDOWN,
			COMSIG_LIVING_STATUS_PARALYZE,
			COMSIG_LIVING_STATUS_STUN,
		)
		RegisterSignals(user, capacity_signals, PROC_REF(on_incapacitated))
	START_PROCESSING(SSprojectiles, src)
	ADD_TRAIT(user, TRAIT_USER_SCOPED, REF(src))
	return TRUE
