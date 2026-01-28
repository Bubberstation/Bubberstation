/mob/living/basic/flesh_mutant_spider
	name = "flesh spider"
	desc = "A odd fleshy creature in the shape of a spider. Its eyes are pitch black and soulless."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "flesh"
	icon_living = "flesh"
	icon_dead = "flesh_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	speak_emote = list("chitters")
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	damage_coeff = list(BRUTE = 1, BURN = 1.5, TOX = 4, STAMINA = 1, OXY = 1)
	basic_mob_flags = FLAMMABLE_MOB
	status_flags = NONE
	speed = 1
	maxHealth = 250
	health = 250
	armour_penetration = 20
	melee_damage_lower = 15
	melee_damage_upper = 30
	obj_damage = 50
	melee_attack_cooldown = CLICK_CD_MELEE
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	unsuitable_cold_damage = 4
	unsuitable_heat_damage = 4
	combat_mode = TRUE
	faction = list(FACTION_HOSTILE)
	pass_flags = PASSTABLE
	unique_name = TRUE
	lighting_cutoff_red = 22
	lighting_cutoff_green = 5
	lighting_cutoff_blue = 5
	butcher_results = list(/obj/item/food/meat/slab/spider = 2, /obj/item/food/spiderleg = 8)
	ai_controller = /datum/ai_controller/basic_controller/giant_spider
	max_stamina = 250
	stamina_crit_threshold = BASIC_MOB_NO_STAMCRIT
	stamina_recovery = 5
	max_stamina_slowdown = 12

/mob/living/basic/flesh_spider/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_WEB_SURFER, INNATE_TRAIT)
	AddElement(/datum/element/cliff_walking)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_CLAW)
	AddElement(/datum/element/venomous, /datum/reagent/toxin/hunterspider, 5, injection_flags = INJECT_CHECK_PENETRATE_THICK)
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/fast_web)
	AddElement(/datum/element/nerfed_pulling, GLOB.typecache_general_bad_things_to_easily_move)
	AddElement(/datum/element/prevent_attacking_of_types, GLOB.typecache_general_bad_hostile_attack_targets, "this tastes awful!")
	AddComponent(\
		/datum/component/blood_walk,\
		blood_type = /obj/effect/decal/cleanable/blood/bubblegum,\
		blood_spawn_chance = 15,\
	)
	AddComponent(\
		/datum/component/regenerator,\
		regeneration_delay = 4 SECONDS,\
		brute_per_second = maxHealth / 25,\
		outline_colour = COLOR_PINK,\
	)

	var/static/list/innate_actions = list(/datum/action/cooldown/mob_cooldown/boss_bone_shard = null)
	grant_actions_by_list(innate_actions)
	apply_wibbly_filters(src)

/mob/living/basic/flesh_mutant_spider/death(gibbed)
	. = ..()
	inflate_gib()

/mob/living/basic/flesh_mutant_spider/gib()
	for(var/turf/blood_turf in view(src, 2))
		new /obj/effect/decal/cleanable/blood(blood_turf)
		for(var/mob/living/mob_in_turf in blood_turf)
			mob_in_turf.visible_message(span_danger("[mob_in_turf] is splattered with blood!"), span_userdanger("You're splattered with blood!"))
			mob_in_turf.add_blood_DNA(list("Non-human DNA" = random_human_blood_type()))
			playsound(mob_in_turf, 'sound/effects/splat.ogg', 50, TRUE, extrarange = SILENCED_SOUND_EXTRARANGE)
	return ..()

/mob/living/basic/flesh_mutant_spider/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced, filterproof, message_range, datum/saymode/saymode, list/message_mods)
	visible_message(span_warning("[src] lets out a guttural chittering sound."))
	return



