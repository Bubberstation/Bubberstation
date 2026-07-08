/// How many planks of wood are required to complete a weapon?
#define WEAPON_COMPLETION_WOOD_AMOUNT 2

/// The number of hits you are set back when a bad hit is made
#define BAD_HIT_PENALTY 3

#define WEAPON_ASSEMBLY_SPEED 3 SECONDS

/// how many chains/smithing plates can be contained?
#define MAX_FORGING_COMPLETE_ITEMS 50

/obj/structure/reagent_crafting_bench
	name = "forging workbench"
	desc = "A crafting bench fitted with tools, securing mechanisms, and a steady surface for blacksmithing."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_structures.dmi'
	icon_state = "crafting_bench_empty"

	anchored = TRUE
	density = TRUE
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 5)

	/// What the currently picked recipe is
	var/datum/crafting_bench_recipe/selected_recipe
	/// Is this bench able to complete forging items? Exists to allow non-forging workbenches to exist
	var/finishes_forging_weapons = TRUE
	/// The cooldown from the last hit before we allow another 'good hit' to happen
	COOLDOWN_DECLARE(hit_cooldown)
	/// holds stackables
	var/list/stack_item_container = list()
	/// holds misc. forging items
	var/list/forging_complete_container = list(/obj/item/forging/complete/chain = list(), /obj/item/forging/complete/plate = list())
	/// holds forge item placed on the table via hand, or placed on it via weapon completion
	var/obj/item/forged_item_on_surface

	/// What recipes are we allowed to choose from?
	var/list/allowed_choices = list(
		/datum/crafting_bench_recipe/wearable/plate_armor/plate_helmet,
		/datum/crafting_bench_recipe/wearable/plate_armor/plate_vest,
		/datum/crafting_bench_recipe/wearable/plate_armor/plate_gloves,
		/datum/crafting_bench_recipe/wearable/plate_armor/plate_boots,
		/datum/crafting_bench_recipe/wearable/plate_armor/horse_shoes,
		/datum/crafting_bench_recipe/wearable/ring,
		/datum/crafting_bench_recipe/wearable/collar,
		/datum/crafting_bench_recipe/cowboy_holster,
		/datum/crafting_bench_recipe/charging_holster,
		/datum/crafting_bench_recipe/crusader_belt,
		/datum/crafting_bench_recipe/multi_scabbard,
		/datum/crafting_bench_recipe/repairing_scabbard,
		/datum/crafting_bench_recipe/knifethrower,
		/datum/crafting_bench_recipe/bluespace_plants,
		/datum/crafting_bench_recipe/pavise,
		/datum/crafting_bench_recipe/buckler,
		/datum/crafting_bench_recipe/bow,
		/datum/crafting_bench_recipe/wearable/handcuffs,
		/datum/crafting_bench_recipe/revolver,
		////datum/crafting_bench_recipe/borer_cage,
		/datum/crafting_bench_recipe/coil,
		/datum/crafting_bench_recipe/seed_mesh,
		/datum/crafting_bench_recipe/centrifuge,
		/datum/crafting_bench_recipe/bokken,
		/datum/crafting_bench_recipe/empty_circuit,
	)
	/// Radial options for recipes in the allowed_choices list, populated by populate_radial_choice_list
	var/list/radial_choice_list = list()
	/// An associative list of names --> recipe path that the radial recipe picker will choose from later
	var/list/recipe_names_to_path = list()
	/// Filters the radial choice list by required skill
	var/list/choice_list_skill_filter = list()
	/// Filters the radial choice list by required level in its skill; true means corresponding element requires it
	var/list/choice_list_skill_level_filter = list()
	/// Filters the radial choice list by if it requires the smithing skillchip; true means corresponding element requires it
	var/list/choice_list_trait_filter = list()

/obj/structure/reagent_crafting_bench/Initialize(mapload)
	. = ..()
	if(!mapload)
		anchored = FALSE
	populate_radial_choice_list()

