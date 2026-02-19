#define BB_NPC_PATROL_POINT "bb_npc_patrol_point"
#define BB_BASIC_MOB_CUFF_TYPE "bb_cuff_type"
#define BB_BASIC_MOB_DEFAULT_CUFF_TYPE (/obj/item/restraints/handcuffs/cable/zipties/used)

/datum/outfit/trainstation_civilian
	name = "Trainstation civilian"
	uniform = /obj/item/clothing/under/colonial
	shoes = /obj/item/clothing/shoes/jackboots/black
	suit = /obj/item/clothing/suit/discoblazer

	back = /obj/item/storage/backpack/satchel

/datum/outfit/trainstation_civilian/style_1
	name = "Trainstation civilian - 1"
	neck = /obj/item/clothing/neck/large_scarf
	head = /obj/item/clothing/head/costume/ushanka
	suit = /obj/item/clothing/suit/brownfurrich/white

	back = /obj/item/storage/backpack/satchel

/datum/outfit/trainstation_civilian/style_2
	name = "Trainstation civilian - 2"
	neck = /obj/item/clothing/neck/large_scarf/red
	uniform = /obj/item/clothing/under/colonial
	shoes = /obj/item/clothing/shoes/jackboots/black
	suit = /obj/item/clothing/suit/modern_winter

	back = /obj/item/storage/backpack/satchel

/datum/outfit/trainstation_civilian/style_3
	name = "Trainstation civilian - 3"
	neck = /obj/item/clothing/neck/large_scarf/blue
	uniform = /obj/item/clothing/under/colonial
	shoes = /obj/item/clothing/shoes/jackboots/black
	suit = /obj/item/clothing/suit/costume/pg

	back = /obj/item/storage/backpack

/datum/outfit/trainstation_civilian/style_4
	name = "Trainstation civilian - 4"
	glasses = /obj/item/clothing/glasses/hud/ar
	neck = /obj/item/clothing/neck/large_scarf/blue
	uniform = /obj/item/clothing/under/colonial
	shoes = /obj/item/clothing/shoes/jackboots/black
	suit = /obj/item/clothing/suit/jacket/cherno

	back = /obj/item/storage/backpack

/datum/outfit/trainstation_civilian/teshari
	name = "Trainstation civilian(teshari)"
	uniform = /obj/item/clothing/under/suit/black
	shoes = /obj/item/clothing/shoes/jackboots/black

	back = /obj/item/storage/backpack/satchel

/datum/outfit/trainstation_civilian/teshari/style_1
	name = "Trainstation civilian(teshari) - 1"
	suit = /obj/item/clothing/suit/hooded/wintercoat

/datum/outfit/trainstation_civilian/teshari/style_2
	name = "Trainstation civilian(teshari) - 2"
	suit = /obj/item/clothing/suit/hooded/wintercoat/engineering

/datum/outfit/trainstation_civilian/teshari/style_3
	name = "Trainstation civilian(teshari) - 3"
	suit = /obj/item/clothing/suit/hooded/wintercoat/hop

/datum/outfit/trainstation_civilian/teshari/style_4
	name = "Trainstation civilian(teshari) - 4"
	suit = /obj/item/clothing/suit/hooded/wintercoat/medical/coroner

/datum/outfit/trainstation_civilian/teshari/style_5
	name = "Trainstation civilian(teshari) - 5"
	neck = /obj/item/clothing/neck/cloak/herald_cloak

/datum/outfit/trainstation_civilian/teshari/style_6
	name = "Trainstation civilian(teshari) - 6"
	neck = /obj/item/clothing/neck/cloak/rd

/datum/outfit/trainstation_civilian/teshari/style_7
	name = "Trainstation civilian(teshari) - 7"
	neck = /obj/item/clothing/neck/cloak/hos


