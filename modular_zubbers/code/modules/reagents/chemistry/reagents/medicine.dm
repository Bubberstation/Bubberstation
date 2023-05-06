
/datum/reagent/medicine/inaprovaline
	name = "Inaprovaline"
	description = "Stabilizes the breathing of patients. Good for those in critical condition."
	reagent_state = LIQUID
	ph = 8.5
	color = "#5dc1f0"
	overdose_threshold = 60

/datum/reagent/medicine/inaprovaline/on_mob_life(mob/living/carbon/M)
	if(M.losebreath >= 5)
		M.losebreath -= 5
	..()

/datum/reagent/medicine/bicaridine
	name = "Bicaridine"
	description = "Restores bruising. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#fc2626"
	overdose_threshold = 30
	ph = 5

/datum/reagent/medicine/bicaridine/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-4*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	..()
	. = 1

/datum/reagent/medicine/bicaridine/overdose_process(mob/living/M)
	M.adjustBruteLoss(6*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	..()
	. = 1

/datum/reagent/medicine/kelotane
	name = "Kelotane"
	description = "Restores fire damage. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#ffc400"
	overdose_threshold = 30
	ph = 9

/datum/reagent/medicine/kelotane/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-4*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	..()
	. = 1

/datum/reagent/medicine/kelotane/overdose_process(mob/living/M)
	M.adjustFireLoss(6*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	..()
	. = 1

/datum/reagent/medicine/dylovene
	name = "Dylovene"
	description = "Heals toxin damage and removes toxins in the bloodstream. Overdose causes toxin damage."
	reagent_state = LIQUID
	color = "#6aff00"
	overdose_threshold = 30
	taste_description = "a roll of gauze"
	ph = 10

/datum/reagent/medicine/dylovene/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-4*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,1)
	..()
	. = 1

/datum/reagent/medicine/dylovene/overdose_process(mob/living/M)
	M.adjustToxLoss(6*REAGENTS_EFFECT_MULTIPLIER, FALSE) // End result is 2 toxin loss taken, because it heals 2 and then removes 4.
	..()
	. = 1

/datum/reagent/medicine/tricordrazine
	name = "Tricordrazine"
	description = "Slowly heals all types of damage, and has a high overdose threshold. Overdose instead causes it."
	reagent_state = LIQUID
	color = "#e650c0"
	overdose_threshold = 50 //you can apply one full patch and slowly heal for a while.
	taste_description = "grossness"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM

/datum/reagent/medicine/tricordrazine/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-2*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	M.adjustFireLoss(-2*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	M.adjustOxyLoss(-2*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	M.adjustToxLoss(-2*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	. = 1
	..()

/datum/reagent/medicine/tricordrazine/overdose_process(mob/living/M)
	M.adjustToxLoss(4*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	M.adjustOxyLoss(4*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	M.adjustBruteLoss(4*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	M.adjustFireLoss(4*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	..()
	. = 1

/datum/reagent/medicine/dexalin
	name = "Dexalin"
	description = "A compound of oxygen bonded to iron dissolved in acetone, which is effective at oxygenating blood. Overdose induces respiratory failure."
	reagent_state = LIQUID
	color = "#13d2f0"
	overdose_threshold = 30
	ph = 9.7

/datum/reagent/medicine/dexalin/on_mob_life(mob/living/carbon/M)
	M.adjustOxyLoss(-10*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	..()
	. = 1

/datum/reagent/medicine/dexalin/overdose_process(mob/living/M)
	M.adjustOxyLoss(18*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	..()
	. = 1

/datum/reagent/medicine/styptic_powder
	name = "Styptic Powder"
	description = "If used in touch-based applications, immediately restores bruising as well as restoring more over time. It is poisonous if taken orally or by injection. If overdosed, deals moderate toxin damage."
	reagent_state = LIQUID
	color = "#FF9696"
	ph = 6.7
	metabolization_rate = 5 * REAGENTS_METABOLISM
	overdose_threshold = 25

/datum/reagent/medicine/styptic_powder/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = TRUE)
	. = ..()
	if(iscarbon(M) && M.stat != DEAD)
		if(method in list(INGEST, VAPOR, INJECT))
			M.adjustToxLoss(0.5*reac_volume)
			if(show_message)
				to_chat(M, "<span class='warning'>You don't feel so good...</span>")
		else if(M.getBruteLoss())
			M.adjustBruteLoss(-reac_volume)
			if(show_message)
				to_chat(M, "<span class='danger'>You feel your bruises healing! It stings like hell!</span>")
			M.emote("scream")
	..()

/datum/reagent/medicine/styptic_powder/expose_obj(obj/O, reac_volume)
	. = ..()
	if(istype(O, /obj/item/stack/medical/gauze))
		var/obj/item/stack/medical/gauze/G = O
		reac_volume = min((reac_volume/10), G.amount)
		new /obj/item/stack/medical/suture(get_turf(G), reac_volume)
		G.use(reac_volume)

/datum/reagent/medicine/styptic_powder/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-2*REAGENTS_EFFECT_MULTIPLIER, 0)
	..()
	. = 1

/datum/reagent/medicine/styptic_powder/overdose_start(mob/living/M)
	metabolization_rate = 15 * REAGENTS_METABOLISM
	..()
	. = 1

/datum/reagent/medicine/styptic_powder/overdose_process(mob/living/M)
	M.adjustToxLoss(10*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	..()
	. = 1

/datum/reagent/medicine/propanol_sulfadiazine
	name = "Silver Sulfadiazine"
	description = "If used in touch-based applications, immediately restores burn wounds as well as restoring more over time. It is mildly poisonous taken orally or by injection. If overdosed, deals moderate toxin damage."
	reagent_state = LIQUID
	ph = 7.2
	color = "#ffeac9"
	metabolization_rate = 5 * REAGENTS_METABOLISM
	overdose_threshold = 25

/datum/reagent/medicine/propanol_sulfadiazine/expose_obj(obj/O, reac_volume)
	. = ..()
	if(istype(O, /obj/item/stack/medical/gauze))
		var/obj/item/stack/medical/gauze/G = O
		reac_volume = min((reac_volume/10), G.amount)
		new /obj/item/stack/medical/mesh(get_turf(G), reac_volume)
		G.use(reac_volume)

/datum/reagent/medicine/propanol_sulfadiazine/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = TRUE)
	. = ..()
	if(iscarbon(M) && M.stat != DEAD)
		if(method in list(INGEST, VAPOR, INJECT))
			M.adjustToxLoss(0.5*reac_volume)
			if(show_message)
				to_chat(M, "<span class='warning'>You don't feel so good...</span>")
		else if(M.getFireLoss())
			M.adjustFireLoss(-reac_volume)
			if(show_message)
				to_chat(M, "<span class='danger'>You feel your burns healing! It stings like hell!</span>")
			M.emote("scream")
	..()

/datum/reagent/medicine/propanol_sulfadiazine/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-2*REAGENTS_EFFECT_MULTIPLIER, 0)
	..()
	. = 1

/datum/reagent/medicine/propanol_sulfadiazine/overdose_start(mob/living/M)
	metabolization_rate = 15 * REAGENTS_METABOLISM
	..()
	. = 1

/datum/reagent/medicine/propanol_sulfadiazine/overdose_process(mob/living/M)
	M.adjustToxLoss(10*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	..()
	. = 1
