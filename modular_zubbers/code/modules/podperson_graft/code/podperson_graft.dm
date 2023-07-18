
/obj/item/secateurs/pre_attack_secondary(atom/target, mob/living/user, params)
	if(user.combat_mode)
		return ..()
	if(istype(target, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = target
		if(istype(H.dna.species, /datum/species/pod))
			user.visible_message(span_warning("[user.name] attempts to take a cutting of [H.name]"))
			if(!do_after(user, 2.5 SECONDS, H))
				to_chat(user, span_warning("Both you and your target have to hold still!"))
				return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
			var/obj/item/graft_podperson/snip = new/obj/item/graft_podperson(target.loc)
			snip.ckey = ckey(H.last_mind.key)
			snip.realName = H.real_name
			snip.mind = H.last_mind
			snip.blood_gender = H.gender
			snip.blood_type = H.dna.blood_type
			snip.features = H.dna.features
			snip.factions = H.faction
			snip.quirks = H.quirks
			snip.sampleDNA = H.dna.unique_enzymes
			snip.originspecies = H.dna.species
			snip.mutation_index = H.dna.mutation_index
			snip.mutant_bodyparts = H.dna.mutant_bodyparts
			snip.name = "cutting of [H.real_name]"
			H.visible_message(span_warning("[user.name] takes a cutting of [H.name]. That looked painful!"),span_userdanger("[user.name] takes a cutting of you. Yeeowch!"))
			to_chat(user, span_danger("You take a cutting of [H.name]. That must have stung a bit."))
			H.adjustBruteLoss(10)
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
		else
			to_chat(user, span_warning("You can't take a cutting from someone who's not a podperson!"))
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	else
		to_chat(user, span_warning("You can't take a cutting from non-humanoids!"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/graft_podperson
	name = "podperson cutting"
	desc = "A carefully cut sample from a podperson's body. It can be grafted onto a replica pod to create a clone of its source."
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "graft_plant"
	worn_icon_state = "graft"
	attack_verb_continuous = list("plants", "vegitizes", "crops", "reaps", "farms")
	attack_verb_simple = list("plant", "vegitize", "crop", "reap", "farm")
	var/ckey
	var/realName
	var/datum/mind/mind
	var/blood_gender
	var/blood_type
	var/list/features
	var/factions
	var/list/quirks
	var/sampleDNA
	var/originspecies
	var/list/mutation_index
	var/list/mutant_bodyparts
