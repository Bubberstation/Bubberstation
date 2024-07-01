/obj/machinery/telecomms/hub/receive_information(datum/signal/signal, obj/machinery/telecomms/machine_from)
	. = ..()

	if(!.)
		return

	//Is this actually enabled?
	if(!SSticker.quote_of_the_round_record_start)
		return

	//Non-common radio.
	if(signal.frequency != FREQ_COMMON) //Common only.
		return

	//Invalid or incomplete data.
	if(!length(signal.data) || !signal.data["message"] || !signal.data["name"] || !signal.data["job"] || signal.data["name"] == "Unknown")
		return

	if(world.time >= SSticker.quote_of_the_round_record_start && !prob(80)) //Atmos optimization

		if(!istype(signal,/datum/signal/subspace/vocal))
			return

		var/datum/signal/subspace/vocal/vsignal = signal

		var/mob/found_user = vsignal.virt && vsignal.virt.source && ismob(vsignal.virt.source) ? vsignal.virt.source : null

		if(!found_user) //Not a mob. We don't check for ckey or stuff like that because maybe poly will say something hilarious.
			return

		//Okay time to find a suitable message.
		var/found_name = found_user.real_name == vsignal.data["name"] ? found_user.real_name : "[found_user.real_name] (as [vsignal.data["name"]])"
		var/found_message = vsignal.data["message"]
		var/found_job = vsignal.data["job"]

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
		SSticker.quote_of_the_round_text = found_message
		SSticker.quote_of_the_round_attribution = "[found_name], [found_job]"
		SSticker.quote_of_the_round_record_start = null //Chosen!
		message_admins("[found_message] by [ADMIN_LOOKUPFLW(found_user)] has been randomly selected as quote of the round. <a href='?src=[REF(src)];cancel_quote=1'>Click here</a> to change.")

/obj/machinery/telecomms/hub/Topic(href, href_list)
	. = ..()
	if(href_list["cancel_quote"] && check_rights(R_ADMIN))
		if(!SSticker.quote_of_the_round_text)
			to_chat(usr, span_warning("This quote of the day has already been changed."), confidential = TRUE)
			return
		log_admin_private("[key_name_admin(usr)] has rerolled the quote of the round, which was: [SSticker.quote_of_the_round_text].")
		SSticker.quote_of_the_round_text = null
		SSticker.quote_of_the_round_attribution = null
		SSticker.quote_of_the_round_record_start = world.time + 10 MINUTES
		message_admins("[key_name_admin(usr)] has rerolled the quote of the round. A new one will be chosen in 10 minutes.")
