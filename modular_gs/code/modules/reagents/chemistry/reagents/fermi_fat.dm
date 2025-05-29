//Reagent
/datum/reagent/fermi_fat
	name = "Galbanic Compound"
	description = "A chemical compound derived from lipoifier. Massively increases adipose mass and parts of it become impossible to shed through normal means."
	color = "#E70C0C"
	taste_description = "hunger"
	pH = 7
	overdose_threshold = 50
	metabolization_rate = REAGENTS_METABOLISM / 4
	can_synth = FALSE //DO NOT MAKE THIS SNYTHESIZABLE, THESE CHEMS ARE SUPPOSED TO NOT BE USED COMMONLY
	chemical_flags = REAGENT_ORGANIC_PROCESS | REAGENT_BIOFUEL_PROCESS

	overdose_threshold = 50
	addiction_threshold = 100
	addiction_stage1_end = 10
	addiction_stage2_end = 30
	addiction_stage3_end = 60
	addiction_stage4_end = 100

	var/addiction_mults = 0

//Reaction
/datum/chemical_reaction/fermi_fat
	name = "FermiFat"
	id = /datum/reagent/fermi_fat
	mix_message = "the reaction appears to swell!"
	required_reagents = list(/datum/reagent/consumable/lipoifier = 0.1, /datum/reagent/medicine/pen_acid = 0.1, /datum/reagent/iron = 0.1)
	results = list(/datum/reagent/fermi_fat = 0.2)
	required_temp = 1
	OptimalTempMin 		= 700		// Lower area of bell curve for determining heat based rate reactions
	OptimalTempMax 		= 740		// Upper end for above
	ExplodeTemp 		= 755 		// Temperature at which reaction explodes
	OptimalpHMin 		= 2			// Lowest value of pH determining pH a 1 value for pH based rate reactions (Plateu phase)
	OptimalpHMax 		= 3.5		// Higest value for above
	ReactpHLim 			= 1 		// How far out pH wil react, giving impurity place (Exponential phase)
	CatalystFact 		= 0 		// How much the catalyst affects the reaction (0 = no catalyst)
	CurveSharpT 		= 4 		// How sharp the temperature exponential curve is (to the power of value)
	CurveSharppH 		= 4 		// How sharp the pH exponential curve is (to the power of value)
	ThermicConstant		= -10 		// Temperature change per 1u produced
	HIonRelease 		= 0.02 		// pH change per 1u reaction (inverse for some reason)
	RateUpLim 			= 2 		// Optimal/max rate possible if all conditions are perfect
	FermiChem 			= TRUE		// If the chemical uses the Fermichem reaction mechanics
	FermiExplode 		= FALSE		// If the chemical explodes in a special way
	PurityMin 			= 0.1

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
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/overdose, name)
	return

/datum/reagent/fermi_fat/addiction_act_stage1(mob/living/M)
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/withdrawal_light, name)
	if(prob(30))
		var/add_text = pick("You feel pretty hungry.", "You think of [name].", "Your look around for food.", "[name] wasn't so bad.")
		to_chat(M, "<span class='notice'>[add_text]</span>")
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.adjust_fatness(1, FATTENING_TYPE_CHEM)
		C.fullness = max(0, C.fullness-1)
		C.nutrition = max(0, C.nutrition-1)
		if(addiction_mults < 1)
			C.nutri_mult += 0.5
			C.weight_gain_rate += 0.25
			addiction_mults = 1
	return

/datum/reagent/fermi_fat/addiction_act_stage2(mob/living/M)
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/withdrawal_medium, name)
	if(prob(30))
		var/add_text = pick("You are very hungry.", "You could go for some [name].", "Your mouth waters.", "Is there any [name] around?")
		to_chat(M, "<span class='notice'>[add_text]</span>")
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.adjust_fatness(2, FATTENING_TYPE_CHEM)
		C.fullness = max(0, C.fullness-2)
		C.nutrition = max(0, C.nutrition-2)
		if(addiction_mults < 2)
			C.nutri_mult += 0.5
			C.weight_gain_rate += 0.25
			addiction_mults = 2
	return

