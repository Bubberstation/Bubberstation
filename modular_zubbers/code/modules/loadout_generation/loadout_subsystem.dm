SUBSYSTEM_DEF(loadout)
	name = "Loadout Generation"
	dependencies = list(
		/datum/controller/subsystem/machines,
	)

	var/static/list/loadout_blacklist_terms = list(
		"debug",
		"admin",
		"god",
		"dev",
		"centcom",
		"central com",
	)

	var/static/list/vendor_to_loadout = list(
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
	)

	var/static/list/vendor_to_loadout_overrides = list(
		/obj/machinery/vending/autodrobe = list(),
		/obj/machinery/vending/clothing = list()
	)

	var/list/loadout_blacklist //Generated in init.
	var/list/loadout_blacklist_names //Generated in init.

	flags = SS_NO_FIRE

/datum/controller/subsystem/loadout/Initialize()
	loadout_blacklist = generate_loadout_blacklist()
	loadout_blacklist_names = list()
	GLOB.all_loadout_categories = src.init_loadout_categories() //This is a global to ensure maximum compatibility with /tg/
	return SS_INIT_SUCCESS


/datum/controller/subsystem/loadout/proc/init_loadout_categories()

	var/list/loadout_categories = list()

	//Step 0: Create the loadout categories
	for(var/category_type in subtypesof(/datum/loadout_category))
		var/datum/loadout_category/created_category = new category_type()
		created_category.associated_items = list()
		loadout_categories += created_category

	/*
	//Step 1: Create loadout items based config.
	for(var/datum/loadout_category/found_category as anything in loadout_categories)
		found_category.generate_from_config()
	*/

	//Step 2: Create loadout items based on vendors
	for(var/obj/machinery/vending/vendor as anything in vendor_to_loadout)
		generate_loadout_list_from_vendor(
			vendor,
			vendor_to_loadout[vendor],
			loadout_categories
		)
	for(var/obj/machinery/vending/vendor as anything in vendor_to_loadout_overrides)
		generate_loadout_list_from_vendor(
			vendor,
			vendor_to_loadout[vendor],
			loadout_categories
		)

	/*
	//Step 3: Create loadout items based on world.
	for(var/datum/loadout_category/found_category as anything in loadout_categories)
		found_category.generate_from_world()
	*/

	sortTim(loadout_categories, /proc/cmp_loadout_categories)

	return loadout_categories