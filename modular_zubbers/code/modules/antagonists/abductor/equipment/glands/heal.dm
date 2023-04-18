/obj/item/organ/internal/heart/gland/heal/proc/replace_bladder(obj/item/organ/internal/bladder/bladder)
	if(bladder)
		owner.visible_message(span_warning("[owner] vomits up his [bladder.name]!"), span_userdanger("You suddenly vomit up your [bladder.name]!"))
		owner.vomit(0, TRUE, TRUE, 1, FALSE, FALSE, FALSE, TRUE)
		bladder.Remove(owner)
		bladder.forceMove(owner.drop_location())
	else
		to_chat(owner, span_warning("You feel a weird rumble in your bowels..."))

	var/bladder_type = /obj/item/organ/internal/bladder
	if(owner?.dna?.species?.mutantbladder)
		bladder_type = owner.dna.species.mutantbladder
	var/obj/item/organ/internal/bladder/new_bladder = new bladder_type()
	new_bladder.Insert(owner)
