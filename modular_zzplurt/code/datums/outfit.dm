/datum/outfit
	///Slot for underwear like boxers and panties
	var/w_underwear = null
	///Slot for socks, yes, the thing that usually goes before your shoes
	var/w_socks = null
	///Slot for the undershirt (which is quite a foreign concept to me) or bras
	var/w_shirt = null
	///Slot for the opposite ear.
	var/ears_extra = null
	///Slot for the part of your arms that isn't quite hands yet.
	var/wrists = null

/datum/outfit/apply_fingerprints(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return

	if(user.w_underwear)
		user.w_underwear.add_fingerprint(user, ignoregloves = TRUE)
	if(user.w_shirt)
		user.w_shirt.add_fingerprint(user, ignoregloves = TRUE)
	if(user.w_socks)
		user.w_socks.add_fingerprint(user, ignoregloves = TRUE)
	if(user.wrists)
		user.wrists.add_fingerprint(user, ignoregloves = TRUE)
	if(user.ears_extra)
		user.ears_extra.add_fingerprint(user, ignoregloves = TRUE)

/datum/outfit/copy_outfit_from_target(mob/living/carbon/human/H)
	. = ..()
	if(!.)
		return

	if(H.w_underwear)
		w_underwear = H.w_underwear.type
	if(H.w_shirt)
		w_shirt = H.w_shirt.type
	if(H.w_socks)
		w_socks = H.w_socks.type
	if(H.wrists)
		wrists = H.wrists.type
	if(H.ears_extra)
		ears_extra = H.ears_extra.type

/datum/outfit/get_types_to_preload()
	. = ..()
	. += w_underwear
	. += w_shirt
	. += ears_extra
	. += wrists
	. += w_socks

/datum/outfit/get_json_data()
	. = ..()
	.["w_underwear"] = w_underwear
	.["w_shirt"] = w_shirt
	.["ears_extra"] = ears_extra
	.["wrists"] = wrists
	.["w_socks"] = w_socks

/datum/outfit/copy_from(datum/outfit/target)
	. = ..()
	w_underwear = target.w_underwear
	w_shirt = target.w_shirt
	wrists = target.wrists
	ears_extra = target.ears_extra
	w_socks = target.w_socks

/datum/outfit/load_from(list/outfit_data)
	. = ..()
	w_underwear = text2path(outfit_data["w_underwear"])
	w_shirt = text2path(outfit_data["w_shirt"])
	wrists = text2path(outfit_data["wrists"])
	w_socks = text2path(outfit_data["w_socks"])
	ears_extra = text2path(outfit_data["ears_extra"])
