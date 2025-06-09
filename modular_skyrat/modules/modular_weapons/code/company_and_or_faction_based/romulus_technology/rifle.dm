// At the end of the day, we make choices we don't want to make, because we hope it'll pay off, but this is a choice I will make.
/*
Coil Rifle
*/

/obj/item/gun/ballistic/automatic/coilgun
	name = "\improper RomTech MEC-1E "
	desc = "The magnetic experimental coil 1 or the Coilgun as it is called, uses electromagnetic coil to propell a solid projectile at enemy at high speed. Used by Romulus Federation Military Force and Kepler Colonial Defense \
	    Developed by 'The Citadel'. It was intended to be a replacement for the aging RT-M4A which by this point was no longer being produced due to improved technology in manufracturing \
		The gun has a safety feature that prevents it from being fired one handed despite it being made of lightweight polymer. Some part of the gun feels oddly <b> Hollow </b>"
	icon = 'icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "battle_rifle"
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
	projectile_speed_multiplier = 1.2
	fire_delay = 2
	burst_size = 1
	actions_types = list()
	spread = 10 //slightly inaccurate in burst fire mode, mostly important for long range shooting
	fire_sound = 'sound/items/weapons/thermalpistol.ogg'
	suppressor_x_offset = 8

	/// Determines how many shots we can make before the weapon needs to be maintained.
	var/shots_before_degradation = 10
	/// The max number of allowed shots this gun can have before degradation.
	var/max_shots_before_degradation = 10
	/// Determines the degradation stage. The higher the value, the more poorly the weapon performs.
	var/degradation_stage = 0
	/// Maximum degradation stage.
	var/degradation_stage_max = 5
	/// The probability of degradation increasing per shot.
	var/degradation_probability = 10
	/// The maximum speed malus for projectile flight speed. Projectiles probably shouldn't move too slowly or else they will start to cause problems.
	var/maximum_speed_malus = 0.7
	/// What is our damage multiplier if the gun is emagged?
	var/emagged_projectile_damage_multiplier = 1.6

	/// Whether or not our gun is suffering an EMP related malfunction.
	var/emp_malfunction = FALSE

	/// Our timer for when our gun is suffering an extreme malfunction. AKA it is going to explode
	var/explosion_timer

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/automatic/battle_rifle/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 2)
	register_context()

/obj/item/gun/ballistic/automatic/battle_rifle/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(held_item?.tool_behaviour == TOOL_MULTITOOL && shots_before_degradation < max_shots_before_degradation)
		context[SCREENTIP_CONTEXT_LMB] = "Reset System"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/gun/ballistic/automatic/battle_rifle/examine_more(mob/user)
	. = ..()
	. += span_notice("<b><i>Looking down at \the [src], you recall something you read in a promotional pamphlet... </i></b>")

	. += span_info("The BR-38 possesses an acceleration rail that launches bullets at higher than typical velocity.\
		This allows even less powerful cartridges to put out significant amounts of stopping power.")

	. += span_notice("<b><i>However, you also remember some of the rumors...  </i></b>")

	. += span_notice("In a sour twist of irony for Nanotrasen's historical issues with ballistics-based security weapons, the BR-38 has one significant flaw. \
		It is possible for the weapon to suffer from unintended discombulations due to closed heat distribution systems should the weapon be tampered with. \
		R&D are working on this issue before the weapon sees commercial sales. That, and trying to work out why the weapon's onboard computation systems suffer \
		from so many calculation errors.")

/obj/item/gun/ballistic/automatic/battle_rifle/examine(mob/user)
	. = ..()
	if(shots_before_degradation)
		. += span_notice("[src] can fire [shots_before_degradation] more times before risking system degradation.")
	else
		. += span_notice("[src] is in the process of system degradation. It is currently at stage [degradation_stage] of [degradation_stage_max]. Use a multitool on [src] to recalibrate. Alternatively, insert it into a weapon recharger.")

/obj/item/gun/ballistic/automatic/battle_rifle/update_icon_state()
	. = ..()
	if(!shots_before_degradation)
		inhand_icon_state = "[base_icon_state]-empty"
	else
		inhand_icon_state = "[base_icon_state]"

/obj/item/gun/ballistic/automatic/battle_rifle/update_overlays()
	. = ..()
	if(degradation_stage)
		. += "[base_icon_state]_empty"
	else if(shots_before_degradation)
		var/ratio_for_overlay = CEILING(clamp(shots_before_degradation / max_shots_before_degradation, 0, 1) * 3, 1)
		. += "[icon_state]_stage_[ratio_for_overlay]"

/obj/item/gun/ballistic/automatic/battle_rifle/emp_act(severity)
	. = ..()
	if (!(. & EMP_PROTECT_SELF) && prob(50 / severity))
		shots_before_degradation = 0
		emp_malfunction = TRUE
		attempt_degradation(TRUE)

