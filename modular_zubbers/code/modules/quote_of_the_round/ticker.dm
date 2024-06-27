/datum/controller/subsystem/ticker
	var/message_of_the_round_record_start
	var/quote_of_the_round_text

/datum/controller/subsystem/ticker/Initialize()
	. = ..()
	message_of_the_round_record_start = rand(CONFIG_GET(number/quote_of_the_round_time_random_start), CONFIG_GET(number/quote_of_the_round_time_random_end))
	message_admins(
		span_notice("The quote of the round will be chosen in [DisplayTimeText(message_of_the_round_record_start,1)].")
	)

/datum/controller/subsystem/ticker/Shutdown()

	if(quote_of_the_round_text)
		send2chat(
			new /datum/tgs_message_content(
				"Randomly Chosen Quote of the Round:\n\
				[quote_of_the_round_text], during round **[GLOB.round_id]**, on [SSmapping.config.map_name].",
				CONFIG_GET(string/channel_announce_new_game)
			)
		)

	. = ..()
