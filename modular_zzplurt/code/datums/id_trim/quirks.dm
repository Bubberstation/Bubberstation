// This file contains all the trims associated with quirks.

// Base entry
/datum/id_trim/quirk
	trim_icon = 'modular_zzplurt/icons/obj/card.dmi'
	trim_state = "trim_question"
	assignment = "Error Reporter"
	department_color = COLOR_NEARLY_ALL_BLACK
	subdepartment_color = COLOR_NEARLY_ALL_BLACK

// Quirk: Bloodsucker Fledgling
/datum/id_trim/quirk/bloodfledge
	trim_state = "trim_bloodfledge"
	// Colors disabled because Bloodfledge ID has a custom sprite
	department_color = "#00000000"
	subdepartment_color = "#00000000"
	assignment = "Bloodsucker Fledgling"
	intern_alt_name = "Fledgling"
	threat_modifier = 2 // Equal to dress code violation
