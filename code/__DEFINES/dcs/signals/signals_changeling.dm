///Called when a changeling uses its transform ability (source = carbon), from /datum/action/changeling/transform/sting_action(mob/living/carbon/human/user)
#define COMSIG_CHANGELING_TRANSFORM "changeling_transform"

///Called when the Organic Capacitor HUD element needs redrawing (source = mob), from /atom/movable/screen/ling/capacitor
#define COMSIG_CHANGELING_UPDATE_CAPACITOR_HUD "changeling_update_capacitor_hud"

///Called to add or remove Organic Capacitor charge from outside the power itself (source = mob), e.g. BZ metabolites burning it off.
#define COMSIG_CHANGELING_ADJUST_CAPACITOR "changeling_adjust_capacitor"
