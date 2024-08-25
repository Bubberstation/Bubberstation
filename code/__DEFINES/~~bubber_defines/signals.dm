// Signal sent when the morgue tray throws its alarm
#define COMSIG_MORGUE_ALARM "morgue_alarm"
// Can be sent whenever an object's name is changed so components can be properly updated as well
#define COMSIG_NAME_CHANGED "name_changed"
///from [/mob/living/carbon/human/Move]: ()
#define COMSIG_NECK_STEP_ACTION "neck_step_action"

// CORRUPTION SIGNALS

/// From /obj/structure/fleshmind/structure/proc/activate_ability() (src)
#define COMSIG_CORRUPTION_STRUCTURE_ABILITY_TRIGGERED "corruption_structure_ability_triggered"

/// From /mob/living/basic/fleshmind/phaser/proc/phase_move_to(atom/target, nearby = FALSE)
#define COMSIG_PHASER_PHASE_MOVE "phaser_phase_move"
/// from /mob/living/basic/fleshmind/phaser/proc/enter_nearby_closet()
#define COMSIG_PHASER_ENTER_CLOSET "phaser_enter_closet"

/// from /obj/structure/fleshmind/structure/core/proc/rally_troops()
#define COMSIG_FLESHMIND_CORE_RALLY "fleshmind_core_rally"
