// This file contains all the trims associated with quirks.

// Base entry
/datum/id_trim/quirk
	trim_icon = 'modular_zzplurt/icons/obj/card.dmi'
	trim_state = "trim_question"
	assignment = "Error Reporter"
	intern_alt_name = "Quirky"
	department_color = COLOR_WEBSAFE_DARK_GRAY
	subdepartment_color = "#00000000" // Disabled

// Quirk: Bloodsucker Fledgling
/datum/id_trim/quirk/bloodfledge
	trim_state = "trim_droplet_red"
	department_color = "#00000000" // Disabled because of custom sprite
	assignment = "Bloodsucker Fledgling"
	intern_alt_name = "Fledgling"
	threat_modifier = 2 // Equal to dress code violation

// Quirk: Concubus
/datum/id_trim/quirk/concubus
	trim_state = "trim_droplet"
	assignment = "Concubus"
	intern_alt_name = "Imp"
	subdepartment_color = COLOR_BUBBLEGUM_RED

// Quirk: Gargoyle
/datum/id_trim/quirk/gargoyle
	trim_state = "trim_rectangle"
	assignment = "Gargoyle"
	intern_alt_name = "Statuette"
	subdepartment_color = "#918E85" // Named "Stone Grey"

// Quirk: Hallowed
/datum/id_trim/quirk/hallowed
	trim_state = "trim_cleric"
	assignment = "Deacon"
	intern_alt_name = "Probationer"
	subdepartment_color = LIGHT_COLOR_HOLY_MAGIC
	threat_modifier = -1 // Equal to mind shield

// Quirk: Rad Fiend
/datum/id_trim/quirk/rad_fiend
	trim_state = "trim_rad"
	assignment = "Rad Fiend"
	intern_alt_name = "Radspawn"
	subdepartment_color = "#14FF67" // Matches radiation outline

// Quirk: Werewolf
/datum/id_trim/quirk/werewolf
	trim_state = "trim_moon"
	assignment = "Werewolf"
	intern_alt_name = "Puppy"
	subdepartment_color = "#F6F1D5" // Named "Moon Color"
	threat_modifier = 2 // Equal to dress code violation
