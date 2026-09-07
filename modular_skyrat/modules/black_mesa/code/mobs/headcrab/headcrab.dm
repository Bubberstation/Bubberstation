/**
 * Headcrab (/mob/living/basic/blackmesa/xen/headcrab)
 * Parasitic alien that jumps at targets and can zombify humans.
 *
 * A classic Half-Life enemy that uses jumping attacks and can turn humans into zombies.
 * - Jumps at targets from range
 * - Can zombify unprotected humans on headshot
 * - Detaches from zombies on death with a chance to survive
 */
/mob/living/basic/blackmesa/xen/headcrab
	name = "headcrab"
	desc = "Don't let it latch onto your hea-... hey, that's kinda cool."
	icon = 'modular_skyrat/modules/black_mesa/icons/mobs.dmi'
	icon_state = "headcrab"
	icon_living = "headcrab"
	icon_dead = "headcrab_dead"
	base_icon_state = "headcrab"

	// Health and combat
	maxHealth = 50
	health = 50
	melee_damage_lower = 0  // No melee attacks, only jump attacks
	melee_damage_upper = 0
	combat_mode = TRUE

	// Mob traits
	mob_biotypes = MOB_ORGANIC | MOB_BEAST
	basic_mob_flags = NONE
	ai_controller = /datum/ai_controller/basic_controller/headcrab

	// Movement
	speed = 3
	move_force = MOVE_FORCE_WEAK
	move_resist = MOVE_FORCE_WEAK
	pull_force = MOVE_FORCE_WEAK
	pixel_x = -8
	base_pixel_x = -8
	faction = list(FACTION_XEN) // Friendly to other Xen creatures
	can_be_shielded = FALSE  // Headcrabs don't use shield pylons

	// Spawning and loot
	gold_core_spawnable = HOSTILE_SPAWN
	butcher_results = list(
		/obj/item/stack/sheet/bone = 1
	)

	/// Maximum distance this headcrab can jump in tiles
	var/throw_at_range = 10

	/// Base speed at which this headcrab jumps (actual speed varies with distance)
	var/throw_at_speed = 2

	/// Track if we've attached to a human, to prevent multiple zombifications
	var/is_zombie = FALSE

/mob/living/basic/blackmesa/xen/headcrab
	alert_sounds = list('modular_skyrat/modules/black_mesa/sound/mobs/headcrab/alert1.ogg')

/mob/living/basic/blackmesa/xen/headcrab/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_IMPACT, PROC_REF(handle_impact))
	ai_controller.set_blackboard_key(BB_TARGET_MINIMUM_STAT, HARD_CRIT) // Allow targeting unconscious people
	var/static/list/actions_to_grant = list(
		/datum/action/cooldown/mob_cooldown/headcrab_jump = BB_TARGETED_ACTION
	)
	grant_actions_by_list(actions_to_grant)

