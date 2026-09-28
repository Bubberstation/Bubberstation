/datum/id_trim/away/tarkon
	assignment = "P-T Deck Worker"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_WHITE
	department_state = "department"
	subdepartment_color = COLOR_DARK_CYAN
	sechud_icon_state = SECHUD_UNKNOWN
	trim_state = "trim_unknown"

/datum/id_trim/away/tarkon/cargo
	assignment = "P-T Cargo Personnel"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_DARK_BROWN
	department_state = "department"
	sechud_icon_state = SECHUD_CARGO_TECHNICIAN
	trim_state = "trim_cargotechnician"

/datum/id_trim/away/tarkon/sec
	assignment = "P-T Port Guard"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_DARK_RED
	sechud_icon_state = SECHUD_SECURITY_OFFICER
	trim_state = "trim_securityofficer"

/datum/id_trim/away/tarkon/service
	assignment = "P-T Service Personnel"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_GREEN
	department_state = "department"
	sechud_icon_state = SECHUD_CHEF
	trim_state = "trim_cook"

/datum/id_trim/away/tarkon/med
	assignment = "P-T Trauma Medic"
	access = list(ACCESS_MEDICAL, ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_MEDICAL_BLUE
	sechud_icon_state = SECHUD_MEDICAL_DOCTOR
	trim_state = "trim_medicaldoctor"

/datum/id_trim/away/tarkon/eng
	assignment = "P-T Maintenance Crew"
	department_color = COLOR_ENGINEERING_ORANGE
	sechud_icon_state = SECHUD_STATION_ENGINEER
	trim_state = "trim_stationengineer"

/datum/id_trim/away/tarkon/sci
	assignment = "P-T Field Researcher"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_SCIENCE_PINK
	sechud_icon_state = SECHUD_SCIENTIST
	trim_state = "trim_scientist"

/datum/id_trim/away/tarkon/robo
	access = list(ACCESS_ROBOTICS)

/datum/id_trim/away/tarkon/ensign
	assignment = "Tarkon Ensign"
	access = list(ACCESS_MEDICAL, ACCESS_ROBOTICS, ACCESS_AWAY_GENERAL, ACCESS_TARKON, ACCESS_WEAPONS)
	department_color = COLOR_COMMAND_BLUE
	sechud_icon_state = SECHUD_BLUESHIELD
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_blueshield"

/datum/id_trim/away/tarkon/director
	assignment = "Port Tarkon Director"
	access = list(ACCESS_MEDICAL, ACCESS_ROBOTICS, ACCESS_AWAY_GENERAL, ACCESS_TARKON, ACCESS_WEAPONS)
	department_color = COLOR_COMMAND_BLUE
	sechud_icon_state = SECHUD_CAPTAIN
	trim_state = "trim_captain"