/obj/structure/reagent_crafting_bench/proc/populate_radial_choice_list()

	var/datum/radial_menu_choice/option
	for(var/recipe in allowed_choices)
		var/datum/crafting_bench_recipe/recipe_to_take_from = new recipe()
		var/obj/recipe_resulting_item = recipe_to_take_from.resulting_item

		option = new
		option.image = image(icon = initial(recipe_resulting_item.icon), icon_state = initial(recipe_resulting_item.icon_state))
		option.name = initial(recipe_resulting_item.name)
		option.info = initial(recipe_resulting_item.desc)
		radial_choice_list[recipe_to_take_from.recipe_name] = option

		recipe_names_to_path[recipe_to_take_from.recipe_name] = recipe
		choice_list_skill_filter[recipe_to_take_from.recipe_name] = initial(recipe_to_take_from.relevant_skill)
		choice_list_skill_level_filter[recipe_to_take_from.recipe_name] = initial(recipe_to_take_from.relevant_skill_level)
		choice_list_trait_filter[recipe_to_take_from.recipe_name] = initial(recipe_to_take_from.required_traits)
		qdel(recipe_to_take_from)


/obj/structure/reagent_crafting_bench/examine(mob/user)
	. = ..()
	. += span_notice("You could secure or unsecure it with a wrench.")
	. += span_notice("You could pry it apart with a crowbar.")
	. += span_notice("You could insert a stack of material into the drawers, or <b>right click</b> to retrieve it later.")

	if(!isnull(forged_item_on_surface))
		if(istype(forged_item_on_surface, /obj/item/forging/complete))
			var/obj/item/forging/complete/complete_item
			. += span_notice("[src] has a <b>[initial(complete_item.name)]</b> sitting on it, awaiting completion. <br>")
			var/obj/item/completion_item = complete_item.spawning_item
			. += span_notice("With <b>[WEAPON_COMPLETION_WOOD_AMOUNT]</b> sheets of <b>wood</b> nearby, and some <b>hammering</b>, it could be completed into a <b>[initial(completion_item.name)]</b>.")
			return // We don't want to show any selected recipes if there's weapon head on the bench
	else
		if(selected_recipe)
			var/obj/resulting_item = selected_recipe.resulting_item
			. += span_notice("The selected recipe's resulting item is: <b>[initial(resulting_item.name)]</b> <br>")
			. += span_notice("Gather the required materials, listed below, <b>near the bench</b>, then start <b>hammering</b> to complete it! <br>")

			if(!length(selected_recipe.recipe_requirements))
				. += span_boldwarning("Somehow, this recipe has no requirements, report this as this shouldn't happen.")
				return

		. += selected_recipe.get_recipe_requirements_description()
	return .

/obj/structure/reagent_crafting_bench/update_appearance(updates)
	. = ..()
	cut_overlays()

	if(isnull(forged_item_on_surface))
		return

	var/image/overlayed_item
	if(isnull(forged_item_on_surface.icon_preview))
		overlayed_item = image(icon = forged_item_on_surface.icon, icon_state = forged_item_on_surface.icon_state)
	else
		overlayed_item = image(icon = forged_item_on_surface.icon_preview, icon_state = forged_item_on_surface.icon_state_preview)
	add_overlay(overlayed_item)

/obj/structure/reagent_crafting_bench/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	select_recipe(user)

/obj/structure/reagent_crafting_bench/attack_hand_secondary(mob/living/user, list/modifiers)
	var/temp_list = generate_stack_held_list_radial()
	var/option = show_radial_menu(user, src, temp_list, radius = 38, require_near = TRUE, tooltips = TRUE)

	if(!isnull(forging_complete_container[option]))
		for(var/obj/item/stored_item in forging_complete_container[option])
			if(stored_item.loc == src)
				stored_item.forceMove(get_turf(src))
	else if(!isnull(stack_item_container[option]))
		var/obj/item/stack/sheet/output_stack = stack_item_container[option]
		stack_item_container[option] = null
		if(output_stack.loc == src)
			output_stack.forceMove(get_turf(src))

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN


