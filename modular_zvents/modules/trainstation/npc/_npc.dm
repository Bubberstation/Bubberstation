/proc/is_npc(thing)
	return istype(thing, /mob/living/basic/npc)

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
	var/outfit
	var/species = /datum/species/human
	var/mob_type = /obj/effect/mob_spawn/corpse/human
	var/item_l_hand
	var/item_r_hand
	var/call_for_help = TRUE
	var/make_random_name = TRUE

	var/randomize_mutant_colors = FALSE
	var/add_hair = TRUE
	var/mutant_color_1 = COLOR_WHITE
	var/mutant_color_2 = COLOR_WHITE
	var/mutant_color_3 = COLOR_WHITE

	var/anchor_search_range = 5
	var/mapping_anchor = null

	var/innate_actions = list()

	var/ranged = FALSE
	var/casingtype = /obj/item/ammo_casing/c9mm
	var/projectilesound = 'sound/items/weapons/gun/pistol/shot.ogg'
	var/burst_shots
	var/ranged_cooldown = 1 SECONDS


	var/speech_chance = 20
	var/list/speech_phrases = list(
		"Quiet… the walls are listening.",
		"Sirens all night again…",
		"Never believe the announcements.",
		"%MOBNAME%, are you coughing too?",
		"They say it'll be over soon…",
		"I forgot what clean air smells like.",
		"They took someone again last night.",
		"Dont go near the checkpoint without a mask.",
		"Yesterday there was a neighbor… today — gone.",
		"Everythings under control, right? Heh…",
		"Another lockdowns coming, I can feel it.",
		"My eyes hurt… that dust again.",
		"Anyone seen the sun without filters?",
		"Dont ask where this scar came from.",
		"Just stay away from the news."
	)

	var/list/speech_emote_see = list(
		"nervously looks around.",
		"presses a hand to their mouth and coughs.",
		"flinches at a distant siren.",
		"clenches their fists and stares into nothing.",
		"quickly pulls the mask up over their nose.",
		"rubs red, irritated eyes and winces.",
		"freezes, listening hard.",
		"hides their hands in sleeves and hunches over.",
		"keeps touching their throat unconsciously."
	)

	var/list/speech_emote_hear = list(
		"whispers barely audible: «they’re watching…»",
		"mumbles curses in a low, rough voice.",
		"coughs hoarsely and spits to the side.",
		"mutters: «one more day… one more…»",
		"lets out a short, choked sob and goes silent.",
		"breathes out slowly through clenched teeth.",
		"whispers a three-word prayer and stops.",
		"quietly repeats: «don’t look back… don’t look back…»"
	)

	var/save_data = TRUE

	var/saved_skin_tone
	var/saved_physique
	var/saved_eye_color_left
	var/saved_eye_color_right
	var/saved_hairstyle
	var/saved_hair_color
	var/saved_facial_hairstyle
	var/saved_facial_hair_color
	var/list/saved_mutant_bodyparts = list()
	var/list/saved_dna_features = list()


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
	if(ranged)
		AddComponent(/datum/component/ranged_attacks,\
			casing_type = casingtype,\
			projectile_sound = projectilesound,\
			cooldown_time = ranged_cooldown,\
			burst_shots = burst_shots,\
		)
		if(ranged_cooldown <= 1 SECONDS)
			AddComponent(/datum/component/ranged_mob_full_auto)
	return INITIALIZE_HINT_LATELOAD

/mob/living/basic/npc/LateInitialize()
	if(mapping_anchor)
		for(var/turf/T in view(anchor_search_range, src))
			var/point = locate(mapping_anchor) in T
			if(!point)
				continue
			ai_controller?.set_blackboard_key(BB_NPC_PATROL_POINT, point)
			break


/mob/living/basic/npc/examine(mob/user)
	. = ..()
	if(item_r_hand)
		var/obj/item/I = item_r_hand
		. += span_notice("[I::name] in [p_their()] right hand.")
	if(item_l_hand)
		var/obj/item/I = item_l_hand
		. += span_notice("[I::name] in [p_their()] left hand.")

/mob/living/basic/npc/death(gibbed)
	if(gibbed)
		return ..()
	INVOKE_ASYNC(src, PROC_REF(spawn_real_corpse_and_destroy))
	return ..()

