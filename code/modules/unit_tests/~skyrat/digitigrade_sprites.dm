/// the regex.find() proc returns 0 if it has found nothing.
/// So we're replacing the magic number with a name.
#define NO_MATCH 0

/datum/unit_test/modular_digitigrade_sprites
	var/type_to_test = /obj/item/clothing/under
	var/list/modular_folders = list(
		"modular_skyrat",
		"modular_zubbers",
	)

/datum/unit_test/modular_digitigrade_sprites/proc/get_folders_of_typepaths()
	var/typepaths_to_check = list()
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
				typepaths_to_check |= matches
	return typepaths_to_check

/datum/unit_test/modular_digitigrade_sprites/proc/parse_typepaths_from_text(text)
	var/type_string = "[type_to_test]"
	// escape the slashes in the typepath itself to make it valid for regex
	type_string = replacetext(type_string, "/", "\\/")
	// make sure we only look at the ones defined/overwritten in our folders (by using ^ and $ to find start and end of lines)
	var/regex_string = "^" + type_string + @"[^\n]*$"
	// g flag to find all, m flag to make sure ^ and $ work
	var/regex/matcher = regex(regex_string, "gm")
	var/list/matches = list()
	var/match_index = matcher.Find(text)
	while (match_index != NO_MATCH)
		matches.Add(matcher.match)
		match_index = matcher.Find(text, match_index)
	return matches

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
	var/list/typepaths_to_check = get_folders_of_typepaths()
	for(var/obj/item/clothing/under/valid_subtype as anything in subtypesof(type_to_test))
		var/subtype_string = "[valid_subtype]"
		if(!(subtype_string in typepaths_to_check))
			continue
		var/flags = valid_subtype::supports_variations_flags
		if(!(flags & CLOTHING_DIGITIGRADE_VARIATION) && !(flags & CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON))
			TEST_FAIL("[subtype_string] is missing required digitigrade variation flags.")

#undef NO_MATCH
