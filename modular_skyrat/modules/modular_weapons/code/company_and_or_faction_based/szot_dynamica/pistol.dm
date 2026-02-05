// Plasma spewing pistol
// Sprays a wall of plasma that sucks against armor but fucks against unarmored targets

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower
	name = "\improper Słońce Plasma Projector"
	desc = "An outdated sidearm rarely seen in use by some members of the CIN. \
		Uses plasma power packs. \
		Spews an inaccurate stream of searing plasma out the magnetic barrel so long as it has power and the trigger is pulled."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "slonce"

	fire_sound = 'modular_zubbers/sound/weapons/incinerate.ogg'
	fire_sound_volume = 40 // This thing is comically loud otherwise

	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/plasma_battery
	can_suppress = FALSE
	show_bolt_icon = FALSE
	casing_ejector = FALSE
	empty_indicator = FALSE
	bolt_type = BOLT_TYPE_OPEN
	fire_delay = 0.1 SECONDS
	spread = 15

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, autofire_shot_delay = fire_delay)

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/examine_more(mob/user)
	. = ..()

	. += "The 'Słońce' started life as an experiment in advancing the field of accelerated \
		plasma weaponry. Despite the design's obvious shortcomings in terms of accuracy and \
		range, the CIN combined military command (which we'll call the CMC from now on) took \
		interest in the weapon as a means to counter Sol's more advanced armor technology. \
		As it would turn out, the plasma globules created by the weapon were really not \
		as effective against armor as the CMC had hoped, quite the opposite actually. \
		What the plasma did do well however was inflict grevious burns upon anyone unfortunate \
		enough to get hit by it unprotected. For this reason, the 'Słońce' saw frequent use by \
		army officers and ship crews who needed a backup weapon to incinerate the odd space \
		pirate or prisoner of war."

	return .

// Plasma sharpshooter pistol
// Shoots single, strong plasma blasts at a slow rate

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman
	name = "\improper Gwiazda Plasma Sharpshooter"
	desc = "An outdated sidearm rarely seen in use by some members of the CIN. \
		Uses plasma power packs. \
		Fires relatively accurate globs of searing plasma."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "gwiazda"

	fire_sound = 'modular_zubbers/sound/weapons/burn.ogg'
	fire_sound_volume = 40 // This thing is comically loud otherwise

	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/plasma_battery
	can_suppress = FALSE
	show_bolt_icon = FALSE
	casing_ejector = FALSE
	empty_indicator = FALSE
	bolt_type = BOLT_TYPE_OPEN
	fire_delay = 0.6 SECONDS
	spread = 2.5
	actions_types = list(/datum/action/item_action/activate_plasma_overclock)
	var/current_projspeed_mod = 1.5 // default so the first shot always is at full, duh
	var/overclocking = FALSE
	var/self_destruct_timer

	projectile_damage_multiplier = 3 // 30 damage a shot
	projectile_wound_bonus = 10 // +55 of the base projectile, burn baby burn

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/Initialize(mapload)
	. = ..()

	RegisterSignal(src, COMSIG_MOVABLE_POST_THROW, PROC_REF(shakeit))

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/examine(mob/user, overclocking)
	. = ..()
	if(overclocking)
		. += span_notice("The weapon is glowing red and steaming!")
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/examine_more(mob/user)
	. = ..()
	. += "The 'Gwiazda' is a further refinement of the 'Słońce' design. with improved \
		energy cycling, magnetic launchers built to higher precision, and an overall more \
		ergonomic design. While it still fails to perform against armor, the weapon is \
		significantly more accurate and higher power, at expense of a much lower firerate. \
		Opinions on this weapon within military service were highly mixed, with many preferring \
		the sheer stopping power a spray of plasma could produce, with others loving the new ability \
		to hit something in front of you for once."

	return .

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	. = ..()
	if(overclocking && chambered)
		chambered.projectile_type = /obj/projectile/beam/laser/plasma_glob/supercharged

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/proc/update_projspeed(mob/user)
	var/shots_in_mag = src.get_ammo()
	if(overclocking)
		projectile_speed_multiplier = 1.6
	else if(shots_in_mag >= 13)
		projectile_speed_multiplier = 1.5
	else if(shots_in_mag >= 10 && shots_in_mag <= 12)
		projectile_speed_multiplier = 1.3
	else if(shots_in_mag >= 8 && shots_in_mag <= 9)
		projectile_speed_multiplier = 1.2
	else if(shots_in_mag >= 5 && shots_in_mag <= 7)
		projectile_speed_multiplier = 1.1
	else if(shots_in_mag >= 1 && shots_in_mag <= 4)
		projectile_speed_multiplier = 1.0
	else
		projectile_speed_multiplier = 0.8

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/proc/activate_oveclock(mob/user, current_proj_speed)

