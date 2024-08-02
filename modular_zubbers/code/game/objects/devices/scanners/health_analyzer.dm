GLOBAL_LIST_INIT(analyzerthemes, list(
	"default",
	"hackerman",
	"ntos_rusty",
	"ntos_healthy",
))

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
		"accessible_theme" = lowertext(user.client?.prefs.read_preference(/datum/preference/choiced/health_analyzer_theme)),
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
		if(limb.get_wound_type(/datum/wound/blunt))
			limb_status = "Fracture"
		else if(limb.current_gauze)
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
		var/current_organ = list(
			"name" = organ.name,
			"status" = organ.get_organ_status(advanced),
			"damage" = organ.damage,
			"effects" = organ.damage_description,
		)
		damaged_organs += list(current_organ)
	data["damaged_organs"] = damaged_organs

	var/obj/item/organ/internal/heart = patient.get_organ_by_type(/obj/item/organ/internal/heart)

	if(HAS_TRAIT(patient, TRAIT_DNR))
		data["revivable_string"] = "Permanently deceased" // the actual information shown next to "revivable:" in tgui. "too much damage" etc.
		data["revivable_boolean"] = FALSE // the actual TRUE/FALSE entry used by tgui. if false, revivable text is red. if true, revivable text is yellow
	else if(heart.organ_flags & ORGAN_FAILING || !heart)
		data["revivable_string"] = "Not ready to defibrillate - heart too damaged"
		data["revivable_boolean"] = FALSE
	else if(!(patient.getBruteLoss() >= MAX_REVIVE_BRUTE_DAMAGE) || (patient.getFireLoss() >= MAX_REVIVE_FIRE_DAMAGE))
		data["revivable_string"] = "Ready to [patient ? "defibrillate" : "reboot"]" // Ternary for defibrillate or reboot for some IC flavor
		data["revivable_boolean"] = TRUE
	else
		data["revivable_string"] = "Not ready to [patient ? "defibrillate" : "reboot"] - repair damage above [(round((patient.getBruteLoss() - MAX_REVIVE_BRUTE_DAMAGE) || (patient.getFireLoss() - MAX_REVIVE_FIRE_DAMAGE)))]%"
		data["revivable_boolean"] = FALSE


	/*
	ADVICE
	*/

	return data