/// Handle leap impacts
/mob/living/basic/blackmesa/xen/headcrab/proc/handle_impact(datum/source, atom/hit_atom, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER
	if(!hit_atom || stat == DEAD)
		return
	if(!isliving(hit_atom) || istype(hit_atom, type))
		return

	playsound(src, 'modular_skyrat/modules/black_mesa/sound/mobs/headcrab/attack1.ogg', 100, FALSE)
	var/mob/living/hit_mob = hit_atom

	// More damage if we hit them at high speed
	var/damage = 8
	if(throwingdatum.speed >= 3)
		damage = 12

	hit_mob.apply_damage(damage, BRUTE)

	if(!ishuman(hit_atom))
		return

	var/mob/living/carbon/human/human_target = hit_atom

	// Regular damage if the target is conscious
	if(human_target.stat < UNCONSCIOUS)
		human_target.apply_damage(damage, BRUTE, BODY_ZONE_HEAD)
		return

	// Check for head protection on unconscious targets
	var/obj/item/clothing/head/head_protection = human_target.get_item_by_slot(ITEM_SLOT_HEAD)
	if(head_protection)
		head_protection.take_damage(15)
		return

	// Zombify unprotected unconscious targets
	if(zombify(human_target))
		// Visual and sound feedback
		playsound(src, 'modular_skyrat/modules/black_mesa/sound/mobs/headcrab/attack1.ogg', 100, FALSE)
		do_sparks(3, TRUE, human_target)

		// Log the zombification
		human_target.investigate_log("was zombified by [src] while unconscious.", INVESTIGATE_DEATHS)
		human_target.death(FALSE)

/mob/living/basic/blackmesa/xen/headcrab/death(gibbed)
	// Handle death sound if not gibbed
	if(!gibbed)
		playsound(src, pick(list(
			'modular_skyrat/modules/black_mesa/sound/mobs/headcrab/die1.ogg',
			'modular_skyrat/modules/black_mesa/sound/mobs/headcrab/die2.ogg'
		)), 100)
	return ..()

/// Transforms a human into a headcrab zombie
/mob/living/basic/blackmesa/xen/headcrab/proc/zombify(mob/living/carbon/human/target_human)
	// Sanity checks
	if(is_zombie || !target_human)
		return FALSE

	// Create the zombie at our location
	var/mob/living/basic/blackmesa/xen/headcrab_zombie/new_zombie = new(get_turf(src))
	new_zombie.name = "[target_human.name] zombie"

	// Copy the human's appearance
	target_human.set_hairstyle(null, update = FALSE)
	target_human.update_body_parts()
	new_zombie.copy_overlays(target_human)

	// Add the headcrab overlay
	var/mutable_appearance/blob_head_overlay = mutable_appearance('modular_skyrat/modules/black_mesa/icons/mobs.dmi', "headcrab_zombie")
	new_zombie.add_overlay(blob_head_overlay)

	// Store the human inside the zombie
	target_human.forceMove(new_zombie)
	new_zombie.zombified_human = target_human

	// If they have armor, apply it to the zombie
	var/obj/item/clothing/suit/armor/zombie_suit = target_human.wear_suit
	if(istype(zombie_suit))
		new_zombie.maxHealth += zombie_suit.get_armor_rating(MELEE) //That zombie's got armor, I want armor!
		new_zombie.health = new_zombie.maxHealth

	// Visual and sound feedback for zombie creation
	playsound(new_zombie, 'modular_skyrat/modules/black_mesa/sound/mobs/headcrab/attack1.ogg', 100, FALSE)
	visible_message(span_warning("The corpse of [target_human.name] suddenly rises, a headcrab controlling its lifeless body!"))

	// Move the mind into the zombie, if we have one
	if(!isnull(mind))
		mind.transfer_to(new_zombie, 1)

	// Delete the original headcrab
	qdel(src)
	return TRUE

/**
 * Fast Headcrab (/mob/living/basic/blackmesa/xen/headcrab/fast)
 * A variant of the standard headcrab that moves significantly faster.
 *
 * This version appears in later stages of Half-Life and represents a more dangerous variant.
 * - Moves much quicker than standard headcrabs
 * - Same jumping and zombification mechanics
 * - More dangerous due to increased mobility
 */
/mob/living/basic/blackmesa/xen/headcrab/fast
	speed = -2
	desc = "Don't let it latch onto your hea-... hey, that's kinda cool. This one looks faster than usual."

/datum/action/cooldown/mob_cooldown/headcrab_jump
	name = "Headcrab Leap"
	desc = "Jump at your target"
	cooldown_time = 1 SECONDS
	click_to_activate = TRUE
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "lace" // I love it when it's an upstream and I don't wanna sprite

	var/maximum_distance = 10

/datum/action/cooldown/mob_cooldown/headcrab_jump/PreActivate(atom/target)
	var/dist = get_dist(owner, target)
	if(dist > maximum_distance)
		var/mob/living/living_owner = owner
		if(istype(living_owner))
			living_owner.balloon_alert(living_owner, "too far!")
		return FALSE
	. = ..()

/datum/action/cooldown/mob_cooldown/headcrab_jump/Activate(atom/target)
	var/dist = get_dist(owner, target)
	dist = min(dist + 2, 10)
	var/new_target = null

	var/mob/living/living_target = target
	if(istype(living_target) && living_target.stat >= SOFT_CRIT)
		// Special case to allow zombification
		new_target = living_target
	else
		// This makes them leap further behind their target, overshooting similar to actual headcrabs
		new_target = get_ranged_target_turf_direct(owner.loc, target, dist)
	var/jump_speed = 3
	if(dist <= 4)
		jump_speed = 4 // Faster at close range
	else if(dist >= 8)
		jump_speed = 2 // Slower at long range

	playsound(owner, 'modular_skyrat/modules/black_mesa/sound/mobs/headcrab/attack2.ogg', 50, TRUE)

	addtimer(CALLBACK(src, PROC_REF(leap), new_target, dist, jump_speed), 0.3 SECONDS)
	. = ..()

/datum/action/cooldown/mob_cooldown/headcrab_jump/proc/leap(atom/target, distance, speed)
	if(QDELETED(owner) || QDELETED(target) || owner.stat == DEAD)
		return
	owner.throw_at(target, distance, speed, owner, TRUE, TRUE, null, 0.1, FALSE, speed * 2)
