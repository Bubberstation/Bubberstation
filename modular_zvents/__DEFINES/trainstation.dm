#define TRAIN_STATION_DMM_DIR(_filename) ("_maps/modular_events/trainstation/" + _filename)

#define ZTRAIT_TRAINSTATION "Trainstation"
#define NO_TURF_MOVEMENT_1 (1<<32)

#define COMSIG_TRAIN_BEGIN_MOVING "train_begin_moving"
#define COMSIG_TRAIN_STOP_MOVING "train_stop_moving"
#define COMSIG_TRAIN_TRY_MOVE "train_try_move"
	#define COMPONENT_BLOCK_TRAIN_MOVEMENT (1 << 2)
#define COMSIG_TRAINSTATION_UNLOCKED "trainstation_unlocked"
#define COMSIG_TRAINSTATION_LOADED "trainstation_loaded"
#define COMSIG_TRAINSTATION_UNLOADED "trainstation_unloaded"

#define TRAIT_NO_STATION_UNLOAD "!no_unload"

/// Абстрактная станция, не будет отображаться в меню train_controll'ера, не будет связана с другими станциями
#define TRAINSTATION_ABSCTRACT (1 << 1)
#define TRAINSTATION_NO_FORKS (1 << 2)
#define TRAINSTATION_BLOCKING (1 << 3)
#define TRAINSTATION_NO_SELECTION (1 << 4)
#define TRAINSTATION_NO_NEARSTATION (1 << 5)
#define TRAINSTATION_NO_SPAWNING (1 << 6)
#define TRAINSTATION_LOCAL_CENTER (1 << 7)
#define TRAINSTATION_START_STATION (1 << 8)
#define TRAINSTATION_FINAL_STATION (1 << 9)

#define TRAINSTATION_REGION_THUNDRA "Thundra"
#define TRAINSTATION_REGION_TEMPERATE "Temperate"
#define TRAINSTATION_REGION_DESERT "Desert"

#define TRAINSTATION_TYPE_CARGO "Cargo"
#define TRAINSTATION_TYPE_EMERGENCY "Emergency"
#define TRAINSTATION_TYPE_MILITARY "Military"
#define TRAINSTATION_TYPE_CITY "City"

#define THREAT_LEVEL_SAFE "Safe"
#define THREAT_LEVEL_RISKY "Risky"
#define THREAT_LEVEL_DANGEROUS "Dangerous"
#define THREAT_LEVEL_HAZARDOUS "Hazardous"
#define THREAT_LEVEL_DEADLY "Deadly"


#define FACTION_CIVILIAN "civilian"
#define FACTION_POLICE "police"
#define FACTION_MILITARY "military"
#define FACTION_KHARA "khara"

#define TRAIT_KHARAMUTANT "khara_mutant"

#define BB_MOB_ABILITY_BONESHARD "bb_ability_boneshard"
#define BB_MOB_ABILITY_LEAP "bb_ability_leap"
#define BB_MOB_ABILITY_MEAT_BALL "bb_ability_meatball"
#define BB_MOB_ABILITY_RUMBLE "bb_ability_rumble"
#define BB_MOB_AILITY_SLASH "bb_ability_slash"
#define BB_MOB_ABILITY_FAST_CHARGE "bb_ability_fast_charge"

#define BB_NPC_PATROL_POINT "bb_npc_patrol_point"
#define BB_BASIC_MOB_CUFF_TYPE "bb_cuff_type"
#define BB_BASIC_MOB_DEFAULT_CUFF_TYPE (/obj/item/restraints/handcuffs/cable/zipties/used)
#define BB_BASIC_MOB_BEGIN_CUFFING "bb_begin_cuffing"
#define BB_MEMORY_LAST_TARGET "bb_memo_last_target"
#define BB_MEMORY_LAST_TARGET_TIME "bb_memo_last_target_time"

#define BB_MEMORY_ENEMIES_LIST "enemies_list"


/proc/find_nearest_ally(atom/source, faction, range = 12)
	var/closest
	var/closest_dist = INFINITY
	for(var/mob/living/basic/M in view(range, source))
		if(M == source || !M.faction.Find(faction))
			continue
		var/dist = get_dist(source, M)
		if(dist < closest_dist)
			closest = M
			closest_dist = dist
	return closest
