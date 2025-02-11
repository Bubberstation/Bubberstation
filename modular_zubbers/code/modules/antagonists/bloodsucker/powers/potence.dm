
/datum/action/cooldown/bloodsucker/potence
	name = "Potence"
	desc = "Endow yourself with extraordinary strength."
	button_icon_state = "power_strength"
	power_flags = BP_CONTINUOUS_EFFECT
	check_flags = AB_CHECK_CONSCIOUS
	purchase_flags = BLOODSUCKER_CAN_BUY|GHOUL_CAN_BUY
	bloodcost = 10
	constant_bloodcost = 1
	cooldown_time = 20 SECONDS

/datum/action/cooldown/bloodsucker/potence/get_power_explanation_extended()
	. = list()
	. += "Utilize your blood to augment your strength."
	. += "This will drain blood at a constant rate of one unit per second while active."
	. += "Your punches will deal [GetPowerLevel()] more damage and penetrate [GetEffectiveness()] armor."

/datum/action/cooldown/bloodsucker/potence/ActivatePower(atom/target)
	. = ..()
	var/mob/living/carbon/human/user = owner
	var/hitStrength = GetPowerLevel()
	var/hitEffectiveness = GetEffectiveness()
	for (var/body_zone in GLOB.limb_zones)
		var/obj/item/bodypart/parts_to_buff = user.get_bodypart(body_zone)
		parts_to_buff.unarmed_damage_low += hitStrength
		parts_to_buff.unarmed_damage_high += hitStrength
		parts_to_buff.unarmed_effectiveness += hitEffectiveness
	user.balloon_alert(user, "you feel stronger.")

/datum/action/cooldown/bloodsucker/potence/process(seconds_per_tick)
	// Checks that we can keep using this.
	. = ..()
	if(!.)
		return
	if(!active)
		return

/datum/action/cooldown/bloodsucker/potence/ContinueActive(mob/living/user, mob/living/target)
	. = ..()
	if(!.)
		return FALSE
	/// Must be CONSCIOUS
	if(user.stat != CONSCIOUS)
		to_chat(owner, span_warning("you feel weaker."))
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/potence/proc/GetPowerLevel()
	return 5 + min(2*level_current, 30)

/datum/action/cooldown/bloodsucker/potence/proc/GetEffectiveness() // i learned real quick you don't want unarmed effectiveness to be too high
	return 5 + min(level_current, 10)

/datum/action/cooldown/bloodsucker/potence/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/user = owner
	var/hitStrength = GetPowerLevel()
	var/hitEffectiveness = GetEffectiveness()
	for (var/body_zone in GLOB.limb_zones)
		var/obj/item/bodypart/parts_to_buff = user.get_bodypart(body_zone)
		parts_to_buff.unarmed_damage_low -= hitStrength
		parts_to_buff.unarmed_damage_high -= hitStrength
		parts_to_buff.unarmed_effectiveness -= hitEffectiveness
	user.balloon_alert(user, "you feel weaker.")
