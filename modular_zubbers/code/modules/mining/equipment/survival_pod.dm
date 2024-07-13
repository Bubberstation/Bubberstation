/obj/item/survivalcapsule/plap
	name = "PLAP capsule"
	desc = "A bluespace capsule colored in syndie red and black. It has the letters PLAP written on it."
	template_id = "shelter_plap"
	icon_state = "scapsule"
	icon = 'modular_zubbers/icons/obj/equipment/mining.dmi'

/obj/item/paper/crumpled/plap
	name = "Guide to your PLAP (Portable Listening Advanced Post)"
	default_raw_text = {"<h1><table bgcolor="darkred" width="100%"><th><font color="#ffffff" size=4 face="OCR A Std, monospace"><div align="center">♦♦♦♦♦♦♦♦◹§◺♦♦♦♦♦♦♦♦</font></div></th></table></h1><hr /><font face="Veranda" size=3>Welcome to your very own "Portable" Listening Post! Now that you've unboxed the kit, lets get started on how everything works!<br><br>Included in this kit are:<br>* State of the art protective windows, from the dirty outside world!<br>* A computer bay fit to make the most hackerman of boys cry!<br>* A fax machine painted in sleek Syndicate Red.<br>* A filing cabinet! It's not special. Just a filing cabinet.<br><br>Listen to your foes! Stink up their comms! Find a cute girl to stalk! All is possible with the "Portable" Listening Post!<br><hr />The fax machine included in the PLP is set up to the Sothran network. It is not visible on any fax machines aboard the station, while still able to send to them. Use this to your advantage.</font><hr /><center><font size=3>❘❙❚❘❙❚|<span style="color:black;font-family:'Sitka Small Semibold';">There is glory in silence.</span>|❚❙❘❚❙❘</center><hr><div align="center"><font size=1>Warning. Portable Listening Post can not be moved once placed. Relies on power of the surrounding area. Comms agent not included. Basic knowledge of running communications arrays required. Do not ingest small parts that fall off computer keyboards.</div></font><hr><h1><table bgcolor="darkred" width="100%"><th><font color="#ffffff" size=4 face="OCR A Std, monospace"><div align="center">♦♦♦♦♦♦♦♦◹§◺♦♦♦♦♦♦♦♦</font></div></th></table></h1>"}

/obj/item/survivalcapsule/sauna
	name = "sauna and hottub shelter"
	desc = "A bluespace capsule that deploys a luxurous sauna and hot tub"
	template_id = "shelter_s"

/datum/orderable_item/mining/capsule_sauna
	item_path = /obj/item/survivalcapsule/sauna
	cost_per_order = 7000

/obj/item/survivalcapsule/medical
	name = "medical trauma pod"
	desc = "A bluespace capsule that deploys a fairly effective medical treatment pod!"
	template_id = "shelter_delta"

/obj/item/survivalcapsule/chemistry
	name = "chemical refinement pod"
	desc = "A bluespace capsule that deploys a functional chemistry refining area, useful for harvesting those helpful geysers."
	template_id = "shelter_echo"

/datum/armament_entry/company_import/deforest/equipment/medpod
	item_type = /obj/item/survivalcapsule/medical
	cost = PAYCHECK_COMMAND * 40

/datum/armament_entry/company_import/deforest/equipment/chempod
	item_type = /obj/item/survivalcapsule/chemistry
	cost = PAYCHECK_COMMAND * 20

/*****************************Botany Pods - Home is where the green is...********************************/
/obj/item/survivalcapsule/botany
	name = "botany control capsule"
	desc = "A bluespace pod, containing botanical equipment."
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_botany"
	used = FALSE

/datum/map_template/shelter/botany
	name = "Botany Control"
	shelter_id = "shelter_botany"
	description = "A contained and interconnectable botany pod."
	mappath = "_maps/bubber/pods/shelter_botany.dmm"

/datum/map_template/shelter/botany/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/obj/item/survivalcapsule/trays
	name = "botany trays capsule"
	desc = "A bluespace pod, containing botanical equipment."
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_trays"
	used = FALSE

/datum/map_template/shelter/trays
	name = "Botany Trays"
	shelter_id = "shelter_trays"
	description = "A contained and interconnectable botany pod."
	mappath = "_maps/bubber/pods/shelter_trays.dmm"

/datum/map_template/shelter/trays/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/obj/item/survivalcapsule/fan
	name = "airlock fan capsule"
	desc = "A bluespace pod, containing a deployable fan, to keep the pressure in."
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_fan"
	used = FALSE

/datum/map_template/shelter/fan
	name = "Airlock fan deployer"
	shelter_id = "shelter_fan"
	description = "A contained and interconnectable botany pod."
	mappath = "_maps/bubber/pods/shelter_fan.dmm"

/datum/map_template/shelter/fan/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/obj/item/survivalcapsule/o2
	name = "oxygen harvesting capsule"
	desc = "A bluespace pod, containing a small pumping station, to harvest breathable O2."
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_o2"
	used = FALSE

/datum/map_template/shelter/o2
	name = "o2 harvester deployer"
	shelter_id = "shelter_o2"
	description = "A contained O2 harvesting pod, for planetary use."
	mappath = "_maps/bubber/pods/shelter_o2.dmm"

/datum/map_template/shelter/o2/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/obj/item/survivalcapsule/kitchen
	name = "deployable kitchen capsule"
	desc = "A bluespace pod, containing a kitchen."
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_kitchen"
	used = FALSE

/datum/map_template/shelter/kitchen
	name = "kitchen deployer"
	shelter_id = "shelter_kitchen"
	description = "A contained kitchen."
	mappath = "_maps/bubber/pods/shelter_kitchen.dmm"

/datum/map_template/shelter/kitchen/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/obj/item/survivalcapsule/cabin
	name = "deployable comfort capsule"
	desc = "A bluespace pod, containing a wooden cabin."
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_cabin"
	used = FALSE

/datum/map_template/shelter/cabin
	name = "comfort cabin deployer"
	shelter_id = "shelter_cabin"
	description = "A contained comfort cabin."
	mappath = "_maps/bubber/pods/shelter_cabin.dmm"

/datum/map_template/shelter/cabin/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/obj/item/survivalcapsule/threebythree
	name = "deployable small emtpy capsule"
	desc = "A bluespace pod, containing an empty 3x3 capsule."
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_threebythree"
	used = FALSE

/datum/map_template/shelter/threebythree
	name = "small capsule deployer"
	shelter_id = "shelter_threebythree"
	description = "A contained small capsule."
	mappath = "_maps/bubber/pods/shelter_3x3.dmm"

/datum/map_template/shelter/threebythree/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/obj/item/survivalcapsule/sixbysix
	name = "deployable large emtpy capsule"
	desc = "A bluespace pod, containing an empty 6x6 capsule."
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_sixbysix"
	used = FALSE

/datum/map_template/shelter/sixbysix
	name = "large capsule deployer"
	shelter_id = "shelter_sixbysix"
	description = "A contained large capsule."
	mappath = "_maps/bubber/pods/shelter_6x6.dmm"

/datum/map_template/shelter/sixbysix/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/armament_entry/company_import/nri_surplus/misc/botanypod
	item_type = /obj/item/survivalcapsule/botany
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/nri_surplus/misc/botanytrayspod
	item_type = /obj/item/survivalcapsule/trays
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/nri_surplus/misc/kitchenpod
	item_type = /obj/item/survivalcapsule/kitchen
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/nri_surplus/misc/o2pod
	item_type = /obj/item/survivalcapsule/o2
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/nri_surplus/misc/fanpod
	item_type = /obj/item/survivalcapsule/fan
	cost = PAYCHECK_COMMAND * 1

/datum/armament_entry/company_import/nri_surplus/misc/threebythree
	item_type = /obj/item/survivalcapsule/threebythree
	cost = PAYCHECK_COMMAND * 1

/datum/armament_entry/company_import/nri_surplus/misc/sixbysix
	item_type = /obj/item/survivalcapsule/sixbysix
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/nri_surplus/misc/cabin
	item_type = /obj/item/survivalcapsule/cabin
	cost = PAYCHECK_COMMAND * 2
