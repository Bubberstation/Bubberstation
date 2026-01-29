//Why have to initialize this before the global that initializes loadouts or else loadouts won't work.

GLOBAL_LIST_INIT(access_string_to_job,list(
	"[ACCESS_CAPTAIN]" = list(JOB_CAPTAIN),
	"[ACCESS_HOP]" = list(JOB_HEAD_OF_PERSONNEL),
	"[ACCESS_CMO]" = list(JOB_CHIEF_MEDICAL_OFFICER),
	"[ACCESS_RD]" = list(JOB_RESEARCH_DIRECTOR),
	"[ACCESS_CE]" = list(JOB_CHIEF_ENGINEER),
	"[ACCESS_HOS]" = list(JOB_HEAD_OF_SECURITY),
	"[ACCESS_QM]" = list(JOB_QUARTERMASTER),
	"[ACCESS_CENT_GENERAL]" = list(ALL_JOBS_CENTRAL),
	"[ACCESS_COMMAND]" = list(JOB_CAPTAIN,JOB_HEAD_OF_PERSONNEL,JOB_CHIEF_MEDICAL_OFFICER,JOB_RESEARCH_DIRECTOR,JOB_CHIEF_ENGINEER,JOB_HEAD_OF_SECURITY,JOB_QUARTERMASTER),
))

GLOBAL_LIST_INIT(loadout_blacklist,list())

GLOBAL_LIST_INIT(loadout_blacklist_terms,list(
	"debug",
	"admin",
	"god",
	"dev",
	"centcom",
	"central com",
))

GLOBAL_LIST_INIT(loadout_blacklist_names,list())

GLOBAL_LIST_INIT(vendor_to_loadout, list(
	/obj/machinery/vending/wardrobe/sec_wardrobe = list(ALL_JOBS_SEC),
	/obj/machinery/vending/wardrobe/medi_wardrobe = list(ALL_JOBS_MEDICAL),
	/obj/machinery/vending/wardrobe/engi_wardrobe = list(ALL_JOBS_ENGINEERING),
	/obj/machinery/vending/wardrobe/atmos_wardrobe = list(JOB_ATMOSPHERIC_TECHNICIAN),
	/obj/machinery/vending/wardrobe/cargo_wardrobe = list(ALL_JOBS_CARGO),
	/obj/machinery/vending/wardrobe/robo_wardrobe = list(JOB_ROBOTICIST),
	/obj/machinery/vending/wardrobe/science_wardrobe = list(ALL_JOBS_SCIENCE),
	/obj/machinery/vending/wardrobe/hydro_wardrobe = list(JOB_BOTANIST),
	/obj/machinery/vending/wardrobe/curator_wardrobe = list(JOB_CURATOR),
	/obj/machinery/vending/wardrobe/coroner_wardrobe = list(JOB_CORONER),
	/obj/machinery/vending/wardrobe/bar_wardrobe = list(JOB_BARTENDER),
	/obj/machinery/vending/wardrobe/chef_wardrobe = list(JOB_COOK),
	/obj/machinery/vending/wardrobe/jani_wardrobe = list(JOB_JANITOR),
	/obj/machinery/vending/wardrobe/law_wardrobe = list(JOB_LAWYER),
	/obj/machinery/vending/wardrobe/chap_wardrobe = list(JOB_CHAPLAIN),
	/obj/machinery/vending/wardrobe/chem_wardrobe = list(JOB_CHEMIST),
	/obj/machinery/vending/wardrobe/gene_wardrobe = list(JOB_GENETICIST),
	/obj/machinery/vending/wardrobe/viro_wardrobe = list(JOB_MEDICAL_DOCTOR),
	/obj/machinery/vending/wardrobe/det_wardrobe = list(JOB_DETECTIVE),
	/obj/machinery/vending/wardrobe/cent_wardrobe = list(JOB_NT_REP),
))

GLOBAL_LIST_INIT(access_vendors_for_loadout,list(
	/obj/machinery/vending/access/command
))


//These are run last and override anything created by the above vendors.
//Use null instead of an empty list if you wish to clear restrictions.
GLOBAL_LIST_INIT(vendor_to_loadout_overrides, list(
	/obj/machinery/vending/autodrobe = null,
	/obj/machinery/vending/clothing = null
))

