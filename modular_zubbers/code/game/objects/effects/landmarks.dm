/obj/effect/landmark/start/blacksmith
	name = "Blacksmith"
	icon_state = "Curator"

/obj/effect/landmark/navigate_destination/autoname
	name = "auto-naming navigate verb destination"
	location = null

/obj/effect/landmark/navigate_destination/autoname/Initialize(mapload)
	. = ..()
	location = "[loc.loc.name]" //This looks unsafe. Intentional. This should runtime if there are issues.
