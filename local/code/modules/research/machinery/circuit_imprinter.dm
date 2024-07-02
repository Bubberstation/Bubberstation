/// This isn't actually a feature of the Broadcast Studio on Effigy; but I felt it prudent that because we're not porting over the job (to prevent savefile bloat),
/// We should also not hand out free gamer tools to anyone and everyone.
/obj/machinery/rnd/production/circuit_imprinter/offstation/but_actually_not_just_unlinked_and_less_cool/Initialize(mapload)
	. = ..()
	materials.disconnect_from(materials.silo) // Makes it significantly harder to abuse the out-and-open lathe for AI parts and the like.
