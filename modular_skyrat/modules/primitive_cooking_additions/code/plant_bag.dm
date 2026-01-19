#define RESKIN_LINEN "Linen"

/obj/item/storage/bag/plants/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/plant_bag)

/datum/atom_skin/plant_bag
	abstract_type = /datum/atom_skin/plant_bag

/datum/atom_skin/plant_bag/original
	preview_name = "Original"
	new_icon = 'icons/obj/service/hydroponics/equipment.dmi'
	new_icon_state = "plantbag"
	new_worn_icon = 'icons/mob/clothing/belt.dmi'

/datum/atom_skin/plant_bag/linen
	preview_name = RESKIN_LINEN
	new_icon = 'modular_skyrat/modules/primitive_cooking_additions/icons/plant_bag.dmi'
	new_icon_state = "plantbag_primitive"
	new_worn_icon = 'modular_skyrat/modules/primitive_cooking_additions/icons/plant_bag_worn.dmi'

// This is so the linen reskin shows properly in the suit storage.
/obj/item/storage/bag/plants/build_worn_icon(default_layer, default_icon_file, isinhands, female_uniform, override_state, override_file, mutant_styles)
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	if(default_layer == SUIT_STORE_LAYER)
		for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
			if(reskin_component.is_using_skin(/datum/atom_skin/plant_bag/linen))
				override_file = 'modular_skyrat/modules/primitive_cooking_additions/icons/plant_bag_worn_mirror.dmi'
				break
	return ..()

/// Simple helper to reskin this item into its primitive variant.
/obj/item/storage/bag/plants/proc/make_primitive()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)

	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		reskin_component.set_skin_by_name(RESKIN_LINEN)

/// A helper for the primitive variant, for mappers.
/obj/item/storage/bag/plants/primitive
	icon = 'modular_skyrat/modules/primitive_cooking_additions/icons/plant_bag.dmi'
	icon_state = "plantbag_primitive"
	worn_icon = 'modular_skyrat/modules/primitive_cooking_additions/icons/plant_bag_worn.dmi'
	worn_icon_state = "plantbag_primitive"

/obj/item/storage/bag/plants/primitive/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/storage/bag/plants/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	if(!isprimitivedemihuman(crafter) && !isashwalker(crafter))
		return
	make_primitive()

/obj/item/storage/bag/plants/portaseeder/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

#undef RESKIN_LINEN