/obj/item/gun/ballistic/automatic/battle_rifle/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	projectile_damage_multiplier = emagged_projectile_damage_multiplier
	balloon_alert(user, "heat distribution systems deactivated")
	return TRUE

/obj/item/gun/ballistic/automatic/battle_rifle/multitool_act(mob/living/user, obj/item/tool)
	if(!tool.use_tool(src, user, 20 SECONDS, volume = 50))
		balloon_alert(user, "interrupted!")
		return ITEM_INTERACT_BLOCKING

	emp_malfunction = FALSE
	shots_before_degradation = initial(shots_before_degradation)
	degradation_stage = initial(degradation_stage)
	projectile_speed_multiplier = initial(projectile_speed_multiplier)
	fire_delay = initial(fire_delay)
	update_appearance()
	balloon_alert(user, "system reset")
	return ITEM_INTERACT_SUCCESS

/obj/item/gun/ballistic/automatic/battle_rifle/try_fire_gun(atom/target, mob/living/user, params)
	. = ..()
	if(!chambered || (chambered && !chambered.loaded_projectile))
		return

	if(shots_before_degradation)
		shots_before_degradation --
		return

	else if ((obj_flags & EMAGGED) && degradation_stage == degradation_stage_max && !explosion_timer)
		perform_extreme_malfunction(user)

	else
		attempt_degradation(FALSE)


/obj/item/gun/ballistic/automatic/battle_rifle/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(chambered.loaded_projectile && prob(75) && (emp_malfunction || degradation_stage == degradation_stage_max))
		balloon_alert_to_viewers("*click*")
		playsound(src, dry_fire_sound, dry_fire_sound_volume, TRUE)
		return

	return ..()

/// Proc to handle weapon degradation. Called when attempting to fire or immediately after an EMP takes place.
/obj/item/gun/ballistic/automatic/battle_rifle/proc/attempt_degradation(force_increment = FALSE)
	if(!prob(degradation_probability) && !force_increment || degradation_stage == degradation_stage_max)
		return //Only update if we actually increment our degradation stage

	degradation_stage = clamp(degradation_stage + (obj_flags & EMAGGED ? 2 : 1), 0, degradation_stage_max)
	projectile_speed_multiplier = clamp(initial(projectile_speed_multiplier) + degradation_stage * 0.1, initial(projectile_speed_multiplier), maximum_speed_malus)
	fire_delay = initial(fire_delay) + (degradation_stage * 0.5)
	do_sparks(1, TRUE, src)
	update_appearance()

/// Called by /obj/machinery/recharger while inserted: attempts to recalibrate our gun but reducing degradation.
/obj/item/gun/ballistic/automatic/battle_rifle/proc/attempt_recalibration(restoring_shots_before_degradation = FALSE, recharge_rate = 1)
	emp_malfunction = FALSE

	if(restoring_shots_before_degradation)
		shots_before_degradation = clamp(round(shots_before_degradation + recharge_rate, 1), 0, max_shots_before_degradation)

	else
		degradation_stage = clamp(degradation_stage - 1, 0, degradation_stage_max)
		if(degradation_stage)
			projectile_speed_multiplier = clamp(initial(projectile_speed_multiplier) - degradation_stage * 0.1, maximum_speed_malus, initial(projectile_speed_multiplier))
			fire_delay = initial(fire_delay) + (degradation_stage * 0.5)
		else
			projectile_speed_multiplier = initial(projectile_speed_multiplier)
			fire_delay = initial(fire_delay)

	update_appearance()

/// Proc to handle the countdown for our detonation
/obj/item/gun/ballistic/automatic/battle_rifle/proc/perform_extreme_malfunction(mob/living/user)
	balloon_alert(user, "gun is exploding, throw it!")
	explosion_timer = addtimer(CALLBACK(src, PROC_REF(fucking_explodes_you)), 5 SECONDS, (TIMER_UNIQUE|TIMER_OVERRIDE))
	playsound(src, 'sound/items/weapons/gun/general/empty_alarm.ogg', 50, FALSE)

/// proc to handle our detonation
/obj/item/gun/ballistic/automatic/battle_rifle/proc/fucking_explodes_you()
	explosion(src, devastation_range = 1, heavy_impact_range = 3, light_impact_range = 6, explosion_cause = src)


//Flechette Rifle
//This Replace The Battle Rifle, handle with care please
//This is based on the old CMG Code from Hatterhat when he made it foldable, Dragonfruit made the sprite sometime ago and I'm using it as it's  easier than remaking new sprite from the ground up

