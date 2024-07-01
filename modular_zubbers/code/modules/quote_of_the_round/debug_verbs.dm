ADMIN_VERB(generate_quote_of_the_round, R_DEBUG, "Generate Quote of the Round", "Generates a quote of the round for debug purposes.", ADMIN_CATEGORY_DEBUG)

	if(!SSticker.quote_of_the_round_text)
		SSticker.quote_of_the_round_text = "Bitches ain't shit but hoes and tricks."

	if(!SSticker.quote_of_the_round_attribution)
		SSticker.quote_of_the_round_attribution = "Albert Einstein"

	var/message_to_send = SSticker.generate_quote_of_the_round()

	user << browse(message_to_send,"window='quoteoftheround'")
