/datum/surgery/healing2
	target_mobtypes = list(/mob/living)
	requires_bodypart_type = BODYTYPE_ORGANIC //SKYRAT EDIT CHANGE - ORIGINAL VALUE: requires_bodypart_type = FALSE
	replaced_by = /datum/surgery
	surgery_flags = SURGERY_IGNORE_CLOTHES | SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/heal2,
		/datum/surgery_step/close,
	)

	var/healing_step_type
	var/antispam = FALSE

/datum/surgery/healing2/can_start(mob/user, mob/living/patient)
	. = ..()
	if(!(patient.mob_biotypes & (MOB_ORGANIC|MOB_HUMANOID)))
		return FALSE

/datum/surgery/healing2/New(surgery_target, surgery_location, surgery_bodypart)
	..()
	if(healing_step_type)
		steps = list(
			/datum/surgery_step/incise/nobleed,
			healing_step_type, //hehe cheeky
			/datum/surgery_step/close)

/datum/surgery_step/heal2
	name = "filter blood (bloodfilter)"
	implements = list(
		TOOL_BLOODFILTER = 100,
		/obj/item/plunger = 25)
	repeatable = TRUE
	time = 25
	success_sound = 'sound/machines/ping.ogg'
	failure_sound = 'sound/surgery/organ2.ogg'
	var/toxinhealing = 0
	var/oxygenhealing = 0
	var/toxin_multiplier = 0 //multiplies the damage that the patient has. if 0 the patient wont get any additional healing from the damage he has.
	var/oxygen_multiplier = 0

/// Returns a string letting the surgeon know roughly how much longer the surgery is estimated to take at the going rate
/datum/surgery_step/heal2/proc/get_progress(mob/user, mob/living/carbon/target, toxin_healed, oxygen_healed)
	return

/datum/surgery_step/heal2/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/woundtype
	if(toxinhealing && oxygenhealing)
		woundtype = "blood"
	else if(toxinhealing)
		woundtype = "toxin"
	else //why are you trying to 0,0...?
		woundtype = "blood"
	if(istype(surgery,/datum/surgery/healing))
		var/datum/surgery/healing2/the_surgery = surgery
		if(!the_surgery.antispam)
			display_results(
				user,
				target,
				span_notice("You attempt to treat some of [target]'s [woundtype]."),
				span_notice("[user] attempts to treat some of [target]'s [woundtype]."),
				span_notice("[user] attempts to treat some of [target]'s [woundtype]."),
			)
		display_pain(target, "Your [woundtype] sting like hell!")

/datum/surgery_step/heal2/initiate(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail = FALSE)
	if(!..())
		return
	while((toxinhealing && target.getToxLoss()) || (oxygenhealing && target.getOxyLoss()))
		if(!..())
			break

/datum/surgery_step/heal2/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/user_msg = "You succeed in fixing some of [target]'s wounds" //no period, add initial space to "addons"
	var/target_msg = "[user] fixes some of [target]'s wounds" //see above
	var/toxin_healed = toxinhealing
	var/oxygen_healed = oxygenhealing
	var/dead_patient = FALSE
	if(target.stat == DEAD) //dead patients get way less additional heal from the damage they have.
		toxin_healed += round((target.getToxLoss() * (toxin_multiplier * 0.2)),0.1)
		oxygen_healed += round((target.getOxyLoss() * (oxygen_multiplier * 0.2)),0.1)
		dead_patient = TRUE
	else
		toxin_healed += round((target.getToxLoss() * toxin_multiplier),0.1)
		oxygen_healed += round((target.getOxyLoss() * oxygen_multiplier),0.1)
		dead_patient = FALSE
	if(!get_location_accessible(target, target_zone))
		toxin_healed *= 0.55
		oxygen_healed *= 0.55
		user_msg += " as best as you can while [target.p_they()] [target.p_have()] clothing on"
		target_msg += " as best as [user.p_they()] can while [target.p_they()] [target.p_have()] clothing on"
	target.heal_bodypart_damage(toxin_healed,oxygen_healed)

	user_msg += get_progress(user, target, toxin_healed, oxygen_healed)

	if(HAS_MIND_TRAIT(user, TRAIT_MORBID) && ishuman(user) && !dead_patient) //Morbid folk don't care about tending the dead as much as tending the living
		var/mob/living/carbon/human/morbid_weirdo = user
		morbid_weirdo.add_mood_event("morbid_tend_wounds", /datum/mood_event/morbid_tend_wounds)

	display_results(
		user,
		target,
		span_notice("[user_msg]."),
		span_notice("[target_msg]."),
		span_notice("[target_msg]."),
	)
	if(istype(surgery, /datum/surgery/healing))
		var/datum/surgery/healing2/the_surgery = surgery
		the_surgery.antispam = TRUE
	return ..()

