/datum/heretic_knowledge/flask_purchase
	name = "Auto-Alchemical Creation"
	desc = "Allows you to transmute a large beaker, a stomach, a silver bar, and an alchemical orb into a magical endless flask \
	that refills with with one of the selected reagents: \
	Healing Juice, Gravitum, Blastoff, or Determination."
	gain_text = "Creating more from nothing is every Exile's dream."
	next_knowledge = list(
		/datum/heretic_knowledge/belt_purchase,
		/datum/heretic_knowledge/chaotic_flask_purchase,
		/datum/heretic_knowledge/limited_amount/wand_purchase,
	)
	required_atoms = list(
		/obj/item/reagent_containers/cup/beaker/large = 1,
		/obj/item/organ/internal/stomach = 1,
		/obj/item/stack/sheet/mineral/silver = 1,
		/obj/item/heretic_currency/alchemical = 1
	)
	result_atoms = list(/obj/item/reagent_containers/cup/endless_flask)

	cost = 1
	depth = 6
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "flask"

	var/static/list/possible_flasks = list(
		/obj/item/reagent_containers/cup/endless_flask/healing_juice,
		/obj/item/reagent_containers/cup/endless_flask/gravitum,
		/obj/item/reagent_containers/cup/endless_flask/blastoff,
		/obj/item/reagent_containers/cup/endless_flask/determination
	)

	var/static/list/possible_flasks_ascended = list(
		/obj/item/reagent_containers/cup/endless_flask/regen_jelly,
		/obj/item/reagent_containers/cup/endless_flask/stimulants,
		/obj/item/reagent_containers/cup/endless_flask/changelingadrenaline,
		/obj/item/reagent_containers/cup/endless_flask/leporazine
	)

/datum/heretic_knowledge/flask_purchase/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)


	var/datum/antagonist/heretic/heretic_datum = user.mind?.has_antag_datum(/datum/antagonist/heretic)
	var/is_ascended = heretic_datum?.ascended

	var/obj/item/item_to_create
	if(locate(/obj/item/food/burger) in loc)
		item_to_create = /obj/item/reagent_containers/cup/endless_flask/burger
	else if(is_ascended)
		item_to_create = pick(possible_flasks_ascended)
	else
		item_to_create = pick(possible_flasks)

	item_to_create = new item_to_create(loc)
	ADD_TRAIT(item_to_create, TRAIT_CONTRABAND, INNATE_TRAIT)

	return TRUE
