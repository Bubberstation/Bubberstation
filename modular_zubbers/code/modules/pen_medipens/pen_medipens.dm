// why it's a subtype of deforest medipens? so I don't have to rewrite injection code...
/obj/item/reagent_containers/hypospray/medipen/deforest/printable
	name = "pen injector"
	desc = "The pen injector is an open-source copy of the medipen system - It's less compact design eases mass production, and ensures safety even with untrained personnel by retracting the needle after use, while requiring a more deliberate pen-like grip."
	icon = 'modular_zubbers/icons/obj/medical/pen_medipens/pen_medipens.dmi'
	icon_state = "default"
	base_icon_state = "default"
	volume = 12
	fill_icon = 'modular_zubbers/icons/obj/medical/pen_medipens/fill_overlay.dmi'
	fill_icon_state = "tank"
	fill_icon_thresholds = list(0,1)
	adjust_color_contrast = FALSE
	list_reagents = list()
	custom_price = 0
	/// If this pen has a timer for injecting others with, just for safety with some of the drugs in these (actually to stop people from gaming too hard)
	inject_others_time = 1.5 SECONDS
	no_sticker = TRUE
	reagent_flags = TRANSPARENT

/obj/item/reagent_containers/hypospray/medipen/deforest/printable/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/reagent_containers/hypospray/medipen/deforest/printable/brute
	base_icon_state = "brute"
	icon_state = "brute"

/obj/item/reagent_containers/hypospray/medipen/deforest/printable/burn
	base_icon_state = "burn"
	icon_state = "burn"

/obj/item/reagent_containers/hypospray/medipen/deforest/printable/tox
	base_icon_state = "tox"
	icon_state = "tox"

/obj/item/reagent_containers/hypospray/medipen/deforest/printable/oxy
	base_icon_state = "oxy"
	icon_state = "oxy"

/obj/item/reagent_containers/hypospray/medipen/deforest/printable/red
	base_icon_state = "red"
	icon_state = "red"

// doctor, doctor, we must break into the patient's house
/obj/item/reagent_containers/hypospray/medipen/deforest/printable/medical
	base_icon_state = "medicinedrug"
	icon_state = "medicinedrug"
