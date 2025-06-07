/* GLOBAL_DATUM_INIT(has_no_eol_punctuation, /regex, regex("\\w$"))
GLOBAL_DATUM_INIT(noncapital_i, /regex, regex("\\b\[i]\\b", "g")) */ // TODO: REMOVE THIS IN FAVOUR OF THE SKYRAT FILE.
//Auto punctuation global datums

// The alpha channel gained upon ghosting
#define GHOST_ALPHA 180

/// Used for the trait for when a dragon looses a portal
#define DRAGON_PORTAL_LOSS "dragon_portal_loss"

/// From /mob/proc/equip_to_slot_if_possible()
#define COMSIG_MOB_POST_EQUIP "mob_post_equip"
/// From /mob/living/carbon/human/verb/toggle_undies()
#define COMSIG_HUMAN_TOGGLE_UNDERWEAR "human_toggle_undies"
/// From /obj/item/restraints/handcuffs/proc/apply_cuffs()
#define COMSIG_MOB_HANDCUFFED "mob_handcuffed"
/// From /datum/bodypart_overlay/simple/emote/Destroy() - Calls when an emote that applies a temporary visual effect expires
#define COMSIG_EMOTE_OVERLAY_EXPIRE "emote_overlay_exprie"
/// From /mob/living/carbon/human/proc/adjust_arousal()
#define COMSIG_HUMAN_ADJUST_AROUSAL "human_adjust_arousal"
/// From /mob/living/carbon/human/verb/toggle_genitals()
#define COMSIG_HUMAN_TOGGLE_GENITALS "human_toggle_genitals"
