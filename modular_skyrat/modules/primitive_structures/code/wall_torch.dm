/obj/structure/wall_torch
	name = "mounted torch"
	desc = "A simple torch mounted to the wall, for lighting and such."
	icon = 'modular_skyrat/modules/primitive_structures/icons/lighting.dmi'
	icon_state = "walltorch"
	base_icon_state = "walltorch"
	anchored = TRUE
	density = FALSE
	light_color = LIGHT_COLOR_FIRE
	/// is the bonfire lit?
	var/burning = FALSE
	/// Does this torch spawn pre-lit?
	var/spawns_lit = FALSE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/wall_torch, 28)

/obj/structure/wall_torch/Initialize(mapload)
	. = ..()
	if(spawns_lit)
		light_it_up()
	if(mapload)
		find_and_mount_on_atom()

/obj/structure/wall_torch/attackby(obj/item/used_item, mob/living/user, params)
	if(used_item.get_temperature())
		light_it_up()
	else
		return ..()

/obj/structure/wall_torch/fire_act(exposed_temperature, exposed_volume)
	light_it_up()

/// Sets the torch's icon to burning and sets the light up
/obj/structure/wall_torch/proc/light_it_up()
	icon_state = "[base_icon_state]_on"
	burning = TRUE
	set_light(4)
	update_appearance(UPDATE_ICON)

/obj/structure/wall_torch/extinguish()
	. = ..()
	if(!burning)
		return
	icon_state = base_icon_state
	burning = FALSE
	set_light(0)
	update_appearance(UPDATE_ICON)

/obj/structure/wall_torch/spawns_lit
	spawns_lit = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/wall_torch/spawns_lit, 28)

/datum/crafting_recipe/wall_torch
	name = "Wall Torch"
	result = /obj/item/wallframe/torch
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 2,
		/obj/item/stack/sheet/iron = 1,
		/obj/item/stack/sheet/cloth = 1,
	)
	time = 5 SECONDS
	category = CAT_STRUCTURE

/obj/item/wallframe/torch
	name = "wall mounted torch"
	desc = "A simple torch ready to be mounted to the wall, for lighting and such. Apply to wall to use."
	icon = 'modular_skyrat/modules/primitive_structures/icons/lighting.dmi'
	icon_state = "walltorch"
	result_path = /obj/structure/wall_torch
	pixel_shift = 28
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2, /datum/material/iron = SHEET_MATERIAL_AMOUNT)
