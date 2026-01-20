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

/proc/generate_loadout_list_from_vendor(obj/machinery/vending/vendor_to_check,restricted_roles) as /list

	var/obj/machinery/vending/created_vendor = new vendor_to_check

	for(var/obj/item/clothing/found_clothing in created_vendor.products) //Only get clothing items!

		if(GLOB.all_loadout_datums[found_clothing])
			var/datum/loadout_item/existing_loadout = GLOB.all_loadout_datums[found_clothing]
			if(length(existing_loadout.restricted_roles))
				existing_loadout.restricted_roles |= restricted_roles
			continue

		for(var/datum/loadout_category/found_category as anything in GLOB.all_loadout_categories) //Search the loadout categories.

			var/created_item = FALSE
			for(var/datum/possible_path as anything in found_category.generation_subtypes_whitelist)
				if(!ispath(found_clothing,possible_path))
					continue
				var/item_name = full_capitalize("[found_clothing.name]") //The square brackets allow text macros to run.

				var/datum/loadout_item/loadout_item_datum = new found_category.type_to_generate(
					found_category,
					item_name,
					found_clothing
				)

				loadout_item_datum.restricted_roles = restricted_roles
				loadout_item_datum.group = "Job Items"
				if(!length(found_category.associated_items))
					found_category.associated_items = list()
				found_category.associated_items |= loadout_item_datum
				created_item = TRUE

			if(created_item)
				break

	qdel(created_vendor)
