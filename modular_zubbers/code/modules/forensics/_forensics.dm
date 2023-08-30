/datum/forensics/proc/add_fingerprint(mob/living/suspect, ignoregloves = FALSE)

	if(!isliving(suspect))
		if(!iscameramob(suspect))
			return
		if(isaicamera(suspect))
			var/mob/camera/ai_eye/ai_camera = suspect
			if(!ai_camera.ai)
				return
			suspect = ai_camera.ai

	add_hiddenprint(suspect)

	if(ishuman(suspect))
		var/mob/living/carbon/human/human_suspect = suspect
		add_fibers(human_suspect)
		var/obj/item/gloves = human_suspect.gloves
		if(gloves) //Check if the gloves (if any) hide fingerprints
			if(!(gloves.body_parts_covered & HANDS) || HAS_TRAIT(gloves, TRAIT_FINGERPRINT_PASSTHROUGH) || HAS_TRAIT(human_suspect, TRAIT_FINGERPRINT_PASSTHROUGH))
				ignoregloves = TRUE
			if(!ignoregloves)
				human_suspect.gloves.add_fingerprint(human_suspect, ignoregloves = TRUE) //ignoregloves = TRUE to avoid infinite loop.
				return

		var/full_print = md5(human_suspect.dna.unique_identity)
		var/full_print_length = length(full_print)

		var/start_pos = rand(1,FLOOR(full_print_length,1))
		var/end_pos = rand(CEILING(start_pos,1),full_print_length)

		if(start_pos >= end_pos) //Don't add. Low change for this to actually happen.
			return FALSE

		var/final_print = ""
		for(var/letter_index=start_pos,letter_index<=end_pos,letter_index++)
			final_print = "[final_print][!prob(80) ? "*" : full_print[letter_index]]" //Fingerprint optimization.

		if(fingerprints)
			var/fingerprint_length = length(fingerprints)
			if(fingerprint_length > 5 && prob(fingerprint_length/8 * 100)) //This basically means there is a hard limit of 8 entries, with a soft limit of 5 entries.
				fingerprints.Cut(1,2) //Cut the first entry.
		else
			fingerprints = list()

		fingerprints[prob(50) ? full_print : final_print] = final_print //Reason why we (sometimes) use full print here is to allow for olifaction to work.

	return TRUE