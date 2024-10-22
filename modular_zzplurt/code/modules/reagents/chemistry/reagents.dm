//Own stuff

//Belly inflator yes
/datum/reagent/belly_inflator
	name = "Belladine nectar"
	description = "It will give you the lewdest tummy ache you've ever had"
	color = "#01ff63"
	taste_description = "blueberry gum"
	overdose_threshold = 17

/datum/reagent/belly_inflator/on_mob_life(mob/living/carbon/M)
	. = ..()
	if(!ishuman(M))
		return ..()

	var/mob/living/carbon/human/H = M
	var/obj/item/organ/external/genital/belly/B = H.get_organ_slot(ORGAN_SLOT_BELLY)
	if(!B)
		B = new
		B.build_from_dna(H.dna, ORGAN_SLOT_BELLY)
		B.Insert(M)
		to_chat(M, span_warning("You feel your midsection get warmer... bubbling softly as it seems to start distending</b>"))
		M.reagents.remove_reagent(type, 5)

	//If they have, increase size.
	if(B.genital_size < 16) //just in case
		B.set_size(B.genital_size + 0.1)
	..()

/datum/reagent/GEsmaller_hypo
	name = "Super Antacid"
	color = "#fca3d4"
	taste_description = "Milky strawberries"
	description = "A medicine used to treat a patient's heavily bloated stomach"
	metabolization_rate = 0.5

/datum/reagent/GEsmaller_hypo/on_mob_life(mob/living/carbon/M)
	var/obj/item/organ/external/genital/belly/B = M.get_organ_slot(ORGAN_SLOT_BELLY)
	if(!B)
		return ..()
	var/optimal_size = M.dna.features["belly_size"]
	if(!optimal_size)//Fast fix for those who don't want it.
		B.set_size(B.genital_size-0.2)
	else if(B.genital_size > optimal_size)
		B.set_size(B.genital_size-0.1)
	else if(B.genital_size < optimal_size)
		B.set_size(B.genital_size + 0.1)
	return ..()


///Ass enhancer
/datum/reagent/butt_enlarger
	name = "Denbu Tincture" //on Hyper it was 'Denbu Draft' but this makes it more consistent with the rectifying chemical down below.
	description = "A mixture of natural vitamins and valentines plant extract, causing butt enlargement in humanoids."
	color = "#e8ff1b"
	taste_description = "butter with a sweet aftertaste" //pass me the butter, OM NOM
	overdose_threshold = 17

/datum/reagent/butt_enlarger/on_mob_life(mob/living/carbon/M) //Increases butt size
	if(!ishuman(M))
		return ..()
	var/mob/living/carbon/human/H = M
	var/obj/item/organ/external/genital/butt/B =M.get_organ_slot(ORGAN_SLOT_BUTT)
	if(!B) //If they don't have a butt. Give them one!
		B = new
		B.build_from_dna(H.dna, ORGAN_SLOT_BUTT)
		B.Insert(M)
		to_chat(M, "<span class='warning'>Your ass cheeks bulge outwards and feel more plush.</b></span>")
		M.reagents.remove_reagent(type, 5)

	//If they have, increase size.
	if(B.genital_size < BUTT_MAX_SIZE) //just in case
		B.set_size(B.genital_size + 0.05)
	..()

/datum/reagent/AEsmaller_hypo //"BEsmaller" already exists so using "AE" instead, A is for ass.
	name = "Rectify tincture"
	color = "#e8ff1b"
	taste_description = "butter"
	description = "A medicine used to treat organomegaly in a patient's ass."
	metabolization_rate = 0.5

/datum/reagent/AEsmaller_hypo/on_mob_life(mob/living/carbon/M)
	var/obj/item/organ/external/genital/butt/B = M.get_organ_slot(ORGAN_SLOT_BUTT)
	if(!B)
		return ..()

	var/optimal_size = M.dna.features["butt_size"]
	if(!optimal_size)//Fast fix for those who don't want it.
		B.set_size(B.genital_size -0.2)
	else if(B.genital_size > optimal_size)
		B.set_size(B.genital_size - 0.1)
	else if(B.genital_size < optimal_size)
		B.set_size(B.genital_size + 0.1)
	return ..()