/obj/structure/reagent_crafting_bench/attack_robot(mob/living/user)
	. = ..()
	select_recipe(user)

/obj/structure/reagent_crafting_bench/proc/add_completed_forged_item(obj/item/new_item)
	forged_item_on_surface = new_item
	forged_item_on_surface.forceMove(src)

/obj/structure/reagent_crafting_bench/proc/select_recipe(mob/living/user)
	update_appearance()

	if(!isnull(forged_item_on_surface))
		user.put_in_hands(forged_item_on_surface)
		forged_item_on_surface = null
		balloon_alert(user, "[forged_item_on_surface] retrieved")
		update_appearance()
		return

	if(selected_recipe)
		clear_recipe()
		balloon_alert_to_viewers("recipe cleared")
		update_appearance()
		return

	var/chosen_recipe = show_radial_menu(user, src, get_filtered_radial_choices(user), radius = 38, require_near = TRUE, tooltips = TRUE)

	if(!chosen_recipe)
		balloon_alert(user, "no recipe choice")
		return

	var/datum/crafting_bench_recipe/recipe_to_use = recipe_names_to_path[chosen_recipe]
	selected_recipe = new recipe_to_use

	balloon_alert(user, "recipe chosen")
	update_appearance()

///Exclusively gives all the radial choices that the user can know how to make.
/obj/structure/reagent_crafting_bench/proc/get_filtered_radial_choices(mob/living/user)
	var/returner = list()
	if(isnull(user?.mind))
		return returner

	for(var/key,value in radial_choice_list)
		if(user_can_craft(user, key))
			returner[key] = value

	return returner

/obj/structure/reagent_crafting_bench/proc/user_can_craft(mob/living/user, key)
	if(isnull(user?.mind))
		return FALSE
	if(!isnull(choice_list_skill_filter[key]) && user.mind.get_skill_level(choice_list_skill_filter[key]) < choice_list_skill_level_filter[key])
		return FALSE
	if(!isnull(choice_list_trait_filter[key]))
		for(var/my_trait in choice_list_trait_filter[key])
			if (!HAS_TRAIT(user, my_trait))
				return FALSE
	return TRUE

/// Clears the current recipe and sets hits to completion to zero
/obj/structure/reagent_crafting_bench/proc/clear_recipe()
	QDEL_NULL(selected_recipe)

/obj/structure/reagent_crafting_bench/item_interaction(mob/living/user, obj/item/attacking_item, params)
	if(istype(attacking_item, /obj/item/forging/complete) && user.combat_mode == FALSE)
		var/obj/item/forging/complete/complete_item = attacking_item
		if(!isnull(complete_item.spawning_item))
			attempt_place(attacking_item, user)
			return TRUE

	if(istype(attacking_item, /obj/item/stack/sheet))
		attempt_stack_storage(attacking_item, user)
		return TRUE

	if(!isnull(forging_complete_container[attacking_item.type]))
		attempt_complete_item_storage(attacking_item, user)
		return TRUE

	return ..()

/obj/structure/reagent_crafting_bench/tong_act(mob/living/user, obj/item/tool)
	var/obj/item/forging/forge_item = tool
	add_fingerprint(user)
	var/obj/obj_tong_search = locate() in forge_item.contents
	if(obj_tong_search)
		var/returner = item_interaction(user, obj_tong_search)
		if(length(tool.contents) < 1)
			forge_item.icon_state = "tong_empty"
		return returner
	else
		if(!isnull(forged_item_on_surface))
			if(forged_item_on_surface.loc != src)
				forged_item_on_surface.forceMove(forge_item)
				forge_item.icon_state = "tong_full"
				balloon_alert(user, "took [forged_item_on_surface]")
				forged_item_on_surface = null
			return ITEM_INTERACT_SUCCESS
		else
			var/temp_list = generate_stack_held_list_radial()
			var/option = show_radial_menu(user, src, temp_list, radius = 38, require_near = TRUE, tooltips = TRUE)
			if(user.get_active_held_item() != tool)
				if(!isnull(stack_item_container[option]))
					var/obj/item/stack/sheet/output_stack = stack_item_container[option]
					if(!isnull(output_stack) && output_stack.loc == src)
						output_stack.tong_act(user, tool)
						return ITEM_INTERACT_SUCCESS
				else if(!isnull(forging_complete_container[option]) && length(forging_complete_container[option]) > 0)
					var/obj/item/stack/sheet/output_complete = forging_complete_container[option][1]
					if(!isnull(output_complete) && output_complete.loc == src)
						output_complete.tong_act(user, tool)
						return ITEM_INTERACT_SUCCESS
			else
				balloon_alert(user, "you let go of [tool]!")

	return NONE

