/datum/signal/subspace/vocal/proc/on_heard(atom/movable/hearer)
	if (!isliving(hearer))
		return
	var/mob/living/living_hearer = hearer
	if (data["cursed"] && !IS_HERETIC_OR_MONSTER(living_hearer) && !issilicon(living_hearer) && !living_hearer.has_status_effect(/datum/status_effect/heretic_comms_immunity))
		living_hearer.mob_mood?.adjust_sanity(-5)
		living_hearer.apply_status_effect(/datum/status_effect/heretic_comms_immunity)
		if (prob(20))
			to_chat(living_hearer, span_warning("The words from the radio ring in your head, wrong, all sorts of wrong..."))
			to_chat(living_hearer, span_warning("You get the feeling that disabling any nearby radios would help."))
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

/datum/status_effect/heretic_comms_immunity // antispam
	id = "heretic_comms_immunity"
	alert_type = null
	tick_interval = STATUS_EFFECT_NO_TICK
	duration = 1 SECONDS
