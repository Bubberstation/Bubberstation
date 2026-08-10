/datum/quirk/hydra
	name = "Hydra Heads"
	desc = "You are a tri-headed creature. To use, format name like (Rucks-Sucks-Ducks)"
	value = 0
	mob_trait = TRAIT_HYDRA_HEADS
	gain_text = span_notice("You hear two other voices inside of your head(s).")
	lose_text = span_danger("All of your minds become singular.")
	medical_record_text = "There are multiple heads and personalities affixed to one body."
	icon = FA_ICON_HORSE_HEAD
	// remember what the name was before activation
	var/original_name
	var/datum/action/innate/hydra_head/head_spell
	var/datum/action/innate/hydra_reset/reset_spell

/datum/quirk/hydra/add(client/client_source)
	head_spell = new()
	reset_spell = new()
	head_spell.Grant(quirk_holder)
	reset_spell.Grant(quirk_holder)

/datum/quirk/hydra/remove()
	head_spell.Remove(quirk_holder)
	reset_spell.Remove(quirk_holder)
	QDEL_NULL(head_spell)
	QDEL_NULL(reset_spell)
	quirk_holder.real_name = original_name

/datum/action/innate/hydra_head
	name = "Switch head"
	desc = "Switch between each of the heads on your body."
	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"

/datum/action/innate/hydra_head/Activate() //Oops, all hydra!
	var/mob/living/carbon/human/hydra = owner
	var/datum/quirk/hydra/hydra_quirk = hydra.get_quirk(/datum/quirk/hydra)
	if(!hydra_quirk.original_name) // sets the archived 'real' name if not set.
		hydra_quirk.original_name = hydra.real_name
	var/list/names = splittext(hydra_quirk.original_name,"-")
	var/selhead = input("Who would you like to speak as?","Heads:") in names
	hydra.real_name = selhead
	hydra.visible_message(span_notice("[hydra.name] pulls the rest of their heads back; and puts [selhead]'s forward."), \
							span_notice("You are now talking as [selhead]!"), ignored_mobs=owner)

/datum/action/innate/hydra_reset
	name = "Reset Speech"
	desc = "Go back to speaking as a whole."
	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"

/datum/action/innate/hydra_reset/Activate()
	var/mob/living/carbon/human/hydra = owner
	var/datum/quirk/hydra/hydra_quirk = hydra.get_quirk(/datum/quirk/hydra)
	if(!hydra_quirk.original_name) // sets the archived 'real' name if not set.
		hydra_quirk.original_name = hydra.real_name
	hydra.real_name = hydra_quirk.original_name
	hydra.visible_message(span_notice("[hydra.name] pushes all three heads forwards; they seem to be talking as a collective."), \
							span_notice("You are now talking as [hydra_quirk.original_name]!"), ignored_mobs=owner)
