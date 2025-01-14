/mob/living/basic/carp
	health = 50
	maxHealth = 50


/mob/living/basic/carp/advanced
	health = 100
	maxHealth = 100

/mob/living/basic/carp/mega/Initialize(mapload)
	. = ..()
	maxHealth += rand(15, 40)

/mob/living/basic/carp/babydragon
	name = "\improper Juvinile Space Dragon"
	desc = "A serpentine leviathan whose flight defies all modern understanding of physics. Said to be the ultimate stage in the life cycle of the Space Carp. This one is still young, and likely doesn't know its full strength!"
	health = 400
	maxHealth = 400
	icon = 'icons/mob/nonhuman-player/spacedragon.dmi'
	icon_state = "spacedragon"
	icon_living = "spacedragon"
	icon_dead = "spacedragon_dead"
	butcher_results = list(/obj/item/stack/ore/diamond = 5, /obj/item/stack/sheet/sinew = 5, /obj/item/stack/sheet/bone = 30)
	can_buckle_to = FALSE
	death_sound = 'sound/mobs/non-humanoids/space_dragon/space_dragon_roar.ogg'
	death_message = "screeches in agony as it collapses to the floor, its life extinguished."
	mob_size = MOB_SIZE_LARGE
	armour_penetration = 30
	pixel_x = -16
	base_pixel_x = -16
	maptext_height = 64
	maptext_width = 64
	obj_damage = 100
	melee_damage_upper = 35
	melee_damage_lower = 35
	attack_verb_continuous = "chomps"
	attack_verb_simple = "chomp"
	attack_sound = 'sound/effects/magic/demon_attack1.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
