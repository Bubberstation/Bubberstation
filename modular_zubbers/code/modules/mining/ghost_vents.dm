#define COLONY_THREAT_XENOS "xenos"
#define COLONY_THREAT_PIRATES "pirates"
#define COLONY_THREAT_CARP "carp"
#define COLONY_THREAT_SNOW "snow"
#define COLONY_THREAT_MINING "mining"
#define COLONY_THREAT_ICE_MINING "ice-mining"
#define COLONY_THREAT_BEACH "beach"
#define COLONY_THREAT_CULT "cult"

//Resetting veins for ghost roles. Randomizes bouldersize, mineral breakdown, and potentially threats.

/obj/structure/ore_vent/ghost_mining
	name = "oxide nodule vent"
	desc = "A vent full of rare oxide nodules, producing various minerals every time one is brought up. Scan with an advanced mining scanner to start extracting ore from it."
	icon_state = "ore_vent_active"
	base_icon_state = "ore_vent_active"
	mineral_breakdown = list(
		/datum/material/iron = 50,
		/datum/material/glass = 50,
	) //we don't need a separate starting list
	unique_vent = TRUE
	boulder_size = BOULDER_SIZE_SMALL
	defending_mobs = list(/mob/living/basic/carp)
	var/clear_tally = 0 //so we can track how many time it clears for data-testing purposes.
	var/boulder_bounty = 10 //how many boulders per clear attempt. First one is small and easy
	var/new_ore_cycle = TRUE //We want this to generate new ore types upon untapping. Var incase we want some wacky shit later.
	var/static_threat = FALSE //Is this a static threat? Useful for boss/elite vents
	var/static_magnitude = null //Does this vent have a static magnitude?
	var/static_boulder_size = null //Does this vent have a static boulder size?
	var/static_boulder_bounty = null //does this vent have a static boulder bounty?
	var/random_start = FALSE  //does this vent randomize at start?
	var/threat_pool = list(
		COLONY_THREAT_CARP,
		COLONY_THREAT_PIRATES,
		COLONY_THREAT_XENOS,
	) //we put this here for customization reasons. For singular threat ones, Only put one.

/obj/structure/ore_vent/ghost_mining/examine(mob/user)
	. = ..()
	switch(tapped)
		if(TRUE)
			. += span_notice("The current nodule holds [boulder_bounty] chunks worth of ore.")
		if(FALSE)
			. += span_notice("The vent holds a nodule breakable into [boulder_bounty] ore chunks.")
	if(clear_tally >= 1)
		. += span_notice("This vent has hauled up [clear_tally] nodules.")

/obj/structure/ore_vent/ghost_mining/produce_boulder(apply_cooldown)
	. = ..()
	boulder_bounty -= 1
	if(boulder_bounty == 0)
		reset_vent(TRUE)

/obj/structure/ore_vent/ghost_mining/Initialize(mapload)
	. = ..()
	if(random_start)
		reset_vent(FALSE)

/obj/structure/ore_vent/ghost_mining/start_wave_defense() //We add faction and change spawn text a bit. tbh we could rebalance a bit but thats for later ideas
	AddComponent(\
		/datum/component/spawner, \
		spawn_types = defending_mobs, \
		spawn_time = (10 SECONDS + (5 SECONDS * (boulder_size/5))), \
		faction = list(FACTION_MINING), \
		max_spawned = 10, \
		max_spawn_per_attempt = (1 + (boulder_size/5)), \
		spawn_text = "emerges from hidden tunnels near", \
		spawn_distance = 4, \
		spawn_distance_exclude = 3, \
	)
	COOLDOWN_START(src, wave_cooldown, wave_timer)
	addtimer(CALLBACK(src, PROC_REF(handle_wave_conclusion)), wave_timer)
	icon_state = icon_state_tapped
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/ore_vent/ghost_mining/proc/reset_vent(cleared = FALSE) // We want to re-cycle the vent to an untapped state.
	var/gps_name = "fresh oxide chunk" // Default backup incase we dont recycle ore
	cut_overlays() // Remove the rig. Maybe later i or someone else can do some fancy animation for this.
	tapped = FALSE //make it untapped by state, duh.
	SSore_generation.processed_vents -= src //make it registered as untapped
	icon_state = base_icon_state // Resets the icon
	update_appearance(UPDATE_ICON_STATE)
	if(cleared)
		clear_tally += 1 // data points bby
	if(new_ore_cycle) //Do we want this to get new ores?
		var/new_boulder_size = pick(ore_vent_options) // we put this here for GPS and customization reasons
		if(static_boulder_size)
			new_boulder_size = static_boulder_size
		reset_ores(new_boulder_size) // title. We use the variable thing PURELY for the sake of having the GPS tied here and not to reset ores
		generate_description() // makes the description register the new ores
		gps_name = "[new_boulder_size] oxide chunk" // should generate as "large oxide chunk"
	else
		boulder_bounty = initial(boulder_bounty) //Just resets to what it started with. Yes, this is all this needs.

	AddComponent(/datum/component/gps, gps_name) // We let GPS be a system to let people know when it resets


