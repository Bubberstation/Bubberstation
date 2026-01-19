/obj/machinery/computer/operating/ui_data(mob/user)
	var/list/data = ..()
	data["traumas"] = list()
	if(isnull(table))
		return data
	var/mob/living/carbon/patient = table.patient
	if(isnull(patient))
		return data

	if(LAZYLEN(patient.get_traumas()))
		for(var/active_trauma in patient.get_traumas())
			var/datum/brain_trauma/trauma = active_trauma
			if(!trauma.display_scanner)
				continue

			var/trauma_treatment = ""
			var/chem_required = ""
			switch(trauma.resilience)
				if(TRAUMA_RESILIENCE_BASIC)
					trauma_treatment += "Brain Surgery"
				if(TRAUMA_RESILIENCE_SURGERY)
					trauma_treatment += "Brain Surgery"
				if(TRAUMA_RESILIENCE_LOBOTOMY)
					trauma_treatment += "Neurectomy"
					if(issynthetic(patient))
						chem_required += "Liquid Solder"
					else
						chem_required += "Neurine"
				if(TRAUMA_RESILIENCE_MAGIC)
					trauma_treatment += "Blessed Neurectomy"
					if(issynthetic(patient))
						chem_required += "Liquid Solder, Holy Water"
					else
						chem_required += "Neurine, Holy Water"
				if(TRAUMA_RESILIENCE_ABSOLUTE)
					trauma_treatment += "Untreatable"
				if(TRAUMA_RESILIENCE_WOUND)
					trauma_treatment += "Treat active wound"
			data["traumas"] += list(list(
				"name" = capitalize(trauma.name),
				"info" = capitalize(trauma.scan_desc),
				"treatment" = trauma_treatment,
				"chems" = chem_required,
			))

	return data
