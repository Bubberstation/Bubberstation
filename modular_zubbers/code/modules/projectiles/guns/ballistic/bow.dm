
/obj/item/gun/ballistic/bow/security
	name = "hardlight bow"
	desc = "A classic shortbow design, upgraded with carbon fiber structure and a hardlight bowstring. Elegant to use, though undeniably still a bit antiquated. \
	Offers heightened armor penetration and wounding potential than the older variants."
	icon = 'modular_zubbers/code/modules/security/icons/bow.dmi'
	icon_state = "hardlightbow"
	inhand_icon_state = "bow_hardlight"
	base_icon_state = "hardlightbow"

/obj/item/gun/ballistic/bow/security/Initialize(mapload)
	. = ..()

	ADD_TRAIT(src, TRAIT_POWERFUL_BOW, REF(src))
