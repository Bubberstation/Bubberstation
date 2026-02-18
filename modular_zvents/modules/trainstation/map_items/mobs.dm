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


/mob/living/basic/civilian
	name = "Civilian"
	desc = ""
	icon = 'icons/mob/simple/simple_human.dmi'
	health = 150
	maxHealth = 150
	speed = 1.5
	mob_biotypes = MOB_ORGANIC | MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	melee_damage_lower = 10
	melee_damage_upper = 10
	unsuitable_atmos_damage = 7.5
	unsuitable_cold_damage = 7.5
	unsuitable_heat_damage = 7.5
	max_stamina = 250
	stamina_crit_threshold = BASIC_MOB_NO_STAMCRIT
	stamina_recovery = 5
	max_stamina_slowdown = 12
	faction = list(FACTION_NEUTRAL, FACTION_CIVILIAN)


	ai_controller = /datum/ai_controller/basic_controller/civilian
	// Аутфит, что будет одет на моба
	var/outfit
	// Раса которой будет  этот человек
	var/species = /datum/species/human
	// Особый вид моба, которым будет этот человек
	var/mob_type = /obj/effect/mob_spawn/corpse/human
	// Предмет в левой руке
	var/item_l_hand
	// Предмет в правой руке
	var/item_r_hand
	// Должен ли этот моб звать на помощь при атаке
	var/call_for_help = TRUE
	// Нужно ли создавать этому мобу случайное имя
	var/make_random_name = TRUE


	var/mutant_color_1 = COLOR_WHITE
	var/mutant_color_2 = COLOR_WHITE
	var/mutant_color_3 = COLOR_WHITE

/mob/living/basic/civilian/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_SHOE)
	AddElement(/datum/element/basic_eating)
	AddElement(/datum/element/ai_retaliate)
	generate_dynamic_appearance()
	if(make_random_name)
		name = generate_random_name_species_based(gender, TRUE, species)
	generate_desc_based_on_species()

/mob/living/basic/civilian/proc/generate_desc_based_on_species()
	switch(species)
		if(/datum/species/human)
			desc = "A regular human civilian. Nothing particularly stands out about them."

		if(/datum/species/teshari)
			desc = "A small, feathered raptor known as a teshari. Lightweight, quick, and covered in soft plumage — a rare sight among civilians."

		if(/datum/species/vulpkanin)
			desc = "A furred vulpkanin with expressive ears and a bushy tail. This canine-like civilian has keen senses and an alert posture."

		if(/datum/species/tajaran)
			desc = "A feline tajaran with soft fur, expressive ears, and a swaying tail. Their sharp eyes scan the surroundings with quiet curiosity."

		if(/datum/species/lizard)
			desc = "A scaled lizardperson with a proud posture and a flicking tail. Their tough hide and sharp features mark them as a hardy civilian."

		else
			var/datum/species/path = species
			desc = "A civilian of unusual species. [path ? "([path::name])" : "Unknown race."]"
	if(prob(30))
		desc += pick(" They seem a bit lost.", " They look tired from the long shift.", " They're quietly humming something.", " A faint smell of [pick("coffee","machine oil","fish","wet fur")] lingers around them.")

/mob/living/basic/civilian/proc/get_mutant_colors()
	return list(mutant_color_1, mutant_color_2, mutant_color_3)

/mob/living/basic/civilian/proc/get_default_features()
	return list()

#define ARGS_FEATURES "mut_features"
#define ARGS_COLORS "mut_colors"
#define ARG_FEATURE "mut_feature"
#define ARG_FEATURE_NAME "mut_feat_name"

/mob/living/basic/civilian/proc/generate_dynamic_appearance()
	var/list/features = list(ARGS_FEATURES = get_default_features(), ARGS_COLORS = get_mutant_colors())
	var/string_features = list2params(features)
	var/static/list/saved_appaerances = list()
	var/dynamic_appearance = null
	if(saved_appaerances[string_features])
		dynamic_appearance = saved_appaerances[string_features]
	else
		// Создаем динмаичный внешний вид
		var/mob/living/carbon/human/dummy/consistent/dummy = new()
		dummy.set_species(species)
		dummy.stat = DEAD
		dummy.underwear = "Nude"
		dummy.undershirt = "Nude"
		dummy.socks = "Nude"
		dummy.bra = "Nude"
		dummy.set_combat_mode(combat_mode)
		if(outfit)
			var/datum/outfit/dummy_outfit = new outfit()
			if(item_r_hand != NO_REPLACE)
				dummy_outfit.r_hand = item_r_hand
			if(item_l_hand != NO_REPLACE)
				dummy_outfit.l_hand = item_l_hand
			dummy.equipOutfit(dummy_outfit, visuals_only = TRUE)
		else if(mob_type)
			var/obj/effect/mob_spawn/spawner = new mob_type(null, TRUE)
			spawner.outfit_override = list()
			if(item_r_hand != NO_REPLACE)
				spawner.outfit_override["r_hand"] = item_r_hand
			if(item_l_hand != NO_REPLACE)
				spawner.outfit_override["l_hand"] = item_l_hand
			spawner.special(dummy, dummy)
			spawner.equip(dummy)
		for(var/obj/item/carried_item in dummy)
			if(dummy.is_holding(carried_item))
				var/datum/component/two_handed/twohanded = carried_item.GetComponent(/datum/component/two_handed)
				if(twohanded)
					twohanded.wield(dummy)
				var/datum/component/transforming/transforming = carried_item.GetComponent(/datum/component/transforming)
				if(transforming)
					transforming.set_active(carried_item)
		if(length(features[ARGS_FEATURES]))
			for(var/list/special in features[ARGS_FEATURES])
				dummy.dna.mutant_bodyparts[special[ARG_FEATURE]] = list(
					MUTANT_INDEX_NAME = special[ARG_FEATURE_NAME],
					MUTANT_INDEX_COLOR_LIST = features[ARGS_COLORS],
				)
		dummy.dna.features[FEATURE_MUTANT_COLOR] = features[ARGS_COLORS][1]
		dummy.dna.species.regenerate_organs(dummy, dummy.dna.species, visual_only = TRUE)
		dummy.update_body(TRUE)
		dummy.update_held_items()
		var/mutable_appearance/output = dummy.appearance
		saved_appaerances[string_features] = output
		qdel(dummy)
	icon = 'icons/mob/human/human.dmi'
	icon_state = ""
	appearance_flags |= KEEP_TOGETHER
	copy_overlays(dynamic_appearance, cut_old = TRUE)

