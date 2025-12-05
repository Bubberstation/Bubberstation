//This is basically unused in regular gameplay.
//Making this a virus may be... unbalanced considering that this can spread via contact/airborne/walking on blood and would probably be inbalanced.
//Maybe use this in the future if you think you can balance it. I don' recommend it. ~BurgerBB

/datum/disease/advance/changelingzombie
	copy_type = /datum/disease/advance

/datum/disease/advance/changelingzombie/New()
	name = "Classified Virus"
	symptoms = list(
		new/datum/symptom/changelingzombie,
		new/datum/symptom/shedding,
		new/datum/symptom/viralevolution,
		new/datum/symptom/disfiguration
	)
	..()

/datum/symptom/changelingzombie

	name = "changeling zombie transformation"
	illness = "CLASSIFIED"
	desc = "Upon reaching stage 4, the victim will undergo the process of changeling zombie transformation."
	naturally_occuring = FALSE

	stealth = -6
	resistance = 3
	stage_speed = 2
	transmittable = -6

	level = 10
	severity = 100

	required_organ = ORGAN_SLOT_BRAIN

	symptom_delay_min = 100
	symptom_delay_max = 100

	threshold_descs = list(
		"Stage Speed 8" = "Causes the transformation process to begin on stage 3 instead of 5.",
		"Transmission 4" = "Causes toxin damage over time.",
		"Resistance 12" = "Curing the virus won't inherently cure already transformed hosts."
	)

	var/required_stage = 5
	var/toxic = FALSE
	var/should_cure_changeling_zombie = TRUE

/datum/symptom/changelingzombie/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(!toxic || neutered || !power)
		return
	if(A.stage < required_stage)
		return
	var/damage_to_deal = (A.stage * power) - 2
	if(damage_to_deal <= 0)
		return
	A.affected_mob.adjust_tox_loss(damage_to_deal)

/datum/symptom/changelingzombie/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStageSpeed() > 8)
		required_stage = 3
	if(A.totalTransmittable() > 4)
		toxic = TRUE
		symptom_delay_min = 1
		symptom_delay_max = 1
	if(A.totalResistance() > 12)
		should_cure_changeling_zombie = FALSE

/datum/symptom/changelingzombie/on_stage_change(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(!neutered && power && A.stage >= required_stage && can_become_changeling_zombie(A.affected_mob))
		A.affected_mob.AddComponent(/datum/component/changeling_zombie_infection)

/datum/symptom/changelingzombie/End(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	//Fun fact: This even affects the neutered variant.
	//It is theoretically possible to make a neutered variant that actually cures already transformed people.
	var/datum/component/changeling_zombie_infection/found_infection = A.affected_mob.GetComponent(/datum/component/changeling_zombie_infection)
	if(!found_infection)
		return
	if(found_infection.zombified && !neutered && !should_cure_changeling_zombie)
		return
	qdel(found_infection)


