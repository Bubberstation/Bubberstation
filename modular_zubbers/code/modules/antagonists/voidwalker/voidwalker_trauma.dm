/datum/brain_trauma/voided/on_gain()
	. = ..()
	owner.add_mood_event("voided", /datum/mood_event/voided)

/datum/brain_trauma/voided/on_lose()
	. = ..()
	owner.clear_mood_event("voided")

//renamed the decal to not be vomit
/obj/effect/decal/cleanable/vomit/nebula
	name = "nebula puddle"
