// Make disposal pipes hurt you if you ride them.

/obj/structure/disposalpipe
	// Set this to true if you want a disposal pipe to deal no damage.
	var/padded_corners = FALSE

/obj/structure/disposalpipe/transfer_to_dir(obj/structure/disposalholder/holder, nextdir)

	if(padded_corners || !holder || !holder.hasmob || holder.dir == nextdir || prob(80)) //Disposals optimization.
		return ..()

	. = ..() //We don't put this at the start of the the proc in case the direction of the holder changes.

	var/did_damage = FALSE
	for(var/mob/living/found_victim in holder.contents)
		if(found_victim.stat >= HARD_CRIT) //Hard crit or worse.
			continue
		if(HAS_TRAIT(found_victim, TRAIT_TRASHMAN))
			continue
		//Moon has ~100 disposal corners if you fall in the main loop, worst case scenario.
		//20% * 100 * 4 = 80 damage.
		found_victim.adjust_brute_loss(4)
		did_damage = TRUE

	if(did_damage)
		playsound(src, 'modular_zubbers/code/modules/emotes/sound/effects/bonk.ogg', 25, TRUE, -1)