/mob/living/basic/civilian/human
	species = /datum/species/human

/mob/living/basic/civilian/teshari
	species = /datum/species/teshari
	mob_type = /obj/effect/mob_spawn/corpse/human

/mob/living/basic/civilian/teshari/get_default_features()
	return list(
		list(ARG_FEATURE = FEATURE_EARS, ARG_FEATURE_NAME = "Teshari Feathers Upright"),
		list(ARG_FEATURE = FEATURE_TAIL_GENERIC, ARG_FEATURE_NAME = "Teshari (Default)")
	)

/mob/living/basic/civilian/vulpkanin
	species = /datum/species/vulpkanin

/mob/living/basic/civilian/tajaran
	species = /datum/species/tajaran

/mob/living/basic/civilian/lizard
	species = /datum/species/lizard

#undef ARGS_FEATURES
#undef ARGS_COLORS
#undef ARG_FEATURE


/datum/ai_controller/basic_controller/civilian
	blackboard = list(
		BB_ALWAYS_IGNORE_FACTION = TRUE,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_FLEE_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk

	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/target_retaliate/to_flee,
		/datum/ai_planning_subtree/flee_target/from_flee_key,
		/datum/ai_planning_subtree/call_for_help/from_flee_key,
		/datum/ai_planning_subtree/random_speech/civilian,
	)

/datum/ai_planning_subtree/random_speech/civilian
	speech_chance = 20
	speak = list("Hello %MOBNAME%!", "How it's going %MOBNAME%", "Be careful at stations...")
	emote_see = list("shakes.", "shakes his head.", "looks around.")
	emote_hear = list("mumbles something under his breath.")


/datum/ai_planning_subtree/random_speech/civilian/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/basic/pawn = controller.pawn
	if(!pawn)
		return
	if(!SPT_PROB(speech_chance, seconds_per_tick))
		return
	var/audible_emotes_length = emote_hear?.len
	var/non_audible_emotes_length = emote_see?.len
	var/speak_lines_length = speak?.len

	var/total_choices_length = audible_emotes_length + non_audible_emotes_length + speak_lines_length

	if (total_choices_length == 0)
		return

	var/random_number_in_range = rand(1, total_choices_length)
	var/sound_to_play = length(sound) > 0 ? pick(sound) : null

	if(random_number_in_range <= audible_emotes_length)
		controller.queue_behavior(/datum/ai_behavior/perform_emote, pick(emote_hear), sound_to_play)
	else if(random_number_in_range <= (audible_emotes_length + non_audible_emotes_length))
		controller.queue_behavior(/datum/ai_behavior/perform_emote, pick(emote_see))
	else
		for(var/mob/living/carbon/human/H in view(5, pawn))
			if(H.stat == CONSCIOUS && !H.alpha == 0 && H.client)
				var/phrase = pick(speak)
				phrase = replacetext(phrase, "%MOBNAME%", H.name)
				controller.queue_behavior(/datum/ai_behavior/perform_speech, phrase, sound_to_play)
				break

/datum/ai_planning_subtree/call_for_help
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/set_key = BB_BASIC_MOB_CURRENT_TARGET
	var/call_for_faction = list(FACTION_POLICE)
	var/search_range = 9
	var/list/speak_help = list("Help!", "I was attacked!")

/datum/ai_planning_subtree/call_for_help/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/atom/attacker = controller.blackboard[target_key]
	var/mob/living/pawn = controller.pawn
	if(!attacker)
		return
	controller.queue_behavior(/datum/ai_behavior/perform_speech, pick(speak_help), null)
	for(var/mob/living/basic/saver in view(search_range, pawn))
		if(is_allie(saver, pawn, faction_to_check = call_for_faction))
			saver?.ai_controller?.set_blackboard_key(set_key, attacker)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_planning_subtree/call_for_help/proc/is_allie(mob/living/target, mob/living/pawn, faction_to_check)
	if(faction_check(target.faction, faction_to_check))
		return TRUE
	if(target.faction_check_atom(target))
		return TRUE
	return FALSE

/datum/ai_planning_subtree/call_for_help/from_flee_key
	target_key = BB_BASIC_MOB_FLEE_TARGET