/datum/reagent/fermi_fat/addiction_act_stage3(mob/living/M)
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/withdrawal_severe, name)
	if(prob(30))
		var/add_text = pick("You are starving!", "You need some [name]!", "Your stomach growls loudly!.", "You can't stop thinking about [name]")
		to_chat(M, "<span class='danger'>[add_text]</span>")
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.adjust_fatness(3, FATTENING_TYPE_CHEM)
		C.fullness = max(0, C.fullness-3)
		C.nutrition = max(0, C.nutrition-3)
		if(addiction_mults < 3)
			C.nutri_mult += 0.5
			C.weight_gain_rate += 0.25
			addiction_mults = 3
	return

/datum/reagent/fermi_fat/addiction_act_stage4(mob/living/M)
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/withdrawal_critical, name)
	if(prob(30))
		var/add_text = pick("You are ravenous!!", "You need [name] NOW!!", "You'd eat ANYTHING!!", "Where is the [name]?!", "Hungry, hungry, so HUNGRY!!", "More, you need more!!")
		to_chat(M, "<span class='boldannounce'>[add_text]</span>")
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.adjust_fatness(4, FATTENING_TYPE_CHEM)
		C.fullness = max(0, C.fullness-4)
		C.nutrition = max(0, C.nutrition-4)
		if(addiction_mults < 4)
			C.nutri_mult += 0.5
			C.weight_gain_rate += 0.25
			addiction_mults = 4
	return

/datum/reagent/fermi_fat/proc/addiction_remove(mob/living/carbon/C)
	if(addiction_mults > 0)
		C.nutri_mult = max(1, 0.5 * addiction_mults)
		C.weight_gain_rate = max(0,11, 0.25 * addiction_mults)
	return

//Reagent
/datum/reagent/fermi_slim
	name = "Macerinic Solution"
	description = "A solution with unparalleled obesity-solving properties. One of the few things known to be capable of removing galbanic fat."
	color = "#3b0ce7"
	taste_description = "thinness"
	pH = 7
	metabolization_rate = REAGENTS_METABOLISM / 4
	can_synth = FALSE
	chemical_flags = REAGENT_ORGANIC_PROCESS | REAGENT_BIOFUEL_PROCESS

	overdose_threshold = 50

//Reaction
/datum/chemical_reaction/fermi_slim
	name = "FermiSlim"
	id = /datum/reagent/fermi_slim
	mix_message = "the reaction seems to become thinner!"
	required_reagents = list(/datum/reagent/medicine/lipolicide = 0.1, /datum/reagent/ammonia = 0.1, /datum/reagent/oxygen = 0.1)
	results = list(/datum/reagent/fermi_slim = 0.2)
	required_temp = 1
	OptimalTempMin 		= 600		// Lower area of bell curve for determining heat based rate reactions
	OptimalTempMax 		= 650		// Upper end for above
	ExplodeTemp 		= 700 		// Temperature at which reaction explodes
	OptimalpHMin 		= 10		// Lowest value of pH determining pH a 1 value for pH based rate reactions (Plateu phase)
	OptimalpHMax 		= 11.5		// Higest value for above
	ReactpHLim 			= 1 		// How far out pH wil react, giving impurity place (Exponential phase)
	CatalystFact 		= 0 		// How much the catalyst affects the reaction (0 = no catalyst)
	CurveSharpT 		= 4 		// How sharp the temperature exponential curve is (to the power of value)
	CurveSharppH 		= 4 		// How sharp the pH exponential curve is (to the power of value)
	ThermicConstant		= -10 		// Temperature change per 1u produced
	HIonRelease 		= -0.02		// pH change per 1u reaction (inverse for some reason)
	RateUpLim 			= 2 		// Optimal/max rate possible if all conditions are perfect
	FermiChem 			= TRUE		// If the chemical uses the Fermichem reaction mechanics
	FermiExplode 		= FALSE		// If the chemical explodes in a special way
	PurityMin 			= 0.1

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
