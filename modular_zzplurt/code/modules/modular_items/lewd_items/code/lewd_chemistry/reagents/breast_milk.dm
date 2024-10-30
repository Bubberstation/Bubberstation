// New implementation
/datum/reagent/consumable/milk/breast_milk
	name = "breast milk"
	description = "An opaque white liquid taken fresh from the source."
	taste_description = "warm and creamy"
	default_container = /datum/glass_style/drinking_glass/breast_milk

// Replace glass requirement
/datum/glass_style/drinking_glass/breast_milk
	required_drink_type = /datum/reagent/consumable/milk/breast_milk
