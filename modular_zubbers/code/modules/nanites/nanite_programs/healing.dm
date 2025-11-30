//Programs that heal the host in some way.

/datum/nanite_program/regenerative
	name = "Accelerated Regeneration"
	desc = "The nanites boost the host's natural regeneration, increasing their healing speed. Will not consume nanites while the host is unharmed."
	use_rate = 0.5
	rogue_types = list(/datum/nanite_program/necrotic)
	var/valid_bodytype = BODYTYPE_ORGANIC
	var/valid_biotype = MOB_ORGANIC
	var/healing_rate = NANITE_BIO_REGENERATION
	var/always_active = FALSE

/datum/nanite_program/regenerative/check_conditions()
	if(always_active)
		return TRUE
	if(!host_mob.get_brute_loss() && !host_mob.get_fire_loss())
		return FALSE
	if(iscarbon(host_mob))
		var/mob/living/carbon/carbon = host_mob
		var/list/parts = carbon.get_damaged_bodyparts(TRUE, TRUE, valid_bodytype)
		if(!parts.len)
			return FALSE
	else if(!(host_mob.mob_biotypes & valid_biotype))
		return FALSE
	return ..()

/datum/nanite_program/regenerative/active_effect()
	host_mob.heal_overall_damage(healing_rate, healing_rate, required_bodytype = valid_bodytype)

/datum/nanite_program/regenerative/advanced
	name = "Bio-Reconstruction"
	desc = "The nanites manually repair and replace organic cells, acting much faster than normal regeneration. \
			However, this program cannot detect the difference between harmed and unharmed, causing it to consume nanites even if it has no effect."
	use_rate = 5.5
	rogue_types = list(/datum/nanite_program/suffocating, /datum/nanite_program/necrotic)
	healing_rate = NANITE_ADV_BIO_REGENERATION
	always_active = TRUE

/datum/nanite_program/regenerative/robotic
	name = "Mechanical Repair"
	desc = "The nanites fix damage in the host's mechanical limbs. Will not consume nanites while the host's mechanical limbs are undamaged, or while the host has no mechanical limbs."
	use_rate = 3
	rogue_types = list(/datum/nanite_program/necrotic)
	valid_bodytype = BODYTYPE_ROBOTIC
	valid_biotype = MOB_ROBOTIC
	healing_rate = NANITE_ROBO_REGENERATION

/datum/nanite_program/temperature
	name = "Temperature Adjustment"
	desc = "The nanites adjust the host's internal temperature to an ideal level. Will not consume nanites while the host is at a normal body temperature."
	use_rate = 3.5
	rogue_types = list(/datum/nanite_program/skin_decay)

/datum/nanite_program/temperature/check_conditions()
	if(host_mob.bodytemperature > (host_mob.get_body_temp_normal(apply_change=FALSE) - 30) && host_mob.bodytemperature < (host_mob.get_body_temp_normal(apply_change=FALSE) + 30))
		return FALSE
	return ..()

/datum/nanite_program/temperature/active_effect()
	var/target_temp = host_mob.get_body_temp_normal(apply_change=FALSE)
	if(host_mob.bodytemperature > target_temp)
		host_mob.adjust_bodytemperature(-40 * TEMPERATURE_DAMAGE_COEFFICIENT, target_temp)
	else if(host_mob.bodytemperature < (target_temp + 1))
		host_mob.adjust_bodytemperature(40 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, target_temp)

/datum/nanite_program/purging
	name = "Blood Purification"
	desc = "The nanites purge toxins and chemicals from the host's bloodstream. Consumes nanites even if it has no effect."
	use_rate = 1
	rogue_types = list(/datum/nanite_program/suffocating, /datum/nanite_program/necrotic)
	var/healing_rate = NANITE_TOX_REGENERATION
	var/purge_path = /datum/reagent
	var/force_heal = FALSE

/datum/nanite_program/purging/check_conditions()
	. = ..()
	if(!. || !host_mob.reagents)
		return FALSE // No trying to purge simple mobs

/datum/nanite_program/purging/active_effect()
	host_mob.adjust_tox_loss(-healing_rate, forced = force_heal)
	for(var/datum/reagent/R as anything in host_mob.reagents.reagent_list)
		if(!istype(R, purge_path))
			continue
		host_mob.reagents.remove_reagent(R.type, 1)

/datum/nanite_program/purging/advanced
	name = "Selective Blood Purification"
	desc = "The nanites purge toxins and dangerous chemicals from the host's bloodstream, while ignoring beneficial chemicals. \
			The added processing power required to analyze the chemicals severely increases the nanite consumption rate. Consumes nanites even if it has no effect."
	use_rate = 2
	rogue_types = list(/datum/nanite_program/suffocating, /datum/nanite_program/necrotic)
	healing_rate = NANITE_ADV_TOX_REGENERATION
	purge_path = /datum/reagent/toxin
	force_heal = TRUE

