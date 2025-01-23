#define COLONY_THREAT_XENOS "xenos"
#define COLONY_THREAT_PIRATES "pirates"
#define COLONY_THREAT_CARP "carp"
#define COLONY_THREAT_SNOW "snow"
#define COLONY_THREAT_MINING "mining"
#define COLONY_THREAT_ICE_MINING "ice-mining"

//Resetting veins for ghost roles. Randomizes bouldersize, mineral breakdown, and potentially threats.

/obj/structure/ore_vent/ghost_mining
	name = "oxide nodule vent"
	desc = "A vent full of rare oxide nodules, producing varous minerals every time one is brought up. Scan with an advanced mining scanner to start extracting ore from it."
	icon_state = "ore_vent_active"
	mineral_breakdown = list(
		/datum/material/iron = 50,
		/datum/material/glass = 50) //we dont need a seperate starting list
	unique_vent = TRUE
	boulder_size = BOULDER_SIZE_SMALL
	defending_mobs = list(/mob/living/basic/carp)
	var/clear_tally = 0 //so we can track how many time it clears for data-testing purposes.
	var/boulder_bounty = 10 //how many boulders per clear attempt. First one is small and easy
	var/threat_pool = list(
		COLONY_THREAT_CARP,
		COLONY_THREAT_PIRATES,
		COLONY_THREAT_XENOS
	) //we put this here for customization reasons. For singular threat ones, Only put one.


/obj/structure/ore_vent/ghost_mining/produce_boulder(apply_cooldown)
	. = ..()
	boulder_bounty -= 1
	if(boulder_bounty == 0)
		reset_vent()

/obj/structure/ore_vent/ghost_mining/proc/reset_vent()
	cut_overlays()
	tapped = FALSE
	SSore_generation.processed_vents -= src
	icon_state = base_icon_state
	update_appearance(UPDATE_ICON_STATE)
	clear_tally += 1
	reset_ores()

/obj/structure/ore_vent/ghost_mining/proc/reset_ores()
	var/magnitude = rand(1,4)
	var/ore_pool = list(
		/datum/material/iron = 14,
		/datum/material/glass = 12,
		/datum/material/plasma = 10,
		/datum/material/titanium = 9,
		/datum/material/silver = 9,
		/datum/material/gold = 7,
		/datum/material/diamond = 3,
		/datum/material/uranium = 5,
		/datum/material/bluespace = 3,
		/datum/material/plastic = 2,
		)
	var/ore_output_size = list(
		LARGE_VENT_TYPE,
		MEDIUM_VENT_TYPE,
		SMALL_VENT_TYPE,
		)

	var/new_boulder_size = pick(ore_output_size)
	switch(new_boulder_size)
		if(LARGE_VENT_TYPE)
			boulder_size = BOULDER_SIZE_LARGE
			wave_timer = WAVE_DURATION_LARGE
		if(MEDIUM_VENT_TYPE)
			boulder_size = BOULDER_SIZE_MEDIUM
			wave_timer = WAVE_DURATION_MEDIUM
		if(SMALL_VENT_TYPE)
			boulder_size = BOULDER_SIZE_SMALL
			wave_timer = WAVE_DURATION_SMALL

	boulder_bounty = (magnitude * new_boulder_size)

	name = "[new_boulder_size] oxide chunk"
	AddComponent(/datum/component/gps, name)

	var/threat_pick = pick(threat_pool)

	switch(threat_pick)
		if(COLONY_THREAT_CARP)
			defending_mobs = list(
				/mob/living/basic/carp,
				/mob/living/basic/carp/mega)
		if(COLONY_THREAT_PIRATES)
			defending_mobs = list(
				/mob/living/basic/trooper/pirate/melee/space,
				/mob/living/basic/trooper/pirate/ranged/space
			)
		if(COLONY_THREAT_XENOS)
			defending_mobs = list(
				/mob/living/basic/alien,
				/mob/living/basic/alien/drone,
				/mob/living/basic/alien/sentinel
			)
		if(COLONY_THREAT_MINING)
			defending_mobs = list(
				/mob/living/basic/mining/goliath,
				/mob/living/basic/mining/legion/spawner_made,
				/mob/living/basic/mining/watcher,
				/mob/living/basic/mining/lobstrosity/lava,
				/mob/living/basic/mining/brimdemon,
				/mob/living/basic/mining/bileworm,
			)
		if(COLONY_THREAT_ICE_MINING)
			defending_mobs = list(
				/mob/living/basic/mining/ice_whelp,
				/mob/living/basic/mining/lobstrosity,
				/mob/living/basic/mining/legion/snow/spawner_made,
				/mob/living/basic/mining/ice_demon,
				/mob/living/basic/mining/wolf,
				/mob/living/simple_animal/hostile/asteroid/polarbear,
			)
		if(COLONY_THREAT_SNOW)
			defending_mobs = list(
				/mob/living/basic/mining/lobstrosity,
				/mob/living/basic/mining/legion/snow/spawner_made,
				/mob/living/basic/mining/wolf,
				/mob/living/simple_animal/hostile/asteroid/polarbear,
			)

	for(var/old_ore in mineral_breakdown)
		mineral_breakdown -= old_ore

	for(var/new_ore in 1 to magnitude)
		var/datum/mineral_picked = pick(ore_pool)
		mineral_breakdown += mineral_picked
		ore_pool -= mineral_picked
		mineral_breakdown[mineral_picked] = rand(5, 20) //we need a weight to the boulders or else produce_boulder shits the bed.

//// Vent variants for ghost roles in future work

/obj/structure/ore_vent/ghost_mining/lavaland
	defending_mobs = list(/mob/living/basic/mining/legion/spawner_made) //one of the easier starting ones
	threat_pool = list(COLONY_THREAT_MINING)

/obj/structure/ore_vent/ghost_mining/snowland
	icon_state = "ore_vent_ice_active"
	defending_mobs = list(/mob/living/basic/mining/wolf) //one of the easier snowies
	threat_pool = list(COLONY_THREAT_ICE_MINING, COLONY_THREAT_SNOW)

/obj/structure/ore_vent/ghost_mining/pirate
	defending_mobs = list(/mob/living/basic/trooper/pirate/melee,
		/mob/living/basic/trooper/pirate/ranged) //you can space cheese the starting ones, but only the starting ones
	threat_pool = list(COLONY_THREAT_PIRATES)

/obj/structure/ore_vent/ghost_mining/xenos
	defending_mobs = list(/mob/living/basic/alien/drone)
	threat_pool = list(COLONY_THREAT_XENOS)

/obj/structure/ore_vent/ghost_mining/carp
	defending_mobs = list(/mob/living/basic/carp)
	threat_pool = list(COLONY_THREAT_CARP)
