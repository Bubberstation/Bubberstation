/datum/objective/prank
	target_amount = 10
/datum/objective/prank/New()
	explanation_text = "Create a photo blog on the stations newscasters to acheive virality. Create at least [target_amount] entries."

/datum/objective/prank/check_completion()
	var/prank_score
	for(var/datum/feed_channel/feed_channel in GLOB.news_network.network_channels)
		if(feed_channel.abductor_channel)
			prank_score += length(feed_channel.messages)

/datum/feed_channel
	var/abductor_channel = FALSE


/datum/feed_network/create_feed_channel(channel_name, author, desc, locked, adminChannel = FALSE, hardset_channel)
	. = ..()
	var/datum/feed_channel/newChannel = .
	if (HAS_TRAIT(usr, TRAIT_ABDUCTOR_TRAINING))
		newChannel.abductor_channel = TRUE
	if (istype(usr) && HAS_MIND_TRAIT(usr, TRAIT_ABDUCTOR_TRAINING))
		newChannel.abductor_channel = TRUE

/datum/feed_channel/toggle_censor_author()

	if(abductor_channel)
		to_chat(usr, "ACCESS DENIED")
		return FALSE
	. = ..()
