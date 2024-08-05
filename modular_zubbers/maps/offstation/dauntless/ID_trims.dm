/datum/id_trim/syndicom/bubberstation

//Dauntless

/datum/id_trim/syndicom/bubberstation/dauntless
	assignment = "Dauntless Operative"
	trim_state = "trim_unknown"
	department_color = COLOR_ASSEMBLY_BLACK
	subdepartment_color = COLOR_SYNDIE_RED

/datum/id_trim/syndicom/bubberstation/dauntless/prisoner
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "Dauntless Hostage"
	trim_state = "trim_ds2prisoner"
	subdepartment_color = COLOR_MAROON
	sechud_icon_state = SECHUD_DS2_PRISONER
	access = list(ACCESS_MAINT_TUNNELS) // I can't set it to null without creating a runtime.

/datum/id_trim/syndicom/bubberstation/dauntless/syndicatestaff
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "Dauntless General Staff"
	trim_state = "trim_ds2generalstaff"
	sechud_icon_state = SECHUD_DS2_GENSTAFF
	access = list(ACCESS_SYNDICATE)

/datum/id_trim/syndicom/bubberstation/dauntless/researcher
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "Dauntless Researcher"
	trim_state = "trim_ds2researcher"
	sechud_icon_state = SECHUD_DS2_RESEARCHER
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS,ACCESS_RESEARCH,ACCESS_SCIENCE)

/datum/id_trim/syndicom/bubberstation/dauntless/enginetechnician
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "Dauntless Engineer"
	trim_state = "trim_ds2enginetech"
	sechud_icon_state = SECHUD_DS2_ENGINETECH

/datum/id_trim/syndicom/bubberstation/dauntless/medicalofficer
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "Dauntless Medical Officer"
	trim_state = "trim_ds2medicalofficer"
	sechud_icon_state = SECHUD_DS2_DOCTOR

/datum/id_trim/syndicom/bubberstation/dauntless/miner
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "Dauntless Mining Officer"
	trim_state = "trim_ds2miningofficer"
	sechud_icon_state = SECHUD_DS2_MININGOFFICER
	access = list(ACCESS_SYNDICATE)

/datum/id_trim/syndicom/bubberstation/dauntless/masteratarms
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "Dauntless Master At Arms"
	trim_state = "trim_ds2masteratarms"
	sechud_icon_state = SECHUD_DS2_MASTERATARMS
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/datum/id_trim/syndicom/bubberstation/dauntless/brigofficer
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "Dauntless Brig Officer"
	trim_state = "trim_ds2brigofficer"
	sechud_icon_state = SECHUD_DS2_BRIGOFFICER
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/datum/id_trim/syndicom/bubberstation/dauntless/corporateliasion
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "Syndicate Corporate Liaison"
	trim_state = "trim_ds2corporateliaison"
	sechud_icon_state = SECHUD_DS2_CORPLIAISON
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/datum/id_trim/syndicom/bubberstation/dauntless/stationadmiral
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "Ship Admiral"
	trim_state = "trim_ds2admiral"
	sechud_icon_state = SECHUD_DS2_ADMIRAL
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)



