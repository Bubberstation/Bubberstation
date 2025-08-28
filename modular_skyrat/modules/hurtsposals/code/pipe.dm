// Make disposal pipes hurt you if you ride them.

/obj/structure/disposalpipe/transfer_to_dir(obj/structure/disposalholder/holder, nextdir)

	if(!holder || !holder.hasmob || holder.dir == next_dir || !prob(80)) //Disposals optimization.
		return ..()

	. = ..() //We don't put this at the start of the the proc in case the direction of the holder changes.

	for(var/mob/living/found_victim in holder.contents)
		if(found_victim.stat >= HARD_CRIT) //Hard crit or worse.
			continue
		if(HAS_TRAIT(found_victim, TRAIT_TRASHMAN))
			continue
		living_within.adjustBruteLoss(4)
