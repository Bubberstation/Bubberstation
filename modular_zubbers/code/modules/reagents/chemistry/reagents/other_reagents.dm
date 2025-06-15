/datum/reagent/mutationtoxin/akula
	name = "Akula Mutation Toxin"
	description = "An akula toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/akula
	taste_description = "fishy"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE

/datum/reagent/mutationtoxin/dwarf
	name = "Dwarf Mutation Toxin"
	description = "A dwarf toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/dwarf
	taste_description = "earthy"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE

/datum/reagent/mutationtoxin/felinid/primitive
	name = "Ice Walker Mutation Toxin"
	description = "A ice Walker toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/human/felinid/primitive
	taste_description = "something ancient and cold"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE

/datum/reagent/mutationtoxin/ghoul
	name = "Ghoul Mutation Toxin"
	description = "A ghoul toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/ghoul
	taste_description = "rotting flesh"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE

/datum/reagent/mutationtoxin/hemophage
	name = "Hemophage Corruption Virus"
	description = "A hemophage virus."
	color = BLOOD_COLOR_RED
	taste_description = "blood"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE

/datum/reagent/mutationtoxin/hemophage/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT|INHALE)) || ((methods & (VAPOR|TOUCH)) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/transformation/hemophage(), FALSE, TRUE)

/datum/reagent/mutationtoxin/monkey
	name = "Monkey Mutation Toxin"
	description = "A monkey toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/monkey
	taste_description = "bananas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE

/datum/reagent/mutationtoxin/skrell
	name = "Skrell Mutation Toxin"
	description = "A skrell toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/skrell
	taste_description = "squid"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE

/datum/reagent/mutationtoxin/tajaran
	name = "Tajaran Mutation Toxin"
	description = "A tajaran toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/tajaran
	taste_description = "toxoplasmosis"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE

/datum/reagent/mutationtoxin/teshari
	name = "Teshari Mutation Toxin"
	description = "A teshari toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/teshari
	taste_description = "fried chicken"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE

/datum/reagent/mutationtoxin/vox
	name = "Vox Mutation Toxin"
	description = "A voxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/vox
	taste_description = "skreeing with a metallic tinge"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE

/datum/reagent/mutationtoxin/vox_primalis
	name = "Vox Primalis Mutation Toxin"
	description = "A vox primalis toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/vox_primalis
	taste_description = "screeching with a metallic tinge"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE

/datum/reagent/mutationtoxin/xenohybrid
	name = "Xenohybrid Mutation Toxin"
	description = "A xenohybrid toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/xeno
	taste_description = "sour"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
