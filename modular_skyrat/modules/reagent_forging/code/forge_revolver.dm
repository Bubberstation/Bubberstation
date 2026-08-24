// COMSIG_ATOM_WAS_ATTACKED check out this signal's implementation

/obj/item/gun/ballistic/revolver/handcrafted_single_action
	name = "\improper handcrafted revolver"
	desc = "A traditional-style cowboy revolver. It's single-action, so <b>the hammer must be manually cocked back to cycle the round.</b>"
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	icon_state = "revolver_preview"
	icon_preview = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	icon_state_preview = "revolver_preview"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/handcrafted_single_action
	fire_sound_volume = 90
	bolt_type = BOLT_TYPE_NO_BOLT
	semi_auto = FALSE
	mag_display = FALSE
	bolt_wording = "hammer"
	rack_delay = 1
	fire_delay = 1
	//just a little extra damage as a treat
	projectile_damage_multiplier = 1.2
	///below stats should match or exceed the murphy's
	throwforce = 14
	force = 8
	material_flags = MATERIAL_EFFECTS | MATERIAL_AFFECT_STATISTICS | MATERIAL_ADD_PREFIX

	//is the hammer primed (ready to fire) or released (safe)?
	var/hammer_is_primed = FALSE
	var/hammer_pull_speed_fanning = 0 DECISECONDS
	var/hammer_pull_speed_onehanded = 5 DECISECONDS
	var/static/holster_misfire_chance = 70

	//forging base components
	var/obj/item/forging/complete/revolver_frame/frame
	var/obj/item/forging/complete/revolver_cylinder/cylinder

/obj/item/gun/ballistic/revolver/handcrafted_single_action/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_imbued/weapon, oil_effects = list(FORGE_EFFECT_FORCE = 4))
	AddComponent(/datum/component/forge_smithable, \
		FORGING_WEAPON_REFORGING_MAX_QUALITY, \
		TRUE, \
		FORGING_WEAPON_REFORGING_MAX_PERFECT_HITS, \
		FORGING_WEAPON_REFORGING_MAX_BAD_HITS, \
		FORGING_WEAPON_REFORGING_AVERAGE_WAIT, \
		perfection_effects = list(FORGE_EFFECT_FORCE = MAX_PERFECT_FORCE_BONUS))

	RegisterSignal(src, COMSIG_MOVABLE_THROW_LANDED, PROC_REF(try_throw_misfire))

/obj/item/gun/ballistic/revolver/handcrafted_single_action/change_material_strength(datum/material/material, mat_amount, multiplier, remove = FALSE)
	blacksmithing_change_material_strength(src, material, mat_amount, multiplier, remove)

	var/density = material.get_property(MATERIAL_DENSITY)
	var/hardness = material.get_property(MATERIAL_HARDNESS)
	var/flexibility = material.get_property(MATERIAL_FLEXIBILITY)
	var/inaccuracy_modifier = max(0, ((flexibility * 2) - (density + hardness)) * 40 )
	var/damage_modifier = min(0, ((density + hardness) - (flexibility * 2)) / 20)

	if(!remove)
		spread += inaccuracy_modifier
		projectile_damage_multiplier += damage_modifier
	else
		spread -= inaccuracy_modifier
		projectile_damage_multiplier -= damage_modifier

/obj/item/gun/ballistic/revolver/handcrafted_single_action/give_manufacturer_examine()
	return


/obj/item/gun/ballistic/revolver/handcrafted_single_action/update_icon(updates)
	. = ..()
	icon_state = "revolver_handle"

/obj/item/gun/ballistic/revolver/handcrafted_single_action/update_overlays()
	. = ..()

	var/mutable_appearance/temp_mutable
	if(hammer_is_primed)
		temp_mutable = mutable_appearance(icon, "revolver_frame_primed")
	else
		temp_mutable = mutable_appearance(icon, "revolver_frame")

	if(!isnull(frame))
		temp_mutable.color = frame?.color
	. += temp_mutable

	temp_mutable = mutable_appearance(icon,"revolver_cylinder_inserted")
	if(!isnull(cylinder))
		temp_mutable.color = cylinder?.color
	. += temp_mutable

///Can't be toggled safety -- you need to manage the hammer
/obj/item/gun/ballistic/revolver/handcrafted_single_action/give_gun_safeties()
	return

/obj/item/gun/ballistic/revolver/handcrafted_single_action/shoot_with_empty_chamber()
	. = ..()
	set_hammer_cock(FALSE)

///go my snowflake code for handling the revolver's hammer!!!
/obj/item/gun/ballistic/revolver/handcrafted_single_action/attack_self(mob/living/user)
	if(recent_rack > world.time)
		return

	var/rack_delay_to_use
	var/obj/item/bodypart/other_hand = user.has_hand_for_held_index(user.get_inactive_hand_index()) //
	if(user.get_inactive_held_item() || !other_hand) //if both hands occupied, one-handed rack
		rack_delay_to_use = hammer_pull_speed_onehanded
	else
		rack_delay_to_use = hammer_pull_speed_fanning
	recent_rack = world.time + rack_delay_to_use
	rack(user)

