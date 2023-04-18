/mob/living/carbon/Initialize(mapload)
	. = ..()
	set_hydration(rand(HYDRATION_LEVEL_START_MIN, HYDRATION_LEVEL_START_MAX))
	set_urination(rand(URINATION_LEVEL_START_MIN, URINATION_LEVEL_START_MAX))

/mob/living/carbon/verb/piss()
	set name = "Urinate"
	set category = "IC"
	set desc = "You shouldn't do this while clothed."

	DEFAULT_QUEUE_OR_CALL_VERB(VERB_CALLBACK(src, PROC_REF(urinate), TRUE))

/mob/living/carbon/proc/urinate(intentional = FALSE)
	if(urination < 30)
		if(intentional)
			to_chat(src, span_info("You don't have to."))
		return
	if(stat >= DEAD)
		if(intentional)
			to_chat(src, span_info("The dead can't pee."))
		return
	var/obj/item/organ/internal/bladder/bladder = getorganslot(ORGAN_SLOT_BLADDER)
	if(!bladder || bladder.organ_flags & ORGAN_FAILING)
		if(intentional)
			to_chat(src, span_warning("You don't have a functional bladder!"))
		return

	var/obj/item/organ/external/genital/penis/penis = getorganslot(ORGAN_SLOT_PENIS)
	var/obj/structure/sink/sink = locate() in get_turf(src)
	var/obj/structure/toilet/toilet = locate() in get_turf(src)
	var/obj/structure/urinal/urinal = locate() in get_turf(src)
	//Gentleman's piss
	if(urinal)
		visible_message(
			span_notice("<b>[src]</b> pisses on [urinal]"),
			span_notice("I take a piss on [urinal]. Sweet relief.")
		)
	//Decent piss
	else if(toilet)
		visible_message(
			span_notice("<b>[src]</b> pisses on [toilet]."),
			span_notice("You take a piss on [toilet]. Sweet relief.")
		)
	//Secret piss
	else if(sink && penis)
		visible_message(
			span_notice("<b>[src]</b> pisses on [sink]."),
			span_nicegreen("I take a piss on [sink]. <b>Classic!</b>")
		)

	//Floor piss
	else
		visible_message(
			span_boldwarning("<b>[src]</b> pisses on the floor!"),
			span_notice("I pee on the floor.")
		)
		var/turf/T = get_turf(src)
		var/datum/reagents/piss = new /datum/reagents(10)
		var/ratio = min(HYDRATION_LEVEL_FULL / (hydration || 1), 0.99) //always will have some piss
		reagents.trans_to(piss, ratio * 3.3)
		piss.add_reagent(/datum/reagent/water, max((ratio * 10) - piss.total_volume, 0.01))
		piss.add_reagent(/datum/reagent/toxin/piss, (1 - ratio))
		T.add_liquid_from_reagents(piss)
	adjust_urination(-rand(25,50))
	playsound(get_turf(src), 'modular_zubbers/sound/effects/pee.ogg', 60)


/mob/living/carbon/proc/handle_hydration()
	return

/mob/living/carbon/proc/set_hydration(change)
	hydration = max(0, change)

/mob/living/carbon/proc/adjust_hydration(change, max = INFINITY)
	hydration = clamp(hydration + change, 0, max)


/mob/living/carbon/proc/handle_urination()
	return

/mob/living/carbon/proc/set_urination(change)
	urination = max(0, change)

/mob/living/carbon/proc/adjust_urination(change, max = INFINITY)
	urination = clamp(urination + change, 0, max)

