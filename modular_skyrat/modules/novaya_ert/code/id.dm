/obj/item/card/id/advanced/centcom/ert/nri
	name = "\improper PSC ID"
	desc = "An ID straight from the Pan-Slavic Commonwealth."
	icon_state = "card_black"
	assigned_icon_state = "assigned_centcom"

/datum/id_trim/nri
	assignment = "PSC Soldier"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_nri"
	department_color = COLOR_RED_LIGHT
	subdepartment_color = COLOR_COMMAND_BLUE
	sechud_icon_state = "hud_nri"
	threat_modifier = 2 // Matching the nri_police threat modifier

/datum/id_trim/nri/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))


/datum/id_trim/nri/commander
	assignment = "PSC Platoon Commander"
	trim_state = "trim_nri_commander"
	department_color = COLOR_RED_LIGHT
	subdepartment_color = COLOR_COMMAND_BLUE
	sechud_icon_state = "hud_nri_commander"

/datum/id_trim/nri/heavy
	assignment = "PSC Heavy Soldier"

/datum/id_trim/nri/medic
	assignment = "PSC Corpsman"

/datum/id_trim/nri/engineer
	assignment = "PSC Combat Engineer"

/datum/id_trim/nri/diplomat
	assignment = "PSC Diplomat"
	trim_state = "trim_nri_commander"
	department_color = COLOR_RED_LIGHT
	subdepartment_color = COLOR_COMMAND_BLUE
	sechud_icon_state = "hud_nri_commander"

/datum/id_trim/nri/diplomat/major
	assignment = "PSC Major"

/datum/id_trim/nri/diplomat/scientist
	assignment = "PSC Research Inspector"

/datum/id_trim/nri/diplomat/doctor
	assignment = "PSC Medical Inspector"
