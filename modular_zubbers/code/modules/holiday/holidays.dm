GLOBAL_VAR_INIT(holiday_message_sent, FALSE)

/datum/holiday/xmas/roundstart_celebrate()
	. = ..()
	if(GLOB.holiday_message_sent)
		return

	addtimer(CALLBACK(src, PROC_REF(annouce_surplus_gifts)), 15 SECONDS) // wait until a bit after all the roundstart announcements etc. are done
	GLOB.holiday_message_sent = TRUE

/datum/holiday/xmas/proc/annouce_surplus_gifts()
	priority_announce(
			text = "Nanotrasen hopes you all had an enjoyable holiday period, or at the very least survived it with most of your limbs intact. \
				We regret to inform you that our logistics centre is currently overflowing with pallets of undelivered Christmas presents, \
				all thoughtfully addressed to various members of this station.\n\nWhether you missed out because you were away, died on the job, \
				or simply couldn’t be bothered to walk your lazy self over to the Christmas tree, Central Command will, for the next few days, \
				arrange delivery of these neglected gifts via the Cargo department.\n\nAll we ask in return is a modest shipping and handling fee. \
				After all, nothing says \"seasonal goodwill\" quite like paying extra for things that were already yours. Happy holidays!",
			title = "Medium Priority Holiday Announcement",
			sender_override = "Central Command Logistics Department",
			color_override = "pink",
		)
