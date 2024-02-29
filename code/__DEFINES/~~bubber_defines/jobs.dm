#define RECORDS_TEXT_CHAR_REQUIREMENT 15
#define JOB_UNAVAILABLE_FLAVOUR_SILICON (JOB_UNAVAILABLE_AUGMENT + 1)
//A proc to determine if a job is a silicon job.
#define is_silicon_job(A) (istype(A, /datum/job/ai) || istype(A, /datum/job/cyborg))

/**
 * =======================
 * WARNING WARNING WARNING
 * WARNING WARNING WARNING
 * WARNING WARNING WARNING
 * =======================
 * These names are used as keys in many locations in the database
 * you cannot change them trivially without breaking job bans and
 * role time tracking, if you do this and get it wrong you will die
 * and it will hurt the entire time
 */

// Our exclusive jobs
#define JOB_SECURITY_MEDIC "Security Medic"
#define JOB_BLACKSMITH "Blacksmith"

#define JOB_DISPLAY_ORDER_BLACKSMITH 48