/datum/outfit/trainstation_civilian/police
	name = "Trainstation police officer"

	head = /obj/item/clothing/head/beret/sec/peacekeeper
	glasses = /obj/item/clothing/glasses/hud/ar/aviator/security
	suit = /obj/item/clothing/suit/hooded/wintercoat/security
	uniform = /obj/item/clothing/under/rank/security/corrections_officer/sweater
	belt = /obj/item/storage/belt/security/webbing/peacekeeper
	gloves = /obj/item/clothing/gloves/color/black/security/blu
	shoes = /obj/item/clothing/shoes/combat/swat

	back = /obj/item/storage/backpack/messenger/blueshield

/datum/outfit/trainstation_civilian/police/alt
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper
	back = /obj/item/storage/backpack/security


/mob/living/basic/npc
	name = "Civilian"
	desc = ""
	icon = 'icons/mob/simple/simple_human.dmi'
	health = 150
	maxHealth = 150
	speed = 1.5
	mob_biotypes = MOB_ORGANIC | MOB_HUMANOID
	basic_mob_flags = FLAMMABLE_MOB | SENDS_DEATH_MOODLETS
	sentience_type = SENTIENCE_HUMANOID
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	melee_damage_lower = 10
	melee_damage_upper = 10
	unsuitable_atmos_damage = 7.5
	unsuitable_cold_damage = 7.5
	unsuitable_heat_damage = 7.5
	max_stamina = 250
	stamina_crit_threshold = BASIC_MOB_NO_STAMCRIT
	stamina_recovery = 5
	max_stamina_slowdown = 12
	faction = list(FACTION_CIVILIAN, FACTION_NEUTRAL)
	ghost_controllable = TRUE

	ai_controller = /datum/ai_controller/basic_controller/civilian

	var/possible_outfits = list()
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

	var/randomize_mutant_colors = FALSE
	var/add_hair = TRUE
	var/mutant_color_1 = COLOR_WHITE
	var/mutant_color_2 = COLOR_WHITE
	var/mutant_color_3 = COLOR_WHITE

	var/anchor_search_range = 5
	var/mapping_anchor = null

	// Боевая часть начинается тут
	var/innate_actions = list()

	var/ranged = FALSE
	var/casingtype = /obj/item/ammo_casing/c9mm
	var/projectilesound = 'sound/items/weapons/gun/pistol/shot.ogg'
	var/burst_shots
	var/ranged_cooldown = 1 SECONDS


/mob/living/basic/npc/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_SHOE)
	AddElement(/datum/element/basic_eating)
	AddElement(/datum/element/ai_retaliate)
	if(randomize_mutant_colors)
		randomize_colors()
	if(make_random_name)
		name = generate_name()
	if(!outfit)
		pick_outfit()
	else if(islist(outfit))
		outfit = pick(outfit)
	gender = pick(MALE, FEMALE)
	INVOKE_ASYNC(src, PROC_REF(generate_dynamic_appearance))
	generate_desc_based_on_species()
	if(mapping_anchor)
		for(var/turf/T in view(anchor_search_range, src))
			var/point = locate(mapping_anchor) in T
			if(!point)
				continue
			ai_controller?.set_blackboard_key(BB_NPC_PATROL_POINT, point)
			break
	if(ranged)
		AddComponent(\
			/datum/component/ranged_attacks,\
			casing_type = casingtype,\
			projectile_sound = projectilesound,\
			cooldown_time = ranged_cooldown,\
			burst_shots = burst_shots,\
		)
		if(ranged_cooldown <= 1 SECONDS)
			AddComponent(/datum/component/ranged_mob_full_auto)

/mob/living/basic/npc/examine(mob/user)
	. = ..()
	if(item_r_hand)
		var/obj/item/I = item_r_hand
		. += span_notice("[I::name] in [p_their()] right hand.")
	if(item_l_hand)
		var/obj/item/I = item_l_hand
		. += span_notice("[I::name] in [p_their()] left hand.")

/mob/living/basic/npc/proc/pick_outfit()
	outfit = pick(possible_outfits)

/mob/living/basic/npc/proc/generate_desc_based_on_species()
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

