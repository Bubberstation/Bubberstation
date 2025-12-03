// Specialized check for station resources: ore silos and other resource-related objects
/datum/storyteller_metric/resource_check
	name = "Resource Check"

	// List of machinery types to process
	var/static/list/machinery_types = list(
		/obj/machinery/ore_silo,
		/obj/machinery/rnd/production,
		/obj/machinery/autolathe
	)

/datum/storyteller_metric/resource_check/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	var/total_minerals = 0

	// Iterate over all machinery types
	for(var/machinery_type in machinery_types)
		for(var/machinery in SSmachines.get_machines_by_type(machinery_type))
			if(!istype(machinery, machinery_type))
				continue

			// Handle ore silos
			if(istype(machinery, /obj/machinery/ore_silo))
				var/obj/machinery/ore_silo/silo = machinery
				if(!silo.holds)
					continue
				for(var/mat_type in silo.holds)
					var/datum/material/mat = mat_type
					total_minerals += silo.holds[mat]
			else
				var/obj/machinery/lathe = machinery
				var/datum/component/remote_materials/silo_link = lathe.GetComponent(/datum/component/remote_materials)
				if(silo_link && !isnull(silo_link?.silo)) // Skip machines with silo link
					continue
				var/datum/component/material_container/mat_con = lathe.GetComponent(/datum/component/material_container)
				if(!mat_con)
					continue
				for(var/material in mat_con.materials)
					var/datum/material/mat = material
					total_minerals += mat_con.materials[mat]

	// Store total minerals in the vault
	inputs.vault[STORY_VAULT_RESOURCE_MINERALS] = total_minerals

	// Other resources, like cargo points
	var/other_resources = 0
	if(SSshuttle && SSshuttle.points)
		other_resources += SSshuttle.points
	inputs.vault[STORY_VAULT_RESOURCE_OTHER] = other_resources
	..()

