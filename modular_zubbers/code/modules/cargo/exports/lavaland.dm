// Gibtonite Exportable based on quality

/datum/export/lavaland/gibtonite
	cost = CARGO_CRATE_VALUE * 10
	unit_name = "gibtonite chunk"
	export_types = list(/obj/item/gibtonite)
	var/gibtonite_quality

/datum/export/lavaland/gibtonite/total_printout(datum/export_report/ex, notes = TRUE) //in the unlikely case a miner feels like selling megafauna loot
	. = ..()
	if(. && notes)
		switch(gibtonite_quality)
			if(GIBTONITE_QUALITY_HIGH)
				. += " (Grade A Shipment) On behalf of the Nanotrasen RnD division: Thank you for your hard work."
			if(GIBTONITE_QUALITY_MEDIUM)
				. += " (Grade B Shipment)"
			if(GIBTONITE_QUALITY_LOW)
				. += " (Grade C Shipment)"

/datum/export/lavaland/gibtonite/get_cost(obj/item/gibtonite/bombrock)
	gibtonite_quality = bombrock.quality
	switch(bombrock.quality)
		if(GIBTONITE_QUALITY_HIGH)
			return CARGO_CRATE_VALUE * 20
		if(GIBTONITE_QUALITY_MEDIUM)
			return CARGO_CRATE_VALUE * 10
		if(GIBTONITE_QUALITY_LOW)
			return CARGO_CRATE_VALUE * 5
