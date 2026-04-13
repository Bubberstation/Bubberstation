/datum/signal/subspace/vocal/proc/on_heard(atom/movable/hearer)
	if (!isliving(hearer))
		return
	var/mob/living/living_hearer = hearer
	if (data["cursed"] && !IS_HERETIC_OR_MONSTER(living_hearer) && !issilicon(living_hearer))
		living_hearer.mob_mood?.adjust_sanity(-5)
		if (prob(20))
			to_chat(living_hearer, span_warning("The words ring in your mind, wrong, wrong, all sorts of wrong..."))
			living_hearer.adjust_organ_loss(ORGAN_SLOT_BRAIN, 20, 50)
			living_hearer.adjust_hallucinations_up_to(20 SECONDS, 1 MINUTES)

/obj/machinery/telecomms/processor/update_overlays()
	. = ..()

	if (GLOB.processors_cursed)
		. += mutable_appearance('icons/mob/effects/heretic_aura.dmi', "heretic_aura")

/obj/machinery/telecomms/processor/examine(mob/user)
	. = ..()

	if (GLOB.processors_cursed)
		. += span_warning("A terrible secret has been unleashed. It will pass with time...")
		. += span_notice("You can disable the processors to prevent the mindbending effects of the curse - just remember to turn them on later.")
