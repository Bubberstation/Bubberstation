///Whether a mob is a Bloodsucker
#define IS_BLOODSUCKER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/bloodsucker))
///Whether a mob is a Vassal
#define IS_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal))
///Whether a mob is a Favorite Vassal
#define IS_FAVORITE_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal/vassal_types/favorite))
///Whether a mob is a Revenge Vassal
#define IS_REVENGE_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal/vassal_types/revenge))
///Whether a mob is a Monster Hunter-NOT NEEDED RIGHT NOW
//#define IS_MONSTERHUNTER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/monsterhunter))
//Used in bloodsucker_life.dm
#define MARTIALART_FRENZYGRAB "frenzy grabbing"
