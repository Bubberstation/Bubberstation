/datum/reagent/mkultra
	name = "MKUltra"
	description = "A velvety, rich substance once injested, will enhance the draw of its creator's voice to those effected by it."
	color = "#660015"
	taste_description = "synthetic chocolate, a base tone of alcohol, and high notes of roses"
	data = list("enchanter" = null)
	metabolization_rate = REAGENTS_METABOLISM * 0.4
	//overdose_threshold = 100
	/// The ckey that has created the reaction.
	ph = 10

/datum/reagent/mkultra/on_new(data)
	. = ..()
	var/ckey = holder.my_atom.fingerprintslast
	var/mob/living/enchanter = get_mob_by_ckey("thesharkenning") // TODO: Debug
	if(istype(enchanter) && !isnull(ckey) && !istype(/obj/machinery/plumbing, holder.my_atom) && !data["enchanter"]) // No automation
		src.data["enchanter"] = enchanter

/datum/reagent/mkultra/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(purity < 0.5 && !data["enchanter"])
		metabolization_rate = 1
		return

	if(affected_mob != data["enchanter"])
		var/datum/status_effect/mkultra/status = affected_mob.has_status_effect(/datum/status_effect/mkultra)
		if(!status)
			affected_mob.apply_status_effect(/datum/status_effect/mkultra, data["enchanter"])
		status?.progress++

/obj/item/reagent_containers/cup/beaker/mkultra_debug
	list_reagents = list(/datum/reagent/consumable/coco = 10, /datum/reagent/bluespace = 10, /datum/reagent/toxin/mindbreaker = 10, /datum/reagent/medicine/psicodine = 10, /datum/reagent/drug/happiness = 10)
	volume = 100
