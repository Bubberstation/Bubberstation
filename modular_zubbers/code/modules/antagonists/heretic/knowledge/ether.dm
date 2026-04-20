// The idea here is to give heretics something to restore things they would need medbay for but not a cure-all
// A bubber edit changes the heal flag in eldritch_flask.dm
/datum/heretic_knowledge/ether
	desc = "Transmutes a pool of vomit and a shard into a single use potion, drinking it will remove any sort of abnormality from your body including diseases, traumas (but not implants) \
		without restoring any health, at the cost of losing consciousness for an entire minute."
	drafting_tier = 2 // very strong, even with the nerf

/obj/item/ether
	desc = "A flask of nausea-inducing, thick green liquid. Restores your body's secondary ailments (missing parts, blood loss, wounds, diseases), then places you into an enhanced sleep for a full minute."
