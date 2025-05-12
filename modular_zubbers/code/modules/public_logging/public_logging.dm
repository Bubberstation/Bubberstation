GLOBAL_VAR(public_log_directory)
GLOBAL_PROTECT(public_log_directory)
GLOBAL_VAR(master_public_log_file)


/proc/log_public_file(redacted_log_text, no_regex_needed)
	if(fexists(GLOB.master_public_log_file) && !isnull(redacted_log_text))
		if(no_regex_needed)
			rustg_file_append("\[[time2text(world.timeofday)]\] : [redacted_log_text]\n", GLOB.master_public_log_file)
			return
		var/regex/stripping = regex(@"\((\w+)\)", "i")
		var/stripped_copy = replacetext(redacted_log_text, stripping, "redacted key")
		rustg_file_append("\[[time2text(world.timeofday)]\] : [stripped_copy]\n", GLOB.master_public_log_file)
