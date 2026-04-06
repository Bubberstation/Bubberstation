/// The maximum force that can be given to a weapon via perfect hits
#define MAX_PERFECT_FORCE_BONUS 3
/// Minimum and maximum force multiplier if a weapon contains incomplete parts
#define MIN_INCOMPLETE_DAMAGE_MULT 0.1
#define MAX_INCOMPLETE_DAMAGE_MULT 0.5
//ditto, with staff reagents
#define MIN_INCOMPLETE_STAFF_INJECT_MULT 0.2
#define MAX_INCOMPLETE_STAFF_INJECT_MULT 0.5


/datum/crafting_bench_recipe
	/// The name of the recipe to show
	var/recipe_name = "generic debug recipe"
	/// The items required to create the resulting item
	var/list/recipe_requirements
	/// What the end result of this recipe should be
	var/resulting_item = /obj/item/forging
	/// If we use the materials from the component parts
	var/transfers_materials = TRUE
	/// How long it takes at the crafting bench to assemble
	var/time_to_assemble = 2 SECONDS
	/// What skill is relevant to the creation of this item?
	var/relevant_skill = /datum/skill/smithing
	/// What skill level is required in that creation?
	var/relevant_skill_level = 0
	/// Does the recipe also require a specific trait?
	var/required_traits = null
	/// How much experience in our relevant skill do we give upon completion?
	var/relevant_skill_reward = 30
	/// Do the crafting pieces go into the result item, or get qdel'd?
	var/insert_ingredients_into_product_contents

///Creates the item using the given list of ingredients -- it's assumed that this is only called after the list is verified to contain all ingredients. Probably shouldn't be parent called due to ingredient deletion.
/datum/crafting_bench_recipe/proc/create_using_item_list(list/item_list, mob/living/user)
	var/obj/item/returner = new resulting_item(src)

	transfer_reagent_imbues_from_ingredients_to_product(item_list, returner, user)
	put_materials_in_product_from_ingredients(item_list, returner)
	consume_crafting_ingredients(item_list, returner)
	return returner

/datum/crafting_bench_recipe/proc/transfer_reagent_imbues_from_ingredients_to_product(list/ingredients, obj/item/product, mob/living/user)
	//imbued of the final product should be approx. imbued of all containing products
	var/datum/component/reagent_imbued/output_reagent_component = product.GetComponent(/datum/component/reagent_imbued)
	var/datum/reagents/my_reagents = combine_reagent_imbues(ingredients)
	output_reagent_component.set_reagent_imbue(my_reagents, clear_source_reagents = TRUE, smithing_oil_bonus = HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING))

/datum/crafting_bench_recipe/proc/combine_reagent_imbues(list/reagent_imbued_items)
	var/datum/reagents/reagents_sum = new(maximum = 4096, new_flags = NO_REACT)
	var/datum/component/reagent_imbued/current_reagent_component
	for(var/obj/item in reagent_imbued_items)
		current_reagent_component = item.GetComponent(/datum/component/reagent_imbued)
		if(!isnull(current_reagent_component))
			current_reagent_component.imbued_reagent.trans_to(reagents_sum, current_reagent_component.imbued_reagent.total_volume)

	return reagents_sum

/datum/crafting_bench_recipe/proc/put_materials_in_product_from_ingredients(list/ingredients, obj/item/product)
	if(transfers_materials)
		var/materials_to_transfer = list()
		for(var/obj/requirement_item as anything in ingredients)
			if(istype(requirement_item, /obj/item/forging/complete))
				if(!requirement_item.custom_materials || !transfers_materials)
					continue

				for(var/custom_material in requirement_item.custom_materials)
					materials_to_transfer += custom_material

		product.set_custom_materials(materials_to_transfer, multiplier = 1)


