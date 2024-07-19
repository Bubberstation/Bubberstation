/datum/component/personal_crafting/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("make", "make_mass")
			var/datum/crafting_recipe/crafting_recipe = locate(params["recipe"]) in (mode ? GLOB.cooking_recipes : GLOB.crafting_recipes)

			if (istype(crafting_recipe, /datum/crafting_recipe/improv_explosive) || istype(crafting_recipe, /datum/crafting_recipe/molotov) || istype(crafting_recipe, /datum/crafting_recipe/chemical_payload) || istype(crafting_recipe, /datum/crafting_recipe/chemical_payload2))
				var/client/client = usr.client
				if (CONFIG_GET(flag/use_exp_tracking) && client && client.get_exp_living(TRUE) < 8 HOURS) // Player with less than 8 hours playtime is making an IED or molotov cocktail.
					if(client.next_ied_grief_warning < world.time)
						var/turf/T = get_turf(usr)
						client.next_ied_grief_warning = world.time + 15 MINUTES // Wait 15 minutes before alerting admins again
						message_admins("[span_adminhelp("ANTI-GRIEF:")] New player [ADMIN_LOOKUPFLW(usr)] has crafted an IED or Molotov at [ADMIN_VERBOSEJMP(T)].")
						client.crafted_ied = TRUE
