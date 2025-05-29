/datum/surgery/breast_augmentation
	name = "Breast augmentation"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/retract_skin, /datum/surgery_step/augment_breasts, /datum/surgery_step/close)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/augment_breasts
	name = "augment breasts"
	implements = list(/obj/item/scalpel = 100, /obj/item/stack/sheet/plastic = 100, /obj/item/melee/transforming/energy/sword = 75, /obj/item/kitchen/knife = 65,
		/obj/item/shard = 45, /obj/item = 30) // 30% success with any sharp item.
	time = 32
	repeatable = TRUE

/datum/surgery_step/augment_breasts/tool_check(mob/user, obj/item/tool)
	if(istype(tool, /obj/item/cautery) || istype(tool, /obj/item/gun/energy/laser))
		return FALSE
	return !tool.get_temperature()

/datum/surgery_step/augment_breasts/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	//Patient has titties
	if(target.has_breasts())
		if(tool.get_sharpness())
			display_results(user, target, "<span class='notice'>You begin to cut the excess out of [target]'s breasts, bringing them down a cup size...</span>",
			"[user] begins to augment [target]'s breasts.",
			"[user] begins to augment [target]'s breasts.")
		if(istype(tool, /obj/item/stack/sheet/plastic))
			display_results(user, target, "<span class='notice'>You begin to mold, shape, and then add plastic to [target]'s breasts, increasing their cup size by 1...</span>",
			"[user] begins to augment [target]'s breasts.",
			"[user] begins to augment [target]'s breasts.")
	//Patient does not have titties
	else
		if(istype(tool, /obj/item/stack/sheet/plastic))
			display_results(user, target, "<span class='notice'>You begin to remodel [target]'s chest, creating a new pair of breasts which are barely A cups...</span>",
			"[user] begins to perform plastic surgery on [target].",
			"[user] begins to perform plastic surgery on [target].")

/datum/surgery_step/augment_breasts/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/organ/genital/breasts/B = target.getorganslot("breasts")
	//Patient has titties
	if(B)
		//Reduce their size (you fucking monster)
		if(tool.get_sharpness())
			B.cached_size = B.cached_size - 1
			B.update()
			return 1
		//Increase the size (that's more like it!)
		if(istype(tool, /obj/item/stack/sheet/plastic))
			var/obj/item/stack/sheet/plastic/pS = tool
			pS.use(1)

			B.cached_size = B.cached_size + 1
			B.update()
			return 1
	//Patient does not have titties
	else
		//Give 'em titties
		if(istype(tool, /obj/item/stack/sheet/plastic))
			//Makes it so no one has any weird coloured tits
			var/mob/living/carbon/human/H = target
			if(H.dna.species.use_skintones)
				H.dna.features["breasts_color"] = SKINTONE2HEX(H.skin_tone)
			else
				H.dna.features["breasts_color"] = H.dna.features["mcolor"]

			var/obj/item/stack/sheet/plastic/pS = tool
			pS.amount = pS.amount - 1
			pS.use(1)

			var/obj/item/organ/genital/breasts/nB = new
			nB.size = "flat"
			nB.cached_size = 0
			nB.prev_size = 0
			nB.Insert(target)
			nB.update()
			return 1
