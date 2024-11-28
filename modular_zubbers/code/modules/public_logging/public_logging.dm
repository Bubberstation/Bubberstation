GLOBAL_VAR(public_log_directory)
GLOBAL_PROTECT(public_log_directory)
GLOBAL_VAR(master_public_log_file)


/proc/log_public_file(redacted_log_text)
	if(fexists(GLOB.master_public_log_file) && !isnull(redacted_log_text))
		rustg_file_append("\[[time2text(world.timeofday)]\] : [redacted_log_text]\n", GLOB.master_public_log_file)
