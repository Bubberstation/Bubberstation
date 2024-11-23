/obj/effect/landmark/start/blacksmith
	name = "Blacksmith"
	icon_state = "Curator"

/obj/effect/landmark/navigate_destination/autoname
	name = "auto-naming navigate verb destination"
	location = null

/obj/effect/landmark/navigate_destination/autoname/Initialize(mapload)
	. = ..()
	location = "[loc.loc.name]" //This looks unsafe. Intentional. This should runtime if there are issues.

/obj/effect/landmark/latejoin_override
	name = "JoinLate Override"

/obj/effect/landmark/latejoin_override/Initialize(mapload)
	..()
	SSjob.latejoin_override_trackers += loc
	return INITIALIZE_HINT_QDEL

/datum/controller/subsystem/job/
	var/list/latejoin_override_trackers = list()

/obj/effect/landmark/navigate_destination/cryo
	location = "Cryopods"

/obj/effect/landmark/navigate_destination/dockpublicmining
	location = "Public Mining"
