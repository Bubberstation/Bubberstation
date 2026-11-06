// Gibtonite Exportable based on quality

/datum/export/gibtonite
	abstract_type = /datum/export/gibtonite
	export_types = list(/obj/item/gibtonite)
	var/quality

/datum/export/gibtonite/applies_to(obj/item/gibtonite/exported_item, apply_elastic = TRUE, export_markets)
	if(!..())
		return FALSE
	return exported_item.quality == quality

/datum/export/gibtonite/high
	cost = CARGO_CRATE_VALUE * 20
	unit_name = "grade A gibtonite chunk"
	message = "On behalf of the Nanotrasen RnD division: Thank you for your hard work"
	quality = GIBTONITE_QUALITY_HIGH

/datum/export/gibtonite/medium
	cost = CARGO_CRATE_VALUE * 10
	unit_name = "grade B gibtonite chunk"
	message = "On behalf of the Nanotrasen RnD division: Thank you for your hard work"
	quality = GIBTONITE_QUALITY_MEDIUM

/datum/export/gibtonite/low
	cost = CARGO_CRATE_VALUE * 5
	unit_name = "grade C gibtonite chunk"
	message = "On behalf of the Nanotrasen RnD division: Thank you for your hard work"
	quality = GIBTONITE_QUALITY_LOW