/obj/effect/mob_spawn/ghost_role/flesh_spider
	name = "Flesh cocoon"
	desc = "A large pulsating plant..."
	icon = 'icons/mob/simple/meteor_heart.dmi'
	icon_state = "flesh_pod"
	mob_type = /mob/living/basic/flesh_mutant_spider
	density = FALSE
	uses = 1
	deletes_on_zero_uses_left = FALSE
	prompt_name = "venus human trap"
	you_are_text = "You are a flesh-blood spider."
	flavour_text = "You are a flesh-blood spider!  Protect your nest at all costs, and feast on those who oppose you!"
	important_text = "Do not left your nest in any circumstance!"
	faction = list(FACTION_HOSTILE)
	light_range = 2
	light_power = 3

/obj/effect/mob_spawn/ghost_role/flesh_spider/Initialize(mapload)
	. = ..()
	set_light(light_range, light_power, LIGHT_COLOR_FLARE)

/obj/effect/mob_spawn/ghost_role/flesh_spider/pre_ghost_take(mob/dead/observer/user)
	icon_state = "flesh_pod_open"
	for(var/turf/blood_turf in view(src, 2))
		new /obj/effect/decal/cleanable/blood(blood_turf)
		for(var/mob/living/mob_in_turf in blood_turf)
			mob_in_turf.visible_message(span_danger("[mob_in_turf] is splattered with blood!"), span_userdanger("You're splattered with blood!"))
			mob_in_turf.add_blood_DNA(list("Non-human DNA" = random_human_blood_type()))
			playsound(mob_in_turf, 'sound/effects/splat.ogg', 50, TRUE, extrarange = SILENCED_SOUND_EXTRARANGE)
	return ..()

/mob/living/basic/corrupted_arachnid
	name = "Corrupted arachnid"
	desc = "Though physically imposing, it prefers to ambush its prey, and it will only engage with an already crippled opponent."
	icon = 'icons/mob/simple/jungle/arachnid.dmi'
	icon_state = "arachnid"
	icon_living = "arachnid"
	icon_dead = "arachnid_dead"
	color = COLOR_RED
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	armour_penetration = 50
	melee_damage_lower = 25
	melee_damage_upper = 35
	melee_attack_cooldown = CLICK_CD_MELEE
	maxHealth = 300
	health = 300

	pixel_x = -16
	base_pixel_x = -16

	habitable_atmos = null
	faction = list(FACTION_HOSTILE)
	obj_damage = 50
	minimum_survivable_temperature = T0C
	maximum_survivable_temperature = T0C + 450
	status_flags = CANSTUN
	lighting_cutoff_red = 5
	lighting_cutoff_green = 20
	lighting_cutoff_blue = 25
	mob_size = MOB_SIZE_LARGE

	speak_emote = list("chitters")
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	ai_controller = /datum/ai_controller/basic_controller/mega_arachnid


/mob/living/basic/corrupted_arachnid/Initialize(mapload)
	. = ..()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/mob_cooldown/secrete_acid = BB_ARACHNID_SLIP,
		/datum/action/cooldown/spell/pointed/projectile/flesh_restraints = BB_ARACHNID_RESTRAIN,
		/datum/action/cooldown/mob_cooldown/boss_leap = null,
	)
	grant_actions_by_list(innate_actions)
	AddComponent(/datum/component/seethrough_mob)
	AddComponent(/datum/component/tree_climber, climbing_distance = 15)
	AddComponent(\
		/datum/component/regenerator,\
		regeneration_delay = 10 SECONDS,\
		brute_per_second = maxHealth / 30,\
		outline_colour = COLOR_PINK,\
	)
	apply_wibbly_filters(src)


/mob/living/basic/corrupted_arachnid/death(gibbed)
	inflate_gib()
	. = ..()

/mob/living/basic/corrupted_arachnid/gib()
	for(var/turf/blood_turf in view(src, 4))
		new /obj/effect/decal/cleanable/blood(blood_turf)
		for(var/mob/living/mob_in_turf in blood_turf)
			mob_in_turf.visible_message(span_danger("[mob_in_turf] is splattered with blood!"), span_userdanger("You're splattered with blood!"))
			mob_in_turf.add_blood_DNA(list("Non-human DNA" = random_human_blood_type()))
			playsound(mob_in_turf, 'sound/effects/splat.ogg', 50, TRUE, extrarange = SILENCED_SOUND_EXTRARANGE)
	return ..()