/obj/item/gun/ballistic/automatic/rom_flech
	name = "\improper RomTech CMG-1 Rifle"
	desc = "The Compact Machinegun-1 is an automatic rifle fielded by the Romulus Expeditionary Force, chambered in an experimental flechette cartridge capable of defeating all type of conventional body armour. Has a folding stock"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/gun40x32.dmi'
	icon_state = "cmg1"
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	worn_icon_state = "infanterie_evil"
//placeholder, I had to do this in a crunch hour.. sorry! - Kali
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "infanterie_evil"
	bolt_type = BOLT_TYPE_LOCKING
	mag_display = TRUE
	empty_indicator = TRUE
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT
	selector_switch_icon = TRUE
	burst_size = 2
	fire_delay = 2
	spread = 5
//	pin = /obj/item/firing_pin/alert_level this does work but it's a conceptual failure
	pin = /obj/item/firing_pin
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/smg_light.ogg'

	accepted_magazine_type = /obj/item/ammo_box/magazine/caflechette
	spawn_magazine_type = /obj/item/ammo_box/magazine/caflechette
	var/folding_sound = 'sound/items/weapons/batonextend.ogg'
	/// is our stock collapsed?
	var/folded = FALSE
	/// how long does it take to extend/collapse the stock
	var/toggle_time = 1 SECONDS
	/// what's our spread with our extended stock (mild varedit compatibility I Guess)?
	var/unfolded_spread = 2
	/// what's our spread with a folded stock (see above comment)?
	var/folded_spread = 15
	/// Do we have any recoil if it's folded?
	var/folded_recoil = 3
	///Do we lose any recoil when it's not?
	var/unfolded_recoil = 0
	///Shuld this gun be one handed anyway?
	var/one_handed_always = TRUE
/obj/item/gun/ballistic/automatic/rom_flech/examine(mob/user)
	. = ..()
	. += span_notice("<b>Alt-click</b> to [folded ? "extend" : "collapse"] the stock.")

/obj/item/gun/ballistic/automatic/rom_flech/click_alt(mob/user)
	if(!user.is_holding(src))
		return
	if(item_flags & IN_STORAGE)
		return
	toggle_stock(user)

/obj/item/gun/ballistic/automatic/rom_flech/proc/toggle_stock(mob/user, forced)
	if(!user && forced)
		folded = !folded
		update_fold_stats()
		return
	balloon_alert(user, "[folded ? "extending" : "collapsing"] stock...")
	if(!do_after(user, toggle_time))
		balloon_alert(user, "interrupted!")
		return
	folded = !folded
	update_fold_stats()
	balloon_alert(user, "stock [folded ? "collapsed" : "extended"]")
	playsound(src.loc, folding_sound, 30, 1)

/obj/item/gun/ballistic/automatic/rom_flech/proc/update_fold_stats()
	if(folded)
		spread = folded_spread
		w_class = WEIGHT_CLASS_NORMAL
		recoil = folded_recoil
		weapon_weight = WEAPON_LIGHT
	else
		spread = unfolded_spread
		w_class = WEIGHT_CLASS_BULKY
		recoil = unfolded_recoil
		if(one_handed_always)
			weapon_weight = WEAPON_LIGHT
		else
			weapon_weight = WEAPON_HEAVY
	update_icon()

/obj/item/gun/ballistic/automatic/rom_flech/update_overlays()
	. = ..()
	. += "[icon_state]-stock[folded ? "_in" : "_out"]"

/obj/item/gun/ballistic/automatic/rom_flech/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ROMTECH)

/obj/item/gun/ballistic/automatic/rom_flech/empty
	spawnwithmagazine = FALSE

/obj/item/storage/toolbox/guncase/skyrat/pistol/rom_flech
	name = "CMG-1 Rifle Case"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/rom_flech/empty

/obj/item/storage/toolbox/guncase/skyrat/pistol/rom_flech/PopulateContents()
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/caflechette = 2,
		/obj/item/ammo_box/magazine/caflechette/ballpoint = 3,
	), src)

/obj/item/gun/ballistic/automatic/rom_flech/blueshield
	name = "\improper RomTech CMG-2C Rifle"
	desc = "The Compact Machinegun-2 Commando is an automatic rifle used by Romulus Executive Protection Service, modified to be one handed for usage with shield."
	icon_state = "cmg2"
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	worn_icon_state = "infanterie_evil"
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "infanterie_evil"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_LIGHT
	burst_size = 3
	spread = 0

	unfolded_spread = 0
	folded_spread = 7
	folded_recoil = 2
	unfolded_recoil = 0
	one_handed_always = 1

/obj/item/gun/ballistic/automatic/rom_flech/blueshield/empty
	spawnwithmagazine = FALSE

/obj/item/storage/toolbox/guncase/skyrat/pistol/blueshield_cmg
	name = "CMG-2C Rifle Case"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/rom_flech/blueshield/empty

/obj/item/storage/toolbox/guncase/skyrat/pistol/blueshield_cmg/PopulateContents()
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/caflechette = 2,
		/obj/item/ammo_box/magazine/caflechette/ripper = 2,
	), src)
