//Reagent
/datum/reagent/fermi_fat
	name = "Galbanic Compound"
	description = "A chemical compound derived from lipoifier. Massively increases adipose mass and parts of it become impossible to shed through normal means."
	color = "#E70C0C"
	taste_description = "hunger"
	ph = 7
	overdose_threshold = 50
	metabolization_rate = REAGENTS_METABOLISM / 2
	overdose_threshold = 50
	addiction_types = list(/datum/addiction/fermi_fat = 4)


//Reaction
/datum/chemical_reaction/fermi_fat
	mix_message = "the reaction appears to swell!"
	required_reagents = list(/datum/reagent/consumable/lipoifier = 0.1, /datum/reagent/medicine/pen_acid = 0.1, /datum/reagent/iron = 0.1)
	results = list(/datum/reagent/fermi_fat = 0.2)
	required_temp 		= 700		// Lower area of bell curve for determining heat based rate reactions
	optimal_temp 		= 740		// Upper end for above
	overheat_temp 		= 755 		// Temperature at which reaction explodes
	optimal_ph_min 		= 2			// Lowest value of pH determining pH a 1 value for pH based rate reactions (Plateu phase)
	optimal_ph_max 		= 3.5		// Higest value for above
	determin_ph_range 	= 1 		// How far out pH wil react, giving impurity place (Exponential phase)
	temp_exponent_factor= 4 		// How sharp the temperature exponential curve is (to the power of value)
	ph_exponent_factor	= 4 		// How sharp the pH exponential curve is (to the power of value)
	thermic_constant	= -50 		// Temperature change per 1u produced
	H_ion_release		= 0.02 		// pH change per 1u reaction (inverse for some reason)
	rate_up_lim			= 2 		// Optimal/max rate possible if all conditions are perfect
	purity_min 			= 0.1
	reaction_flags 		= REACTION_CLEAR_RETAIN

//When added
/datum/reagent/fermi_fat/on_mob_add(mob/living/carbon/M)
	. = ..()
	if(iscarbon(M))
		log_game("[M] ckey: [M.key] has ingested fermifat.")

//Effects
/datum/reagent/fermi_fat/on_mob_life(mob/living/carbon/M)
	if(!iscarbon(M))
		return..()
	M.adjust_fatness(30, FATTENING_TYPE_CHEM)
	M.adjust_perma(1, FATTENING_TYPE_CHEM)
	..()
	. = 1

//While overdosed
/datum/reagent/fermi_fat/overdose_process(mob/living/M)
	if(!iscarbon(M))
		return..()
	var/mob/living/carbon/C = M
	C.adjust_fatness(20, FATTENING_TYPE_CHEM)
	C.adjust_perma(1, FATTENING_TYPE_CHEM)
	..()

/datum/reagent/fermi_fat/overdose_start(mob/living/M)
	to_chat(M, "<span class='userdanger'>You took too much [name]! Your body is growing out of control!</span>")
	M.add_mood_event("[type]_overdose", /datum/mood_event/overdose, name)
	return

/datum/addiction/fermi_fat
	name = "Galbanic"
	addiction_gain_threshold = 80
	addiction_loss_threshold = 0
	var/addiction_mults = 0

/datum/addiction/fermi_fat/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	if(prob(30))
		var/add_text = pick("You feel pretty hungry.", "You think of [name].", "You look around for food.", "[name] wasn't so bad.")
		to_chat(affected_carbon, "<span class='notice'>[add_text]</span>")
	affected_carbon.adjust_fatness(1, FATTENING_TYPE_CHEM)
	affected_carbon.fullness = max(0, affected_carbon.fullness-1)
	affected_carbon.nutrition = max(0, affected_carbon.nutrition-1)
	if(addiction_mults < 1)
		// affected_carbon.nutri_mult += 0.5 commenting out since I can't be bothered for now
		affected_carbon.weight_gain_rate += 0.25
		addiction_mults = 1