/obj/structure/reagent_crafting_bench/mouse_drop_receive(atom/movable/attacking_item, mob/living/user, params)
	. = ..()
	if(!isliving(user))
		return

	if(!isobj(attacking_item))
		return

	if(istype(attacking_item, /obj/item/forging/complete))
		attempt_place(attacking_item, user)

/obj/structure/reagent_crafting_bench/proc/attempt_place(obj/item/attacking_item, mob/user)
	if(!isnull(forged_item_on_surface))
		balloon_alert(user, "already full")
		return

	forged_item_on_surface = attacking_item
	attacking_item.forceMove(src)
	balloon_alert_to_viewers("placed [attacking_item]")
	update_appearance()
	return

/obj/structure/reagent_crafting_bench/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	set_anchored(!anchored)
	balloon_alert_to_viewers(anchored ? "secured" : "unsecured")
	return TRUE

/obj/structure/reagent_crafting_bench/crowbar_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	balloon_alert(user, "pried apart")
	deconstruct(TRUE)
	return TRUE

/obj/structure/reagent_crafting_bench/atom_deconstruct(disassembled = TRUE)
	if(length(contents))
		for(var/obj/contained in contents)
			contained.forceMove(get_turf(src))
	return ..()

/obj/structure/reagent_crafting_bench/hammer_act(mob/living/user, obj/item/tool)
	if(DOING_INTERACTION(user, DOAFTER_SMITHING_ANVIL))
		return

	if(!isnull(forged_item_on_surface))
		return try_weapon_completion(user, tool)

	if(check_craftability_general(user, tool) == ITEM_INTERACT_BLOCKING)
		return ITEM_INTERACT_BLOCKING

	var/skill_modifier = user.mind.get_skill_modifier(selected_recipe.relevant_skill, SKILL_SPEED_MODIFIER)

	playsound(src, 'sound/items/hammering_wood.ogg', 50, vary = TRUE)
	if(do_after(user, selected_recipe.time_to_assemble * skill_modifier,target = src, interaction_key = DOAFTER_SMITHING_TABLE) && isnull(forged_item_on_surface))
		var/list/things_to_use = can_we_craft_this(selected_recipe.recipe_requirements, TRUE)

		create_thing_from_requirements(things_to_use, selected_recipe, user, selected_recipe.relevant_skill, selected_recipe.relevant_skill_reward)
		return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_BLOCKING