/obj/structure/ore_vent/ghost_mining/proc/reset_ores(new_boulder_size) // We want this to reset its ore... Maybe.
	var/magnitude = rand(1,4) // Affects boulder spawn ammount and how many material types one boulder has.
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
	) // Ore pool, Weighted... to do: upstream a bananium vent icon so i can add bananium

	if(static_magnitude) //over-writes the random one, but only if we have a static magnitude
		magnitude = static_magnitude

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

	if(static_boulder_bounty)
		boulder_bounty = static_boulder_bounty
	else
		boulder_bounty = (magnitude * boulder_size) // minimal 5, maximum is 60. tbh not that hard in space

	var/threat_pick = pick(threat_pool) //We choose from the threat pool list and use it to generate a defending_mobs list. todo: complex additive mode for funny shenanigans

	if(!static_threat)
		switch(threat_pick)
			if(COLONY_THREAT_CARP) // carps. space fishies. easy to kill but kinda dodgy and could outnumber
				defending_mobs = list(
					/mob/living/basic/carp,
					/mob/living/basic/carp/mega,
				)
			if(COLONY_THREAT_PIRATES) // Pirates. Ranged could become a problem fast
				defending_mobs = list(
					/mob/living/basic/trooper/pirate/melee/space,
					/mob/living/basic/trooper/pirate/ranged/space,
				)
			if(COLONY_THREAT_XENOS) // i lub tgmc
				defending_mobs = list(
					/mob/living/basic/alien,
					/mob/living/basic/alien/drone,
					/mob/living/basic/alien/sentinel,
				)
			if(COLONY_THREAT_MINING) // Lavaland mobs
				defending_mobs = list(
					/mob/living/basic/mining/goliath,
					/mob/living/basic/mining/legion/spawner_made,
					/mob/living/basic/mining/watcher,
					/mob/living/basic/mining/lobstrosity/lava,
					/mob/living/basic/mining/brimdemon,
					/mob/living/basic/mining/bileworm,
				)
			if(COLONY_THREAT_ICE_MINING) // Ice-moon underground. Basically just surface but has two mobs that make it worse
				defending_mobs = list(
					/mob/living/basic/mining/ice_whelp,
					/mob/living/basic/mining/lobstrosity,
					/mob/living/basic/mining/legion/snow/spawner_made,
					/mob/living/basic/mining/ice_demon,
					/mob/living/basic/mining/wolf,
					/mob/living/simple_animal/hostile/asteroid/polarbear,
				)
			if(COLONY_THREAT_SNOW) // icemoon surface
				defending_mobs = list(
					/mob/living/basic/mining/lobstrosity,
					/mob/living/basic/mining/legion/snow/spawner_made,
					/mob/living/basic/mining/wolf,
					/mob/living/simple_animal/hostile/asteroid/polarbear,
				)
			if(COLONY_THREAT_BEACH) // I want to do some shit with the beach biodome later.
				defending_mobs = list(
					/mob/living/basic/crab,
					/mob/living/basic/mining/lobstrosity/juvenile/lava,
					/mob/living/basic/mining/lobstrosity/lava,
				)
			if(COLONY_THREAT_CULT) // Cult constructs
				defending_mobs = list(
					/mob/living/basic/construct/artificer/hostile,
					/mob/living/basic/construct/juggernaut/hostile,
					/mob/living/basic/construct/proteon/hostile,
					/mob/living/basic/construct/wraith/hostile,
				)

	for(var/old_ore in mineral_breakdown) //We remove the old ore
		mineral_breakdown -= old_ore

	for(var/new_ore in 1 to magnitude) //We put in the new ore
		var/datum/mineral_picked = pick(ore_pool)
		mineral_breakdown += mineral_picked
		ore_pool -= mineral_picked //No "OOPS, ALL IRON!"
		mineral_breakdown[mineral_picked] = rand(5, 20) //we need a weight to the boulders or else produce_boulder shits the bed.

//// Vent variants for ghost roles in future work

/obj/structure/ore_vent/ghost_mining/lavaland
	defending_mobs = list(/mob/living/basic/mining/legion/spawner_made) //one of the easier starting ones
	threat_pool = list(COLONY_THREAT_MINING)

/obj/structure/ore_vent/ghost_mining/lavaland/ras //random at start
	random_start = TRUE

