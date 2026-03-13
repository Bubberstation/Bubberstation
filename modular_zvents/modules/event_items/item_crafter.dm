/datum/component/item_crafter
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/atom/craftable_type = null // Type of item to craft
	var/list/ingredients_required = list() // Assoc list: type = count
	var/list/ingredients_stored = list() // Assoc list: type = count
	var/craft_time = 10 SECONDS
	var/craft_sound = null
	var/sound_volume = 50
	var/output_dir = null // Direction to throw crafted item
	var/obj/item/stored_item = null // If no output_dir, store here
	var/busy = FALSE // Crafting in progress

/datum/component/item_crafter/Initialize(list/_ingredients = list(), _craft_time = 10 SECONDS, _craft_sound = null, _sound_volume = 50, _output_dir = null)
	. = ..()
	ingredients_required = _ingredients.Copy()
	craft_time = _craft_time
	craft_sound = _craft_sound
	sound_volume = _sound_volume
	output_dir = _output_dir

	setup_template(get_turf(parent))
	var/atom/atom_parent = parent
	atom_parent.add_filter("custom_crafter_outline", 2, list("type" = "outline", "color" = "#fdad35", "size" = 1))

/datum/component/item_crafter/Destroy(force)
	. = ..()
	var/atom/atom_parent = parent
	atom_parent.remove_filter("custom_crafter_outline")

/datum/component/item_crafter/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(insert_ingredient))
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND_SECONDARY, PROC_REF(unload_crafter))
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(handle_interaction))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/component/item_crafter/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(COMSIG_ATOM_ATTACKBY, COMSIG_ATOM_ATTACK_HAND_SECONDARY, COMSIG_ATOM_ATTACK_HAND, COMSIG_ATOM_EXAMINE))

/datum/component/item_crafter/proc/setup_template(turf/T)
	if(!T)
		return
	for(var/obj/item/I in T.contents)
		if(!istype(I) || I == parent)
			continue
		craftable_type = I.type
		qdel(I) // Use as template
		break // Only one template
	if(!craftable_type)
		log_mapping("Item crafter at [get_turf(parent)] has no template item to craft.")

/datum/component/item_crafter/proc/insert_ingredient(datum/source, obj/item/I, mob/living/user)
	SIGNAL_HANDLER
	if(busy)
		user.balloon_alert(user, "crafter busy!")
		return COMPONENT_NO_AFTERATTACK
	var/ingridient_type = null
	for(var/type_path in ingredients_required)
		if(istype(I, type_path))
			ingridient_type = type_path
			break
	if(!ingridient_type)
		user.balloon_alert(user, "wrong ingredient!")
		return COMPONENT_NO_AFTERATTACK

	var/amount_needed = ingredients_required[ingridient_type] - (ingredients_stored[ingridient_type] || 0)
	if(amount_needed <= 0)
		user.balloon_alert(user, "enough of this ingredient!")
		return COMPONENT_NO_AFTERATTACK

	var/amount_to_use = 1
	if(ispath(ingridient_type, /obj/item/stack) && istype(I, /obj/item/stack))
		var/obj/item/stack/S = I
		amount_to_use = min(amount_needed, S.amount)
		if(!S.use(amount_to_use))
			user.balloon_alert(user, "failed to use stack!")
			return COMPONENT_NO_AFTERATTACK
	else
		user.transferItemToLoc(I, parent)
		qdel(I) // Consume non-stack item

	ingredients_stored[ingridient_type] = (ingredients_stored[ingridient_type] || 0) + amount_to_use
	user.balloon_alert(user, "inserted [amount_to_use] [initial(I.name)]")
	return COMPONENT_NO_AFTERATTACK

