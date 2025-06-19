// At the end of the day, we make choices we don't want to make, because we hope it'll pay off, but this is a choice I will make so that I can regret my action than inaction.
/*
Coil Rifle
*/
// Some background, this rifle is indeed based on the Citadel Station magnetic rifle.  Initially, I was going to actually make it a 1:1 of it but I realised it wasn't interesting enough, I didn't have support for it either
// The desire to make this gun is not new by any means, I had always wanted to eventually phase out every ballistic and replace it with something like MCR on every level, it didn't happen.
// What ended up happening is that necromanceranne would PR the BR-38. and this is where we are now
// This is a gun that is made by anne, it's writing is my own. The code and it's soul is not. Ask me about the guns, ask her about the code. and to be honest I don't actually know who made the original gun or sprites. What I am making now is a parody of a perceived utopia.

/obj/item/gun/ballistic/automatic/coilgun
	name = "\improper RomTech MEC-1E"
	desc = "The magnetic experimental coil 1 or the Coilgun as it is called, uses electromagnetic coil to propel a solid projectile at enemy at high speed.\
		Used by Romulus Federation Military Force and Kepler Colonial Defense"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/gun48x32.dmi'
	icon_state = "pcr"
	inhand_icon_state = "battle_rifle"
	base_icon_state = "battle_rifle"
	worn_icon = 'icons/mob/clothing/back.dmi'
	worn_icon_state = "battle_rifle"
	slot_flags = ITEM_SLOT_BACK

	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/m38
	w_class = WEIGHT_CLASS_BULKY
	force = 15
	mag_display = TRUE
	projectile_damage_multiplier = 2
	projectile_speed_multiplier = 1.4
	fire_delay = 2
	burst_size = 1
	actions_types = list()
	spread = 5
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/smg_heavy.ogg'
	suppressor_x_offset = 8

	/// Determines how many shots we can make before the weapon needs to be maintained.
	var/shots_before_degradation = 20
	/// The max number of allowed shots this gun can have before degradation.
	var/max_shots_before_degradation = 20
	/// Determines the degradation stage. The higher the value, the more poorly the weapon performs.
	var/degradation_stage = 0
	/// Maximum degradation stage.
	var/degradation_stage_max = 10
	/// The probability of degradation increasing per shot.
	var/degradation_probability = 5
	/// The maximum speed malus for projectile flight speed. Projectiles probably shouldn't move too slowly or else they will start to cause problems.
	var/maximum_speed_malus = 0.7
	/// The maximum spread malus for projectile random spread variation. Projectiles probably shouldn't have too high spread else it can hit walls instead. - Necromanceranne
	var/maximum_spread_malus = 12
	/// Whether or not our gun is suffering an EMP related malfunction. Bear in mind unlike the BR38 this does not jam unless EMP'd
	var/emp_malfunction = FALSE

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/automatic/coilgun/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(held_item?.tool_behaviour == TOOL_MULTITOOL && shots_before_degradation < max_shots_before_degradation)
		context[SCREENTIP_CONTEXT_LMB] = "Reset System"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/gun/ballistic/automatic/coilgun/examine_more(mob/user)
	. = ..()
	. += span_notice("<b><i>Looking down at \the [src], you recall something you read in a promotional pamphlet... </i></b>")

	. += span_info("The MEC-1E possesses an acceleration rail that launches bullets at higher than typical velocity.\
		This allows even less powerful cartridges to put out significant amounts of stopping power.")

	. += span_notice("<b><i>You remember being taught about this in your firearm history course</i></b>")

	. += span_notice("Developed by 'The Citadel' Prior to construction of Space Station 13. It was intended to be a replacement for the aging RT-M4A\
		Which by this point was no longer being produced due to improved technology in manufacturing. Relegating gunpowder-based firearm to only hardline conservatives \
		The gun has a safety feature that prevents it from being fired one handed\
		Despite it being made of lightweight polymer because of NCE believing the guns would be 'un-balanced' in the wrong hands.\
		Some part of the gun feels oddly <b> Hollow. </b>")