/datum/crafting_bench_recipe/proc/consume_crafting_ingredients(list/things_to_use, obj/item/product)
	for(var/obj/item/thing in things_to_use)
		if(isstack(thing))
			var/obj/item/stack/stack_thing
			stack_thing = thing
			var/stack_type = stack_thing.type
			var/amount_to_subtract = recipe_requirements[stack_type]
			if(insert_ingredients_into_product_contents)
				var/obj/item/stack/temp_stack = stack_thing.split_stack(amount_to_subtract)
				temp_stack.forceMove(product)
			else
				stack_thing.use(amount_to_subtract, transfer = FALSE, check = TRUE)
		else
			if(insert_ingredients_into_product_contents)
				thing.forceMove(product)
			else
				qdel(thing)

/datum/crafting_bench_recipe/proc/get_total_completion_amount(list/things_to_use)
	var/total_completion = 0
	var/total_forge_items = 0
	for(var/obj/item/forging/complete/complete_forging_item in things_to_use)
		total_completion += complete_forging_item.hammer_completion_amount
		total_forge_items ++
	total_completion /= total_forge_items
	return total_completion

/datum/crafting_bench_recipe/proc/apply_perfect_and_completion_bonuses(list/things_to_use, obj/item/product)

/datum/crafting_bench_recipe/weapon_completion_recipe //Exists so I don't have to modify the code too much for weapon completion
	recipe_name = "generic weapon completion recipe (should not be visible)"
	recipe_requirements = list(
		/obj/item/stack/sheet/mineral/wood = 2,
	)
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)

/datum/crafting_bench_recipe/weapon_completion_recipe/create_using_item_list(list/item_list, mob/living/user)
	var/asfdsf = LAZYLEN(item_list)
	user.balloon_alert(user, "[asfdsf]")
	if(!is_type_in_list(/obj/item/forging/complete, item_list))
		stack_trace("[src] didn't contain a valid reagent smithing weapon head when its recipe was completed!")

	var/obj/item/forging/complete/weapon_head = item_list[is_path_in_list(/obj/item/forging/complete/, item_list, TRUE)]
	var/obj/item/returner = new weapon_head.spawning_item(src)
	apply_perfect_and_completion_bonuses(item_list, returner)
	transfer_reagent_imbues_from_ingredients_to_product(item_list, returner)
	put_materials_in_product_from_ingredients(item_list, returner, user)

	consume_crafting_ingredients(item_list, returner)
	return returner

/datum/crafting_bench_recipe/weapon_completion_recipe/apply_perfect_and_completion_bonuses(list/things_to_use, obj/item/product)
	var/obj/item/forging/complete/weapon_head = is_path_in_list(/obj/item/forging/complete, things_to_use, TRUE)
	var/pieces_completion_amount = get_total_completion_amount(things_to_use)
	if(!istype(weapon_head, /obj/item/forging/complete/staff)) //we don't want the staff to get added damage
		product.force += clamp(weapon_head.perfect_ratio * MAX_PERFECT_FORCE_BONUS, 0, MAX_PERFECT_FORCE_BONUS)
		//recalculate force based on if the components were quenched too early
		if(pieces_completion_amount < 1)
			product.force *= lerp(MIN_INCOMPLETE_DAMAGE_MULT, MAX_INCOMPLETE_DAMAGE_MULT, pieces_completion_amount)
	else
		var/datum/component/reagent_imbued/staff_component = weapon_head.GetComponent(/datum/component/reagent_imbued)
		if(!isnull(staff_component) && pieces_completion_amount < 1)
			staff_component.imbued_reagent.maximum_volume = round(staff_component.imbued_reagent.maximum_volume * lerp(MIN_INCOMPLETE_STAFF_INJECT_MULT, MAX_INCOMPLETE_STAFF_INJECT_MULT, pieces_completion_amount))


/datum/crafting_bench_recipe/wearable/plate_helmet
	recipe_name = "plate helmet"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 4,
	)
	resulting_item = /obj/item/clothing/head/helmet/forging_plate_helmet
	time_to_assemble = 1.5 SECONDS