/datum/surgery_step/heal2/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_warning("You screwed up!"),
		span_warning("[user] screws up!"),
		span_notice("[user] fixes some of [target]'s wounds."),
		target_detailed = TRUE,
	)
	var/toxin_dealt = toxinhealing * 0.8
	var/oxygen_dealt = oxygenhealing * 0.8
	toxin_dealt += round((target.getToxLoss() * (toxin_multiplier * 0.5)),0.1)
	oxygen_dealt += round((target.getOxyLoss() * (oxygen_multiplier * 0.5)),0.1)
	target.take_bodypart_damage(toxin_dealt, oxygen_dealt, wound_bonus=CANT_WOUND)
	return FALSE

/***************************toxin***************************/
/datum/surgery/healing2/toxin
	name = "Tend Blood (toxin)"

/datum/surgery/healing2/toxin/basic
	name = "Tend Blood (toxin, Basic)"
	replaced_by = /datum/surgery/healing2/toxin/upgraded
	healing_step_type = /datum/surgery_step/heal2/toxin/basic
	desc = "A surgical procedure that provides basic treatment for a patient's toxin traumas. Heals slightly more when the patient is severely injured."

/datum/surgery/healing2/toxin/upgraded
	name = "Tend Blood (toxin, Adv.)"
	replaced_by = /datum/surgery/healing2/toxin/upgraded/femto
	requires_tech = TRUE
	healing_step_type = /datum/surgery_step/heal2/toxin/upgraded
	desc = "A surgical procedure that provides advanced treatment for a patient's toxin traumas. Heals more when the patient is severely injured."

/datum/surgery/healing2/toxin/upgraded/femto
	name = "Tend Blood (toxin, Exp.)"
	replaced_by = /datum/surgery/healing2/combo/upgraded/femto
	requires_tech = TRUE
	healing_step_type = /datum/surgery_step/heal2/toxin/upgraded/femto
	desc = "A surgical procedure that provides experimental treatment for a patient's toxin traumas. Heals considerably more when the patient is severely injured."

/********************TOXIN STEPS********************/
/datum/surgery_step/heal2/toxin/get_progress(mob/user, mob/living/carbon/target, toxin_healed, oxygen_healed)
	if(!toxin_healed)
		return

	var/estimated_remaining_steps = target.getToxLoss() / toxin_healed
	var/progress_text

	if(locate(/obj/item/healthanalyzer) in user.held_items)
		progress_text = ". Remaining toxin: <font color='#28d836'>[target.getToxLoss()]</font>"
	else
		switch(estimated_remaining_steps)
			if(-INFINITY to 1)
				return
			if(1 to 3)
				progress_text = ", pumping out the last few toxins"
			if(3 to 6)
				progress_text = ", counting down the last few toxins left to treat"
			if(6 to 9)
				progress_text = ", continuing to pump away at [target.p_their()] extensive poisoning"
			if(9 to 12)
				progress_text = ", steadying yourself for the long filtration ahead"
			if(12 to 15)
				progress_text = ", though [target.p_they()] still look[target.p_s()] more like a waste dump than a person"
			if(15 to INFINITY)
				progress_text = ", though you feel like you're barely making a dent in filtering [target.p_their()] immense poisoning"

	return progress_text

/datum/surgery_step/heal2/toxin/basic
	name = "tend toxin (bloodfilter)"
	toxinhealing = 5
	toxin_multiplier = 0.07

/datum/surgery_step/heal2/toxin/upgraded
	toxinhealing = 5
	toxin_multiplier = 0.1

/datum/surgery_step/heal2/toxin/upgraded/femto
	toxinhealing = 5
	toxin_multiplier = 0.2

/***************************oxygen***************************/
/datum/surgery/healing2/oxygen
	name = "Tend Blood (oxygen)"

/datum/surgery/healing2/oxygen/basic
	name = "Tend Blood (oxygen, Basic)"
	replaced_by = /datum/surgery/healing2/oxygen/upgraded
	healing_step_type = /datum/surgery_step/heal2/oxygen/basic
	desc = "A surgical procedure that provides basic treatment for a patient's oxygens. Heals slightly more when the patient is severely injured."

/datum/surgery/healing2/oxygen/upgraded
	name = "Tend Blood (oxygen, Adv.)"
	replaced_by = /datum/surgery/healing2/oxygen/upgraded/femto
	requires_tech = TRUE
	healing_step_type = /datum/surgery_step/heal2/oxygen/upgraded
	desc = "A surgical procedure that provides advanced treatment for a patient's oxygens. Heals more when the patient is severely injured."

/datum/surgery/healing2/oxygen/upgraded/femto
	name = "Tend Blood (oxygen, Exp.)"
	replaced_by = /datum/surgery/healing2/combo/upgraded/femto
	requires_tech = TRUE
	healing_step_type = /datum/surgery_step/heal2/oxygen/upgraded/femto
	desc = "A surgical procedure that provides experimental treatment for a patient's oxygens. Heals considerably more when the patient is severely injured."