/mob/living/basic/npc/proc/randomize_colors()
	var/preset = rand(1, 7)
	switch(preset)
		if(1)
			mutant_color_1 = pick("#2F2F2F", "#3D3D3D", "#505050", "#6B6B6B", "#8C8C8C")
			mutant_color_2 = "#C8C8C8"
			mutant_color_3 = "#1A1A1A"

		if(2)
			mutant_color_1 = pick("#C9B8A0", "#B89F7E", "#A67C52", "#D2B48C", "#E0C9A0")
			mutant_color_2 = "#F4E4C9"
			mutant_color_3 = "#5C4633"

		if(3)
			mutant_color_1 = pick("#3F2A1E", "#523B2A", "#664B38", "#8B6647", "#A37F5E")
			mutant_color_2 = "#C9A37A"
			mutant_color_3 = "#2C2118"

		if(4)
			mutant_color_1 = pick("#9F3A1F", "#BF4F22", "#E07035", "#FF9F4F", "#D96F1F")
			mutant_color_2 = "#FFCC99"
			mutant_color_3 = "#5C2F1A"

		if(5)
			mutant_color_1 = pick("#48689E", "#334C7A", "#263B5E", "#6A8A9E", "#7E9EB0")
			mutant_color_2 = "#B0CDE8"
			mutant_color_3 = "#1F2F4A"

		if(6)
			mutant_color_1 = pick("#1E3F2B", "#2A5A3C", "#3A7A52", "#6E9B6E", "#8FBC8F")
			mutant_color_2 = "#A8D4B5"
			mutant_color_3 = "#13261F"

		if(7)
			mutant_color_1 = pick("#3A2A5C", "#4A3A78", "#5F4A96", "#7E6EB8", "#9B79C4")
			mutant_color_2 = "#D4B8F0"
			mutant_color_3 = "#2A1F3F"

	if(prob(40))
		mutant_color_1 = color_interpolate(mutant_color_1, "#FFFFFF", 0.12)
	else if(prob(30))
		mutant_color_1 = color_interpolate(mutant_color_1, "#000000", 0.08)


/mob/living/basic/npc/proc/generate_name()
	return generate_random_name_species_based(gender, TRUE, species)

/mob/living/basic/npc/proc/get_mutant_colors()
	return list(mutant_color_1, mutant_color_2, mutant_color_3)

/mob/living/basic/npc/proc/get_default_features()
	return list()

#define ARGS_FEATURES "mut_features"
#define ARGS_COLORS "mut_colors"
#define ARG_FEATURE "mut_feature"
#define ARG_FEATURE_NAME "mut_feat_name"


/mob/living/basic/npc/proc/generate_dynamic_appearance()
	var/skin_tone = pick(GLOB.skin_tones)
	var/eye_color = random_eye_color()
	var/hair_color = random_hair_color()
	var/list/features = list(ARGS_FEATURES = get_default_features(),ARGS_COLORS = get_mutant_colors())
	var/dynamic_appearance = null

	// Создаем динмаичный sвнешний вид
	var/mob/living/carbon/human/dummy/dummy = new()
	dummy.set_species(species)
	dummy.stat = DEAD
	dummy.underwear = "Nude"
	dummy.undershirt = "Nude"
	dummy.socks = "Nude"
	dummy.bra = "Nude"
	dummy.set_combat_mode(combat_mode)
	dummy.set_eye_color(eye_color)
	if(species == /datum/species/human)
		dummy.physique = gender
		dummy.skin_tone = skin_tone
	if(add_hair)
		var/datum/sprite_accessory/hairstyle = SSaccessories.hairstyles_list[random_hairstyle(gender)]
		if(hairstyle && hairstyle.natural_spawn && !hairstyle.locked)
			dummy.set_hairstyle(hairstyle.name, update = FALSE)
		dummy.set_haircolor(hair_color, update = FALSE)
		dummy.updateappearance(TRUE, FALSE, FALSE)
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
	dummy.dna.features[FEATURE_MUTANT_COLOR_TWO] = features[ARGS_COLORS][2]
	dummy.dna.features[FEATURE_MUTANT_COLOR_THREE] = features[ARGS_COLORS][3]
	dummy.dna.species.regenerate_organs(dummy, dummy.dna.species, visual_only = TRUE)
	dummy.update_body(TRUE)
	dummy.update_held_items()
	dynamic_appearance = dummy.appearance
	icon = 'icons/mob/human/human.dmi'
	icon_state = ""
	appearance_flags |= KEEP_TOGETHER
	copy_overlays(dynamic_appearance, cut_old = TRUE)
	qdel(dummy)

