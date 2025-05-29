/obj/item/reagent_containers/food
	var/blessed = 0

/obj/item/reagent_containers/food/snacks/gbburrito
	name = "\improper GATO Gas Giant Burrito"
	icon = 'Gainstation13/icons/obj/food/food.dmi'
	icon_state = "gbburrito"
	desc = "More than three pounds of beans, meat, and cheese wrapped in a greasy tortilla. It's piping hot."
	trash = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/flatulose = 4, /datum/reagent/consumable/sodiumchloride = 0.5)
	filling_color = "#74291b"
	tastes = list("refried beans","grease" = 1)
	foodtype = MEAT

//these have been ported from CHOMPstation / Virgo
/obj/item/reagent_containers/food/snacks/doner_kebab
	name = "doner kebab"
	icon = 'GainStation13/icons/obj/food/ported_meals.dmi'
	desc = "A delicious sandwich-like food from ancient Earth. The meat is typically cooked on a vertical rotisserie."
	icon_state = "doner_kebab"
	trash = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	filling_color = "#93684d"
	tastes = list("thinly sliced meat","meat" = 1)
	foodtype = GRAIN | VEGETABLES | MEAT | JUNKFOOD

/obj/item/reagent_containers/food/snacks/lasagna
	name = "lasagna"
	desc = "Meaty, tomato-y, and ready to eat-y. Favorite of cats."
	icon = 'GainStation13/icons/obj/food/ported_meals.dmi'
	icon_state = "lasagna"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	filling_color = "#872020"
	tastes = list("italian cuisine" = 1)
	foodtype = GRAIN | VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/corndog
	name = "corn dog"
	desc = "A cornbread covered sausage deepfried in oil."
	icon = 'GainStation13/icons/obj/food/ported_meals.dmi'
	icon_state = "corndog"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#df9745"
	tastes = list("corn batter", "sausage" = 1)
	foodtype = GRAIN | MEAT | JUNKFOOD

