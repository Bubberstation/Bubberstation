// Signal sent when the morgue tray throws its alarm
#define COMSIG_MORGUE_ALARM "morgue_alarm"
// Can be sent whenever an object's name is changed so components can be properly updated as well
#define COMSIG_NAME_CHANGED "name_changed"
///from [/mob/living/carbon/human/Move]: ()
#define COMSIG_NECK_STEP_ACTION "neck_step_action"
/// from /obj/item/organ/proc/on_bodypart_remove(obj/item/bodypart/limb, movement_flags)
#define COMSIG_ORGAN_BODYPART_REMOVED "organ_bodypart_removed"
/// From /datum/controller/subsystem/economy/proc/issue_paydays()
#define COMSIG_ON_BANK_ACCOUNT_PAYOUT "bank_account_payout"
/// identical to COMSIG_MOB_APPLY_DAMAGE, but always runs, even if there is no damage
#define COMSIG_MOB_ALWAYS_APPLY_DAMAGE "mob_always_apply_damage"
/// From modular_zubbers/code/modules/disease/disease_transmission.dm
#define COMSIG_DISEASE_COUNT_UPDATE "disease_count_update"
/// From [/mob/living/carbon/human/verb/safeword]: (mob/living/carbon)
#define COMSIG_OOC_ESCAPE "ooc_escape"
/// From [/datum/outfit]: (datum/outfit)
#define COMSIG_OUTFIT_EQUIP "outfit_equip"
/// at the end of /mob/living/proc/can_enter_vent(obj/machinery/atmospherics/components/ventcrawl_target, provide_feedback = TRUE)
/// Return true in this signal to allow ventcrawling, but you need atleast TRAIT_VENTCRAWLER_NUDE on the mob. Sorry. It does allow for custom config via the signal, however
#define COMSIG_CAN_VENTCRAWL "can_ventcrawl"
#define COMISG_VENTCRAWL_PRE_ENTER "ventcrawling_pre_enter"
#define COMSIG_VENTCRAWL_PRE_EXIT "ventcrawling_pre_exit"
#define COMSIG_VENTCRAWL_ENTER "ventcrawling_enter"
#define COMSIG_VENTCRAWL_EXIT "ventcrawling_exit"
#define COMSIG_VENTCRAWL_PRE_CANCEL "ventcrawling_pre_cancel"
/// From /mob/proc/equip_to_slot_if_possible()
#define COMSIG_MOB_POST_EQUIP "mob_post_equip"
/// From /mob/living/carbon/human/verb/toggle_undies()
#define COMSIG_HUMAN_TOGGLE_UNDERWEAR "human_toggle_undies"
/// From /obj/item/restraints/handcuffs/proc/apply_cuffs()
#define COMSIG_MOB_HANDCUFFED "mob_handcuffed"
/// From /datum/bodypart_overlay/simple/emote/Destroy() - Calls when an emote that applies a temporary visual effect expires
#define COMSIG_EMOTE_OVERLAY_EXPIRE "emote_overlay_exprie"
/// From /mob/living/carbon/human/proc/adjust_arousal() - Triggered by status
#define COMSIG_HUMAN_ADJUST_AROUSAL "human_adjust_arousal"
/// from /mob/living/carbon/human/verb/toggle_arousal() - Triggered by player toggle
#define COMSIG_HUMAN_TOGGLE_AROUSAL "human_toggle_arousal"
/// From /mob/living/carbon/human/verb/toggle_genitals()
#define COMSIG_HUMAN_TOGGLE_GENITALS "human_toggle_genitals"

/// /datum/component/tameable/try_tame(atom/source, obj/item/food, mob/living/attacker) in 
#define COMSIG_MOB_TRY_TAME "mob_try_tame"
