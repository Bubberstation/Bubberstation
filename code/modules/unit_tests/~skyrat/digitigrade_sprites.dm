/datum/unit_test/modular_digitigrade_sprites
	var/type_to_test = /obj/item/clothing/under
	var/list/modular_folders = list(
		"modular_skyrat",
		"modular_zubbers",
	)

/datum/unit_test/modular_digitigrade_sprites/proc/get_folders_of_typepaths()
	var/typepath_files = list()
	for(var/folder_name in modular_folders)
		var/dir = "[folder_name]/"
		for(var/file in flist(dir))
			var/list/files = find_all_dm_files(dir)
			for(var/full_path in files)
				var/text = rustg_file_read(full_path)
				if(!text)
					continue
				var/list/matches = parse_typepaths_from_text(text)
				if(!length(matches))
					continue
				typepath_files |= parse_typepaths_from_text(text)
	return typepath_files

/datum/unit_test/modular_digitigrade_sprites/proc/parse_typepaths_from_text(text)
	var/type_string = "[type_to_test]"
	// escape the slashes in the typepath itself to make it valid for regex
	type_string = replacetext(type_string, "/", "\\/")
	var/regex/matcher = regex(type_string + @"[^s\n]*")
	if(!matcher.Find(text))
		return list()
	return matcher.group

/datum/unit_test/modular_digitigrade_sprites/proc/find_all_dm_files(dir)
	var/list/results = list()
	for(var/entry in flist(dir))
		var/path = "[dir][entry]"
		if(copytext(entry, -2) == "dm")
			results += path
		else if(copytext(entry, -1) == "/")
			results += find_all_dm_files(path)
	return results

/datum/unit_test/modular_digitigrade_sprites/Run()
	var/list/typepath_files = get_folders_of_typepaths()
	for(var/obj/item/clothing/under/valid_subtype as anything in subtypesof(/obj/item/clothing/under))
		var/subtype_string = "[valid_subtype]"
		if(subtype_string in typepath_files)
			continue
		var/flags = valid_subtype::supports_variations_flags
		if(!(flags & CLOTHING_DIGITIGRADE_VARIATION) && !(flags & CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON))
			TEST_FAIL("[subtype_string] is missing required digitigrade variation flags.")
