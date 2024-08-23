//For nolog PR #1116
/obj/item/pipe/Initialize(mapload)
	flags_1 |= SUPERMATTER_NOLOGS_1
	. = ..()