/datum/component/item_crafter/proc/unload_crafter(datum/source, mob/living/user)
	SIGNAL_HANDLER
	if(busy)
		user.balloon_alert(user, "crafter busy!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!length(ingredients_stored))
		user.balloon_alert(user, "no ingredients to unload!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	// Unload all stored ingredients
	for(var/type_path in ingredients_stored)
		var/amount = ingredients_stored[type_path]
		if(ispath(type_path, /obj/item/stack))
			var/obj/item/stack/S = new type_path(get_turf(parent))
			S.amount = amount
			S.update_appearance()
		else
			for(var/i in 1 to amount)
				new type_path(get_turf(parent))
	ingredients_stored = list()
	user.balloon_alert(user, "unloaded all ingredients")
	user.balloon_alert_to_viewers("unloads ingredients")
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/datum/component/item_crafter/proc/handle_interaction(datum/source, mob/living/user)
	SIGNAL_HANDLER
	if(busy)
		user.balloon_alert(user, "crafter busy!")
		return COMPONENT_CANCEL_ATTACK_CHAIN
	if(stored_item)
		// Extract stored item
		stored_item.forceMove(user.loc)
		user.balloon_alert(user, "extracted crafted item")
		user.balloon_alert_to_viewers("extracts item")
		stored_item = null
		return COMPONENT_CANCEL_ATTACK_CHAIN

	// Check if enough ingredients
	var/can_craft = TRUE
	for(var/type_path in ingredients_required)
		if((ingredients_stored[type_path] || 0) < ingredients_required[type_path])
			can_craft = FALSE
			break
	if(!can_craft)
		user.balloon_alert(user, "not enough ingredients!")
		return COMPONENT_CANCEL_ATTACK_CHAIN
	if(!craftable_type)
		user.balloon_alert(user, "no template set!")
		return COMPONENT_CANCEL_ATTACK_CHAIN

	// Start crafting
	busy = TRUE
	if(craft_sound)
		playsound(parent, craft_sound, sound_volume, TRUE)
	do_jiggle()
	user.balloon_alert(user, "crafting started...")
	user.balloon_alert_to_viewers("starts crafting")
	addtimer(CALLBACK(src, PROC_REF(finish_craft), user), craft_time)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/item_crafter/proc/do_jiggle()
	var/atom/A = parent
	var/matrix/original_matrix = matrix(A.transform)
	var/matrix/M = matrix(A.transform)
	var/degree = pick(-15, 15)
	M.Turn(degree)
	animate(A, transform = M, time = 1, loop = -1)
	addtimer(CALLBACK(src, PROC_REF(stop_jiggle), original_matrix), craft_time)

/datum/component/item_crafter/proc/stop_jiggle(matrix/original_matrix)
	var/atom/A = parent
	animate(A)
	A.transform = original_matrix

/datum/component/item_crafter/proc/finish_craft(mob/living/user)
	busy = FALSE
	// Consume ingredients
	for(var/type_path in ingredients_required)
		ingredients_stored[type_path] -= ingredients_required[type_path]
		if(ingredients_stored[type_path] <= 0)
			ingredients_stored -= type_path

	// Create item
	var/obj/item/new_item = new craftable_type(get_turf(parent))
	if(output_dir)
		var/turf/target_turf = get_step(parent, output_dir)
		new_item.throw_at(target_turf, 1, 1)
		user?.balloon_alert(user, "crafted, thrown to [dir2text(output_dir)]!")
		user?.balloon_alert_to_viewers("item crafted, thrown")
	else
		stored_item = new_item
		new_item.forceMove(parent)
		user?.balloon_alert(user, "crafted, click to retrieve!")
		user?.balloon_alert_to_viewers("item crafted")

/datum/component/item_crafter/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	var/atom/craftable = craftable_type
	if(!craftable_type)
		examine_list += span_warning("No craftable item template set!")
		return
	examine_list += span_notice("This crafter produces \a [initial(craftable.name)].")
	if(length(ingredients_required))
		examine_list += span_notice("Required ingredients:")
		for(var/type_path in ingredients_required)
			var/obj/item/I = type_path
			var/amount_needed = ingredients_required[type_path]
			var/amount_stored = ingredients_stored[type_path] || 0
			examine_list += span_notice("- [initial(I.name)]: [amount_stored]/[amount_needed]")
	else
		examine_list += span_warning("No recipe set!")

/obj/effect/mapping_helpers/crafter_recipe
	name = "Item crafter"
	icon_state = "sort_type_helper_sup"
	var/target_crafter_type = /obj/structure
	var/list/ingredients = list()
	var/craft_time = 10 SECONDS
	var/craft_sound = null
	var/sound_volume = 50

/obj/effect/mapping_helpers/crafter_recipe/Initialize(mapload)
	. = ..()
	if(mapload && target_crafter_type)
		if(!ispath(target_crafter_type, /atom))
			log_mapping("[src] at [loc] has invalid target_crafter_type: [target_crafter_type].")
			qdel(src)
			return
		var/atom/target = locate(target_crafter_type) in loc
		if(!target)
			target = new target_crafter_type(loc)
		target.AddComponent(/datum/component/item_crafter, ingredients, craft_time, craft_sound, sound_volume)
	qdel(src)

/obj/effect/mapping_helpers/crafter_output_dir
	name = "crafter output dir helper"
	icon_state = "sort_type_helper_sup"
	var/target_crafter_type = /obj/structure


/obj/effect/mapping_helpers/crafter_output_dir/Initialize(mapload)
	. = ..()
	if(mapload && target_crafter_type)
		if(!ispath(target_crafter_type, /atom))
			log_mapping("[src] at [loc] has invalid target_crafter_type: [target_crafter_type].")
			qdel(src)
			return
		var/atom/target = locate(target_crafter_type) in loc
		if(!target)
			target = new target_crafter_type(loc)
		var/datum/component/item_crafter/C = target.GetComponent(/datum/component/item_crafter)
		if(!C)
			C = target.AddComponent(/datum/component/item_crafter)
		if(C)
			C.output_dir = dir
	qdel(src)


MAPPING_DIRECTIONAL_HELPERS(/obj/effect/mapping_helpers/crafter_output_dir, 0)
