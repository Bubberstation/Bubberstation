// Signals involving reagents with a mob

//
// ADD SIGNALS
//

/**
 * Triggered when adding Cum or Femcum
 * * Used by quirk: Concubus
 * * Used by quirk: Dumb For Cum
 */
#define COMSIG_REAGENT_ADD_CUM "reagent_add_cum"

/**
 * Triggered when adding Breast Milk
 * * Used by quirk: Concubus
 */
#define COMSIG_REAGENT_ADD_BREASTMILK "reagent_add_breastmilk"

/**
 * Triggered when adding Blood
 * * Used by quirk: Bloodfledge
 */
#define COMSIG_REAGENT_ADD_BLOOD "reagent_add_blood"

//
// METABOLIZE SIGNALS
//

/**
 * Triggered when metabolizing Nuka Cola
 * * Used by quirk: Rad Fiend
 */
#define COMSIG_REAGENT_METABOLIZE_NUKACOLA "reagent_metabolize_nukacola"

/**
 * Triggered when metabolizing Holy Water
 * * Used by quirk: Hallowed
 */
#define COMSIG_REAGENT_METABOLIZE_HOLYWATER "reagent_metabolize_holywater"

/**
 * Triggered when done metabolizing Holy Water
 * * Used by quirk: Cursed Blood
 */
#define COMSIG_REAGENT_METABOLIZE_END_HOLYWATER "reagent_metabolize_end_holywater"

//
// PROCESSING SIGNALS
//

/**
 * Triggered when processing Holy Water
 * * Used by quirk: Bloodfledge
 * * Used by quirk: Cursed Blood
 * * Used by quirk: Hallowed
 */
#define COMSIG_REAGENT_PROCESS_HOLYWATER "reagent_process_holywater"

/**
 * Triggered when processing Hell Water
 * * Used by quirk: Cursed Blood
 */
#define COMSIG_REAGENT_PROCESS_HELLWATER "reagent_process_hellwater"

/**
 * Triggered when processing Salt
 * * Used by quirk: Sodium Sensitivity
 */
#define COMSIG_REAGENT_PROCESS_SALT "reagent_process_salt"

//
// MOB EXPOSE SIGNALS
//

/**
 * Triggered when a mob is exposed to Salt
 * * Used by quirk: Sodium Sensitivity
 */
#define COMSIG_REAGENT_EXPOSE_SALT "reagent_expose_salt"

/**
 * Triggered when a mob is exposed to Holy Water
 * * Used by quirk: Sodium Sensitivity
 */
#define COMSIG_REAGENT_EXPOSE_HOLYWATER "reagent_expose_holywater"
