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
/// From /mob/proc/equip_to_slot_if_possible()
#define COMSIG_MOB_POST_EQUIP "mob_post_equip"
/// From /mob/living/carbon/human/verb/toggle_undies()
#define COMSIG_HUMAN_TOGGLE_UNDERWEAR "human_toggle_undies"
/// From /obj/item/restraints/handcuffs/proc/apply_cuffs()
#define COMSIG_MOB_HANDCUFFED "mob_handcuffed"
