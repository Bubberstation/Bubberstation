//Food
/obj/item/food/candy/hundred_credit_bar
	name = "hundred credit bar"
	desc = "Now with real gold!"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "hundred_credit_bar"
	trash_type = /obj/item/trash/candy/hundred_credit_bar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/gold = 5
	)
	tastes = list("rich candy" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/coconut_joy
	name = "coconut joy"
	desc = "You will be forced to smile when eating this overprocessed coconut treat."
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "coconut_joy"
	trash_type = /obj/item/trash/candy/coconut_joy
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/coconut_milk = 2,
		/datum/reagent/drug/happiness = 3
	)
	tastes = list("dry cardboard" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/hurr_bar
	name = "hurr bar"
	desc = "A favorite of idiots and bitrunners everywhere!"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "hurr_bar"
	trash_type = /obj/item/trash/candy/hurr_bar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/medicine/mannitol = 5
	)
	tastes = list("brain damage" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/laughter_bar
	name = "laughter bar"
	desc = "The clown's favorite."
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "laughter_bar"
	trash_type = /obj/item/trash/candy/laughter_bar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/laughter = 5
	)
	tastes = list("funny candy" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/laughter_bar/slaughter
	name = "slaughter bar"
	desc = "Wait, what?"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/blood = 5
	)
	tastes = list("the need to KILL" = 1)
	foodtypes = JUNKFOOD | SUGAR | BLOODY



/obj/item/food/candy/kit_catgirl_metaclique_bar
	name = "cat-cat bar"
	desc = "The #1 choice for cat people all across the station! Now with 100% less chocolate!"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "kit_catgirl_metaclique_bar"
	trash_type = /obj/item/trash/candy/kit_catgirl_metaclique_bar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/pax/catnip = 5
	)
	tastes = list("chocolate?" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/twink_bar
	name = "twin-k bar"
	desc = "A lizard's favorite chocolate bar!"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "twink_bar"
	trash_type = /obj/item/trash/candy/twink_bar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/colorful_reagent = 5
	)
	tastes = list("pride" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/elon_musk_bar
	name = "musket bar"
	desc = "The #1 choice for pirates!"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "elon_musk_bar"
	trash_type = /obj/item/trash/candy/elon_musk_bar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/gunpowder = 5
	)
	tastes = list("chocolate" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/malf_way
	name = "malful way bar"
	desc = "A proud supporter of the SELF movement!"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "malf_way"
	trash_type = /obj/item/trash/candy/malf_way
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/medicine/nanite_slurry = 5
	)
	tastes = list("AI LAWS" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/triggerfinger
	name = "triggerfinger bar"
	desc = "A favorite of cargo techs everywhere, this chocolate bar will be sure to knock anyone dead without warning or escalation!"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "triggerfinger"
	trash_type = /obj/item/trash/candy/triggerfinger
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/toxin/zombiepowder = 5
	)
	tastes = list("flying rodents" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

//Wrappers.
/obj/item/trash/candy/hundred_credit_bar
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "hundred_credit_bar_trash"

/obj/item/trash/candy/coconut_joy
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "coconut_joy_trash"

/obj/item/trash/candy/hurr_bar
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "hurr_bar_trash"

/obj/item/trash/candy/laughter_bar
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "laughter_bar_trash"

/obj/item/trash/candy/kit_catgirl_metaclique_bar
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "kit_catgirl_metaclique_bar_trash"

/obj/item/trash/candy/twink_bar
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "twink_bar_trash"

/obj/item/trash/candy/elon_musk_bar
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "elon_musk_bar_trash"

/obj/item/trash/candy/malf_way
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "malf_way_trash"

/obj/item/trash/candy/triggerfinger
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "triggerfinger_trash"
