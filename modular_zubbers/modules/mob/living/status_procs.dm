/* get_quirk_security_string() is used to add all of the quirks that have security notes into a singular note for security officers
*
* Arguments:
* * Category- Which types of quirks we want to print out. Defaults to everything
*/
/mob/living/proc/get_quirk_security_string(category = CAT_QUIRK_ALL)
	var/list/dat = list()
	for(var/datum/quirk/candidate as anything in quirks)
		dat += candidate.security_record_text

	if(!length(dat))
		return "No prior security issues."
	return dat.Join(" ")
