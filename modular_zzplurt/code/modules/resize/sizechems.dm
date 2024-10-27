//Size Chemicals, now with better and less cringy names.
//TO DO: USE BETTER FERMICHEM TO MAKE ALL OF THESE CHEMICALS MORE INTERACTIVE

//Sizechem reagent
/datum/reagent/sizechem
	name = "Cell-Volume Altering Base"
	description = "A stabilized compound liquid, used as a basis for increasing or decreasing the size of living matter with more recipes."
	color = "#C900CC"
	taste_description = "regret"
	metabolization_rate = 0.25

//Sizechem reaction
/datum/chemical_reaction/sizechem
	results = list(/datum/reagent/sizechem = 0.3)
	required_reagents = list(/datum/reagent/growthserum = 0.15, /datum/reagent/gold = 0.15, /datum/reagent/acetone = 0.15)
	required_temp = 1
	mix_message = "the reaction rapidly alters in size!"
	optimal_temp = 630
	overheat_temp = 635
	optimal_ph_min = 5
	optimal_ph_max = 5.5
	determin_ph_range = 2
	temp_exponent_factor = 4
	ph_exponent_factor = 4
	thermic_constant = -10
	H_ion_release = 0.02
	rate_up_lim = 1
	purity_min = 0.2
	reaction_flags = REACTION_HEAT_ARBITARY

//Growthchem reagent
/datum/reagent/growthchem
	name = "Prospacillin"
	description = "A stabilized altercation of size-altering liquids, this one appears to increase cell volume."
	color = "#E70C0C"
	taste_description = "a sharp, fiery and intoxicating flavour"
	overdose_threshold = 10
	metabolization_rate = 0.25

//Growthchem reaction
/datum/chemical_reaction/growthchem
	results = list(/datum/reagent/growthchem = 0.25)
	required_reagents = list(/datum/reagent/sizechem = 0.15, /datum/reagent/consumable/condensedcapsaicin = 0.15, /datum/reagent/drug/aphrodisiac = 0.30)
	required_temp = 1
	mix_message = "the reaction appears to grow!"
	optimal_temp = 730
	overheat_temp = 735
	optimal_ph_min = 3
	optimal_ph_max = 3.5
	determin_ph_range = 2
	temp_exponent_factor = 4
	ph_exponent_factor = 4
	thermic_constant = -10
	H_ion_release = 0.02
	rate_up_lim = 1
	purity_min = 0.2
	reaction_flags = REACTION_HEAT_ARBITARY

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

//Shrinchem reaction
/datum/chemical_reaction/shrinkchem
	results = list(/datum/reagent/shrinkchem = 0.25)
	required_reagents = list(/datum/reagent/sizechem = 0.15, /datum/reagent/consumable/frostoil = 0.15, /datum/reagent/drug = 0.30)
	required_temp = 1
	mix_message = "the reaction appears to shrink!"
	optimal_temp = 150
	overheat_temp = 350
	optimal_ph_min = 3
	optimal_ph_max = 4.5
	determin_ph_range = 2
	temp_exponent_factor = 4
	ph_exponent_factor = 4
	thermic_constant = -10
	H_ion_release = 0.02
	rate_up_lim = 1
	purity_min = 0.2
	reaction_flags = REACTION_HEAT_ARBITARY

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