/obj/item/gun/ballistic/revolver/handcrafted_single_action/rack(mob/user = null)
	if(DOING_INTERACTION(user, DOAFTER_REVOLVER_HAMMER_COCK))
		return

	if(!hammer_is_primed)
		set_hammer_cock(TRUE)
		balloon_alert(user, "cocked the hammer")
		playsound(src, 'sound/items/weapons/gun_mode_switch1.ogg', vol = 35, vary = TRUE, frequency = 1.8, extrarange = SHORT_RANGE_SOUND_EXTRARANGE)
		if(!istype(magazine,/obj/item/ammo_box/magazine/internal/cylinder))
			stack_trace("[usr] has a magazine that isn't a revolver cylinder!")
		var/obj/item/ammo_box/magazine/internal/cylinder/my_cylinder = magazine
		my_cylinder.rotate()
		chamber_round()
	else
		set_hammer_cock(FALSE)
		balloon_alert(user, "decocked the hammer")
		playsound(src, 'sound/items/weapons/gun_mode_switch1.ogg', vol = 35, vary = TRUE, frequency = 1.6, extrarange = SHORT_RANGE_SOUND_EXTRARANGE)

/obj/item/gun/ballistic/revolver/handcrafted_single_action/proc/set_hammer_cock(cock)
	hammer_is_primed = cock
	update_appearance()

/obj/item/gun/ballistic/revolver/handcrafted_single_action/try_fire_gun(atom/target, mob/living/user, params)
	if(hammer_is_primed)
		return ..()
	else
		balloon_alert(user, "hammer isn't cocked!")
		return FALSE

////////////////////////// MISFIRE WHEN SHOVED OR ATTACKED ///////////////////////////////////////

/obj/item/gun/ballistic/revolver/handcrafted_single_action/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	set_hammer_cock(FALSE)
	. = ..()

/obj/item/gun/ballistic/revolver/handcrafted_single_action/equipped(mob/user, slot, initial)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_WAS_ATTACKED = PROC_REF(try_attack_misfire)//,
		///COMSIG_CARBON_HELP_ACT = PROC_REF(try_hug_misfire),
		//COMSIG_LIVING_Z_IMPACT = PROC_REF(try_fall_misfire),
		)
	if(slot != ITEM_SLOT_HANDS)
		AddComponent(/datum/component/connect_inventory, user, connections, allowed_slots = ALL ^ ITEM_SLOT_HANDS)

/obj/item/gun/ballistic/revolver/handcrafted_single_action/dropped(mob/user, silent)
	. = ..()
	qdel(GetComponent(/datum/component/connect_inventory))


/obj/item/gun/ballistic/revolver/handcrafted_single_action/proc/try_attack_misfire(mob/victim, mob/attacker, attack_flags)
	if(attack_flags & ATTACKER_SHOVING && prob(50))
		if(holster_misfire(victim, attacker) == TRUE)
			victim.visible_message(span_warning("[victim]'s [src] goes off from [attacker]'s attack!"),
				span_danger("Your primed [src] triggers from [attacker]'s strike! "), ignored_mobs = victim)

/*
/obj/item/gun/ballistic/revolver/handcrafted_single_action/proc/try_hug_misfire(mob/living/source)
	if(prob(3))
		if(holster_misfire(victim, attacker) == TRUE)
			user.visible_message(span_warning("[victim]'s [src] goes off from [attacker]'s hug!"),
				span_danger("Your primed [src] triggers from [attacker]'s hug! "), ignored_mobs = victim)


/obj/item/gun/ballistic/revolver/handcrafted_single_action/proc/try_fall_misfire(datum/source, levels, turf/fell_on)
	if(prob(70))
		if(holster_misfire(victim, attacker) == TRUE)
			user.visible_message(span_warning("[victim]'s [src] goes off from [attacker]'s hug!"),
				span_danger("Your primed [src] triggers from the sharp fall! "), ignored_mobs = victim)
*/
/obj/item/gun/ballistic/revolver/handcrafted_single_action/proc/holster_misfire(mob/victim, mob/attacker)
	return try_fire_gun(victim, attacker, null, FALSE)

/obj/item/gun/ballistic/revolver/handcrafted_single_action/proc/try_throw_misfire(datum/source, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER
	//todo: gun fires in random direction if it's thrown
	//if(prob(100))
	return

////////////////////////////////////// MISC RELATED STUFF //////////////////////////////////////

/obj/item/ammo_box/magazine/internal/cylinder/handcrafted_single_action
	name = "handcrafted revolver cylinder"
	start_empty = TRUE
	ammo_type = /obj/item/ammo_casing/c38
	caliber = CALIBER_38
	max_ammo = 6

///cause apparently tgcode doesn't have a bug check against if start_empty = false
/obj/item/ammo_box/magazine/internal/cylinder/handcrafted_single_action/Initialize(mapload)
	. = ..()
	while(stored_ammo.len < max_ammo)
		stored_ammo += null

///get round doesn't spin the cylinder; cocking the hammer (from rack()) must be used to spin the cylinder
/obj/item/ammo_box/magazine/internal/cylinder/handcrafted_single_action/get_round()
	var/casing = null
	if(length(stored_ammo) >= 1)
		casing = stored_ammo[1]
		if (ispath(casing))
			casing = new casing(src)
			stored_ammo[1] = casing
	return casing

/obj/item/ammo_box/magazine/internal/cylinder/handcrafted_single_action/spin()
	. = ..()

/datum/material_slot/revolver/frame
	name = "frame"
	material_amount = 1

/datum/material_slot/revolver/cylinder
	name = "frame"
	material_amount = 0.9
