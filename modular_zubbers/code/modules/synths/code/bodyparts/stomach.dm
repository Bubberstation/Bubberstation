/obj/item/organ/internal/stomach/synth/Insert(mob/living/carbon/receiver, special, drop_if_replaced)
	. = ..()
	add_synth_signals(receiver)

/obj/item/organ/internal/stomach/synth/Remove(mob/living/carbon/stomach_owner, special)
	. = ..()
	remove_synth_signals(stomach_owner)

/obj/item/organ/internal/stomach/synth/proc/add_synth_signals(mob/living/carbon/stomach_owner)
	SIGNAL_HANDLER
	RegisterSignal(stomach_owner, COMSIG_PROCESS_BORGCHARGER_OCCUPANT, PROC_REF(on_borg_charge))

/obj/item/organ/internal/stomach/synth/proc/remove_synth_signals(mob/living/carbon/stomach_owner)
	SIGNAL_HANDLER
	UnregisterSignal(stomach_owner, COMSIG_PROCESS_BORGCHARGER_OCCUPANT)

/obj/item/organ/internal/stomach/synth/proc/on_borg_charge(datum/source, amount)
	SIGNAL_HANDLER

	// This is so it isn't completely instant
	amount /= 200
	if(owner.nutrition < NUTRITION_LEVEL_WELL_FED)
		owner.nutrition += amount
		if(owner.nutrition > NUTRITION_LEVEL_FULL)
			owner.nutrition = NUTRITION_LEVEL_ALMOST_FULL