/obj/structure/ore_vent/ghost_mining/snowland
	icon_state = "ore_vent_ice_active"
	base_icon_state = "ore_vent_ice_active"
	defending_mobs = list(/mob/living/basic/mining/wolf) //one of the easier snowies
	threat_pool = list(COLONY_THREAT_SNOW)

/obj/structure/ore_vent/ghost_mining/snowland/ras
	random_start = TRUE

/obj/structure/ore_vent/ghost_mining/undersnow
	icon_state = "ore_vent_ice_active"
	base_icon_state = "ore_vent_ice_active"
	defending_mobs = list(/mob/living/basic/mining/wolf) //one of the easier snowies
	threat_pool = list(COLONY_THREAT_ICE_MINING)

/obj/structure/ore_vent/ghost_mining/pirate
	defending_mobs = list(
		/mob/living/basic/trooper/pirate/melee,
		/mob/living/basic/trooper/pirate/ranged,
	) //you can space cheese the starting ones, but only the starting ones
	threat_pool = list(COLONY_THREAT_PIRATES)

/obj/structure/ore_vent/ghost_mining/xenos
	defending_mobs = list(/mob/living/basic/alien/drone)
	threat_pool = list(COLONY_THREAT_XENOS)

/obj/structure/ore_vent/ghost_mining/carp
	defending_mobs = list(/mob/living/basic/carp)
	threat_pool = list(COLONY_THREAT_CARP)

/obj/structure/ore_vent/ghost_mining/crab
	defending_mobs = list(/mob/living/basic/crab)
	threat_pool = list(COLONY_THREAT_BEACH)

/obj/structure/ore_vent/ghost_mining/cult
	defending_mobs = list(/mob/living/basic/construct/proteon/hostile)
	threat_pool = list(COLONY_THREAT_CULT)

/obj/structure/ore_vent/ghost_mining/ras
	random_start = TRUE

/obj/structure/ore_vent/ghost_mining/boss
	name = "swirling oxide pool"
	desc = "A deep mineral pool laden with massive oxide chunks. This one has an evil aura about it. Better be careful."
	static_threat = TRUE
	unique_vent = TRUE
	spawn_drone_on_tap = FALSE
	boulder_size = BOULDER_SIZE_LARGE
	mineral_breakdown = list( // All the riches of the world, eeny meeny boulder room.
		/datum/material/iron = 1,
		/datum/material/glass = 1,
		/datum/material/plasma = 1,
		/datum/material/titanium = 1,
		/datum/material/silver = 1,
		/datum/material/gold = 1,
		/datum/material/diamond = 1,
		/datum/material/uranium = 1,
		/datum/material/bluespace = 1,
		/datum/material/plastic = 1,
	)
	defending_mobs = list(
		/mob/living/simple_animal/hostile/megafauna/dragon,
		/mob/living/simple_animal/hostile/megafauna/colossus,
		/mob/living/simple_animal/hostile/megafauna/bubblegum,
	)
	excavation_warning = "Something big is nearby. Are you ABSOLUTELY ready to excavate this ore vent? A NODE drone will be deployed after threat is neutralized."
	boulder_bounty = 40 // one boulder spawns roughly every minute, 40 minutes for the vent to reset
	new_ore_cycle = FALSE //We just want the same boulder.
	var/summoned_boss = /mob/living/simple_animal/hostile/megafauna/dragon //What do we spawn? Starts with Drake (the fauna not that guy)

/obj/structure/ore_vent/ghost_mining/boss/examine(mob/user)
	. = ..()
	var/boss_string = ""
	switch(summoned_boss)
		if(/mob/living/simple_animal/hostile/megafauna/dragon) //Megafauna vent start
			boss_string = "oily, flames dancing along the edges"
		if(/mob/living/simple_animal/hostile/megafauna/colossus)
			boss_string = "reflective, the mirror image glaring with judgement"
		if(/mob/living/simple_animal/hostile/megafauna/bubblegum)
			boss_string = "bubbling with frothing blood, emitting a sickly sweet scent"
		if(/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner)
			boss_string = "frozen over with bloodened ice"
		if(/mob/living/simple_animal/hostile/megafauna/wendigo/noportal) //Megafauna vent end
			boss_string = "clear, showing a skull just below"
		if(/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/hunter) //Elite vent start. Yes, I know this isn't an elite, But even my noob-miner ass can do this one.
			boss_string = "frothing with blood and scented of alcohol"
		if(/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/doom) //For icemoon one
			boss_string = "swirling angrily and frothing with rage"
		if(/mob/living/simple_animal/hostile/asteroid/elite/broodmother)
			boss_string = "clear, showing a pit of tendrils and worms beneath"
		if(/mob/living/simple_animal/hostile/asteroid/elite/herald)
			boss_string = "reflective, insidious laughter echoing beneath"
		if(/mob/living/simple_animal/hostile/asteroid/elite/legionnaire)
			boss_string = "clear, a bonfire of bones burning beneath"
		if(/mob/living/simple_animal/hostile/asteroid/elite/pandora) //Elite vent end
			boss_string = "rippling calmly in odd geometric patterns"
	. += span_notice("The surface of the mineral pool is [boss_string].")

