/obj/item/nullrod/whip/Initialize(mapload)
	. = ..()
	// 1.3 * 18 = 23.4 per hit
	AddElement(/datum/element/bane, mob_biotypes = MOB_VAMPIRIC, damage_multiplier = 0.3)

