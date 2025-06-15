/datum/job/cargo_technician/New()
	mail_goodies -= /obj/item/gun/ballistic/automatic/wt550
	mail_goodies += /obj/item/gun/ballistic/automatic/wt550/security
	. = ..()
