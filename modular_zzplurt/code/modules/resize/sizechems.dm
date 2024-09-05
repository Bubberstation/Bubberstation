//Size Chemicals, now with better and less cringy names.
//TO DO: USE BETTER FERMICHEM TO MAKE ALL OF THESE CHEMICALS MORE INTERACTIVE

//Sizechem reagent
/datum/reagent/sizechem
	name = "Cell-Volume Altering Base"
	description = "A stabilized compound liquid, used as a basis for increasing or decreasing the size of living matter with more recipes."
	color = "#C900CC"
	taste_description = "regret"
	can_synth = FALSE
	metabolization_rate = 0.25

//Sizechem reaction
/datum/chemical_reaction/sizechem
	name = "Cell-Volume Altering Base"
	id = /datum/reagent/sizechem
	mix_message = "the reaction rapidly alters in size!"
	required_reagents = list(/datum/reagent/growthserum = 0.15, /datum/reagent/medicine/clonexadone = 0.15, /datum/reagent/gold = 0.15, /datum/reagent/acetone = 0.15)
	results = list(/datum/reagent/sizechem = 0.3)
	required_temp = 1
	//Fermichem vars
	OptimalTempMin 		= 600 		// Lower area of bell curve for determining heat based rate reactions
	OptimalTempMax 		= 630 		// Upper end for above
	ExplodeTemp 		= 635 		// Temperature at which reaction explodes
	OptimalpHMin 		= 5 		// Lowest value of pH determining pH a 1 value for pH based rate reactions (Plateu phase)
	OptimalpHMax 		= 5.5 		// Higest value for above
	ReactpHLim 			= 2 		// How far out pH wil react, giving impurity place (Exponential phase)
	CatalystFact 		= 0 		// How much the catalyst affects the reaction (0 = no catalyst)
	CurveSharpT 		= 4 		// How sharp the temperature exponential curve is (to the power of value)
	CurveSharppH 		= 4 		// How sharp the pH exponential curve is (to the power of value)
	ThermicConstant		= -10 		// Temperature change per 1u produced
	HIonRelease 		= 0.02 		// pH change per 1u reaction (inverse for some reason)
	RateUpLim 			= 1 		// Optimal/max rate possible if all conditions are perfect
	FermiChem 			= TRUE		// If the chemical uses the Fermichem reaction mechanics
	FermiExplode 		= FALSE		// If the chemical explodes in a special way
	PurityMin 			= 0.2

//Growthchem reagent
/datum/reagent/growthchem
	name = "Prospacillin"
	description = "A stabilized altercation of size-altering liquids, this one appears to increase cell volume."
	color = "#E70C0C"
	taste_description = "a sharp, fiery and intoxicating flavour"
	overdose_threshold = 10
	metabolization_rate = 0.25
	can_synth = FALSE //DO NOT MAKE THIS SNYTHESIZABLE, THESE CHEMS ARE SUPPOSED TO NOT BE USED COMMONLY

//Growthchem reaction
/datum/chemical_reaction/growthchem
	name = "Prospacillin"
	id = /datum/reagent/growthchem
	mix_message = "the reaction appears to grow!"
	required_reagents = list(/datum/reagent/sizechem = 0.15, /datum/reagent/consumable/condensedcapsaicin = 0.15, /datum/reagent/drug/aphrodisiac = 0.30)
	results = list(/datum/reagent/growthchem = 0.25)
	required_temp = 1
	OptimalTempMin 		= 700 		// Lower area of bell curve for determining heat based rate reactions
	OptimalTempMax 		= 730 		// Upper end for above
	ExplodeTemp 		= 735 		// Temperature at which reaction explodes
	OptimalpHMin 		= 3 		// Lowest value of pH determining pH a 1 value for pH based rate reactions (Plateu phase)
	OptimalpHMax 		= 3.5 		// Higest value for above
	ReactpHLim 			= 2 		// How far out pH wil react, giving impurity place (Exponential phase)
	CatalystFact 		= 0 		// How much the catalyst affects the reaction (0 = no catalyst)
	CurveSharpT 		= 4 		// How sharp the temperature exponential curve is (to the power of value)
	CurveSharppH 		= 4 		// How sharp the pH exponential curve is (to the power of value)
	ThermicConstant		= -10 		// Temperature change per 1u produced
	HIonRelease 		= 0.02 		// pH change per 1u reaction (inverse for some reason)
	RateUpLim 			= 1 		// Optimal/max rate possible if all conditions are perfect
	FermiChem 			= TRUE		// If the chemical uses the Fermichem reaction mechanics
	FermiExplode 		= FALSE		// If the chemical explodes in a special way
	PurityMin 			= 0.2

