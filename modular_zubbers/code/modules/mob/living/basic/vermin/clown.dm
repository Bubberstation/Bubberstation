// Say hello to the clown bug.

/mob/living/basic/clown_bug
	name = "clown bug"
	desc = "Absolutely disgusting... almost as horrid as that one green clown."
	icon = 'modular_zubbers/icons/mob/simple/animals.dmi'
	icon_state = "clowngoblin"
	icon_dead = "clowngoblin"
	icon_gib = "clowngoblin-gib"
	density = FALSE
	pass_flags = PASSTABLE|PASSGRILLE|PASSMOB|PASSDOORS
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	// God forbid you let the clown create them in xenobio and carry a horde of them
	held_w_class = WEIGHT_CLASS_SMALL
	gold_core_spawnable = HOSTILE_SPAWN

	health = 10
	maxHealth = 10
	melee_damage_lower = 1
	melee_damage_upper = 5
	attack_verb_continuous = "honks"
	attack_verb_simple = "honk"
	friendly_verb_continuous = "honks"
	friendly_verb_simple = "honk"

	speak_emote = list("honks", "screams")
	var/list/squeak_sound = /obj/item/clothing/shoes/clown_shoes::squeak_sound

	ai_controller = /datum/ai_controller/basic_controller/clown_bug
	faction = list(FACTION_CLOWN, FACTION_HOSTILE, FACTION_MAINT_CREATURES) // They are vermin and as such are part of vermin factions

/mob/living/basic/clown_bug/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CLOWNANA, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 10)
	AddComponent(/datum/component/swarming, 8, 8)
	AddComponent(/datum/component/squeak, list('sound/items/bikehorn.ogg' = 1), 100, extrarange = SHORT_RANGE_SOUND_EXTRARANGE)
	AddComponent(/datum/component/slippery, 10, (SLIDE | GALOSHES_DONT_HELP))
	AddElement(/datum/element/ai_retaliate) // Do not the clown bug
	AddElement(/datum/element/can_be_held)
	RegisterSignal(src, COMSIG_HOSTILE_POST_ATTACKINGTARGET, PROC_REF(post_attack))

/mob/living/basic/clown_bug/proc/post_attack(datum/source, mob/living/carbon/human/target, result)
	playsound(src, 'sound/items/bikehorn.ogg', 50, TRUE)
	if(!result)
		return
	var/turf/open/lubeturf = get_turf(target)
	lubeturf.MakeSlippery(TURF_WET_LUBE, 3 SECONDS, 2 SECONDS, 5 SECONDS)
	if(istype(target))
		target.Knockdown(10)

/mob/living/basic/clown_bug/death(gibbed)
	. = ..()
	gib()

/mob/living/basic/clown_bug/spawn_gibs(drop_bitflags)
	var/turf/open/start = get_turf(src)
	var/obj/effect/temp_visual/gib_animation/anim = new /obj/effect/temp_visual/gib_animation(start, icon_gib)
	anim.icon = icon
	for(var/turf/open/lubeturf in range(1, start))
		if(prob(70))
			lubeturf.MakeSlippery(TURF_WET_LUBE, 3 SECONDS, 2 SECONDS, 5 SECONDS)
