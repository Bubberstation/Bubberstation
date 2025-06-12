/obj/item/scalpel
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"korve" = list(
		RESKIN_ICON = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "scalpel",
		),
		"default" = list(
		RESKIN_ICON = 'icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "scalpel",
		),
	)

/obj/item/circular_saw
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"korve" = list(
		RESKIN_ICON = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "saw",
		),
		"default" = list(
		RESKIN_ICON = 'icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "saw",
		),
	)

/obj/item/surgical_drapes
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"korve" = list(
		RESKIN_ICON = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "drapes",
		),
		"default" = list(
		RESKIN_ICON = 'icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "drapes",
		),
	)

/obj/item/retractor
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"korve" = list(
		RESKIN_ICON = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "retractor",
		),
		"default" = list(
		RESKIN_ICON = 'icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "retractor",
		),
	)

/obj/item/hemostat
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"korve" = list(
		RESKIN_ICON = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "hemostat",
		),
		"default" = list(
		RESKIN_ICON = 'icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "hemostat",
		),
	)

/obj/item/cautery
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"korve" = list(
		RESKIN_ICON = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "cautery",
		),
		"default" = list(
		RESKIN_ICON = 'icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "cautery",
		),
	)

/obj/item/blood_filter
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"korve" = list(
		RESKIN_ICON = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "bloodfilter",
		),
		"default" = list(
		RESKIN_ICON = 'icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "bloodfilter",
		),
	)

/obj/item/surgicaldrill
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"korve" = list(
		RESKIN_ICON = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "drill",
		),
		"default" = list(
		RESKIN_ICON = 'icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "drill",
		),
	)

/obj/item/bonesetter
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"korve" = list(
		RESKIN_ICON = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "bonesetter",
		),
		"default" = list(
		RESKIN_ICON = 'icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "bonesetter",
		),
	)

/obj/item/retractor/advanced
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"korve" = list(
		RESKIN_ICON = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "adv_retractor",
		),
		"default" = list(
		RESKIN_ICON = 'icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "adv_retractor",
		),
	)

/obj/item/scalpel/advanced
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"korve" = list(
		RESKIN_ICON = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "e_scalpel",
		),
		"default" = list(
		RESKIN_ICON = 'icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "e_scalpel",
		),
	)

/obj/item/cautery/advanced
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"korve" = list(
		RESKIN_ICON = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "e_cautery",
		),
		"default" = list(
		RESKIN_ICON = 'icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "e_cautery",
		),
	)

/obj/item/blood_filter/advanced
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"korve" = list(
		RESKIN_ICON = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi',
		RESKIN_ICON_STATE = "combitool",
		),
		"default" = list(
		RESKIN_ICON = 'modular_skyrat/modules/filtersandsetters/icons/surgery_tools.dmi',
		RESKIN_ICON_STATE = "combitool",
		),
	)

//Cruel Tools

/obj/item/surgicaldrill/cruel
	desc = "What secrets do they keep buried within those pearls..."
	icon_state = "crueldrill"
	icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT


/obj/item/circular_saw/cruel
	desc = "A twisted blade for twisted purpose. Rip sinew and bone until your work is done."
	icon_state = "cruelsaw"
	icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'
	lefthand_file = 'modular_zubbers/icons/obj/medical/cruelsaw_l.dmi'
	righthand_file = 'modular_zubbers/icons/obj/medical/cruelsaw_r.dmi'
	inhand_icon_state = "cruelsaw"
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/bonesetter/cruel
	name = "bonesetter"
	desc = "We shall make you whole once more..."
	icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/blood_filter/cruel
	name = "malignant blood filter"
	desc = "For filtering the blood."
	icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/autopsy_scanner/cruel
	name = "twisted autopsy scanner"
	desc = "Used in surgery to extract information from a cadaver. Can also scan the health of cadavers like an advanced health analyzer!"
	icon = 'icons/obj/devices/scanner.dmi'
	worn_icon = 'modular_zubbers/icons/obj/clothing/belt.dmi'
	icon_state = "cruelautopsy"
	inhand_icon_state = "cruelautopsy"
	worn_icon_state = "cruelautopsy"
	lefthand_file = 'modular_zubbers/icons/obj/medical/cruelautopsy_l.dmi'
	righthand_file = 'modular_zubbers/icons/obj/medical/cruelautopsy_r.dmi'
	item_flags = CRUEL_IMPLEMENT

//Cruel tools for the morbid surgical implant

/obj/item/retractor/cruel/augment
	desc = "A twisted micro-mechanical manipulator for retracting stuff."
	toolspeed = 0.5


/obj/item/hemostat/cruel/augment
	desc = "Tiny, warped servos power a pair of pincers to stop bleeding."
	toolspeed = 0.5


/obj/item/cautery/cruel/augment
	desc = "Chalk this one up as another successful vivisection."
	toolspeed = 0.5


/obj/item/scalpel/cruel/augment
	desc = "Ultra-sharp blade attached directly to your bone for enhanced vivisection."
	toolspeed = 0.5

/obj/item/surgicaldrill/cruel/augment
	desc = "What secrets do they keep buried within those pearls..."
	hitsound = 'sound/items/weapons/circsawhit.ogg'
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 0.5

/obj/item/circular_saw/cruel/augment
	desc = "A twisted blade for twisted purpose. Rip sinew and bone until your work is done."
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 0.5
