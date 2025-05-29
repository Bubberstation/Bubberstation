/datum/surgery/penis_augmentation
	name = "Penis augmentation"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/retract_skin, /datum/surgery_step/augment_penis, /datum/surgery_step/close)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_PRECISE_GROIN)

/datum/surgery_step/augment_penis
	name = "augment penis"
	implements = list(/obj/item/scalpel = 100, /obj/item/stack/sheet/plastic = 100, /obj/item/melee/transforming/energy/sword = 75, /obj/item/kitchen/knife = 65,
		/obj/item/shard = 45, /obj/item = 30) // 30% success with any sharp item.
	time = 32
	repeatable = TRUE

/datum/surgery_step/augment_penis/tool_check(mob/user, obj/item/tool)
	if(istype(tool, /obj/item/cautery) || istype(tool, /obj/item/gun/energy/laser))
		return FALSE
	return !tool.get_temperature()

/datum/surgery_step/augment_penis/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	//Patient has a cock
	if(target.has_penis())
		if(tool.get_sharpness())
			display_results(user, target, "<span class='notice'>You begin to reshape [target]'s penis, decreasing it's length by an inch...</span>",
			"[user] begins to augment [target]'s penis.",
			"[user] begins to augment [target]'s penis.")
		if(istype(tool, /obj/item/stack/sheet/plastic))
			display_results(user, target, "<span class='notice'>You begin to mold, shape, and then add plastic to [target]'s penis, making it one inch bigger...</span>",
			"[user] begins to augment [target]'s penis.",
			"[user] begins to augment [target]'s penis.")
	//Patient does not have a cock
	else
		if(istype(tool, /obj/item/stack/sheet/plastic))
			display_results(user, target, "<span class='notice'>You begin to remodel [target]'s groin, creating a new penis of length 1 inch...</span>",
			"[user] begins to perform plastic surgery on [target].",
			"[user] begins to perform plastic surgery on [target].")

/datum/surgery_step/augment_penis/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/organ/genital/penis/P = target.getorganslot("penis")
	//Patient has a cock
	if(P)
		//Reduce their size
		if(tool.get_sharpness())
			P.length = P.length - 1
			P.update()
			return 1
		//Increase the size
		if(istype(tool, /obj/item/stack/sheet/plastic))
			var/obj/item/stack/sheet/plastic/pS = tool
			pS.use(1)

			P.length = P.length + 1
			P.update()
			return 1
	//Patient does not have a cock
	else
		//Give 'em a cock
		if(istype(tool, /obj/item/stack/sheet/plastic))
			//Makes it so no one has a weird coloured dick
			var/mob/living/carbon/human/H = target
			if(H.dna.species.use_skintones)
				H.dna.features["penis_color"] = SKINTONE2HEX(H.skin_tone)
			else
				H.dna.features["penis_color"] = H.dna.features["mcolor"]

			var/obj/item/stack/sheet/plastic/pS = tool
			pS.use(1)

			var/obj/item/organ/genital/penis/nP = new
			nP.length = 1
			nP.prev_length = 0
			nP.Insert(target)
			nP.update()
			return 1