/mob/living/basic/npc/civilian
	name = "Civilian"
	possible_outfits = list(
		/datum/outfit/trainstation_civilian,
		/datum/outfit/trainstation_civilian/style_1,
		/datum/outfit/trainstation_civilian/style_2,
		/datum/outfit/trainstation_civilian/style_3,
		/datum/outfit/trainstation_civilian/style_4,
	)

/mob/living/basic/npc/civilian/human
	species = /datum/species/human

/mob/living/basic/npc/civilian/teshari
	species = /datum/species/teshari
	mob_type = /obj/effect/mob_spawn/corpse/human
	add_hair = FALSE
	randomize_mutant_colors = TRUE
	possible_outfits = list(
		/datum/outfit/trainstation_civilian/teshari,
		/datum/outfit/trainstation_civilian/teshari/style_1,
		/datum/outfit/trainstation_civilian/teshari/style_2,
		/datum/outfit/trainstation_civilian/teshari/style_3,
		/datum/outfit/trainstation_civilian/teshari/style_4,
		/datum/outfit/trainstation_civilian/teshari/style_5,
		/datum/outfit/trainstation_civilian/teshari/style_6,
		/datum/outfit/trainstation_civilian/teshari/style_7,
	)


/mob/living/basic/npc/civilian/teshari/get_default_features()
	return list(
		list(ARG_FEATURE = FEATURE_EARS, ARG_FEATURE_NAME = "Teshari Feathers Upright"),
		list(ARG_FEATURE = FEATURE_TAIL_GENERIC, ARG_FEATURE_NAME = "Teshari (Default)")
	)

/mob/living/basic/npc/civilian/vulpkanin
	species = /datum/species/vulpkanin
	randomize_mutant_colors = TRUE

/mob/living/basic/npc/civilian/tajaran
	species = /datum/species/tajaran
	randomize_mutant_colors = TRUE

/mob/living/basic/npc/civilian/lizard
	species = /datum/species/lizard
	randomize_mutant_colors = TRUE

#undef ARGS_FEATURES
#undef ARGS_COLORS
#undef ARG_FEATURE
#undef ARG_FEATURE_NAME

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
		/datum/ai_planning_subtree/clean_target_timed/flee_from,
		/datum/ai_planning_subtree/target_retaliate/to_flee,
		/datum/ai_planning_subtree/call_for_help/from_flee_key,
		/datum/ai_planning_subtree/flee_target/from_flee_key,
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
	var/speak = TRUE
	var/list/speak_help = list("Help!", "I was attacked!")

/datum/ai_planning_subtree/call_for_help/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/atom/attacker = controller.blackboard[target_key]
	var/mob/living/pawn = controller.pawn
	if(!attacker)
		return
	if(is_allie(attacker, pawn, faction_to_check = call_for_faction))
		return
	if(speak)
		controller.queue_behavior(/datum/ai_behavior/perform_speech, pick(speak_help))
	for(var/mob/living/basic/saver in view(search_range, pawn))
		if(is_allie(saver, pawn, faction_to_check = call_for_faction))
			saver?.ai_controller?.set_blackboard_key(set_key, attacker)

/datum/ai_planning_subtree/call_for_help/proc/is_allie(mob/living/target, mob/living/pawn, faction_to_check)
	if(faction_check(target.faction, faction_to_check))
		return TRUE
	if(target.faction_check_atom(target))
		return TRUE
	return FALSE

