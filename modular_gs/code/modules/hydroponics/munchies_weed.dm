/mob/living/carbon
	var/nutri_mult = 1

/obj/item/seeds/cannabis
	mutatelist = list(/obj/item/seeds/cannabis/rainbow,
						/obj/item/seeds/cannabis/death,
						/obj/item/seeds/cannabis/munchies)

/datum/plant_gene/trait/glow/orange
	name = "Orange Bioluminescence"
	glow_color = "#ff9166"

/obj/item/seeds/cannabis/munchies
	name = "pack of munchies weed seeds"
	desc = "These seeds grow into munchies weed."
	species = "munchycannabis"
	plantname = "Munchies Weed"
	product = /obj/item/reagent_containers/food/snacks/grown/cannabis/munchies
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/glow/orange)
	mutatelist = list()
	reagents_add = list(/datum/reagent/drug/space_drugs = 0.05,
						/datum/reagent/drug/munchies = 0.10)
	rarity = 69
	icon = 'GainStation13/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-munchies"
	growing_icon = 'GainStation13/icons/obj/hydroponics/growing.dmi'
	icon_grow = "munchycannabis-grow" // Uses one growth icons set for all the subtypes
	icon_dead = "munchycannabis-dead" // Same for the dead icon
	icon_harvest = "munchycannabis-harvest"

/obj/item/reagent_containers/food/snacks/grown/cannabis/munchies
	seed = /obj/item/seeds/cannabis/munchies
	name = "munchies cannabis leaf"
	desc = "You feel hungry just looking at it."
	icon = 'GainStation13/icons/obj/hydroponics/harvest.dmi'
	icon_state = "munchycannabis"
	wine_power = 90

/datum/reagent/drug/munchies
	name = "Appetite Stimulant"
	value = 6
	description = "A chemical compound that makes one mindlessly ravenous."
	color = "#60A584"
	pH = 9
	metabolization_rate = REAGENTS_METABOLISM / 4

/datum/reagent/drug/munchies/on_mob_add(mob/living/L, amount)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.nutri_mult += 0.5

/datum/reagent/drug/munchies/on_mob_delete(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.nutri_mult -= 0.5

/datum/reagent/drug/munchies/on_mob_life(mob/living/carbon/M)
	. = ..()
	if(prob(10))
		to_chat(M, "<span class='warning'>[pick("You feel a little ravenous...", "You could really go for a snack right now...", "The taste of food seems really enticing right now...", "Your belly groans, demanding food...")]</span>")
	if(M.fullness > 10)
		M.fullness -= 1
	if(M.nutrition > 150)
		M.nutrition -= 1