/datum/addiction/fermi_fat/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	if(prob(30))
		var/add_text = pick("You are very hungry.", "You need some [name]!", "Your stomach growls loudly!.", "Is there any [name] around?")
		to_chat(affected_carbon, "<span class='notice'>[add_text]</span>")
	affected_carbon.adjust_fatness(2, FATTENING_TYPE_CHEM)
	affected_carbon.fullness = max(0, affected_carbon.fullness-2)
	affected_carbon.nutrition = max(0, affected_carbon.nutrition-2)
	if(addiction_mults < 2)
		// affected_carbon.nutri_mult += 0.5
		affected_carbon.weight_gain_rate += 0.25
		addiction_mults = 2

/datum/addiction/fermi_fat/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	if(prob(30))
		var/add_text = pick("You are ravenous!!", "You need [name] NOW!!", "You'd eat ANYTHING!!", "Where is the [name]?!", "Hungry, hungry, so HUNGRY!!", "More, you need more!!")
		to_chat(affected_carbon, "<span class='boldannounce'>[add_text]</span>")
	affected_carbon.adjust_fatness(4, FATTENING_TYPE_CHEM)
	affected_carbon.fullness = max(0, affected_carbon.fullness-4)
	affected_carbon.nutrition = max(0, affected_carbon.nutrition-4)
	if(addiction_mults < 4)
		// affected_carbon.nutri_mult += 0.5
		affected_carbon.weight_gain_rate += 0.25
		addiction_mults = 4

/datum/addiction/fermi_fat/end_withdrawal(mob/living/carbon/C)
	. = ..()
	if(addiction_mults > 0)
		// C.nutri_mult = max(1, 0.5 * addiction_mults)
		C.weight_gain_rate = max(0,11, 0.25 * addiction_mults)


//Reagent
/datum/reagent/fermi_slim
	name = "Macerinic Solution"
	description = "A solution with unparalleled obesity-solving properties. One of the few things known to be capable of removing galbanic fat."
	color = "#3b0ce7"
	taste_description = "thinness"
	ph = 7
	metabolization_rate = REAGENTS_METABOLISM / 2
	overdose_threshold = 50

//Reaction
/datum/chemical_reaction/fermi_slim
	mix_message = "the reaction seems to become thinner!"
	required_reagents = list(/datum/reagent/toxin/lipolicide = 0.1, /datum/reagent/ammonia = 0.1, /datum/reagent/oxygen = 0.1)
	results = list(/datum/reagent/fermi_slim = 0.2)
	required_temp 		= 600		// Lower area of bell curve for determining heat based rate reactions
	optimal_temp 		= 650		// Upper end for above
	overheat_temp 		= 700 		// Temperature at which reaction explodes
	optimal_ph_min 		= 10		// Lowest value of pH determining pH a 1 value for pH based rate reactions (Plateu phase)
	optimal_ph_max 		= 11.5		// Higest value for above
	determin_ph_range 	= 1 		// How far out pH wil react, giving impurity place (Exponential phase)
	temp_exponent_factor= 4 		// How sharp the temperature exponential curve is (to the power of value)
	ph_exponent_factor	= 4 		// How sharp the pH exponential curve is (to the power of value)
	thermic_constant	= -50 		// Temperature change per 1u produced
	H_ion_release		= -0.02		// pH change per 1u reaction (inverse for some reason)
	rate_up_lim 		= 2 		// Optimal/max rate possible if all conditions are perfect
	purity_min 			= 0.1
	reaction_flags 		= REACTION_CLEAR_RETAIN

//Effects
/datum/reagent/fermi_slim/on_mob_life(mob/living/carbon/M)
	if(!iscarbon(M))
		return..()
	M.adjust_fatness(-50, FATTENING_TYPE_WEIGHT_LOSS)
	M.adjust_perma(-5, FATTENING_TYPE_WEIGHT_LOSS)
	..()
	. = 1

/datum/reagent/fermi_slim/overdose_process(mob/living/M)
	if(!iscarbon(M))
		return..()
	var/mob/living/carbon/C = M
	C.fullness = max(0, C.fullness-5)
	C.nutrition = max(0, C.nutrition-5)
	C.weight_loss_rate = min(5, C.weight_loss_rate+0.01)
	..()
