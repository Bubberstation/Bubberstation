/datum/job/psychologist
	alt_titles = list(
		"Psychologist",
		"Counsellor",
		"Psychiatrist",
		"Therapist",
		"Shrink",
		"Anger Management",
		"Emotional Support Animal",
	)

/datum/job/psychologist/New()
	LAZYADDASSOC(mail_goodies, /obj/item/toy/nyamagotchi, 45)
	. = ..()