/********************OXYGEN STEPS********************/
/datum/surgery_step/heal2/oxygen/get_progress(mob/user, mob/living/carbon/target, toxin_healed, oxygen_healed)
	if(!oxygen_healed)
		return
	var/estimated_remaining_steps = target.getOxyLoss() / oxygen_healed
	var/progress_text

	if(locate(/obj/item/healthanalyzer) in user.held_items)
		progress_text = ". Remaining oxygen: <font color='#2b2ee2'>[target.getOxyLoss()]</font>"
	else
		switch(estimated_remaining_steps)
			if(-INFINITY to 1)
				return
			if(1 to 3)
				progress_text = ", oxygenating the last few drops"
			if(3 to 6)
				progress_text = ", watching their flesh return to a normal colour"
			if(6 to 9)
				progress_text = ", continuing to pump away at [target.p_their()] bluing skin"
			if(9 to 12)
				progress_text = ", steadying yourself for the long oxygenation ahead"
			if(12 to 15)
				progress_text = ", though [target.p_they()] still look[target.p_s()] like they've not been able to breathe for a while"
			if(15 to INFINITY)
				progress_text = ", though you feel like you're barely making a dent in treating [target.p_their()] pale, blue body"

	return progress_text

/datum/surgery_step/heal2/oxygen/basic
	name = "tend oxygen wounds (bloodfilter)"
	oxygenhealing = 5
	oxygen_multiplier = 0.07

/datum/surgery_step/heal2/oxygen/upgraded
	oxygenhealing = 5
	oxygen_multiplier = 0.1

/datum/surgery_step/heal2/oxygen/upgraded/femto
	oxygenhealing = 5
	oxygen_multiplier = 0.2

/***************************COMBO***************************/
/datum/surgery/healing2/combo


/datum/surgery/healing2/combo
	name = "Tend Blood (Mixture, Basic)"
	replaced_by = /datum/surgery/healing2/combo/upgraded
	requires_tech = TRUE
	healing_step_type = /datum/surgery_step/heal2/combo
	desc = "A surgical procedure that provides basic treatment for a patient's oxygens and toxin traumas. Heals slightly more when the patient is severely injured."

/datum/surgery/healing2/combo/upgraded
	name = "Tend Blood (Mixture, Adv.)"
	replaced_by = /datum/surgery/healing2/combo/upgraded/femto
	healing_step_type = /datum/surgery_step/heal2/combo/upgraded
	desc = "A surgical procedure that provides advanced treatment for a patient's oxygens and toxin traumas. Heals more when the patient is severely injured."


/datum/surgery/healing2/combo/upgraded/femto //no real reason to type it like this except consistency, don't worry you're not missing anything
	name = "Tend Blood (Mixture, Exp.)"
	replaced_by = null
	healing_step_type = /datum/surgery_step/heal2/combo/upgraded/femto
	desc = "A surgical procedure that provides experimental treatment for a patient's oxygens and toxin traumas. Heals considerably more when the patient is severely injured."

/********************COMBO STEPS********************/
/datum/surgery_step/heal2/combo/get_progress(mob/user, mob/living/carbon/target, toxin_healed, oxygen_healed)
	var/estimated_remaining_steps = 0
	if(toxin_healed > 0)
		estimated_remaining_steps = max(0, (target.getToxLoss() / toxin_healed))
	if(oxygen_healed > 0)
		estimated_remaining_steps = max(estimated_remaining_steps, (target.getOxyLoss() / oxygen_healed)) // whichever is higher between toxin or oxygen steps

	var/progress_text

	if(locate(/obj/item/healthanalyzer) in user.held_items)
		if(target.getToxLoss())
			progress_text = ". Remaining toxin: <font color='#1fe218'>[target.getToxLoss()]</font>"
		if(target.getOxyLoss())
			progress_text += ". Remaining oxygen: <font color='#3225ee'>[target.getOxyLoss()]</font>"
	else
		switch(estimated_remaining_steps)
			if(-INFINITY to 1)
				return
			if(1 to 3)
				progress_text = ", finishing up filtering the last few drops"
			if(3 to 6)
				progress_text = ", actively watching the colours return to their skin"
			if(6 to 9)
				progress_text = ", continuing to pump away at [target.p_their()] extensive blood issues"
			if(9 to 12)
				progress_text = ", steadying yourself for the long fitration and oxygenation surgery ahead"
			if(12 to 15)
				progress_text = ", though [target.p_they()] still look[target.p_s()] like swamp monster than a person"
			if(15 to INFINITY)
				progress_text = ", though you feel like you're barely making a dent in filtering [target.p_their()] gross body"

	return progress_text

/datum/surgery_step/heal2/combo
	name = "filter and oxygenate blood (bloodfilter)"
	toxinhealing = 3
	oxygenhealing = 3
	toxin_multiplier = 0.07
	oxygen_multiplier = 0.07
	time = 10

/datum/surgery_step/heal2/combo/upgraded
	toxinhealing = 3
	oxygenhealing = 3
	toxin_multiplier = 0.1
	oxygen_multiplier = 0.1

/datum/surgery_step/heal2/combo/upgraded/femto
	toxinhealing = 1
	oxygenhealing = 1
	toxin_multiplier = 0.4
	oxygen_multiplier = 0.4

/datum/surgery_step/heal2/combo/upgraded/femto/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_warning("You screwed up!"),
		span_warning("[user] screws up!"),
		span_notice("[user] fixes cleans of [target]'s blood."),
		target_detailed = TRUE,
	)
	target.take_bodypart_damage(5,5)