/// Takes the given list of item requirements and checks the surroundings for them, returns TRUE unless return_ingredients_list is set, in which case a list of all the items to use is returned
/obj/structure/reagent_crafting_bench/proc/try_weapon_completion(mob/living/user, obj/item/tool)
	if(DOING_INTERACTION(user, DOAFTER_SMITHING_TABLE))
		return

	if(!istype(forged_item_on_surface, /obj/item/forging/complete))
		balloon_alert(user, "invalid item")
		return ITEM_INTERACT_BLOCKING

	var/obj/item/forging/complete/complete_item = forged_item_on_surface
	if(!complete_item.spawning_item)
		balloon_alert(user, "[forged_item_on_surface] cannot be completed")
		return ITEM_INTERACT_BLOCKING

	var/list/wood_required_for_weapons = list(
		/obj/item/stack/sheet/mineral/wood = WEAPON_COMPLETION_WOOD_AMOUNT,
	)

	if(!can_we_craft_this(wood_required_for_weapons))
		balloon_alert(user, "not enough wood")
		return ITEM_INTERACT_BLOCKING

	playsound(src, 'sound/items/hammering_wood.ogg', 50, vary = TRUE)
	if(!do_after(user, WEAPON_ASSEMBLY_SPEED, target = src, interaction_key = DOAFTER_SMITHING_TABLE))
		return ITEM_INTERACT_BLOCKING

	var/list/things_to_use = can_we_craft_this(wood_required_for_weapons, TRUE)
	if(!can_we_craft_this(wood_required_for_weapons))
		balloon_alert(user, "not enough wood")
		return ITEM_INTERACT_BLOCKING

	var/obj/thing_just_made = create_thing_from_requirements(things_to_use, user = user, skill_to_grant = /datum/skill/smithing, skill_amount = 30, completing_a_weapon = TRUE)

	if(!thing_just_made)
		message_admins("[src] just tried to finish a weapon but somehow created nothing! This is not working as intended!")
		return ITEM_INTERACT_SUCCESS

	balloon_alert_to_viewers("[thing_just_made] created")
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/structure/reagent_crafting_bench/proc/check_craftability_general(mob/living/user, obj/item/tool)
	if(!selected_recipe)
		balloon_alert(user, "no recipe selected")
		return ITEM_INTERACT_BLOCKING

	if(!user_can_craft(user, selected_recipe.recipe_name))
		balloon_alert(user, "you're not skilled enough!")
		return ITEM_INTERACT_BLOCKING

	if(!can_we_craft_this(selected_recipe.recipe_requirements))
		balloon_alert(user, "missing ingredients")
		return ITEM_INTERACT_BLOCKING

	return ITEM_INTERACT_SUCCESS
/obj/structure/reagent_crafting_bench/proc/can_we_craft_this(list/required_items, return_ingredients_list = FALSE)
	if(!length(required_items))
		message_admins("[src] just tried to check for ingredients nearby without having a list of items to check for!")
		return FALSE

	var/list/surrounding_items = list()
	var/list/requirement_items = list()

	for(var/obj/item/potential_requirement in get_environment())
		surrounding_items += potential_requirement

	for(var/obj/item/requirement_path as anything in required_items)
		var/required_amount = required_items[requirement_path]

		for(var/obj/item/nearby_item as anything in surrounding_items)
			if(!istype(nearby_item, requirement_path))
				continue

			if(isstack(nearby_item)) // If the item is a stack, check if that stack has enough material in it to fill out the amount
				var/obj/item/stack/nearby_stack = nearby_item
				if(required_amount > 0)
					requirement_items += nearby_item
				required_amount -= nearby_stack.amount
			else // Otherwise, we still exist and should subtract one from the required number of items
				if(required_amount > 0)
					requirement_items += nearby_item
				required_amount -= 1

		if(required_amount > 0)
			return FALSE

	if(return_ingredients_list)
		return requirement_items
	else
		return TRUE

/// Passes the list of found ingredients + the recipe to use_or_delete_recipe_requirements, then spawns the given recipe's result
/obj/structure/reagent_crafting_bench/proc/create_thing_from_requirements(list/things_to_use, datum/crafting_bench_recipe/recipe_to_follow, mob/living/user, datum/skill/skill_to_grant, skill_amount, completing_a_weapon)

	if(!recipe_to_follow && !completing_a_weapon)
		message_admins("[src] just tried to complete a recipe without having a recipe, and without it being the completion of a forging weapon!")
		return FALSE

	if(completing_a_weapon && isnull(forged_item_on_surface))
		message_admins("[src] just tried to complete a forge weapon without there being a weapon head inside it to complete!")
		return FALSE

	if(!length(things_to_use))
		message_admins("[src] just tried to craft something from requirements, but was not given a list of requirements!")
		return FALSE

	if(completing_a_weapon)
		recipe_to_follow = new /datum/crafting_bench_recipe/weapon_completion_recipe

	var/obj/newly_created_thing

	if(completing_a_weapon)
		things_to_use.Add(forged_item_on_surface)
	newly_created_thing = recipe_to_follow.create_using_item_list(things_to_use, user, 	src)

	if(!newly_created_thing)
		message_admins("[src] just failed to create something while crafting!")
		return FALSE

	user.mind.adjust_experience(skill_to_grant, skill_amount)

	clear_recipe()
	update_appearance()
	return newly_created_thing

