/// Custom computer for synth brains
/obj/item/modular_computer/pda/synth
	name = "Synthetic internal computer"

	base_active_power_usage = 0
	base_idle_power_usage = 0

	var/obj/item/organ/internal/brain/synth/owner_brain

/obj/item/modular_computer/pda/synth/get_messenger_ending()
	return " Sent from my internal computer."

/*
I give up, this is how borgs have their own menu coded in.
Snowflake codes the interaction check because the default tgui one does not work as I want it.
*/
/mob/living/carbon/human/can_interact_with(atom/A, treat_mob_as_adjacent)
	. = ..()
	if(istype(A, /obj/item/modular_computer/pda/synth))
		var/obj/item/modular_computer/pda/synth/C = A
		if(Adjacent(C.owner_brain.owner) || Adjacent(C.owner_brain))
			. = TRUE

/*
So, I am not snowflaking more code.. except this
Attacking a synth with an id loads it into its slot.. pain and probably shitcode
*/

/obj/item/card/id/attack(mob/living/target_mob, mob/living/user, params)
	var/mob/living/carbon/human/T = target_mob
	if(!istype(T))
		return ..()
		/*
	for(var/obj/item/organ/internal/brain/synth/B in T.get_organ_slot(ORGAN_SLOT_BRAIN))
		if(istype(B))
			return
		B.internal_computer.InsertID(src, user)
		*/
	var/obj/item/organ/internal/brain/synth/B = T.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(istype(B))
		B.internal_computer.InsertID(src, user)
		return
	return ..()