/obj/item/gun/ballistic/automatic/coilgun/examine(mob/user)
	. = ..()
	if(shots_before_degradation)
		. += span_notice("[src] can fire [shots_before_degradation] more times before risking system degradation.")
	else
		. += span_notice("[src] is in the process of system degradation. It is currently at stage [degradation_stage] of [degradation_stage_max]. Use a multitool on [src] to recalibrate. Alternatively, insert it into a weapon recharger.")

/obj/item/gun/ballistic/automatic/coilgun/update_icon_state()
	. = ..()
	if(!shots_before_degradation)
		inhand_icon_state = "[base_icon_state]-empty"
	else
		inhand_icon_state = "[base_icon_state]"

/obj/item/gun/ballistic/automatic/coilgun/update_overlays()
	. = ..()
	if(degradation_stage)
		. += "[base_icon_state]_empty"
	else if(shots_before_degradation)
		var/ratio_for_overlay = CEILING(clamp(shots_before_degradation / max_shots_before_degradation, 0, 1) * 3, 1)
		. += "[icon_state]_stage_[ratio_for_overlay]"

/obj/item/gun/ballistic/automatic/coilgun/emp_act(severity)
	. = ..()
	if (!(. & EMP_PROTECT_SELF) && prob(50 / severity))
		shots_before_degradation = 0
		emp_malfunction = TRUE
		attempt_degradation(TRUE)

/obj/item/gun/ballistic/automatic/coilgun/multitool_act(mob/living/user, obj/item/tool)
	if(!tool.use_tool(src, user, 20 SECONDS, volume = 50))
		balloon_alert(user, "interrupted!")
		return ITEM_INTERACT_BLOCKING

	emp_malfunction = FALSE
	shots_before_degradation = initial(shots_before_degradation)
	degradation_stage = initial(degradation_stage)
	projectile_speed_multiplier = initial(projectile_speed_multiplier)
	spread = initial(spread)
	update_appearance()
	balloon_alert(user, "system reset")
	return ITEM_INTERACT_SUCCESS

/obj/item/gun/ballistic/automatic/coilgun/try_fire_gun(atom/target, mob/living/user, params)
	. = ..()
	if(!chambered || (chambered && !chambered.loaded_projectile))
		return

	if(shots_before_degradation)
		shots_before_degradation --
		return

	else
		attempt_degradation(FALSE)


/obj/item/gun/ballistic/automatic/coilgun/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(chambered.loaded_projectile && prob(43) && (emp_malfunction))
		balloon_alert_to_viewers("*click*")
		playsound(src, dry_fire_sound, dry_fire_sound_volume, TRUE)
		return

	return ..()

/// Proc to handle weapon degradation. Called when attempting to fire or immediately after an EMP takes place.
/obj/item/gun/ballistic/automatic/coilgun/proc/attempt_degradation(force_increment = FALSE)
	if(!prob(degradation_probability) && !force_increment || degradation_stage == degradation_stage_max)
		return //Only update if we actually increment our degradation stage

	degradation_stage = clamp(degradation_stage + (obj_flags ? 2 : 1), 0, degradation_stage_max)
	projectile_speed_multiplier = clamp(initial(projectile_speed_multiplier) + degradation_stage * 0.1, initial(projectile_speed_multiplier), maximum_speed_malus)
	spread = clamp(initial(spread) + (degradation_stage * 0.5), initial(spread), maximum_spread_malus)
	do_sparks(1, TRUE, src)
	update_appearance()

/// Called by /obj/machinery/recharger while inserted: attempts to recalibrate our gun but reducing degradation.
/obj/item/gun/ballistic/automatic/coilgun/proc/attempt_recalibration(restoring_shots_before_degradation = FALSE, recharge_rate = 1)
	emp_malfunction = FALSE

	if(restoring_shots_before_degradation)
		shots_before_degradation = clamp(round(shots_before_degradation + recharge_rate, 1), 0, max_shots_before_degradation)

	else
		degradation_stage = clamp(degradation_stage - 1, 0, degradation_stage_max)
		if(degradation_stage)
			projectile_speed_multiplier = clamp(initial(projectile_speed_multiplier) - degradation_stage * 0.1, maximum_speed_malus, initial(projectile_speed_multiplier))
			spread = clamp(initial(spread) + (degradation_stage * 0.5), initial(spread), maximum_spread_malus)
		else
			projectile_speed_multiplier = initial(projectile_speed_multiplier)
			spread = initial(spread)