/obj/item/reagent_containers/food/snacks/turkey
	name = "turkey"
	desc = "Tastes like chicken. It can be sliced!"
	icon = 'GainStation13/icons/obj/food/ported_meals.dmi'
	icon_state = "turkey"
	slice_path = /obj/item/reagent_containers/food/snacks/turkey_leg
	slices_num = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	filling_color = "#d4864b"
	tastes = list("turkey" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/turkey_leg
	name = "turkey leg"
	desc = "Tastes like chicken."
	icon = 'GainStation13/icons/obj/food/ported_meals.dmi'
	icon_state = "turkey_slice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#ae6941"
	tastes = list("turkey" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/brownies
	name = "brownies"
	desc = "Halfway to fudge, or halfway to cake? Who cares!"
	icon = 'GainStation13/icons/obj/food/ported_meals.dmi'
	icon_state = "brownies"
	slice_path = /obj/item/reagent_containers/food/snacks/brownies_slice
	slices_num = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	filling_color = "#392f27"
	tastes = list("chocolate" = 1)
	foodtype = GRAIN | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/brownies_slice
	name = "brownie"
	desc = "a dense, decadent chocolate brownie."
	icon = 'GainStation13/icons/obj/food/ported_meals.dmi'
	icon_state = "browniesslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#392f27"
	tastes = list("chocolate" = 1)
	foodtype = GRAIN | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/brownies_cosmic
	name = "cosmic brownies"
	desc = "The power of cosmos likes within your hand."
	icon = 'GainStation13/icons/obj/food/ported_meals.dmi'
	icon_state = "cosmicbrownies"
	slice_path = /obj/item/reagent_containers/food/snacks/brownies_slice_cosmic
	slices_num = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = 25, /datum/reagent/medicine/omnizine = 5)
	filling_color = "#392f27"
	tastes = list("chocolate" = 1)
	foodtype = GRAIN | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/brownies_slice_cosmic
	name = "cosmic brownie"
	desc = "a dense, decadent and fun-looking chocolate brownie."
	icon = 'GainStation13/icons/obj/food/ported_meals.dmi'
	icon_state = "cosmicbrownieslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/medicine/omnizine = 1)
	filling_color = "#392f27"
	tastes = list("chocolate" = 1)
	foodtype = GRAIN | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/bacon_and_eggs
	name = "bacon and eggs"
	desc = "A staple of every breakfast."
	icon = 'GainStation13/icons/obj/food/ported_meals.dmi'
	icon_state = "bacon_and_eggs"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	filling_color = "#e9e6e3"
	tastes = list("eggs", "bacon" = 1)
	foodtype = BREAKFAST | MEAT

/obj/item/reagent_containers/food/snacks/eggmuffin
	name = "egg muffin"
	desc = "A staple of every breakfast."
	icon = 'GainStation13/icons/obj/food/ported_meals.dmi'
	icon_state = "eggmuffin"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	filling_color = "#e9e6e3"
	tastes = list("eggs", "breakfast" = 1)
	foodtype = BREAKFAST | MEAT

/obj/item/reagent_containers/food/snacks/cinammonbun
	name = "cinammon bun"
	desc = "Careful not to have it stolen."
	icon = 'GainStation13/icons/obj/food/ported_meals.dmi'
	icon_state = "cinammonbun"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#e9e6e3"
	tastes = list("eggs", "breakfast" = 1)
	foodtype = GRAIN | SUGAR


/obj/item/reagent_containers/food/snacks/soup/lavaland_stew
	name = "lavaland stew"
	desc = "A mixture of various lavaland mushrooms, turned into a bland but medicinal stew."
	icon = 'GainStation13/icons/obj/food/ported_meals.dmi'
	icon_state = "lavalandsoup"
	trash = /obj/item/reagent_containers/glass/bowl/mushroom_bowl
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/vitfro = 15) //Primarily here to let ashwalkers make medicine. Low nutrient content, high medicine content.
	tastes = list("fresh pickings","extreme blandness" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/donkpocket/spicy
	name = "\improper Spicy-pocket"
	desc = "The classic snack food, now with a heat-activated spicy flair."
	icon_state = "donkpocketspicy"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/capsaicin = 2)
	cooked_type = /obj/item/reagent_containers/food/snacks/donkpocket/warm/spicy
	filling_color = "#CD853F"
	tastes = list("meat" = 2, "dough" = 2, "spice" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/warm/spicy
	name = "warm Spicy-pocket"
	desc = "The classic snack food, now maybe a bit too spicy."
	icon_state = "donkpocketspicy"
	bonus_reagents = list(/datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/capsaicin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/capsaicin = 2)
	tastes = list("meat" = 2, "dough" = 2, "weird spices" = 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/teriyaki
	name = "\improper Teriyaki-pocket"
	desc = "An east-asian take on the classic stationside snack."
	icon_state = "donkpocketteriyaki"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/soysauce = 2)
	cooked_type = /obj/item/reagent_containers/food/snacks/donkpocket/warm/teriyaki
	filling_color = "#CD853F"
	tastes = list("meat" = 2, "dough" = 2, "soy sauce" = 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/warm/teriyaki
	name = "warm Teriyaki-pocket"
	desc = "An east-asian take on the classic stationside snack, now steamy and warm."
	icon_state = "donkpocketteriyaki"
	bonus_reagents = list(/datum/reagent/medicine/omnizine = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/soysauce = 2)
	tastes = list("meat" = 2, "dough" = 2, "soy sauce" = 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/pizza
	name = "\improper Pizza-pocket"
	desc = "Delicious, cheesy and surprisingly filling."
	icon_state = "donkpocketpizza"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/tomatojuice = 2)
	cooked_type = /obj/item/reagent_containers/food/snacks/donkpocket/warm/pizza
	filling_color = "#CD853F"
	tastes = list("meat" = 2, "dough" = 2, "cheese"= 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/warm/pizza
	name = "warm Pizza-pocket"
	desc = "Delicious, cheesy, and even better when hot."
	icon_state = "donkpocketpizza"
	bonus_reagents = list(/datum/reagent/medicine/omnizine = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/tomatojuice = 2)
	tastes = list("meat" = 2, "dough" = 2, "melty cheese"= 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/honk
	name = "\improper Honk-pocket"
	desc = "The award-winning donk-pocket that won the hearts of clowns and humans alike."
	icon_state = "donkpocketbanana"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/banana = 4)
	cooked_type = /obj/item/reagent_containers/food/snacks/donkpocket/warm/honk
	filling_color = "#XXXXXX"
	tastes = list("banana" = 2, "dough" = 2, "children's antibiotics" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/warm/honk
	name = "warm Honk-pocket"
	desc = "The award-winning donk-pocket, now warm and toasty."
	icon_state = "donkpocketbanana"
	bonus_reagents = list(/datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/laughter = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/banana = 4, /datum/reagent/consumable/laughter = 3)
	tastes = list("dough" = 2, "children's antibiotics" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/berry
	name = "\improper Berry-pocket"
	desc = "A relentlessly sweet donk-pocket first created for use in Operation Dessert Storm."
	icon_state = "donkpocketberry"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/berryjuice = 3)
	cooked_type = /obj/item/reagent_containers/food/snacks/donkpocket/warm/berry
	filling_color = "#CD853F"
	tastes = list("dough" = 2, "jam" = 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/warm/berry
	name = "warm Berry-pocket"
	desc = "A relentlessly sweet donk-pocket, now warm and delicious."
	icon_state = "donkpocketberry"
	bonus_reagents = list(/datum/reagent/medicine/omnizine = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/berryjuice = 3)
	tastes = list("dough" = 2, "warm jam" = 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/gondola
	name = "\improper Gondola-pocket"
	desc = "The choice to use real gondola meat in the recipe is controversial, to say the least." //Only a monster would craft this.
	icon_state = "donkpocketgondola"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/tranquility = 5)
	cooked_type = /obj/item/reagent_containers/food/snacks/donkpocket/warm/gondola
	filling_color = "#CD853F"
	tastes = list("meat" = 2, "dough" = 2, "inner peace" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/warm/gondola
	name = "warm Gondola-pocket"
	desc = "The choice to use real gondola meat in the recipe is controversial, to say the least."
	icon_state = "donkpocketgondola"
	bonus_reagents = list(/datum/reagent/medicine/omnizine = 1, /datum/reagent/tranquility = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/medicine/omnizine = 1, /datum/reagent/tranquility = 5)
	tastes = list("meat" = 2, "dough" = 2, "inner peace" = 1)
	foodtype = GRAIN
