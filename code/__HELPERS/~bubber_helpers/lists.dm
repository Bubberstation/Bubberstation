///Returns an assoc list in plain english as a string
/proc/english_list_assoc(list/input)
	var/output
	for(var/item in input)
		output += "[item] = [input[item]] "

	return trim_right(output)