/datum/ai_planning_subtree/call_for_help/from_flee_key
	target_key = BB_BASIC_MOB_FLEE_TARGET


/**
 * NPC - полицейские
 */


/obj/effect/landmark/police_patrol_point
	name = "Police patrol point"

/mob/living/basic/npc/police
	name = "Police officer"
	health = 250
	maxHealth = 250
	faction = list(FACTION_CIVILIAN, FACTION_POLICE, FACTION_NEUTRAL)
	melee_damage_lower = 15
	melee_damage_upper = 30
	melee_damage_type = STAMINA

	ai_controller = /datum/ai_controller/basic_controller/npc_police
	mapping_anchor = /obj/effect/landmark/police_patrol_point

	possible_outfits = list(
		/datum/outfit/trainstation_civilian/police,
		/datum/outfit/trainstation_civilian/police/alt,
	)

/mob/living/basic/npc/police/generate_name()
	var/static/ranks = list(
		"Officer",
		"Corporal",
		"Sergeant",
		"Lieutenant",
	)
	var/base = ..()
	return "[pick(ranks)] [base]"


/datum/ai_controller/basic_controller/npc_police
	blackboard = list(
		BB_TARGET_MINIMUM_STAT = SOFT_CRIT,
		BB_BASIC_MOB_FLEE_DISTANCE = 5,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_CUFF_TYPE = /obj/item/restraints/handcuffs/cable/zipties/used,
		BB_NPC_PATROL_POINT = null,
	)
	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/walk_near_target/patrol_point

	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/clean_target_timed,
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/call_for_help/no_talk,
		/datum/ai_planning_subtree/random_speech/civilian,
		/datum/ai_planning_subtree/return_to_point/patrol_point,
		/datum/ai_planning_subtree/cuff_if_downed,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/datum/idle_behavior/walk_near_target/patrol_point
	target_key = BB_NPC_PATROL_POINT
	walk_chance = 50
	minimum_distance = 5

/datum/ai_planning_subtree/call_for_help/no_talk
	speak = FALSE

/datum/ai_planning_subtree/return_to_point
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/minimum_distance = 10
	var/stop_chase = TRUE

/datum/ai_planning_subtree/return_to_point/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	var/atom/current_target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(current_target && !stop_chase)
		return
	var/atom/return_to = controller.blackboard[target_key]
	if(!return_to)
		return
	if(get_dist(return_to, pawn) < minimum_distance)
		return
	controller.queue_behavior(/datum/ai_behavior/travel_towards_atom, return_to)

/datum/ai_planning_subtree/return_to_point/patrol_point
	target_key = BB_NPC_PATROL_POINT

#define BB_MEMORY_LAST_TARGET "bb_memo_last_target"
#define BB_MEMORY_LAST_TARGET_TIME "bb_memo_last_target_time"

/datum/ai_planning_subtree/clean_target_timed
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/target_time = 15 SECONDS

/datum/ai_planning_subtree/clean_target_timed/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/target = controller.blackboard[target_key]
	if(!target)
		return
	if(target != controller.blackboard[BB_MEMORY_LAST_TARGET])
		controller.set_blackboard_key(BB_MEMORY_LAST_TARGET, target)
		controller.set_blackboard_key(BB_MEMORY_LAST_TARGET_TIME, world.time)
		return
	else if(world.time >= controller.blackboard[BB_MEMORY_LAST_TARGET_TIME] + target_time)
		controller.clear_blackboard_key(target_key)
		controller.clear_blackboard_key(BB_MEMORY_LAST_TARGET)
		controller.clear_blackboard_key(BB_MEMORY_LAST_TARGET_TIME)

#undef BB_MEMORY_LAST_TARGET
#undef BB_MEMORY_LAST_TARGET_TIME

#define BB_BASIC_MOB_BEGIN_CUFFING "bb_begin_cuffing"

/datum/ai_planning_subtree/cuff_if_downed
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/cuff_time = 5 SECONDS
	var/clear_target = TRUE