/obj/structure/reagent_crafting_bench/proc/attempt_stack_storage(obj/item/stack/sheet/my_stack, mob/living/user)
	var/obj/item/stack/sheet/existing_stack = stack_item_container[my_stack.merge_type]
	if(isnull(existing_stack))
		stack_item_container[my_stack.merge_type] = my_stack
		my_stack.forceMove(src)
		balloon_alert(user, "stashed [my_stack]")
	else
		if(existing_stack.amount >= existing_stack.max_amount)
			balloon_alert(user, "[my_stack] drawer is full!")
		else
			my_stack.merge(stack_item_container[my_stack.merge_type])
			balloon_alert(user, "stashed [my_stack]")

/obj/structure/reagent_crafting_bench/proc/attempt_complete_item_storage(obj/item/forging/complete/complete_item, mob/living/user)
	if(length(forging_complete_container[complete_item.type]) >= MAX_FORGING_COMPLETE_ITEMS)
		balloon_alert(user, "[initial(complete_item.name)] drawer is full!")
	else
		forging_complete_container[complete_item.type] += complete_item
		complete_item.forceMove(src)
		balloon_alert(user, "stashed [initial(complete_item.name)]")

/obj/structure/reagent_crafting_bench/proc/clear_empty_stacks()
	var/obj/item/stack/sheet/my_stack
	var/list/my_list
	for(var/stack_type in stack_item_container)
		my_stack = stack_item_container[stack_type]
		if(isnull(my_stack) || my_stack.amount < 1)
			stack_item_container.Remove(stack_type)

	for(var/complete_item_type in forging_complete_container)
		for(var/obj/item/my_item in forging_complete_container[complete_item_type])
			if(isnull(my_item) || my_item.loc != src)
				my_list = forging_complete_container[complete_item_type]
				my_list.Remove(my_item)

/obj/structure/reagent_crafting_bench/proc/generate_stack_held_list_radial()
	clear_empty_stacks()
	var/list/returner = list()
	var/datum/radial_menu_choice/option
	var/obj/item/stack/sheet/my_sheet
	var/obj/item/forging/complete/my_complete
	for(var/complete_type in forging_complete_container)
		if(length(forging_complete_container[complete_type]) > 0)
			option = new
			my_complete = forging_complete_container[complete_type][1]
			option.image = image(icon = initial(my_complete.icon), icon_state = initial(my_complete.icon_state))
			option.name = initial(my_complete.name)
			option.info = length(forging_complete_container[complete_type])
			returner[complete_type] = option
	for(var/stack_type in stack_item_container)
		option = new
		my_sheet = stack_item_container[stack_type]
		option.image = image(icon = initial(my_sheet.icon), icon_state = initial(my_sheet.icon_state))
		option.name = initial(my_sheet.name)
		option.info = my_sheet.amount
		returner[stack_type] = option
	return returner

/// Gets movable atoms within one tile of range of the crafting bench
/obj/structure/reagent_crafting_bench/proc/get_environment()
	. = list()

	if(!get_turf(src))
		return

	for(var/atom/movable/found_movable_atom in range(1, src))
		if((found_movable_atom.flags_1 & HOLOGRAM_1))
			continue
		. += found_movable_atom
	return .

#undef WEAPON_COMPLETION_WOOD_AMOUNT
#undef BAD_HIT_PENALTY
#undef WEAPON_ASSEMBLY_SPEED
#undef MAX_FORGING_COMPLETE_ITEMS