/mob/living/basic/npc/proc/spawn_real_corpse_and_destroy()
	if(!save_data)
		qdel(src)
		return
	var/mob/living/carbon/human/corpse = new(loc)
	corpse.gender = gender
	corpse.set_species(species)
	corpse.physique = saved_physique
	corpse.skin_tone = saved_skin_tone
	corpse.eye_color_left = saved_eye_color_left
	corpse.eye_color_right = saved_eye_color_right
	corpse.dna.features = saved_dna_features.Copy()
	corpse.dna.mutant_bodyparts = saved_mutant_bodyparts.Copy()
	corpse.dna.species.regenerate_organs(corpse, corpse.dna.species, visual_only = TRUE)
	if(saved_hairstyle)
		corpse.set_hairstyle(saved_hairstyle, update = FALSE)
	if(saved_hair_color)
		corpse.set_haircolor(saved_hair_color, update = FALSE)
	if(saved_facial_hairstyle)
		corpse.set_facial_hairstyle(saved_facial_hairstyle, update = FALSE)
	if(saved_facial_hair_color)
		corpse.set_facial_haircolor(saved_facial_hair_color, update = FALSE)
	corpse.underwear = "Nude"
	corpse.undershirt = "Nude"
	corpse.socks = "Nude"
	corpse.bra = "Nude"
	corpse.update_body(TRUE)
	var/drop_right = prob(50)
	var/drop_left = prob(50)

	if(outfit)
		var/datum/outfit/corpse_outfit = new outfit()
		if(!drop_right && item_r_hand != NO_REPLACE)
			corpse_outfit.r_hand = item_r_hand
		if(!drop_left && item_l_hand != NO_REPLACE)
			corpse_outfit.l_hand = item_l_hand
		corpse.equipOutfit(corpse_outfit)

	if(drop_right && item_r_hand && item_r_hand != NO_REPLACE)
		new item_r_hand(loc)
	if(drop_left && item_l_hand && item_l_hand != NO_REPLACE)
		new item_l_hand(loc)
	var/obj/item/clothing/under/sensor_clothes = corpse.w_uniform
	if(istype(sensor_clothes))
		sensor_clothes.set_sensor_mode(SENSOR_OFF)
	corpse.fully_replace_character_name(null, name)
	corpse.death(TRUE)
	qdel(src)

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
	var/list/features = list(ARGS_FEATURES = get_default_features(), ARGS_COLORS = get_mutant_colors())
	var/dynamic_appearance

	var/mob/living/carbon/human/dummy = new()
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
	dummy.dna.species.mutant_bodyparts = dummy.dna.mutant_bodyparts.Copy()
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

	if(save_data)
		saved_skin_tone = dummy.skin_tone
		saved_physique = dummy.physique
		saved_eye_color_left = dummy.eye_color_left
		saved_eye_color_right = dummy.eye_color_right
		saved_hairstyle = dummy.hairstyle
		saved_hair_color = hair_color
		saved_facial_hairstyle = dummy.facial_hairstyle
		saved_facial_hair_color = hair_color
		saved_mutant_bodyparts = dummy.dna.mutant_bodyparts.Copy()
		saved_dna_features = dummy.dna.features.Copy()
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

	speech_chance = 15
	speech_phrases = list(
		"Move along!",
		"Everything under control here.",
		"Keep your hands visible.",
		"Suspicious activity will be reported.",
		"Stay safe out there.",
	)
	speech_emote_see = list(
		"adjusts %PTHEIR% beret.",
		"scans the surroundings.",
		"rests hand on baton.",
	)
	speech_emote_hear = list(
		"mutters into radio.",
		"clears %PTHEIR% throat.",
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
	projectilesound = 'sound/items/weapons/taser2.ogg'
	casingtype = /obj/projectile/beam/disabler
	burst_shots = 2

/obj/effect/landmark/military_patrol_point
	name = "Military patrol point"

/mob/living/basic/npc/police/military
	health = 300
	maxHealth = 300
	faction = list(FACTION_POLICE, FACTION_NEUTRAL)
	melee_damage_lower = 15
	melee_damage_upper = 30
	ai_controller = /datum/ai_controller/basic_controller/npc_police/ranged
	mapping_anchor = /obj/effect/landmark/military_patrol_point
	lighting_cutoff_red = 22
	lighting_cutoff_green = 5
	lighting_cutoff_blue = 5

	ranged = TRUE
	item_r_hand = /obj/item/gun/ballistic/automatic/m90
	projectilesound = 'sound/items/weapons/gun/smg/shot_alt.ogg'
	casingtype = /obj/item/ammo_casing/c38
	burst_shots = 3

	speech_chance = 15
	speech_phrases = list(
		"Move along.",
		"Keep moving.",
		"You shouldn't be here.",
		"Clear the area.",
		"Hands where I can see them.",
		"This zone is restricted.",
		"Disperse, now.",
		"Not your business.",
		"Back off.",
		"Get out of here.",
		"Area's off-limits.",
		"Keep walking.",
		"Step aside.",
		"No loitering.",
		"Move it, civilian."
	)

	speech_emote_see = list(
		"scans the surroundings.",
		"levels their weapon slightly.",
		"steps forward one pace.",
		"keeps a hand on their rifle.",
		"narrows their eyes at you.",
		"gestures sharply to move.",
		"stands blocking the path.",
		"turns their head to scan behind.",
		"rests a hand near their holster.",
		"watches you without blinking."
	)

	speech_emote_hear = list(
		"mutters into radio.",
		"speaks low into comms.",
		"grunts something unintelligible.",
		"barks a short code word.",
		"whispers coordinates.",
		"reports quietly: «one civilian»",
		"mutters: «another straggler»",
		"clicks tongue and keys the radio.",
		"breathes heavily into the mic.",
		"repeats a curt order under breath."
	)

	possible_outfits = list(/datum/outfit/trainstation_military)

/mob/living/basic/npc/police/military/sniper
	item_r_hand = /obj/item/gun/ballistic/rifle/sniper_rifle
	projectilesound = 'sound/items/weapons/gun/sniper/shot.ogg'
	casingtype = /obj/item/ammo_casing/p50
	burst_shots = 1
	ranged_cooldown = 7 SECONDS
