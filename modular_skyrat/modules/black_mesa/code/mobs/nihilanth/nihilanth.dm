/**
 * Nihilanth - The final boss of Black Mesa
 *
 * A massive floating entity that serves as the master of the Xen forces.
 * Uses powerful ranged attacks and becomes more desperate as its health decreases.
 */
/mob/living/basic/blackmesa/xen/nihilanth
	name = "nihilanth"
	desc = "Holy shit."
	COOLDOWN_DECLARE(voice_cooldown)
	icon = 'modular_skyrat/modules/black_mesa/icons/nihilanth.dmi'
	icon_state = "nihilanth"
	icon_living = "nihilanth"
	pixel_x = -32
	base_pixel_x = -32
	pixel_y = -16  // Adjusted to move hitbox to bottom
	base_pixel_y = -16  // Adjusted to move hitbox to bottom
	density = TRUE
	move_force = MOVE_FORCE_OVERPOWERING
	move_resist = MOVE_FORCE_OVERPOWERING
	pull_force = MOVE_FORCE_OVERPOWERING
	mob_size = MOB_SIZE_LARGE
	layer = LARGE_MOB_LAYER
	maptext_height = 96
	maptext_width = 96 //Keeps it above walls and structures
	mouse_opacity = MOUSE_OPACITY_OPAQUE // Easier to click on
	icon_dead = "bullsquid_dead"
	appearance_flags = TILE_BOUND | PIXEL_SCALE | KEEP_TOGETHER
	maxHealth = 3000
	health = 3000
	obj_damage = 400
	melee_damage_lower = 30
	melee_damage_upper = 40
	armour_penetration = 40
	attack_verb_continuous = "lathes"
	attack_verb_simple = "lathe"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	status_flags = NONE
	lighting_cutoff_red = 25
	lighting_cutoff_green = 15
	lighting_cutoff_blue = 35
	mob_biotypes = MOB_ORGANIC|MOB_SPECIAL|MOB_MINING
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1
	basic_mob_flags = DEL_ON_DEATH
	ai_controller = /datum/ai_controller/basic_controller/nihilanth

	/// Items to drop on death
	var/static/list/death_loot = list(
		/obj/effect/gibspawner/xeno = 1,
		/obj/item/stack/sheet/bluespace_crystal/fifty = 1,
		/obj/item/key/gateway = 1,
		/obj/item/uber_teleporter = 1
	)

/obj/item/stack/sheet/bluespace_crystal/fifty
	amount = 50

/obj/projectile/nihilanth
	name = "portal energy"
	icon_state = "seedling"
	damage = 20
	damage_type = BURN
	light_range = 2
	armor_flag = ENERGY
	light_color = LIGHT_COLOR_BRIGHT_YELLOW
	hitsound = 'sound/items/weapons/sear.ogg'
	hitsound_wall = 'sound/items/weapons/effects/searwall.ogg'
	nondirectional_sprite = TRUE

/mob/living/basic/blackmesa/xen/nihilanth/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_IMMOBILIZED, INNATE_TRAIT) // Prevent unnecessary movement processing
	ADD_TRAIT(src, TRAIT_NO_FLOATING_ANIM, INNATE_TRAIT) // Prevent unnecessary animation processing
	AddElement(/datum/element/death_drops, death_loot)
	AddElement(/datum/element/simple_flying)
	RegisterSignal(src, COMSIG_LIVING_DEATH, PROC_REF(on_death), override = TRUE)
	AddComponent(\
		/datum/component/ranged_attacks,\
		projectile_type = /obj/projectile/nihilanth,\
		projectile_sound = 'sound/items/weapons/lasercannonfire.ogg',\
		cooldown_time = 3 SECONDS,\
		burst_shots = 3\
	)
	update_appearance(UPDATE_ICON)

/// Called when nihilanth dies - play death sound
/mob/living/basic/blackmesa/xen/nihilanth/proc/on_death(datum/source)
	SIGNAL_HANDLER
	playsound(src, pick(list(
		'modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_pain01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_freeeemmaan01.ogg'
	)), 100)

/mob/living/basic/blackmesa/xen/nihilanth/adjust_brute_loss(amount, updating_health = TRUE, forced = FALSE, required_bodytype)
	. = ..()
	if(amount <= 0 || !COOLDOWN_FINISHED(src, voice_cooldown))  // Don't play sounds for healing or during cooldown
		return
	var/list/sound_options
	switch(maxHealth - health)  // Use remaining health instead of current health
		if(2001 to INFINITY)  // 0-33% health remaining
			sound_options = list(
				'modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_pain01.ogg',
				'modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_freeeemmaan01.ogg'
			)
		if(1001 to 2000)  // 33-66% health remaining
			sound_options = list(
				'modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_youalldie01.ogg',
				'modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_foryouhewaits01.ogg'
			)
		if(1 to 1000)  // 66-99% health remaining
			sound_options = list(
				'modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_whathavedone01.ogg',
				'modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_deceiveyou01.ogg'
			)
		else  // Full health
			sound_options = list(
				'modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_thetruth01.ogg',
				'modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_iamthelast01.ogg'
			)
	var/sound_to_play = pick(sound_options)
	var/sound_length = SSsounds.get_sound_length(sound_to_play)
	playsound(src, sound_to_play, 100)
	COOLDOWN_START(src, voice_cooldown, sound_length + 1 SECONDS)