/obj/structure/ore_vent/ghost_mining/boss/reset_vent()
	. = ..()
	var/list/boss_pool = defending_mobs
	var/old_boss = summoned_boss
	boss_pool -= old_boss //avoid repeats.
	summoned_boss = pick(boss_pool)
	boss_pool += old_boss // system stupid, need to reintroduce so no empty list. Yes, the list empties without this somehow.

/obj/structure/ore_vent/ghost_mining/boss/start_wave_defense() //Stolen from original boss vent code
	if(!COOLDOWN_FINISHED(src, wave_cooldown))
		return
	// Completely override the normal wave defense, and just spawn the boss.
	var/mob/living/simple_animal/hostile/megafauna/boss = new summoned_boss(loc)
	RegisterSignal(boss, COMSIG_LIVING_DEATH, PROC_REF(handle_wave_conclusion))
	SSblackbox.record_feedback("tally", "ore_vent_mobs_spawned", 1, summoned_boss)
	COOLDOWN_START(src, wave_cooldown, INFINITY) //Basically forever
	boss.say(boss.summon_line) //Pull their specific summon line to say. Default is meme text so make sure that they have theirs set already.

/obj/structure/ore_vent/ghost_mining/boss/handle_wave_conclusion()
	node = new /mob/living/basic/node_drone(loc) //We're spawning the vent after the boss dies, so the player can just focus on the boss.
	SSblackbox.record_feedback("tally", "ore_vent_mobs_killed", 1, summoned_boss)
	COOLDOWN_RESET(src, wave_cooldown)
	return ..()

/obj/structure/ore_vent/ghost_mining/boss/icemoon
	icon_state = "ore_vent_ice_active"
	base_icon_state = "ore_vent_ice_active"
	summoned_boss = /mob/living/simple_animal/hostile/megafauna/demonic_frost_miner // Icemoon's angriest man
	defending_mobs = list(
		/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner,
		/mob/living/simple_animal/hostile/megafauna/wendigo/noportal,
		/mob/living/simple_animal/hostile/megafauna/colossus,
	)

/obj/structure/ore_vent/ghost_mining/boss/elite
	name = "rippling oxide pool"
	mineral_breakdown = list( // Basic stuff for lavaproofing stuff
		/datum/material/iron = 1,
		/datum/material/glass = 1,
		/datum/material/plasma = 1,
		/datum/material/titanium = 1,
	)
	summoned_boss = /mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/hunter // bloody hunters, cant let dracula flow
	static_magnitude = 4
	static_boulder_size = LARGE_VENT_TYPE // Yes, We use the vent type here. Refer to lines 76 and 106
	static_boulder_bounty = 40 //same as boss vent, roughly 40 minutes between spawns
	new_ore_cycle = TRUE
	excavation_warning = "Something wicked this way comes. Are you ready to excavate this ore vent? A NODE drone will be deployed after threat is neutralized."
	defending_mobs = list(
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother,
		/mob/living/simple_animal/hostile/asteroid/elite/herald,
		/mob/living/simple_animal/hostile/asteroid/elite/pandora,
		/mob/living/simple_animal/hostile/asteroid/elite/legionnaire,
		/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/hunter,
	)

/obj/structure/ore_vent/ghost_mining/boss/elite/Icemoon
	icon_state = "ore_vent_ice_active"
	base_icon_state = "ore_vent_ice_active"
	summoned_boss = /mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/doom // Hes angry he got demoted to elite status
	defending_mobs = list(
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother,
		/mob/living/simple_animal/hostile/asteroid/elite/herald,
		/mob/living/simple_animal/hostile/asteroid/elite/pandora,
		/mob/living/simple_animal/hostile/asteroid/elite/legionnaire,
		/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/doom,
	)

#undef COLONY_THREAT_XENOS
#undef COLONY_THREAT_PIRATES
#undef COLONY_THREAT_CARP
#undef COLONY_THREAT_SNOW
#undef COLONY_THREAT_MINING
#undef COLONY_THREAT_ICE_MINING
#undef COLONY_THREAT_BEACH
#undef COLONY_THREAT_CULT
