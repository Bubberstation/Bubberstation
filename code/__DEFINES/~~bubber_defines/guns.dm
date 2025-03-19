// open to suggestions on where to put these overrides
// hugely not a fan of this but we do what we gotta

/*
 * gotta redefine EVERY goddamn ammo type irt to new mat costs for the ammobench's sake
 * previously, SMALL_MATERIAL_AMOUNT was 100 units out of 2000 from a sheet (5%)
 * so the old cost of SMALL_MATERIAL_AMOUNT * 5 was 500/2000 from a sheet (25%)
 * experimental material balance PR makes it so that SMALL_MATERIAL_AMOUNT is actually 10 units out of 100 (10%)
 * which made it so that the old assumed value of SMALL_MATERIAL_AMOUNT * 5 is 50/100 (50% of a sheet for a single bullet) (suboptimal)
 * these updated, more consistent defines make it so that a single round's total materials should total 20% of a sheet, or 2 SMALL_MATERIAL_AMOUNT
*/

#define AMMO_MATS_BASIC list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, \
)

#define AMMO_MATS_AP list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.6, \
	/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 0.4, \
)

#define AMMO_MATS_TEMP list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.6, \
	/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 0.4, \
)

#define AMMO_MATS_EMP list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.6, \
	/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 0.4, \
)

#define AMMO_MATS_PHASIC list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.6, \
	/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 0.4, \
)

#define AMMO_MATS_TRAC list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.6, \
	/datum/material/silver = SMALL_MATERIAL_AMOUNT * 0.2, \
	/datum/material/gold = SMALL_MATERIAL_AMOUNT * 0.2, \
)

#define AMMO_MATS_HOMING list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1, \
	/datum/material/silver = SMALL_MATERIAL_AMOUNT * 0.2, \
	/datum/material/gold = SMALL_MATERIAL_AMOUNT * 0.2, \
	/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 0.2, \
	/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 0.2, \
	/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 0.2, \
)

// for .35 Sol Ripper
#define AMMO_MATS_RIPPER list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.6, \
	/datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.4, \
)

#define AMMO_MATS_SHOTGUN list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4) // not quite as thick as a half-sheet

#define AMMO_MATS_SHOTGUN_FLECH list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,\
									/datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)

#define AMMO_MATS_SHOTGUN_HIVE list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,\
									/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 1,\
									/datum/material/silver = SMALL_MATERIAL_AMOUNT * 1)

#define AMMO_MATS_SHOTGUN_TIDE list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,\
									/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 1,\
									/datum/material/gold = SMALL_MATERIAL_AMOUNT * 1)

#define AMMO_MATS_SHOTGUN_PLASMA list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,\
									/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 2)
