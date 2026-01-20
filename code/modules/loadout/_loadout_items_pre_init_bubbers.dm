//Why have to initialize this before the global that initializes loadouts or else none of this will work.

GLOBAL_LIST_INIT(vendor_to_loadout,list(
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
	/obj/machinery/vending/wardrobe/cent_wardrobe = list(JOB_NT_REP)
))
