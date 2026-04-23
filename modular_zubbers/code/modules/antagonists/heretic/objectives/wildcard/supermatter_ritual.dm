// prevents the sm from generating power for x time - maybe a longer term effect too
/datum/objective/heretic_wildcard/supermatter
	name = ""
	explanation_text = "Perform the PLACEHOLDER ritual on the station's supermatter engine."

/datum/heretic_knowledge/supermatter_ritual
	name = "PLACEHOLDER"
	unreachable = TRUE

/datum/heretic_knowledge/supermatter_ritual/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()

/datum/heretic_knowledge/supermatter_ritual/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()

	var/obj/machinery/power/supermatter_crystal/crys
	for (var/obj/machinery/power/supermatter_crystal/iter_crys in range(1, loc))
		crys = iter_crys
		break

	if (isnull(crys))
		return FALSE

	priority_announce(
		"Thaumatergic anomaly detected in Supermatter Engine. Observing massively reduced power output - expect resolution in ETA 20 minutes.",
		"CentCom Thaumatergy Monitor",
		'sound/machines/engine_alert/engine_alert3.ogg'
	)


