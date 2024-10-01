/mob/living/silicon/Topic(href, href_list)
	. = ..()
	if(href_list["lookup_info"] == "open_examine_panel")
		examine_panel.holder = src
		examine_panel.ui_interact(usr) //datum has a tgui component, here we open the window
	if(href_list["temporary_flavor"]) // we need this here because tg code doesnt call parent in /mob/living/silicon/Topic()
		show_temp_ftext(usr)
//bubber edit begin
	if(href_list["open_door"])
		var/obj/machinery/door/airlock/door = locate(href_list["open_door"]) in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/airlock)
		var/mob/living/requester = locate(href_list["user"]) in GLOB.mob_list
		if(!requester)
			return
		if(!door)
			return
		open_door(requester, door)
