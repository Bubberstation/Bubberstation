// Saves christmas tree blacklist data
/datum/controller/subsystem/persistence/proc/save_xmas_gift_blacklist()
	var/json_file = file("data/xmas_gift_blacklist.json")
	var/list/file_data = list()
	var/xmas_list_length = LAZYLEN(GLOB.xmas_gift_blacklist)
	file_data["data"] = LAZYCOPY(GLOB.xmas_gift_blacklist)
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(file_data))
	log_game("Saved [xmas_list_length] items into xmas gift blacklist.")

// Loads christmas tree blacklist data
/datum/controller/subsystem/persistence/proc/load_xmas_gift_blacklist()
	var/json_file = file("data/xmas_gift_blacklist.json")
	if(!fexists(json_file))
		return
	var/list/json = json_decode(file2text(json_file))
	if(!json)
		return
	var/list/decoded_xmas_list = json["data"]
	var/xmas_list_length = LAZYLEN(decoded_xmas_list)
	if(!xmas_list_length)
		return

	log_game("Loaded [xmas_list_length] items into xmas gift blacklist.")
	GLOB.xmas_gift_blacklist = LAZYCOPY(decoded_xmas_list)
