//Sends our victim across the station's tables, forcing them to listen to slam of the north star, and potentially slamming them into all the glass tables.
/datum/smite/tabletide
	name = "Tabletide Stationwide"

/datum/smite/tabletide/effect(client/user, mob/living/target)
	var/datum/element/table_smash/smash = SSdcs.GetElement(/datum/element/table_smash)
	minor_announce(html_decode("[target] has brought the wrath of the gods upon themselves and is now being tableslammed across the station. Please stand by."),"Central Command Update")
	SEND_SOUND(target, sound('modular_zubbers/sound/misc/slamofthenorthstar.ogg', volume = 50))
	for(var/area/station/area_in_question as anything in GLOB.the_station_areas)
		for(var/obj/structure/table/table_in_question in area_in_question)
			smash.tablepush(target, target, table_in_question)
			sleep(1)