/datum/crafting_bench_recipe/wearable/plate_vest
	recipe_name = "plate vest"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 6,
	)
	resulting_item = /obj/item/clothing/suit/armor/forging_plate_armor
	time_to_assemble = 3 SECONDS

/datum/crafting_bench_recipe/wearable/plate_gloves
	recipe_name = "plate gloves"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 2,
	)
	resulting_item = /obj/item/clothing/gloves/forging_plate_gloves
	time_to_assemble = 2 SECONDS

/datum/crafting_bench_recipe/wearable/plate_boots
	recipe_name = "plate boots"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 4,
	)
	resulting_item = /obj/item/clothing/shoes/forging_plate_boots
	time_to_assemble = 2 SECONDS

/datum/crafting_bench_recipe/wearable/horse_shoes
	recipe_name = "horse shoes"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 4,
	)
	resulting_item = /obj/item/clothing/shoes/horseshoe/reagent_clothing
	time_to_assemble = 1.5 SECONDS

/datum/crafting_bench_recipe/wearable/ring
	recipe_name = "ring"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 2,
	)
	resulting_item = /obj/item/clothing/gloves/ring/reagent_clothing
	time_to_assemble = 4 SECONDS

/datum/crafting_bench_recipe/wearable/collar
	recipe_name = "collar"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 3,
	)
	resulting_item = /obj/item/clothing/neck/collar/reagent_clothing
	time_to_assemble = 3 SECONDS

/datum/crafting_bench_recipe/wearable/handcuffs
	recipe_name = "handcuffs"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 5,
	)
	resulting_item = /obj/item/restraints/handcuffs/reagent_clothing
	time_to_assemble = 5 SECONDS

/datum/crafting_bench_recipe/borer_cage
	recipe_name = "cortical borer cage"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 6,
	)
	resulting_item = /obj/item/cortical_cage
	time_to_assemble = 2 SECONDS

/datum/crafting_bench_recipe/pavise
	recipe_name = "pavise"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 8,
	)
	resulting_item = /obj/item/shield/buckler/reagent_weapon/pavise
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)
	time_to_assemble = 6 SECONDS

/datum/crafting_bench_recipe/buckler
	recipe_name = "buckler"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 5,
	)
	resulting_item = /obj/item/shield/buckler/reagent_weapon
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)
	time_to_assemble = 3 SECONDS

/datum/crafting_bench_recipe/coil
	recipe_name = "coil"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 2,
	)
	resulting_item = /obj/item/forging/coil
	time_to_assemble = 2 SECONDS

/datum/crafting_bench_recipe/seed_mesh
	recipe_name = "seed mesh"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
		/obj/item/forging/complete/chain = 2,
	)
	resulting_item = /obj/item/seed_mesh
	time_to_assemble = 10 SECONDS

/datum/crafting_bench_recipe/centrifuge
	recipe_name = "centrifuge"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
	)
	resulting_item = /obj/item/reagent_containers/cup/primitive_centrifuge
	time_to_assemble = 7 SECONDS

/datum/crafting_bench_recipe/bokken
	recipe_name = "bokken"
	recipe_requirements = list(
		/obj/item/stack/sheet/mineral/wood = 4,
	)
	resulting_item = /obj/item/forging/reagent_weapon/bokken
	time_to_assemble = 3 SECONDS
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)

/datum/crafting_bench_recipe/bow
	recipe_name = "bow"
	recipe_requirements = list(
		/obj/item/stack/sheet/mineral/wood = 4,
	)
	resulting_item = /obj/item/forging/incomplete_bow
	time_to_assemble = 4 SECONDS
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)

/datum/crafting_bench_recipe/empty_circuit
	recipe_name = "circuit"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
		/obj/item/forging/coil = 1,
	)
	resulting_item = /obj/item/empty_circuit
	time_to_assemble = 20 SECONDS
	required_traits = list(TRAIT_KNOW_CIRCUIT_SMITHING)

#undef MAX_PERFECT_FORCE_BONUS
