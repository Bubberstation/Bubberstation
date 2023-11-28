/// Deals extra damage to mobs of a certain type or species.
/datum/element/bane
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2
	/// can be a mob or a species.
	var/target_type
	/// multiplier of the extra damage based on the force of the item.
	var/damage_multiplier
	/// Added after the above.
	var/added_damage
	/// If it requires combat mode on to deal the extra damage or not.
	var/requires_combat_mode

/datum/element/bane/Attach(datum/target, target_type, damage_multiplier=1, added_damage = 0, requires_combat_mode = TRUE)
	. = ..()

	if(!ispath(target_type, /mob/living) && !ispath(target_type, /datum/species))
		return ELEMENT_INCOMPATIBLE

	src.target_type = target_type
	src.damage_multiplier = damage_multiplier
	src.added_damage = added_damage
	src.requires_combat_mode = requires_combat_mode
<<<<<<< HEAD
	src.mob_biotypes = mob_biotypes
	target.AddComponent(/datum/component/on_hit_effect, CALLBACK(src, PROC_REF(do_bane)), CALLBACK(src, PROC_REF(check_bane)))
=======
>>>>>>> 6d93d20462a27f3351796f4b0ec8cafb715b2847

/datum/element/bane/Detach(datum/target)
	qdel(target.GetComponent(/datum/component/on_hit_effect))
	return ..()

<<<<<<< HEAD
/datum/element/bane/proc/check_bane(bane_applier, target, bane_weapon)
	if(!check_biotype_path(bane_applier, target))
		return
	var/atom/movable/atom_owner = bane_weapon
	if(SEND_SIGNAL(atom_owner, COMSIG_OBJECT_PRE_BANING, target) & COMPONENT_CANCEL_BANING)
		return
	return TRUE

/**
 * Checks typepaths and the mob's biotype, returning TRUE if correct and FALSE if wrong.
 * Additionally checks if combat mode is required, and if so whether it's enabled or not.
 */
/datum/element/bane/proc/check_biotype_path(mob/living/bane_applier, atom/target)
	if(!isliving(target))
		return FALSE
	var/mob/living/living_target = target
	if(bane_applier)
		if(requires_combat_mode && !bane_applier.combat_mode)
			return FALSE
	var/is_correct_biotype = living_target.mob_biotypes & mob_biotypes
	if(mob_biotypes && !(is_correct_biotype))
		return FALSE
	if(ispath(target_type, /mob/living))
		return istype(living_target, target_type)
	else //species type
		return is_species(living_target, target_type)

/datum/element/bane/proc/do_bane(datum/element_owner, mob/living/bane_applier, mob/living/baned_target, hit_zone)
	var/force_boosted
	var/applied_dam_type

	if(isitem(element_owner))
		var/obj/item/item_owner = element_owner
		force_boosted = item_owner.force
		applied_dam_type = item_owner.damtype
	else if(isprojectile(element_owner))
		var/obj/projectile/projectile_owner = element_owner
		force_boosted = projectile_owner.damage
		applied_dam_type = projectile_owner.damage_type
	else if (isliving(element_owner))
		var/mob/living/living_owner = element_owner
		force_boosted = (living_owner.melee_damage_lower + living_owner.melee_damage_upper) / 2
		//commence crying. yes, these really are the same check. FUCK.
		if(isbasicmob(living_owner))
			var/mob/living/basic/basic_owner = living_owner
			applied_dam_type = basic_owner.melee_damage_type
		else if(isanimal(living_owner))
			var/mob/living/simple_animal/simple_owner = living_owner
			applied_dam_type = simple_owner.melee_damage_type
		else
			return
	else
		return

	var/extra_damage = max(0, (force_boosted * damage_multiplier) + added_damage)
	baned_target.apply_damage(extra_damage, applied_dam_type, hit_zone)
	SEND_SIGNAL(baned_target, COMSIG_LIVING_BANED, bane_applier, baned_target) // for extra effects when baned.
	SEND_SIGNAL(element_owner, COMSIG_OBJECT_ON_BANING, baned_target)
=======
/datum/element/bane/proc/species_check(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	SIGNAL_HANDLER

	if(!proximity_flag || !is_species(target, target_type))
		return
	activate(source, target, user)

/datum/element/bane/proc/mob_check(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	SIGNAL_HANDLER

	if(!proximity_flag || !istype(target, target_type))
		return
	activate(source, target, user)

/datum/element/bane/proc/activate(obj/item/source, mob/living/target, mob/living/attacker)
	if(requires_combat_mode && !attacker.combat_mode)
		return

	var/extra_damage = max(0, (source.force * damage_multiplier) + added_damage)
	target.apply_damage(extra_damage, source.damtype, attacker.zone_selected)
	SEND_SIGNAL(target, COMSIG_LIVING_BANED, source, attacker) // for extra effects when baned.
>>>>>>> 6d93d20462a27f3351796f4b0ec8cafb715b2847
