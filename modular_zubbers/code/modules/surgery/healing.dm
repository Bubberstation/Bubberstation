// Speed changes to tend wounds balancing for 135% player health
/datum/surgery_step/heal
	time = 2.7 SECONDS

/datum/surgery_step/heal/brute/basic
	brutehealing = 7

/datum/surgery_step/heal/brute/upgraded
	brutehealing = 7

/datum/surgery_step/heal/brute/upgraded/femto
	brutehealing = 7

/datum/surgery_step/heal/burn/basic
	burnhealing = 7

/datum/surgery_step/heal/burn/upgraded
	burnhealing = 7

/datum/surgery_step/heal/burn/upgraded/femto
	burnhealing = 7

/datum/surgery_step/heal/combo
	brutehealing = 5
	burnhealing = 5
	brute_multiplier = 0.07
	burn_multiplier = 0.07
	time = 1.5 SECONDS

/datum/surgery_step/heal/combo/upgraded
	brutehealing = 5
	burnhealing = 5
	brute_multiplier = 0.1
	burn_multiplier = 0.1

/datum/surgery_step/heal/combo/upgraded/femto
	brutehealing = 7
	burnhealing = 7
	brute_multiplier = 0.2
	burn_multiplier = 0.2
	time = 1.5 SECONDS