/datum/ai_planning_subtree/cuff_if_downed/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	var/atom/target = controller.blackboard[target_key]
	if(!target || !iscarbon(target))
		return
	if(controller.blackboard[BB_BASIC_MOB_BEGIN_CUFFING])
		return
	var/mob/living/carbon/carbon_target = target
	if(carbon_target.handcuffed)
		if(clear_target)
			controller.clear_blackboard_key(target_key)
		return
	if(!carbon_target.canBeHandcuffed())
		return
	if(!(carbon_target.staminaloss >= carbon_target.max_stamina))
		return
	if(get_dist(pawn, carbon_target) > 1)
		return
	var/cuff_type = controller.blackboard[BB_BASIC_MOB_CUFF_TYPE] || BB_BASIC_MOB_DEFAULT_CUFF_TYPE
	controller.queue_behavior(/datum/ai_behavior/zipties_target, target_key, cuff_type, cuff_time, clear_target)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_behavior/zipties_target

/datum/ai_behavior/zipties_target/perform(seconds_per_tick, datum/ai_controller/controller, target_key, cuff_type, cuff_time, clear_target)
	var/mob/living/pawn = controller.pawn
	var/mob/living/carbon/carbon_target = controller.blackboard[target_key]
	if(!carbon_target || (get_dist(pawn, carbon_target) > 1))
		return FALSE
	if(controller.blackboard[BB_BASIC_MOB_BEGIN_CUFFING])
		return FALSE
	controller.set_blackboard_key(BB_BASIC_MOB_BEGIN_CUFFING, TRUE)
	to_chat(carbon_target, span_userdanger("[pawn] is trying to put zipties on you!"))
	pawn.visible_message(span_danger("[pawn] is trying to put zipties on [carbon_target]!"))
	// Начинаем сковывать цель
	if(!do_after(pawn, cuff_time, pawn))
		return FALSE
	controller.clear_blackboard_key(BB_BASIC_MOB_BEGIN_CUFFING)
	carbon_target.set_handcuffed(new cuff_type(carbon_target))
	if(clear_target)
		controller.clear_blackboard_key(target_key)
	return TRUE

#undef BB_BASIC_MOB_BEGIN_CUFFING

/datum/ai_planning_subtree/clean_target_timed/flee_from
	target_key = BB_BASIC_MOB_FLEE_TARGET

/datum/ai_planning_subtree/flee_target/if_to_close
	var/maximum_distance = 2

/datum/ai_planning_subtree/flee_target/if_to_close/should_flee(datum/ai_controller/controller, atom/flee_from)
	if(get_dist(controller.pawn, flee_from) > maximum_distance)
		return FALSE
	return ..()

/mob/living/basic/npc/police/baton
	attack_sound = 'sound/items/weapons/egloves.ogg'
	item_r_hand = /obj/item/melee/baton/security
	melee_damage_lower = 40
	melee_damage_upper = 40
	melee_attack_cooldown = 3 SECONDS

/mob/living/basic/npc/police/baton/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	do_sparks(1, TRUE, src)

/mob/living/basic/npc/police/disabler
	attack_sound = 'sound/items/weapons/egloves.ogg'
	melee_damage_lower = 40
	melee_damage_upper = 40
	melee_attack_cooldown = 3 SECONDS
	ai_controller = /datum/ai_controller/basic_controller/npc_police/ranged

	ranged = TRUE
	item_r_hand = /obj/item/gun/energy/disabler
	casingtype = /obj/projectile/beam/disabler
	projectilesound = 'sound/items/weapons/taser2.ogg'
	burst_shots = 2

/datum/ai_controller/basic_controller/npc_police/ranged
	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/walk_near_target/patrol_point

	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/clean_target_timed,
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/call_for_help/no_talk,
		/datum/ai_planning_subtree/random_speech/civilian,
		/datum/ai_planning_subtree/return_to_point/patrol_point,
		/datum/ai_planning_subtree/flee_target/if_to_close,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree,
	)
