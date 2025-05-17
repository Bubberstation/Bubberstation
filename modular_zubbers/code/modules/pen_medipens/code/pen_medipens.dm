// why it's a subtype of deforest medipens? so I don't have to rewrite injection code...
/obj/item/reagent_containers/hypospray/medipen/deforest/pen_medipen
	name = "pen injector"
	desc = "The pen injector is an open-source copy of the medipen system - It focuses on simplicity, safety and cheapness of production, which can be seen from the less-compact design; It's purpose is to ease manufactoring, skirt patents and ensure safety even with untrained personnel by retracting the needle after use, and requiring a more deliberate pen-like grip."
	icon = 'modular_zubbers/code/modules/pen_medipens/icons/pen_medipens.dmi'
	icon_state = "default"
	base_icon_state = "default"
	volume = 25
	fill_icon = 'modular_zubbers/code/modules/pen_medipens/icons/fill_overlay.dmi'
	fill_icon_state = "tank"
	fill_icon_thresholds = list(0,1)
	adjust_color_contrast = FALSE
	list_reagents = list()
	custom_price = 0
	/// If this pen has a timer for injecting others with, just for safety with some of the drugs in these (actually to stop people from gaming too hard)
	inject_others_time = 1.5 SECONDS

/obj/item/reagent_containers/hypospray/medipen/deforest/pen_medipen/Initialize(mapload)
	. = ..()
	update_appearance()
	label_text = span_notice("There is a sticker pasted onto the side which reads, 'WARNING: This medipen contains [pretty_string_from_reagent_list(reagents.reagent_list, names_only = TRUE, join_text = ", ", final_and = TRUE, capitalize_names = TRUE)], do not use if allergic to any listed chemicals.")


/obj/item/reagent_containers/hypospray/medipen/deforest/pen_medipen/brute
	base_icon_state = "brute"
	icon_state = "brute"

/obj/item/reagent_containers/hypospray/medipen/deforest/pen_medipen/burn
	base_icon_state = "burn"
	icon_state = "burn"

/obj/item/reagent_containers/hypospray/medipen/deforest/pen_medipen/tox
	base_icon_state = "tox"
	icon_state = "tox"

/obj/item/reagent_containers/hypospray/medipen/deforest/pen_medipen/oxy
	base_icon_state = "oxy"
	icon_state = "oxy"

/obj/item/reagent_containers/hypospray/medipen/deforest/pen_medipen/red
	base_icon_state = "red"
	icon_state = "red"

// doctor, doctor, we must break into the patient's house
/obj/item/reagent_containers/hypospray/medipen/deforest/pen_medipen/medical
	base_icon_state = "medicinedrug"
	icon_state = "medicinedrug"
