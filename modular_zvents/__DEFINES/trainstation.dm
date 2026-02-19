#define TRAIN_STATION_DMM_DIR(_filename) ("_maps/modular_events/trainstation/" + _filename)

#define ZTRAIT_TRAINSTATION "Trainstation"
#define NO_TURF_MOVEMENT_1 (1<<32)

#define COMSIG_TRAIN_BEGIN_MOVING "train_begin_moving"
#define COMSIG_TRAIN_STOP_MOVING "train_stop_moving"
#define COMSIG_TRAIN_TRY_MOVE "train_try_move"
	#define COMPONENT_BLOCK_TRAIN_MOVEMENT (1 << 2)
#define COMSIG_TRAINSTATION_UNLOCKED "trainstation_unlocked"

#define TRAIT_NO_STATION_UNLOAD "!no_unload"

#define TRAINSTATION_ABSCTRACT (1 << 1)
#define TRAINSTATION_NO_FORKS (1 << 2)
#define TRAINSTATION_BLOCKING (1 << 3)
#define TRAINSTATION_NO_SELECTION (1 << 4)
#define TRAINSTATION_NO_NEARSTATION (1 << 5)
#define TRAINSTATION_NO_SPAWNING (1 << 6)

#define FACTION_CIVILIAN "civilian"
#define FACTION_POLICE "police"
#define FACTION_MILITARY "military"
#define FACTION_KHARA "khara"


#define BB_NPC_PATROL_POINT "bb_npc_patrol_point"
#define BB_BASIC_MOB_CUFF_TYPE "bb_cuff_type"
#define BB_BASIC_MOB_DEFAULT_CUFF_TYPE (/obj/item/restraints/handcuffs/cable/zipties/used)
#define BB_BASIC_MOB_BEGIN_CUFFING "bb_begin_cuffing"
#define BB_MEMORY_LAST_TARGET "bb_memo_last_target"
#define BB_MEMORY_LAST_TARGET_TIME "bb_memo_last_target_time"

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
