/datum/controller/subsystem/ticker
	var/quote_of_the_round_record_start
	var/quote_of_the_round_text
	var/quote_of_the_round_attribution

/datum/controller/subsystem/ticker/Initialize()
	. = ..()
	quote_of_the_round_record_start = rand(CONFIG_GET(number/quote_of_the_round_time_random_start), CONFIG_GET(number/quote_of_the_round_time_random_end))
	message_admins(
		span_notice("The quote of the round will be chosen in [DisplayTimeText(quote_of_the_round_record_start,1)].")
	)

/datum/controller/subsystem/ticker/OnRoundend(datum/callback/cb)

	if(quote_of_the_round_text)
		send2chat(
			new /datum/tgs_message_content(
				generate_quote_of_the_round(),
				CONFIG_GET(string/channel_announce_new_game)
			)
		)

	. = ..()

/datum/controller/subsystem/ticker/proc/generate_quote_of_the_round()
	return "A shift on [SSmapping.config.map_name] has ended.\n\
	[pick(strings("quote_of_the_round.json", "workers"))] [pick(strings("quote_of_the_round.json", "action"))] [pick(strings("quote_of_the_round.json", "message"))] that occured during said shift:\n\
	> *[quote_of_the_round_text]*\n \\- *[quote_of_the_round_attribution]*"
