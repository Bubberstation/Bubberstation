/datum/job/cargo_technician
	akula_outfit = /datum/outfit/akula/cargo_technician
	required_languages = null
	alt_titles = list(
		"Cargo Technician",
		"Warehouse Technician",
		"Commodities Trader",
		"Deck Worker",
		"Inventory Associate",
		"Mailman",
		"Mailwoman",
		"Mail Carrier",
		"Merchantman",
		"Merchantwoman",
		"Postman",
		"Postwoman",
		"Receiving Clerk",
		"Union Associate",
		"Crate Pusher",
	)

/datum/job/cargo_technician/New()
	mail_goodies -= /obj/item/gun/ballistic/automatic/wt550
	. = ..()
