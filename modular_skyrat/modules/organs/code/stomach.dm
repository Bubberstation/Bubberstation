/obj/item/organ/stomach/oversized
	name = "huge guts"
	desc = "Typically found in huge creatures, this monstrous engine has developed to be highly efficient, made to get an enormous amount of nutrients to an enormous eater."
	icon = 'modular_skyrat/modules/organs/icons/stomach.dmi'
	icon_state = "stomach_big"
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	metabolism_efficiency = 0.07

/obj/item/organ/stomach/synth/oversized
	name = "huge synthetic bio-reactor"
	desc = "Typically found in huge synthetics, this monstrous engine has been developed to be highly efficient, made to provide an enormous amount of power to an enormous machine."
	icon = 'modular_skyrat/modules/organs/icons/stomach.dmi'
	icon_state = "stomach_big_synth" //ugly placeholder sorry im not an artist hehe
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	metabolism_efficiency = 0.07

/obj/item/organ/stomach/mouse
	name = "murid stomach"
	desc = "A smaller stomach divided into two regions: a glandular stomach for secreting gastric acrid, and a non-glandular stomach which is used for food storage and digestion."
	icon_state = "stomach"
	var/last_recipe = null // prevents same recipe from being chosen twice

/obj/item/organ/stomach/mouse/after_eat(atom/edible)
	var/list/possible_recipes = list()
	for(var/datum/crafting_recipe/recipe as anything in (GLOB.cooking_recipes))
		if(istype(edible, /obj/item/food))
			possible_recipes += recipe
			return possible_recipes
		if(length(possible_recipes))
			if(length(possible_recipes) > 2)
				possible_recipes -= src.last_recipe
				return possible_recipes
			var/datum/crafting_recipe/chosen = pick(possible_recipes)
			to_chat(owner, span_notice("[edible] could probably be used to make [chosen]"))
		else
			to_chat(owner, span_notice("Nothing more can be made from this."))

/proc/random_recipe()
	var/list/possible_recipes = list()
	for(var/datum/crafting_recipe/recipe in GLOB.cooking_recipes)
		if(istype(edible, /obj/item/food))
			possible_recipes += recipe
			return possible_recipes
