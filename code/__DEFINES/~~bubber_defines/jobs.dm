#define RECORDS_TEXT_CHAR_REQUIREMENT 15
#define JOB_UNAVAILABLE_FLAVOUR_SILICON (JOB_UNAVAILABLE_AUGMENT + 1)
//A proc to determine if a job is a silicon job, used in job.dm line 925
#define is_silicon_job(A) (istype(A, /datum/job/ai) || istype(A, /datum/job/cyborg))
