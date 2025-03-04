

/obj/item/construction/medical
	name = "medical grade rapid-construction-device (RCD)"
	icon_state = "plumberer2"
	inhand_icon_state = "plumberer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	worn_icon_state = "plumbing"
	icon = 'icons/obj/tools.dmi'
	slot_flags = ITEM_SLOT_BELT
	banned_upgrades = RCD_ALL_UPGRADES & ~RCD_UPGRADE_SILO_LINK
	matter = 200
	max_matter = 200
	drop_sound = 'sound/items/handling/tools/rcd_drop.ogg'
	pickup_sound = 'sound/items/handling/tools/rcd_pickup.ogg'
	sound_vary = TRUE
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 50)
	var/design_title
	var/obj/item/reagent_containers/cup/beaker
	var/list/static/limbs_possible = list(
		/obj/item/bodypart/leg/right,
		/obj/item/bodypart/leg/left,
		/obj/item/bodypart/arm/right,
		/obj/item/bodypart/arm/left,
		/obj/item/bodypart/head,
		/obj/item/organ/external/tail,
		/obj/item/organ/external/spines,
		/obj/item/organ/external/wings,
		/obj/item/organ/external/horns,
		/obj/item/organ/external/frills,
		/obj/item/organ/external/snout,
		/obj/item/organ/external/tail/lizard,
		/obj/item/organ/external/antennae,
		/obj/item/organ/external/wings/moth,
		/obj/item/organ/internal/ears/cat,
		/obj/item/organ/external/tail/cat,

		)

	/Initialize(mapload)

	.=..()


	/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
		SHOULD_CALL_PARENT(TRUE)
		if(istype(interacting_with, /obj/item/rcd_upgrade))
			install_upgrade(interacting_with, user)
			return ITEM_INTERACT_SUCCESS
		if(insert_matter(interacting_with, user))
			return ITEM_INTERACT_SUCCESS
		return ..()


	/ui_data(mob/user)
		var/list/data = list()

		//matter in the rcd

			var/list/data = list()

		for(var/datum/reagent/reagent_id in beaker.reagents.reagent_list)
			var/list/reagent_data = list(
				reagent_name = reagent_id.name,
				reagent_amount = reagent_id.volume,
				reagent_type = reagent_id.type
			)
			data["reagents"] += list(reagent_data)

			data["total_reagents"] = reagents.total_volume
			data["max_reagents"] = reagents.maximum_volume
			data["selected_design"] =

			var/list/designs = list() //initialize all designs under this category
			for(var/atom/movable/design as anything in limbs_possible)
				var/atom/movable/design_path = design

				var/design_name = initial(design_path.name)

				designs += list(list("title" = design_name, "icon" = sanitize_css_class_name(design_name)))

			data += list("designs" = designs)
			data["selected_design"] = design_title

		return data

	/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
		. = ..()
		if(.)
			return

		if(action == "design")
			toggle_silo(ui.user)
			return TRUE

		var/update = handle_ui_act(action, params, ui, state)
		if(isnull(update))
			update = FALSE
		return update

	/ui_interact(mob/user, datum/tgui/ui)
		ui = SStgui.try_update_ui(user, src, ui)
		if(!ui)
			ui = new(user, src, "bubbermedrcd", name)
			ui.open()
