
//the list of possible things people can make if they have maxed forging skill
#define COMSIG_SMITHING_QUENCH "smithing_done"
#define COMSIG_SMITHING_PASSIVE_COOLED "smithing_passive_cooled"

#define DOAFTER_SMITHING_FORGE "smithing_forging_doafter"
#define DOAFTER_SMITHING_ANVIL "smithing_anvil_doafter"

#define DOAFTER_REVOLVER_HAMMER_COCK "smithing_revolver_hammer_cock_doafter"

#define FORGING_WEAPON_REFORGING_MAX_QUALITY 16
#define FORGING_WEAPON_REFORGING_AVERAGE_WAIT 2 SECONDS
#define FORGING_WEAPON_REFORGING_MAX_PERFECT_HITS 10
#define FORGING_WEAPON_REFORGING_MAX_BAD_HITS 6

#define FORGING_CLOTHING_REFORGING_MAX_QUALITY 16
#define FORGING_CLOTHING_REFORGING_AVERAGE_WAIT 2 SECONDS
#define FORGING_CLOTHING_REFORGING_MAX_PERFECT_HITS 10
#define FORGING_CLOTHING_REFORGING_MAX_BAD_HITS 6

#define USER_CAN_REAGENT_IMBUE(user) (HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING) || user.mind.get_skill_level(/datum/skill/smithing) >= SKILL_LEVEL_MASTER)
/// Minimum and maximum force multiplier if a weapon contains incomplete parts
#define MIN_INCOMPLETE_DAMAGE_MULT 0.1
#define MAX_INCOMPLETE_DAMAGE_MULT 0.5
//ditto, with staff reagents
#define MIN_INCOMPLETE_STAFF_INJECT_MULT 0.2
#define MAX_INCOMPLETE_STAFF_INJECT_MULT 0.5
/// Minimum and maximum force multiplier if a weapon contains incomplete parts
#define MIN_INCOMPLETE_ARMOR_MULT 0.1
#define MAX_INCOMPLETE_ARMOR_MULT 0.5
/// The maximum force that can be given to a weapon via perfect hits
#define MAX_PERFECT_FORCE_BONUS 3
/// maximum force that can be given to a reagent staff via perfect hits
#define MAX_PERFECT_STAFF_INTEG_BONUS 20

///amount of chems that can be stored into the result
#define MAX_PRE_IMBUE_STORAGE 60
///amount of chems that the result reads as
#define DEFAULT_IMBUE_STORAGE 10
#define REAGENT_CLOTHING_INJECT_AMOUNT 0.5
#define REAGENT_WEAPON_INJECT_AMOUNT 4
#define REAGENT_STAFF_INJECT_AMOUNT 10
#define MAX_OIL_AP_AMOUNT 10
#define PERFECT_ACCESSORY_DURABILITY_BONUS 50
#define PERFECT_HANDCUFFS_UNLOCK_SPEED_BONUS 2 SECONDS

#define MAX_QUENCH_HEAT 600
#define MIN_VOLUME_TO_QUENCH 300

#define FORGE_EFFECT_FORCE "forge_effect_force"
#define FORGE_EFFECT_ARMORPEN "forge_effect_armorpen"
#define FORGE_EFFECT_ARMOR "forge_effect_armor"
#define FORGE_EFFECT_DURABILITY "forge_effect_durability"
#define FORGE_EFFECT_BLOCKCHANCE "forge_effect_block"
