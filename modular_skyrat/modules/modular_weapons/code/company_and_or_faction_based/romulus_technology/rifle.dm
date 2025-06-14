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
	fire_delay = initial(fire_delay)
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
	fire_delay = clamp(initial(fire_delay) + (degradation_stage * 0.5),initial(fire_delay) , 5)
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
			fire_delay = clamp(initial(fire_delay) + (degradation_stage * 0.5), initial(fire_delay) , 5)
		else
			projectile_speed_multiplier = initial(projectile_speed_multiplier)
			fire_delay = initial(fire_delay)
			spread = initial(spread)

	update_appearance()

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
