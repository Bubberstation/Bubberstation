/datum/round_event_control/fax_spam
	name = "Fax Spam"
	description = "Sends spam pamphlets to all station fax machines"
	typepath = /datum/round_event/fax_spam
	weight = 15
	min_players = 10 // Better chance of there being heads of staff that get annoyed by this
	max_occurrences = 2
	category = EVENT_CATEGORY_BUREAUCRATIC
	earliest_start = 20 MINUTES

	track = EVENT_TRACK_MUNDANE
	tags = list(TAG_NEUTRAL)

/datum/round_event/fax_spam
	announce_chance = 0
	fakeable = FALSE
	var/obj/item/paper/advertisement/spam_type

/datum/round_event/fax_spam/setup()
	spam_type = pick(subtypesof(/obj/item/paper/advertisement))

/datum/round_event/fax_spam/start()
	for(var/obj/machinery/fax/fax_machine as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/fax))
		if(fax_machine.visible_to_network && is_station_level(fax_machine.z))
			var/obj/item/paper/advertisement/spam_message = new spam_type
			fax_machine.receive(spam_message, "Unknown Sender")

/obj/item/paper/advertisement
	icon = 'modular_zubbers/icons/obj/service/advertisements.dmi'

/obj/item/paper/advertisement/grand_nomad_fleet
	name = "Statement to all the mothpeople"
	desc = "A pamphlet from the well known Grand Admiral Signori, military leader for the mothic Grand Nomad Fleet.\
	His face, together with its signature cybernetics and majestic fluff, is printed on the front cover. \
	\"TO ALL KIN STILL LOST\" is written in bold letters next to him."
	icon_state = "nomad"
	var/static/random_sector_number = null

/obj/item/paper/advertisement/grand_nomad_fleet/Initialize(mapload)
	. = ..()
	if(isnull(random_sector_number))
		random_sector_number = rand(10000, 80000)
	add_raw_text("To all the lost mothic kin of [GLOB.station_name]!\n\
	Join the Grand Nomad Fleet, and rejoin with all your kin in the search for new lands. \
	We have parked a small patrol with a civilian transport in the nearby sector [random_sector_number]. \
	We will be leaving in approximately 3 hours, so make haste.")
