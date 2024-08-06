/obj/machinery/disposal/delivery_chute/tagger
	var/currTag = SORT_TYPE_CARGO_BAY //Check out code/__DEFINES/sort_types.dm

/obj/machinery/disposal/delivery_chute/tagger/newHolderDestination(obj/structure/disposalholder/H)
	. = ..()
	if(currTag)
		H.destinationTag = currTag

/obj/machinery/disposal/delivery_chute/tagger/engineering
	currTag = SORT_TYPE_ENGINEERING

/obj/machinery/disposal/delivery_chute/tagger/security
	currTag = SORT_TYPE_SECURITY

/obj/machinery/disposal/delivery_chute/tagger/medbay
	currTag = SORT_TYPE_MEDBAY

/obj/machinery/disposal/delivery_chute/tagger/research
	currTag = SORT_TYPE_RESEARCH

/obj/machinery/disposal/delivery_chute/tagger/kitchen
	currTag = SORT_TYPE_KITCHEN
