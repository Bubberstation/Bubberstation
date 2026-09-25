//Port Tarkon Research Techweb

/datum/techweb/tarkon
	id = "TARKON"
	organization = "Tarkon Industries"
	should_generate_points = TRUE

/datum/techweb/tarkon/New()
	. = ..()
	research_node_id("oldstation_surgery", TRUE, TRUE, FALSE)
	research_node_id("tarkontech", TRUE, TRUE, FALSE)
	research_node_id("tarkon_borgs", TRUE, TRUE, FALSE)
	research_node_id("tarkondefence", TRUE, TRUE, FALSE) // not ideal, but will have to do for now
