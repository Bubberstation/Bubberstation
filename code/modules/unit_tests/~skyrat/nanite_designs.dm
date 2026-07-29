
/datum/unit_test/nanite_designs/Run()
	for(var/datum/design/nanites/current_design as anything in subtypesof(/datum/design/nanites))
		if (isnull(current_design::program_type) || current_design::program_type == /datum/design/nanites::program_type) //Check if the Nanite design provides a program
			TEST_FAIL("Nanite Design [current_design] does not have have any program_type set")
