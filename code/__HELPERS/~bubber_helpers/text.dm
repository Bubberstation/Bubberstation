/// Takes gender and attraction strings and returns a string with the format Gender/Sexuality: arg1, arg2
/// if either value is Unset, remove that part of the string, if both are Unset, return an empty string
/proc/get_gender_attraction_string(gender, attraction)
	var/gender_set = gender != "Unset"
	var/attraction_set = attraction != "Unset"
	if(!gender_set && !attraction_set)
		return ""

	var/list/label = list()
	var/list/values = list()
	if(gender_set)
		label += "Gender"
		values += gender
	if(attraction_set)
		label += "Sexuality"
		values += attraction
	return "[english_list(label, and_text = "/")]: [span_revenboldnotice(english_list(values, and_text = ", "))]"
