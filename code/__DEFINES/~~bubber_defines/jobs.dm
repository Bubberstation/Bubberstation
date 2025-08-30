#define RECORDS_TEXT_CHAR_REQUIREMENT 15
#define JOB_UNAVAILABLE_FLAVOUR_SILICON (JOB_UNAVAILABLE_NOHANDS + 1)
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

/// Time after clocking out before you can clock in again
#define TIMECLOCK_COOLDOWN 5 MINUTES

/// What items do we want to remove from the person clocking out?
#define SELF_SERVE_RETURN_ITEMS list( \
	/obj/item/melee/baton/security, \
	/obj/item/melee/baton/security/loaded, \
	/obj/item/melee/baton/telescopic, \
	/obj/item/melee/baton, \
	/obj/item/assembly/flash/handheld, \
	/obj/item/gun/energy/disabler, \
	/obj/item/megaphone/command, \
	/obj/item/door_remote/captain, \
	/obj/item/door_remote/chief_engineer, \
	/obj/item/door_remote/research_director, \
	/obj/item/door_remote/head_of_security, \
	/obj/item/door_remote/quartermaster, \
	/obj/item/door_remote/chief_medical_officer, \
	/obj/item/circuitboard/machine/techfab/department/engineering, \
	/obj/item/circuitboard/machine/techfab/department/service, \
	/obj/item/circuitboard/machine/techfab/department/security, \
	/obj/item/circuitboard/machine/techfab/department/medical, \
	/obj/item/circuitboard/machine/techfab/department/cargo, \
	/obj/item/circuitboard/machine/techfab/department/science, \
	/obj/item/blueprints, \
	/obj/item/pipe_dispenser/bluespace, \
	/obj/item/mod/control/pre_equipped/advanced, \
	/obj/item/clothing/shoes/magboots/advance, \
	/obj/item/shield/riot/tele, \
	/obj/item/storage/belt/security/full, \
	/obj/item/gun/energy/e_gun/hos, \
	/obj/item/pinpointer/nuke, \
	/obj/item/gun/energy/e_gun, \
	/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild, \
	/obj/item/storage/belt/sheath/sabre, \
	/obj/item/mod/control/pre_equipped/magnate, \
	/obj/item/mod/control/pre_equipped/blueshield, \
	/obj/item/clothing/suit/armor/vest/warden, \
	/obj/item/clothing/glasses/hud/security/sunglasses, \
	/obj/item/clothing/gloves/krav_maga/sec, \
	/obj/item/clothing/suit/armor/vest/alt/sec, \
	/obj/item/storage/belt/holster/detective/full, \
	/obj/item/reagent_containers/spray/pepper, \
	/obj/item/detective_scanner, \
	/obj/item/gun/ballistic/revolver/c38/detective, \
	/obj/item/mod/control/pre_equipped/security, \
	/obj/item/mod/control/pre_equipped/safeguard, \
	/obj/item/gun/energy/cell_loaded/medigun/cmo, \
	/obj/item/defibrillator/compact/loaded, \
	/obj/item/storage/hypospraykit/cmo/preloaded, \
	/obj/item/mod/control/pre_equipped/rescue, \
	/obj/item/gun/ballistic/rifle/boltaction/sporterized, \
	/obj/item/clothing/glasses/hud/gun_permit/sunglasses, \
	/obj/item/card/id/departmental_budget/car, \
	/obj/item/clothing/suit/armor/reactive/teleport, \
	/obj/item/mod/control/pre_equipped/research, \
)
