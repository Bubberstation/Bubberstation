#define ALIEN_DRONE "drone"
#define ALIEN_WARRIOR "warrior"
#define ALIEN_RUNNER "runner"
#define ALIEN_DEFENDER "defender"
#define ALIEN_RAVAGER "ravager"

/mob/living/basic/alien/drone
	/// Determines which subtype of drone gets created. If nothing is set it is randomly chosen upon initialization.
	var/drone_type

/mob/living/basic/alien/drone/Initialize(mapload)
	. = ..()
	var/list/drone_types = list(ALIEN_DRONE, ALIEN_WARRIOR, ALIEN_RUNNER, ALIEN_DEFENDER, ALIEN_RAVAGER)
	if(isnull(drone_type) || !(drone_type in drone_types))
		drone_type = pick(drone_types)

	set_drone_type(drone_type)

/// Sets a drone to one of the template subtypes given an arg string.
/mob/living/basic/alien/drone/proc/set_drone_type(drone_type)
	switch(drone_type)
		if(ALIEN_DRONE)
			name = "alien drone"
			icon_state = "aliendrone"
			icon_living = "aliendrone"
			icon_dead = "aliendrone_dead"
			health = 150
			maxHealth = 150
			melee_damage_lower = 15
			melee_damage_upper = 15
			unique_name = TRUE
			pixel_x = -16
			base_pixel_x = -16
		if(ALIEN_WARRIOR)
			name = "alien warrior"
			icon_state = "alienwarrior"
			icon_living = "alienwarrior"
			icon_dead = "alienwarrior_dead"
			health = 175
			maxHealth = 175
			unique_name = TRUE
			mob_size = MOB_SIZE_LARGE
			pixel_x = -16
			base_pixel_x = -16
		if(ALIEN_RUNNER)
			name = "alien runner"
			icon_state = "alienrunner"
			icon_living = "alienrunner"
			icon_dead = "alienrunner_dead"
			health = 125
			maxHealth = 125
			melee_damage_lower = 10
			melee_damage_upper = 15
			unique_name = TRUE
			pixel_x = -16
			base_pixel_x = -16
		if(ALIEN_DEFENDER)
			name = "alien defender"
			icon_state = "aliendefender"
			icon_living = "aliendefender"
			icon_dead = "aliendefender_dead"
			health = 225
			maxHealth = 225
			melee_damage_lower = 10
			melee_damage_upper = 15
			unique_name = TRUE
			mob_size = MOB_SIZE_LARGE
			pixel_x = -16
			base_pixel_x = -16
		if(ALIEN_RAVAGER)
			name = "alien ravager"
			icon_state = "alienravager"
			icon_living = "alienravager"
			icon_dead = "alienravager_dead"
			health = 200
			maxHealth = 200
			unique_name = TRUE
			mob_size = MOB_SIZE_LARGE
			pixel_x = -16
			base_pixel_x = -16
	update_icon(updates=ALL)

#undef ALIEN_DRONE
#undef ALIEN_WARRIOR
#undef ALIEN_RUNNER
#undef ALIEN_DEFENDER
#undef ALIEN_RAVAGER
