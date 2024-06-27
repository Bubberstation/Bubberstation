/obj/item/radio/intercom/broadcast
	name = "Broadcast intercom"
	desc = "Talk at this to be heard by the whole... station."
	freerange = TRUE
	freqlock = RADIO_FREQENCY_EMAGGABLE_LOCK // Go ahead. Get silly.

/obj/item/radio/intercom/broadcast/Initialize(mapload, ndir, building)
	. = ..()
	set_frequency(FREQ_BROADCAST)
	set_broadcasting(TRUE)

MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/broadcast, 26)