/datum/nanite_program/blood_restoring
	name = "Blood Regeneration"
	desc = "The nanites stimulate and boost blood cell production in the host. Will not consume nanites while the host has a safe blood level."
	use_rate = 1
	rogue_types = list(/datum/nanite_program/suffocating)

/datum/nanite_program/blood_restoring/check_conditions()
	if(iscarbon(host_mob))
		var/mob/living/carbon/C = host_mob
		if(C.blood_volume >= BLOOD_VOLUME_SAFE)
			return FALSE
	else
		return FALSE
	return ..()

/datum/nanite_program/blood_restoring/active_effect()
	if(iscarbon(host_mob))
		var/mob/living/carbon/C = host_mob
		C.blood_volume += 2

/datum/nanite_program/brain_heal
	name = "Neural Regeneration"
	desc = "The nanites fix neural connections in the host's brain, reversing brain damage and minor traumas. Will not consume nanites while it would not have an effect."
	use_rate = 1.5
	rogue_types = list(/datum/nanite_program/brain_decay)

/datum/nanite_program/brain_heal/check_conditions()
	if(host_mob.get_organ_loss(ORGAN_SLOT_BRAIN) > 0)
		return ..()
	if(iscarbon(host_mob))
		var/mob/living/carbon/carbon = host_mob
		if (carbon.has_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC))
			return ..()
	return FALSE

/datum/nanite_program/brain_heal/active_effect()
	host_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, -NANITE_BRAIN_REGENERATION)
	if(iscarbon(host_mob) && prob(1))
		var/mob/living/carbon/C = host_mob
		C.cure_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC)

/datum/nanite_program/brain_heal_advanced
	name = "Neural Reimaging"
	desc = "The nanites are able to backup and restore the host's neural connections, potentially replacing entire chunks of missing or damaged brain matter. Consumes nanites even if it has no effect."
	use_rate = 3
	rogue_types = list(/datum/nanite_program/brain_decay, /datum/nanite_program/brain_misfire)

/datum/nanite_program/brain_heal_advanced/active_effect()
	host_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, -NANITE_ADV_BRAIN_REGENERATION)
	if(iscarbon(host_mob) && prob(1))
		var/mob/living/carbon/C = host_mob
		C.cure_trauma_type(resilience = TRAUMA_RESILIENCE_LOBOTOMY)

/datum/nanite_program/defib
	name = "Defibrillation"
	desc = "The nanites shock the host's heart when triggered, bringing them back to life if the body can sustain it."
	can_trigger = TRUE
	trigger_cost = 25
	trigger_cooldown = 120
	rogue_types = list(/datum/nanite_program/shocking)

/datum/nanite_program/defib/on_trigger(comm_message)
	host_mob.notify_revival("Your heart is being defibrillated by nanites. Re-enter your corpse if you want to be revived!")
	host_mob.grab_ghost()
	playsound(host_mob, 'sound/machines/defib/defib_charge.ogg', 50, FALSE)
	send_user_message("Starting user revival sequence.")
	addtimer(CALLBACK(src, PROC_REF(zap)), 5 SECONDS)

/datum/nanite_program/defib/proc/check_revivable()
	if(!iscarbon(host_mob)) //nonstandard biology
		return FALSE
	var/mob/living/carbon/C = host_mob
	return C.can_defib() & DEFIB_POSSIBLE | DEFIB_NOGRAB_AGHOST

/datum/nanite_program/defib/proc/zap()
	var/mob/living/carbon/C = host_mob
	playsound(C, 'sound/machines/defib/defib_zap.ogg', 50, FALSE)
	C.balloon_alert_to_viewers("twitches violently")
	C.get_ghost()
	if(check_revivable())
		if(C.stat == DEAD)
			var/original_oxyloss = C.get_oxy_loss()
			C.set_oxy_loss(OXYLOSS_PASSOUT_THRESHOLD - 5)
			C.SetSleeping(5 SECONDS)
			C.set_heartattack(FALSE)
			if(C.revive())
				playsound(C, 'sound/machines/defib/defib_success.ogg', 50, FALSE)
				C.emote("gasp")
				C.adjust_jitter_up_to(10 SECONDS, 1 MINUTES)
				SEND_SIGNAL(C, COMSIG_LIVING_MINOR_SHOCK)
				log_game("[C] has been successfully defibrillated by nanites.")
				send_user_message("User revival sequence success.")
				return
			else
				C.set_oxy_loss(original_oxyloss)
	if(C.undergoing_cardiac_arrest() || C.has_status_effect(/datum/status_effect/heart_attack))
		SEND_SIGNAL(C, COMSIG_HEARTATTACK_DEFIB)
		send_user_message("User cardiac arrest prevention attempted.")
		return
	else
		C.apply_status_effect(/datum/status_effect/heart_attack)
	send_user_message("User revival sequence failure.")
	playsound(C, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)

