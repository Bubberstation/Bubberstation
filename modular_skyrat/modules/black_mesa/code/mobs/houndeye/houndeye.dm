#define SONIC_BLAST_COOLDOWN 5 SECONDS
#define SONIC_BLAST_CHARGE_TIME 1.5 SECONDS

/mob/living/basic/blackmesa/xen/houndeye
	name = "houndeye"
	desc = "Some highly aggressive alien creature that attacks using sonic waves."
	icon = 'modular_skyrat/modules/black_mesa/icons/mobs.dmi'
	icon_state = "houndeye"
	base_icon_state = "houndeye"
	icon_living = "houndeye"
	icon_dead = "houndeye_dead"

	// Stats
	maxHealth = 100
	health = 100
	// Can't do much with your stupid little flat head
	melee_damage_lower = 1
	melee_damage_upper = 1
	obj_damage = 50
	attack_sound = 'sound/items/tools/welder.ogg'
	attack_verb_continuous = "headbutts"
	attack_verb_simple = "headbutt"

	// Movement
	speed = 1
	ai_controller = /datum/ai_controller/basic_controller/houndeye
	basic_mob_flags = NONE

	// Mob properties
	mob_biotypes = list(MOB_ORGANIC, MOB_BEAST)
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	gold_core_spawnable = HOSTILE_SPAWN

	// Environmental resistances
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1500

	// Alert sounds from parent type will be used
	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/he_alert1.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/he_alert2.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/he_alert3.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/he_alert4.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/he_alert5.ogg'
	)

/mob/living/basic/blackmesa/xen/houndeye/Initialize(mapload)
	. = ..()
	var/static/list/actions_to_grant = list(
		/datum/action/cooldown/mob_cooldown/sonic_blast = BB_TARGETED_ACTION
	)
	grant_actions_by_list(actions_to_grant)

/**
 * Visual effect for sonic blast charging
 *
 * Creates a charging effect that follows the houndeye
 */
/obj/effect/temp_visual/spirit_hound_charge
	icon = 'icons/effects/effects.dmi'
	icon_state = "lightning"
	duration = 1.5 SECONDS
	randomdir = FALSE
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	/// The mob we're attached to for following
	var/mob/attached_mob

/obj/effect/temp_visual/spirit_hound_charge/Initialize(mapload)
	. = ..()
	if(attached_mob)
		loc = attached_mob.loc

/obj/effect/temp_visual/spirit_hound_charge/proc/attach(mob/living/attached_mob)
	var/turf/newloc = get_turf(attached_mob)
	if(!istype(newloc))
		return
	forceMove(newloc)

/**
 * Visual effect for the sonic blast wave
 *
 * Creates a visible indicator of the sonic blast's area of effect
 */
/obj/effect/temp_visual/sonicblast
	icon = 'icons/effects/effects.dmi'
	icon_state = "shieldsparkles"
	duration = 0.5 SECONDS
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE

/datum/action/cooldown/mob_cooldown/sonic_blast
	name = "Sonic Blast"
	desc = "Create a sonic blast cone in the direction you're facing"
	cooldown_time = SONIC_BLAST_COOLDOWN
	melee_cooldown_time = SONIC_BLAST_COOLDOWN
	click_to_activate = TRUE
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "lightning"

/datum/action/cooldown/mob_cooldown/sonic_blast/Activate(atom/target)
	var/mob/living/living_owner = owner
	if(istype(living_owner))
		living_owner.Immobilize(SONIC_BLAST_CHARGE_TIME, TRUE)
	living_owner.face_atom(target)

	owner.visible_message(span_warning("[owner] begins to charge up energy!"))

	var/static/list/charge_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/charge1.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/charge2.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/charge3.ogg'
	)
	playsound(owner, pick(charge_sounds), 100, TRUE)

	// Visual effect for charging
	var/obj/effect/temp_visual/spirit_hound_charge/charge_effect = new(owner.loc)
	charge_effect.attach(owner)

	addtimer(CALLBACK(src, PROC_REF(release_sonic_blast), target), SONIC_BLAST_CHARGE_TIME)
	. = ..()

/datum/action/cooldown/mob_cooldown/sonic_blast/proc/release_sonic_blast(atom/target)
	if(QDELETED(owner) || QDELETED(target))
		return

	// Get turfs in a cone shape in front of the houndeye
	for(var/turf/potential_hit_turf in view(4, owner))
		if(get_dist(owner, potential_hit_turf) > 4)
			continue
		if(angle2dir_cardinal(get_angle(owner, potential_hit_turf)) != owner.dir)
			continue
		damage_turf(potential_hit_turf)

	// Play the blast sound
	playsound(owner, 'sound/effects/explosion/explosioncreak2.ogg', 100, TRUE)
	owner.visible_message(span_danger("[owner] releases a powerful sonic blast!"))

/datum/action/cooldown/mob_cooldown/sonic_blast/proc/damage_turf(turf/turf_victim)
	new /obj/effect/temp_visual/sonicblast(turf_victim)
	for(var/mob/living/living_victim in turf_victim)
		if(living_victim == owner)
			continue
		var/dist_mod = 1 - (get_dist(owner, living_victim) / 5) // Damage dropoff with range
		var/damage = round(15 * dist_mod)
		living_victim.apply_damage(damage, BRUTE)
		living_victim.apply_damage(damage, STAMINA)
		if(prob(50))
			living_victim.Knockdown(1 SECONDS)
		to_chat(living_victim, span_warning("You're hit by [owner]'s sonic blast!"))
	for(var/obj/object_victim in turf_victim)
		if(istype(object_victim, /obj/structure/window))
			object_victim.take_damage(30)
		else if(istype(object_victim, /obj/structure/table) || istype(object_victim, /obj/structure/rack))
			object_victim.take_damage(10)


#undef SONIC_BLAST_COOLDOWN
#undef SONIC_BLAST_CHARGE_TIME
