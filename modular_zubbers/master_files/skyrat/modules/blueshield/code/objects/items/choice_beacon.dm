/obj/item/choice_beacon/blueshield
	name = "Blueshield's locker beacon"
	desc = "Summons the Blueshield's equipment locker. Recommended for use only in secure areas."
	company_source = "Nanotrasen kitting division"
	company_message = span_bold("Request status: Received. Package status: Delivered. Note: This equipment is to be used solely by Blueshield personnel to protect heads of staff.")

/obj/item/choice_beacon/blueshield/generate_display_names()
	var/static/list/blueshield_locker
	if(!blueshield_locker)
		blueshield_locker = list()
		var/list/locker_choice = list(
			/obj/structure/closet/secure_closet/blueshield
		)
		for(var/obj/structure/closet/secure_closet/blueshield/locker as anything in locker_choice)
			blueshield_locker[initial(locker.name)] = locker
	return blueshield_locker
