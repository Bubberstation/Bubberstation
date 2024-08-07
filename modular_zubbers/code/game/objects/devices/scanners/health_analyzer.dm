GLOBAL_LIST_INIT(analyzerthemes, list(
	"default",
	"hackerman",
	"ntos_rusty",
	"ntos_healthy",
))

#define MAX_HEALTH_ANALYZER_UPDATE_RANGE 3

/obj/item/healthanalyzer/process(seconds_per_tick)
	if(get_turf(src) != get_turf(current_user) || get_dist(get_turf(current_user), get_turf(patient)) > MAX_HEALTH_ANALYZER_UPDATE_RANGE || patient == current_user)
		STOP_PROCESSING(SSobj, src)
		patient = null
		current_user = null
		return
	update_static_data(current_user)

/obj/item/healthanalyzer/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MedScanner", "Medical Scanner")
		ui.open()

/obj/item/healthanalyzer/ui_static_data(mob/user)

	var/list/data = list(
		"patient" = patient.name,
		"dead" = (patient.stat == DEAD),
		"health" = patient.health,
		"max_health" = patient.maxHealth,
		"crit_threshold" = patient.crit_threshold,
		"dead_threshold" = HEALTH_THRESHOLD_DEAD,
		"total_brute" = round(patient.getBruteLoss()),
		"total_burn" = round(patient.getFireLoss()),
		"toxin" = round(patient.getToxLoss()),
		"oxy" = round(patient.getOxyLoss()),
		"ssd" = (!patient.client),
		"blood_type" = patient.dna.blood_type,
		"blood_amount" = patient.blood_volume,
		"majquirks" = patient.get_quirk_string(FALSE, CAT_QUIRK_MAJOR_DISABILITY, from_scan = TRUE),
		"minquirks" = patient.get_quirk_string(FALSE, CAT_QUIRK_MINOR_DISABILITY, TRUE),
		"accessible_theme" = lowertext(user.client?.prefs.read_preference(/datum/preference/choiced/health_analyzer_themes)),
	)
	/*
	CHEMICALS
	*/
	var/list/chemicals_lists = list()
	for(var/datum/reagent/reagent as anything in patient.reagents.reagent_list)
		chemicals_lists["[reagent.name]"] = list(
			"name" = reagent.name,
			"description" = reagent.description,
			"amount" = round(reagent.volume, 0.1),
			"od" = reagent.overdosed,
			"od_threshold" = reagent.overdose_threshold,
			"dangerous" = reagent.overdosed || istype(reagent, /datum/reagent/toxin)
		)
	data["has_chemicals"] = length(patient.reagents.reagent_list)
	data["chemicals_lists"] = chemicals_lists
	data["species"] = patient.dna.species
	data["custom_species"] = patient.client?.prefs.read_preference(/datum/preference/text/custom_species)

	/*
	LIMBS
	*/

	var/list/limb_data_lists = list()
	if(!ishuman(patient)) // how did we get here?
		return

	var/mob/living/carbon/carbontarget = patient
	var/list/damaged = carbontarget.get_damaged_bodyparts(1,1)

	for(var/obj/item/bodypart/limb as anything in damaged)
		var/list/current_list = list(
			"name" = limb.name,
			"brute" = round(limb.brute_dam),
			"burn" = round(limb.burn_dam),
			"bandaged" = limb.current_gauze,
			"missing" = !limb ? TRUE: FALSE,
			"limb_status" = null,
			"limb_type" = null,
			"bleeding" = limb.get_wound_type(/datum/wound/slash) ? limb : null,
			"infection" = limb.get_wound_type(/datum/wound/burn) ? TRUE : FALSE
		)
		var/limb_status = ""
		var/limb_type = ""
		if(IS_ROBOTIC_LIMB(limb))
			limb_type = "Robotic"
		else if((limb.get_wound_type(/datum/wound/blunt)) && limb.current_gauze)
			limb_status = "Stabilized"
		else if((limb.get_wound_type(/datum/wound/blunt)) && limb.current_gauze)
			limb_status = "Splinted"

		current_list["limb_type"] = limb_type
		current_list["limb_status"] = limb_status
		limb_data_lists["[capitalize(limb.name)]"] = current_list
	data["limb_data_lists"] = limb_data_lists
	data["limbs_damaged"] = length(limb_data_lists)
	data["body_temperature"] = "[round(patient.bodytemperature*1.8-459.67, 0.1)] degrees F ([round(patient.bodytemperature-T0C, 0.1)] degrees C)"

	/*
	ORGANS, handles organ data input into the tgui
	*/

	var/damaged_organs = list()
	for(var/obj/item/organ/internal/organ as anything in patient.organs)
		if(!organ.damage)
			continue
		if(!organ)
			return
		var/current_organ = list(
					"name" = organ.name,
					"status" = organ.get_organ_status(advanced),
					"damage" = organ.damage,
			"effects" = organ.damage_description,
				)
		damaged_organs += list(current_organ)
	data["damaged_organs"] = damaged_organs

	//var/obj/item/organ/internal/heart = patient.get_organ_by_type(/obj/item/organ/internal/heart)

	if(HAS_TRAIT(patient, TRAIT_DNR))
		data["revivable_string"] = "Permanently deceased" // the actual information shown next to "revivable:" in tgui. "too much damage" etc.
		data["revivable_boolean"] = FALSE // the actual TRUE/FALSE entry used by tgui. if false, revivable text is red. if true, revivable text is yellow
	//else if((heart.organ_flags & ORGAN_FAILING) || (!patient.get_organ_slot(ORGAN_SLOT_HEART)))
		//data["revivable_string"] = "Not ready to defibrillate - heart too damaged"
		//data["revivable_boolean"] = FALSE
	else if(!(patient.getBruteLoss() >= MAX_REVIVE_BRUTE_DAMAGE) || !(patient.getFireLoss() >= MAX_REVIVE_FIRE_DAMAGE))
		data["revivable_string"] = "Ready to [patient ? "defibrillate" : "reboot"]" // Ternary for defibrillate or reboot for some IC flavor
		data["revivable_boolean"] = TRUE
	else
		data["revivable_string"] = "Not ready to [patient ? "defibrillate" : "reboot"] - repair damage above [(round((patient.getBruteLoss() - MAX_REVIVE_BRUTE_DAMAGE) || (patient.getFireLoss() - MAX_REVIVE_FIRE_DAMAGE)))]%"
		data["revivable_boolean"] = FALSE


	/*
	ADVICE
	*/
	var/list/advice = list()
	var/list/temp_advice = list()
	if(!HAS_TRAIT(patient, TRAIT_DNR)) // only show advice at all if the patient is coming back
		//random stuff that docs should be aware of. possible todo: make a system so we can put these in a collapsible tgui element if there's more added here.
		if(patient.maxHealth != HUMAN_MAXHEALTH)
			advice += list(list(
				"advice" = "Patient has [patient.maxHealth / HUMAN_MAXHEALTH * 100]% constitution.",
				"tooltip" = patient.maxHealth < HUMAN_MAXHEALTH ? "Patient has less maximum health than most humans." : "Patient has more maximum health than most humans.",
				"icon" = patient.maxHealth < HUMAN_MAXHEALTH ? "heart-broken" : "heartbeat",
				"color" = patient.maxHealth < HUMAN_MAXHEALTH ? "grey" : "pink"
			))
		//species advice. possible todo: make a system so we can put these in a collapsible tgui element
		if(issynthetic(patient)) //specifically checking synth/robot here as these are specific to whichever species
			advice += list(list(
				"advice" = "Synthetic: Patient is not revived by defibrillation.",
				"tooltip" = "Synthetics do not heal when being shocked with a defibrillator, meaning they are only revivable over [(round((patient.getBruteLoss() - MAX_REVIVE_BRUTE_DAMAGE) || (patient.getFireLoss() - MAX_REVIVE_FIRE_DAMAGE)))]% health.",
				"icon" = "robot",
				"color" = "label"
			))
			advice += list(list(
				"advice" = "Synthetic: Patient overheats while lower than [patient.crit_threshold / patient.maxHealth * 100]% health.",
				"tooltip" = "Synthetics overheat rapidly while their health is lower than [patient.crit_threshold / patient.maxHealth * 100]%. When defibrillating, the patient should be repaired above this threshold to avoid unnecessary burning.",
				"icon" = "robot",
				"color" = "label"
			))
			advice += list(list(
				"advice" = "Synthetic: Patient does not suffer from blood loss.",
				"tooltip" = "Synthetics don't lose blood normaly.",
				"icon" = "robot",
				"color" = "label"
			))
		if(patient.stat == DEAD) // death advice
			for(var/obj/item/clothing/C in patient.get_equipped_items())
				if((C.body_parts_covered & CHEST) && (C.clothing_flags & THICKMATERIAL))
					advice += list(list(
						"advice" = "Remove patient's suit or armor.",
						"tooltip" = "To defibrillate the patient, you need to remove anything conductive obscuring their chest.",
						"icon" = "shield-alt",
						"color" = "blue"
						))
			if((patient.getBruteLoss() <= MAX_REVIVE_BRUTE_DAMAGE) || (patient.getFireLoss() <= MAX_REVIVE_FIRE_DAMAGE))
				advice += list(list(
					"advice" = "Administer shock via defibrillator!",
					"tooltip" = "The patient is ready to be revived, defibrillate them as soon as possible!",
					"icon" = "bolt",
					"color" = "yellow"
					))
		if(patient.getBruteLoss() > 5)
			if(!issynthetic(patient))
				advice += list(list(
					"advice" = "Use Brute healing medicine or sutures to repair the bruised areas.",
					"tooltip" = "Brute damage can be cured with sutures, or administer some brute healing medicine.",
					"icon" = "band-aid",
					"color" = "green"
					))
			else
				advice += list(list(
					"advice" = "Use a welding tool to repair the dented areas.",
					"tooltip" = "Only a welding tool can repair dented robotic limbs.",
					"icon" = "tools",
					"color" = "red"
				))
		if(patient.getFireLoss() > 5)
			if(!issynthetic(patient))
				advice += list(list(
					"advice" = "Use Burn healing medicine or sutures to repair the burned areas.",
					"tooltip" = "Regenerative Mesh will heal burn damage, or you can administer burn healing medicine.",
					"icon" = "band-aid",
					"color" = "orange"
					))
			else
				advice += list(list(
					"advice" = "Use cable coils to repair the scorched areas.",
					"tooltip" = "Only cable coils can repair scorched robotic limbs.",
					"icon" = "plug",
					"color" = "orange"
				)) /*
			if(infection_message)
				temp_advice = list(list(
					"advice" = "Administer a single dose of spaceacillin - infections detected.",
					"tooltip" = "There are one or more infections detected. If left untreated, they may worsen into Necrosis and require surgery.",
					"icon" = "biohazard",
					"color" = "olive"
					))
				if(chemicals_lists["Spaceacillin"])
					if(chemicals_lists["Spaceacillin"]["amount"] < 2)
						advice += temp_advice
				else
					advice += temp_advice
			var/datum/internal_organ/brain/brain = patient.internal_organs_by_name["brain"]
			if(brain.organ_status != ORGAN_HEALTHY)
				temp_advice = list(list(
					"advice" = "Administer a single dose of mannitol.",
					"tooltip" = "Significant brain damage detected. Mannitol heals brain damage. If left untreated, patient may be unable to function well.",
					"icon" = "syringe",
					"color" = "blue"
					))
				if(chemicals_lists["Mannitol"])
					if(chemicals_lists["Mannitol"]["amount"] < 3)
						advice += temp_advice
				else
					advice += temp_advice
			var/datum/internal_organ/eyes/eyes = patient.internal_organs_by_name["eyes"]
			if(eyes.organ_status != ORGAN_HEALTHY)
				temp_advice = list(list(
					"advice" = "Administer a single dose of occuline.",
					"tooltip" = "Eye damage detected. Occuline heals eye damage. If left untreated, patient may be unable to see properly.",
					"icon" = "syringe",
					"color" = "yellow"
					))
				if(chemicals_lists["Occuline"])
					if(chemicals_lists["Occuline"]["amount"] < 3)
						advice += temp_advice
				else
					advice += temp_advice */
		if(patient.getBruteLoss() > 30)
			temp_advice = list(list(
				"advice" = "Administer a single dose of Libital or Salicylic Acid to reduce physical trauma.",
				"tooltip" = "Significant physical trauma detected. Libital and Salicylic Acid both reduce brute damage.",
				"icon" = "syringe",
				"color" = "red"
				))
			if(chemicals_lists["Libital"])
				if(chemicals_lists["Libital"]["amount"] < 3)
					advice += temp_advice
			else
				advice += temp_advice
		if(patient.getFireLoss() > 30)
			temp_advice = list(list(
				"advice" = "Administer a single dose of Aiuri or Oxandrolone to reduce burns.",
				"tooltip" = "Significant tissue burns detected. Aiuri and Oxandrolone both reduces burn damage.",
				"icon" = "syringe",
				"color" = "yellow"
				))
			if(chemicals_lists["Aiuri"])
				if(chemicals_lists["Aiuri"]["amount"] < 3)
					advice += temp_advice
			else
				advice += temp_advice
		if(patient.getToxLoss() > 15)
			temp_advice = list(list(
				"advice" = "Administer a single dose of multiver or pentetic acid.",
				"tooltip" = "Significant blood toxins detected. Multiver and Pentetic Acid both will reduce toxin damage, or their liver will filter it out on its own. Damaged livers will take even more damage while clearing blood toxins.",
				"icon" = "syringe",
				"color" = "green"
				))
			if(chemicals_lists["Multiver"])
				if(chemicals_lists["Multiver"]["amount"] < 5)
					advice += temp_advice
			else
				advice += temp_advice
		if(patient.getOxyLoss() > 30)
			temp_advice = list(list(
				"advice" = "Administer a single dose of salbutamol to re-oxygenate patient's blood.",
				"tooltip" = "If you don't have Salbutamol, CPR or treating their other symptoms and waiting for their bloodstream to re-oxygenate will work.",
				"icon" = "syringe",
				"color" = "blue"
				))
			if(chemicals_lists["Salbutamol"])
				if(chemicals_lists["Salbutamol"]["amount"] < 3)
					advice += temp_advice
			else
				advice += temp_advice
		if(patient.blood_volume <= 500 && !chemicals_lists["Saline-Glucose"])
			advice += list(list(
				"advice" = "Administer a single dose of Saline-Glucose or Iron.",
				"tooltip" = "The patient has lost a significant amount of blood. Saline-Glucose or Iron speeds up blood regeneration significantly.",
				"icon" = "syringe",
				"color" = "cyan"
				))
			advice += temp_advice
		if(patient.stat != DEAD && patient.health < patient.crit_threshold)
			temp_advice = list(list(
				"advice" = "Administer a single dose of epinephrine.",
				"tooltip" = "When used in hard critical condition, Epinephrine prevents suffocation and heals the patient, triggering a 5 minute cooldown.",
				"icon" = "syringe",
				"color" = "purple"
				))
			if(chemicals_lists["Epinephrine"])
				if(chemicals_lists["Epinephrine"]["amount"] < 5)
					advice += temp_advice
			else
				advice += temp_advice

	else
		advice += list(list(
			"advice" = "Patient is unrevivable.",
			"tooltip" = "The patient is permanently deceased. Can occur through being decapitated, DNR on record, or soullessness.",
			"icon" = "ribbon",
			"color" = "white"
			))
	if(advice.len)
		data["advice"] = advice
	else
		data["advice"] = null
	return data


#undef MAX_HEALTH_ANALYZER_UPDATE_RANGE
