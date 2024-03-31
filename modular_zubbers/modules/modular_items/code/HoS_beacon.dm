/obj/item/choice_beacon/head_of_security
	name = "gun choice beacon"
	desc = "whatever you choose will determine the outcome of space station 13 and the fate of the company so choose wisely."
	company_source = "Romulus Shipping Company"
	company_message = span_bold("Copy that SS13, supply pod enroute!")


/obj/item/choice_beacon/head_of_security/generate_display_names()
	var/static/list/hosgun_list
	if(!hosgun_list)
		hosgun_list = list()
		for(var/obj/item/storage/box/hosgun/box as anything in typesof(/obj/item/storage/box/hosgun))
			hosgun_list[initial(box.name)] = box
	return hosgun_list

/obj/item/storage/box/hosgun
	name = "Classic 3-round burst pistol 9mm"

/obj/item/storage/box/hosgun/PopulateContents()
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/storage/box/hecu_rations(src)
	new /obj/item/storage/fancy/cigarettes/cigars(src)

/obj/item/storage/box/hosgun/revolver
	name = "Romulus Officer Heavy Revolver .460"

/obj/item/storage/box/hosgun/revolver/PopulateContents()
	new /obj/item/storage/box/gunset/hos_revolver(src)
	new /obj/item/knife/combat(src)

/obj/item/storage/box/hosgun/glock
	name = "Solaris Police Dual 9mm Pistol"

/obj/item/storage/box/hosgun/glock/PopulateContents()
	new /obj/item/clothing/neck/tie/red(src)
	new /obj/item/storage/pill_bottle/probital(src)
