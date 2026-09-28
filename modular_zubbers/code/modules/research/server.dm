//Port Tarkon Research Server

/obj/machinery/rnd/server/tarkon
	name = "\improper Tarkon Industries R&D Server"
	circuit = /obj/item/circuitboard/machine/rdserver/tarkon
	req_access = list(ACCESS_AWAY_SCIENCE)

/obj/machinery/rnd/server/tarkon/Initialize(mapload)
	var/datum/techweb/tarkon_techweb = locate(/datum/techweb/tarkon) in SSresearch.techwebs
	stored_research = tarkon_techweb
	return ..()

/obj/machinery/rnd/server/tarkon/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(held_item && istype(held_item, /obj/item/research_notes))
		context[SCREENTIP_CONTEXT_LMB] = "Generate research points"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/rnd/server/tarkon/examine(mob/user)
	. = ..()
	if(!in_range(user, src) && !isobserver(user))
		return
	. += span_notice("Insert [EXAMINE_HINT("Research Notes")] to generate points.")

/obj/machinery/rnd/server/tarkon/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/research_notes) && stored_research)
		var/obj/item/research_notes/research_notes = attacking_item
		stored_research.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = research_notes.value))
		playsound(src, 'sound/machines/copier.ogg', 50, TRUE)
		qdel(research_notes)
		return
	return ..()
