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

/datum/surgery_step/proc/get_feedback_message(mob/living/user, mob/living/target, speed_mod = 1)
	return

/datum/surgery_step/heal/brute/get_feedback_message(mob/living/user, mob/living/target, speed_mod = 1)
	var/show_message = FALSE
	if(HAS_TRAIT(user, TRAIT_MEDICAL_HUD))
		show_message = TRUE
	else if(locate(/obj/item/healthanalyzer) in user.held_items)
		show_message = TRUE
	else if(get_location_modifier(target) == OPERATING_COMPUTER_MODIFIER)
		show_message = TRUE

	if(show_message)
		return "[round(1 / speed_mod, 0.1)]x (<font color='#F0197D'>[target.get_brute_loss()]</font>) <font color='#7DF9FF'>[feedback_value]</font>"

/datum/surgery_step/heal/burn/get_feedback_message(mob/living/user, mob/living/target, speed_mod = 1)
	var/show_message = FALSE
	if(HAS_TRAIT(user, TRAIT_MEDICAL_HUD))
		show_message = TRUE
	else if(locate(/obj/item/healthanalyzer) in user.held_items)
		show_message = TRUE
	else if(get_location_modifier(target) == OPERATING_COMPUTER_MODIFIER)
		show_message = TRUE

	if(show_message)
		return "[round(1 / speed_mod, 0.1)]x (<font color='#FF7F50'>[target.get_fire_loss()]</font>) <font color='#7DF9FF'>[feedback_value]</font>"

/datum/surgery_step/heal/combo/get_feedback_message(mob/living/user, mob/living/target, speed_mod = 1)
	var/show_message = FALSE
	if(HAS_TRAIT(user, TRAIT_MEDICAL_HUD))
		show_message = TRUE
	else if(locate(/obj/item/healthanalyzer) in user.held_items)
		show_message = TRUE
	else if(get_location_modifier(target) == OPERATING_COMPUTER_MODIFIER)
		show_message = TRUE

	if(show_message)
		return "[round(1 / speed_mod, 0.1)]x (<font color='#F0197D'>[target.get_brute_loss()]</font>/<font color='#FF7F50'>[target.get_fire_loss()]</font>) <font color='#7DF9FF'>[feedback_value]</font>"
