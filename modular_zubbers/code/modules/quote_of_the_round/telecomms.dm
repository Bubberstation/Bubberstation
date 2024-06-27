/obj/machinery/telecomms/hub/receive_information(datum/signal/signal, obj/machinery/telecomms/machine_from)
	. = ..()

	if(!.)
		return

	//Is this actually enabled?
	if(!SSticker.message_of_the_round_record_start)
		return

	//Non-common radio.
	if(signal.frequency != FREQ_COMMON) //Common only.
		return

	//Invalid or incomplete data.
	if(!length(signal.data) || !signal.data["message"] || !signal.data["name"] || !signal.data["job"] || signal.data["name"] == "Unknown")
		return

	if(world.time >= SSticker.message_of_the_round_record_start)

		//Okay time to find a suitable message.
		var/found_name = signal.data["name"]
		var/found_message = signal.data["message"]
		var/found_job = signal.data["job"]

		//Check if the name and message are suitable (sometimes these can be bypassed).
		if(is_ic_filtered(found_name) || is_ic_filtered(found_message) || is_ic_filtered(found_job))
			return

		//Check the number of characters.
		var/letter_length = length(found_message) //Number of characters.
		var/letter_min = CONFIG_GET(number/quote_of_the_round_letter_min)
		var/letter_max = CONFIG_GET(number/quote_of_the_round_letter_max)
		if(letter_min && letter_length < letter_min)
			return
		if(letter_max && letter_length > letter_max)
			return

		//Check the number of words.
		var/word_length = length(splittext(found_message," ")) //Number of words.
		var/word_min = CONFIG_GET(number/quote_of_the_round_word_min)
		var/word_max = CONFIG_GET(number/quote_of_the_round_word_max)
		if(word_min && word_length < word_min)
			return
		if(word_max && word_length > word_max)
			return

		//Finally, store it and save it.
		SSticker.quote_of_the_round_text = "\"[found_message]\" - [found_name], [found_job]"
		SSticker.message_of_the_round_record_start = null //Chosen!