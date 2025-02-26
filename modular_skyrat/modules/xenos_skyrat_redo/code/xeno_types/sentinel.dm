/// SKYRAT MODULE SKYRAT_XENO_REDO

/mob/living/carbon/alien/adult/skyrat/sentinel
	name = "alien sentinel"
	desc = "An alien that'd be unremarkable if not for the bright coloring and visible acid glands that cover it."
	caste = "sentinel"
	maxHealth = 200
	health = 200
	icon_state = "aliensentinel"
	melee_damage_lower = 10
	melee_damage_upper = 15
	next_evolution = /mob/living/carbon/alien/adult/skyrat/spitter

/mob/living/carbon/alien/adult/skyrat/sentinel/Initialize(mapload)
	. = ..()

	add_movespeed_modifier(/datum/movespeed_modifier/alien_slow)

/mob/living/carbon/alien/adult/skyrat/sentinel/create_internal_organs()
	organs += new /obj/item/organ/alien/plasmavessel/small
	organs += new /obj/item/organ/alien/neurotoxin/sentinel
	..()

/datum/action/cooldown/alien/acid/skyrat
	name = "Spit Neurotoxin"
	desc = "Spits neurotoxin at someone, exhausting them."
	button_icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
	button_icon_state = "neurospit_0"
	plasma_cost = 40
	/// A singular projectile? Use this one and leave acid_casing null
	var/acid_projectile = /obj/projectile/neurotoxin/skyrat
	/// You want it to be more like a shotgun style attack? Use this one and make acid_projectile null
	var/acid_casing
	/// Used in to_chat messages to the owner
	var/projectile_name = "neurotoxin"
	/// The base icon for the ability, so a red box can be put on it using _0 or _1
	var/button_base_icon = "neurospit"
	/// The sound that should be played when the xeno actually spits
	var/spit_sound = 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_spitacid.ogg'
	shared_cooldown = MOB_SHARED_COOLDOWN_3
	cooldown_time = 5 SECONDS

/datum/action/cooldown/alien/acid/skyrat/IsAvailable(feedback = FALSE)
	return ..() && isturf(owner.loc)

/datum/action/cooldown/alien/acid/skyrat/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_notice("You prepare your [projectile_name] gland. <B>Left-click to fire at a target!</B>"))

	button_icon_state = "[button_base_icon]_1"
	build_all_button_icons()
	on_who.update_icons()

/datum/action/cooldown/alien/acid/skyrat/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	if(refund_cooldown)
		to_chat(on_who, span_notice("You empty your [projectile_name] gland."))

	button_icon_state = "[button_base_icon]_0"
	build_all_button_icons()
	on_who.update_icons()

/datum/action/cooldown/alien/acid/skyrat/InterceptClickOn(mob/living/clicker, params, atom/target)
	. = ..()
	if(!.)
		unset_click_ability(clicker, refund_cooldown = FALSE)
		return FALSE

	var/turf/user_turf = clicker.loc
	var/turf/target_turf = get_step(clicker, target.dir)
	if(!isturf(target_turf))
		return FALSE

	var/modifiers = params2list(params)
	clicker.visible_message(
		span_danger("[clicker] spits [projectile_name]!"),
		span_alertalien("You spit [projectile_name]."),
	)

	if(acid_projectile)
		var/obj/projectile/spit_projectile = new acid_projectile(clicker.loc)
		spit_projectile.aim_projectile(target, clicker, modifiers)
		spit_projectile.firer = clicker
		spit_projectile.fire()
		playsound(clicker, spit_sound, 100, TRUE, 5, 0.9)
		clicker.newtonian_move(get_dir(target_turf, user_turf))
		return TRUE

	if(acid_casing)
		var/obj/item/ammo_casing/casing = new acid_casing(clicker.loc)
		playsound(clicker, spit_sound, 100, TRUE, 5, 0.9)
		casing.fire_casing(target, clicker, null, null, null, ran_zone(), 0, clicker)
		clicker.newtonian_move(get_dir(target_turf, user_turf))
		return TRUE

	CRASH("Neither acid_projectile or acid_casing are set on [clicker]'s spit attack!")

/datum/action/cooldown/alien/acid/skyrat/Activate(atom/target)
	return TRUE

/obj/projectile/neurotoxin/skyrat
	name = "neurotoxin spit"
	icon_state = "neurotoxin"
	damage = 30
	paralyze = 0
	damage_type = STAMINA
	armor_flag = BIO

/obj/projectile/neurotoxin/on_hit(atom/target, blocked = 0, pierce_hit)
	if(isalien(target))
		damage = 0
	return ..()

/datum/action/cooldown/alien/acid/skyrat/lethal
	name = "Spit Acid"
	desc = "Spits neurotoxin at someone, burning them."
	acid_projectile = /obj/projectile/neurotoxin/skyrat/acid
	button_icon_state = "acidspit_0"
	projectile_name = "acid"
	button_base_icon = "acidspit"

/obj/projectile/neurotoxin/skyrat/acid
	name = "acid spit"
	icon_state = "toxin"
	damage = 20
	paralyze = 0
	damage_type = BURN

/obj/item/organ/alien/neurotoxin/sentinel
	name = "neurotoxin gland"
	icon_state = "neurotox"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_XENO_NEUROTOXINGLAND
	actions_types = list(
		/datum/action/cooldown/alien/acid/skyrat,
		/datum/action/cooldown/alien/acid/skyrat/lethal,
	)
