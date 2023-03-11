/datum/id_trim/solfed
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "SolFed"
	trim_state = "trim_solfed"
	department_color = COLOR_SOAPSTONE_GOLD
	subdepartment_color = COLOR_SOAPSTONE_GOLD
	sechud_icon_state = SECHUD_SOLFED

/datum/id_trim/solgov/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))

/datum/id_trim/solfed/liasion
	assignment = "SolFed Liasion"
	sechud_icon_state = SECHUD_SOLFED_LIASON

/datum/id_trim/space_police // Overrides the normal /tg/ ERTSEC Icon, these guys aren't NT!
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_spacepolice"
	department_color = COLOR_CENTCOM_BLUE // why did these guys get this but the other modular id trims didn't. what
	subdepartment_color = COLOR_SECURITY_RED
	sechud_icon_state = SECHUD_SPACE_POLICE
