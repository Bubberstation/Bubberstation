/datum/disease/transformation/hemophage
	name = "Hemophagic Viral Infection"
	cure_text = "Garlic"
	cures = list(/datum/reagent/consumable/garlic)
	agent = "Hemophagic Viral Infection"
	desc = "A gift of the night"
	cure_chance = 2.5
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = NONE
	stage1 = list("You dont feel very well")
	stage2 = list("You feel cold")
	stage3 = list(span_danger("Your heart skips a beat"), span_danger("You have a dull pain in your heart"))
	stage4 = list(span_danger("You're hungry but normal food does not seem appetizing"))
	stage5 = list(span_danger("Blood....Blood..."))
	new_form = /mob/living/carbon/human/species/hemophage
	infectable_biotypes = MOB_ORGANIC|MOB_UNDEAD

/datum/disease/transformation/xeno
	new_form = /mob/living/carbon/alien/adult/skyrat/drone
