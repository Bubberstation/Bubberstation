/datum/round_event_control/fax_spam
	name = "Fax Spam"
	description = "Sends spam pamphlets to all station fax machines"
	typepath = /datum/round_event/fax_spam
	weight = 25
	min_players = 10 // Better chance of there being heads of staff that get annoyed by this
	max_occurrences = 2
	category = EVENT_CATEGORY_BUREAUCRATIC
	earliest_start = 20 MINUTES

	track = EVENT_TRACK_MUNDANE
	tags = list(TAG_NEUTRAL)

/datum/round_event/fax_spam
	announce_chance = 0
	fakeable = FALSE
	var/obj/item/paper/fluff/advertisement/spam_type

/datum/round_event/fax_spam/setup()
	if(prob(25)) // Rarer, nongeneric spam
		spam_type = pick(typesof(/obj/item/paper/fluff/advertisement))
	else
		spam_type = /obj/item/paper/fluff/junkmail_generic

/datum/round_event/fax_spam/start()
	for(var/obj/machinery/fax/fax_machine as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/fax))
		if(fax_machine.visible_to_network && is_station_level(fax_machine.z))
			var/obj/item/paper/fluff/advertisement/spam_message = new spam_type
			fax_machine.receive(spam_message, pick("Silly Cone", "Clown Retirement Program", "Honkin good deals!", "Unknown Sender"))

/obj/item/paper/fluff/advertisement
	icon = 'modular_zubbers/icons/obj/service/advertisements.dmi'
	name = "generic advertisement"
	desc = "A pamphlet filled with useless advertisements."

/obj/item/paper/fluff/advertisement/grand_nomad_fleet
	name = "\improper Statement to all the mothpeople"
	desc = "A pamphlet from the well known Grand Admiral Signori, military leader for the mothic Grand Nomad Fleet.\
	His face, together with its signature cybernetics and majestic fluff, is printed on the front cover. \
	\"TO ALL KIN STILL LOST\" is written in bold letters next to him."
	icon_state = "nomad"
	var/static/random_sector_number = null

/obj/item/paper/fluff/advertisement/grand_nomad_fleet/Initialize(mapload)
	. = ..()
	if(isnull(random_sector_number))
		random_sector_number = rand(10000, 80000)
	add_raw_text("To all the lost mothic kin of [GLOB.station_name]!\n\
	Join the Grand Nomad Fleet, and rejoin with all your kin in the search for new lands. \
	We have parked a small patrol with a civilian transport in the nearby sector [random_sector_number]. \
	We will be leaving in approximately 3 hours, so make haste.")

/obj/item/paper/fluff/advertisement/toolbox
	name = "robust pamphlet"
	desc = "A pamphlet with a large toolbox pictured on the front page"
	default_raw_text = "Show you're the best of the best with our new exclusive <b> ROBUST TOOLBOX </b> line. \
	Provided in 7 different colors, including the brand new hot pink! Starting at 500cr."
	icon_state = "toolbox"

/obj/item/paper/fluff/advertisement/toolbox/Initialize(mapload)
	. = ..()
	icon_state = initial(icon_state)

/obj/item/paper/fluff/advertisement/gilded
	name = "tiziran prince statement"
	desc = "A gilded pamphlet, with royal red text written on the front."
	default_raw_text = "Hello. I am the lost tiziran prince Barnaxi IV messaging you in my time of need. \
	I have been presumed dead in a shuttle ride attacked by separatists, but in reality I survived and stayed in hiding \
	aboard your station. Please store 1000cr in holochips in a bag with your name in Waste Disposal so that I may buy a \
	low profile shuttle ride to my palace. Once I reunite with my family, I will make sure to shower you in royal riches."
	icon_state = "gilded"

/obj/item/paper/fluff/advertisement/gilded/Initialize(mapload)
	. = ..()
	icon_state = initial(icon_state)
