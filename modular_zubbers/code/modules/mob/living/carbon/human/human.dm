/mob/living/carbon/human/urinate(intentional = FALSE)
	if(urination < 30)
		if(intentional)
			to_chat(src, span_info("You don't have to."))
		return
	if(HAS_TRAIT(src, TRAIT_NO_PISSING))
		if(intentional)
			to_chat(src, span_info("You never have to."))
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

	var/obj/item/reagent_containers/cup/cup = get_active_held_item()
	var/obj/item/organ/external/genital/penis/penis = getorganslot(ORGAN_SLOT_PENIS)
	var/obj/structure/sink/sink = locate() in get_turf(src)
	var/obj/structure/toilet/toilet = locate() in get_turf(src)
	var/obj/structure/urinal/urinal = locate() in get_turf(src)
	//Groin "covered"
	if(!is_bottomless())
		// Do not piss self if doing it infront of urinal.
		// Just pull down your pants and piss, then pull it back up like everyone else, dumbass.
		if (urinal && penis)
			visible_message(
				span_notice("<b>[src]</b> pulls down [p_their()] pants, and pisses on \the [urinal]."),
				span_notice("You pull down your pants and take a piss in \the [urinal]. Sweet relief.")
			)
		else if (toilet && penis)
			visible_message(
				span_notice("<b>[src]</b> pisses on [toilet] after putting his pants down."),
				span_notice("You pull down your pants and take a piss on \the [toilet]. Sweet relief.")
			)
		else
			visible_message(
				span_notice("<b>[src]</b> pisses [p_their()] pants."),
				span_notice("You piss yourself...")
			)
	//Medical piss
	else if(istype(cup))
		visible_message(
			span_notice("<b>[src]</b> pisses in \the [cup]."),
			span_notice("You take a piss in \the [cup].")
		)
		var/datum/reagents/piss = new /datum/reagents(10)
		var/ratio = min(HYDRATION_LEVEL_FULL / (hydration || 1), 0.99) //always will have some piss
		reagents.trans_to(piss, ratio * 3.3)
		piss.add_reagent(/datum/reagent/water, max((ratio * 10) - piss.total_volume, 0.01))
		piss.add_reagent(/datum/reagent/toxin/piss, (1 - ratio) * 10)
		piss.trans_to(cup, INFINITY)
		if(piss.total_volume)
			var/turf/turf = get_turf(src)
			turf.add_liquid_from_reagents(piss)
			visible_message(
				span_warning("The piss spills over \the [cup]!")
			)

	//Gentleman's piss
	else if(urinal)
		visible_message(
			span_notice("<b>[src]</b> pisses on \the [urinal]."),
			span_notice("You take a piss in \the [urinal]. Sweet relief.")
		)
	//Decent piss
	else if(toilet)
		visible_message(
			span_notice("<b>[src]</b> pisses on \the [toilet]."),
			span_notice("You take a piss in \the [toilet]. Sweet relief.")
		)
	//Secret piss
	else if(sink && penis)
		visible_message(
			span_notice("<b>[src]</b> pisses on [sink]."),
			span_nicegreen("You take a piss in \the [sink]. <b>Classic!</b>")
		)
	//Floor piss
	else
		visible_message(
			span_boldwarning("<b>[src]</b> pisses on the floor!"),
			span_notice("You pee on the floor.")
		)
		var/turf/T = get_turf(src)
		var/datum/reagents/piss = new /datum/reagents(10)
		var/ratio = min(HYDRATION_LEVEL_FULL / (hydration || 1), 0.99) //always will have some piss
		reagents.trans_to(piss, ratio * 3.3)
		piss.add_reagent(/datum/reagent/water, max((ratio * 10) - piss.total_volume, 0.01))
		piss.add_reagent(/datum/reagent/toxin/piss, (1 - ratio) * 10)
		T.add_liquid_from_reagents(piss)
	adjust_urination(-rand(25, 50))
	playsound(get_turf(src), 'modular_zubbers/sound/effects/pee.ogg', 60)


/mob/living/carbon/human/species/mammal/shadekin
	race = /datum/species/mammal/shadekin