//Growthchem effects
/datum/reagent/growthchem/on_mob_add(mob/living/M)
	. = ..()
	log_game("SIZECODE: [M] ckey: [M.key] has ingested growthchem.")

/datum/reagent/growthchem/on_mob_life(mob/living/M)
	var/size = get_size(M)
	if(size < RESIZE_MACRO)
		M.update_size(0.025)
		M.visible_message(span_danger("[pick("[M] grows!", "[M] expands in size!", "[M] pushes outwards in stature!")]"), span_danger("[pick("You feel your body fighting for space and growing!", "The world contracts inwards in every direction!", "You feel your muscles expand, and your surroundings shrink!")]"))
	..()
	. = 1

//Shrinkchem reagent
/datum/reagent/shrinkchem
	name = "Diminicillin"
	description = "A stabilized altercation of size-altering liquids, this one appears to decrease cell volume."
	color = "#0C26E7"
	taste_description = "a pungent, acidic and jittery flavour"
	overdose_threshold = 10
	metabolization_rate = 0.50
	can_synth = FALSE //SAME STORY AS ABOVE

//Shrinchem reaction
/datum/chemical_reaction/shrinkchem
	name = "Diminicillin"
	id = /datum/reagent/shrinkchem
	mix_message = "the reaction appears to shrink!"
	required_reagents = list(/datum/reagent/sizechem = 0.15, /datum/reagent/consumable/frostoil = 0.15, /datum/reagent/drug = 0.30)
	results = list(/datum/reagent/shrinkchem = 0.25)
	required_temp = 1
	OptimalTempMin 		= 100 		// Lower area of bell curve for determining heat based rate reactions
	OptimalTempMax 		= 150 		// Upper end for above
	ExplodeTemp 		= 350 		// Temperature at which reaction explodes
	OptimalpHMin 		= 3 		// Lowest value of pH determining pH a 1 value for pH based rate reactions (Plateu phase)
	OptimalpHMax 		= 4.5 		// Higest value for above
	ReactpHLim 			= 2 		// How far out pH wil react, giving impurity place (Exponential phase)
	CatalystFact 		= 0 		// How much the catalyst affects the reaction (0 = no catalyst)
	CurveSharpT 		= 4 		// How sharp the temperature exponential curve is (to the power of value)
	CurveSharppH 		= 4 		// How sharp the pH exponential curve is (to the power of value)
	ThermicConstant		= -10 		// Temperature change per 1u produced
	HIonRelease 		= 0.02 		// pH change per 1u reaction (inverse for some reason)
	RateUpLim 			= 1 		// Optimal/max rate possible if all conditions are perfect
	FermiChem 			= TRUE		// If the chemical uses the Fermichem reaction mechanics
	FermiExplode 		= FALSE		// If the chemical explodes in a special way
	PurityMin 			= 0.2

//Shrinkchem effects
/datum/reagent/shrinkchem/on_mob_add(mob/living/M)
	. = ..()
	log_game("SIZECODE: [M] ckey: [M.key] has ingested shrinkchem.")

/datum/reagent/shrinkchem/on_mob_life(mob/living/M)
	var/size = get_size(M)
	if(size > RESIZE_MICRO)
		M.update_size(0.025)
		M.visible_message(span_danger("[pick("[M] shrinks down!", "[M] dwindles in size!", "[M] compresses down!")]"), span_danger("[pick("You feel your body compressing in size!", "The world pushes outwards in every direction!", "You feel your muscles contract, and your surroundings grow!")]"))
	..()
	. = 1
