/datum/brain_trauma/voided/on_gain()
	. = ..()
	owner.add_mood_event("voided", /datum/mood_event/voided)

/datum/brain_trauma/voided/on_lose()
	. = ..()
	owner.clear_mood_event("voided")

//renamed the decal to not be vomit
/obj/effect/decal/cleanable/vomit/nebula
	name = "nebula puddle"


/datum/brain_trauma/voided/avatar
	name = "Voidwalker's Avatar"
	desc = "A humanoid conjuration. They are enlightened with the secrets of the cosmos and are now forever changed."
	ban_from_space = FALSE
	vomit_frequency = 0

/datum/brain_trauma/voided/avatar/on_gain()
	. = ..()
	owner.AddComponent(/datum/component/glass_passer, 2 SECONDS, 2 SECONDS)