/datum/action/item_action/activate_plasma_overclock //Gotta be hud, its un-revertable. Imagine misclicking and blowing up your gun without knowing...
	button_icon = 'icons/obj/weapons/guns/ammo.dmi'
	button_icon_state = "9x19p"
	name = "Overclock Plasma Charger"
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_CONSCIOUS

//Checks if we can overclock the gun, if so, starts the process
/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/ui_action_click(mob/user, actiontype)
	if(!istype(actiontype, /datum/action/item_action/activate_plasma_overclock))
		return ..()
	if(!overclocking)
		overclocking = !overclocking
	balloon_alert(user, "[overclocking ? "Plasma coils overheated, it's going to blow!" : "It's not shutting down!"]")
	if(overclocking)
		overclock(user)
	playsound(src, 'sound/effects/magic/lightning_chargeup.ogg', 50)
	update_item_action_buttons()

	//Base overclock proc, changes our projectile for releasing the flare + explosion
/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/proc/overclock(mob/living/user, slot)
	if(user)
		START_PROCESSING(SSprocessing, src)
		addtimer(CALLBACK(src, PROC_REF(audio_warning)), 7 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(kaboom)), 10 SECONDS)
		shakeit()
		add_shared_particles(/particles/smoke/steam)

/obj/item/ammo_casing/energy/laser/plasma_glob/ready_proj(atom/target, mob/living/user, quiet, zone_override, atom/fired_from)
	var/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/gun = fired_from
	if(istype(gun) && gun.overclocking)
		loaded_projectile.name = "overcharged plasma globule"
		loaded_projectile.icon_state = "plasma_glob_super"
		loaded_projectile.weak_against_armour = FALSE
	gun.update_projspeed(user)
	. = ..()

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/proc/shakeit()
	SIGNAL_HANDLER

	if(!overclocking)
		return
	spasm_animation()

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/proc/kaboom(mob/living/user)
	STOP_PROCESSING(SSprocessing, src)
	var/turf/last_surprise = get_turf(src)
	explosion(src, light_impact_range = 1, flame_range = 3, explosion_cause = src)
	last_surprise.add_liquid(/datum/reagent/toxin/plasma, 3, no_react = FALSE, chem_temp = 300)
	new /obj/effect/hotspot(last_surprise)
	UnregisterSignal(src, COMSIG_MOVABLE_POST_THROW)
	remove_shared_particles(/particles/bonfire)
	qdel(src)

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/proc/audio_warning(mob/living/user)
	playsound(src, 'modular_zubbers/sound/weapons/plasma_explosion.ogg', 100, FALSE, 20, , , , TRUE)
	for(var/mob/living/carbon/M in orange(20, src))
		if(!HAS_TRAIT(M, TRAIT_DEAF))
			to_chat(M, span_warning("You hear a distant pulse of energy, as if a miniature reactor blasting out a shockwave from afar..."))

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/process(seconds_per_tick)
	var/mob/living/carbon/wielder = ismob(loc) ? loc : null
	var/obj/item/bodypart/affecting = wielder.get_bodypart("[(wielder.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
	if(isnull(wielder))
		return
	if(isnull(affecting))
		return
	if(wielder.is_holding(src))
		wielder.apply_damage(2.5, BURN, affecting)
		to_chat(wielder, span_warning("[src] burns your hand, it's too hot!"))

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		if(prob(15 * severity))
			overclock()


// A revolver, but it can hold shotgun shells
// Woe, buckshot be upon ye

/obj/item/gun/ballistic/revolver/shotgun_revolver
	name = "\improper Bóbr 12 GA revolver"
	desc = "An outdated sidearm rarely seen in use by some members of the CIN. A revolver type design with a four shell cylinder. That's right, shell, this one shoots twelve guage."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev12ga
	recoil = SAWN_OFF_RECOIL
	weapon_weight = WEAPON_MEDIUM
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "bobr"
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/revolver_fire.ogg'
	spread = SAWN_OFF_ACC_PENALTY

/obj/item/gun/ballistic/revolver/shotgun_revolver/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/revolver/shotgun_revolver/examine_more(mob/user)
	. = ..()

	. += "The 'Bóbr' started development as a limited run sporting weapon before \
		the military took interest. The market quickly changed from sport shooting \
		targets, to sport shooting TerraGov strike teams once the conflict broke out. \
		This pattern is different from the original civilian version, with a military \
		standard pistol grip and weather resistant finish. While the 'Bóbr' was not \
		a weapon standard issued to every CIN soldier, it was available for relatively \
		cheap, and thus became rather popular among the ranks."

	return .
