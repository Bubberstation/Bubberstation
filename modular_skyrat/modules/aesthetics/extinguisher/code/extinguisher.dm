/obj/structure/extinguisher_cabinet
	icon = 'modular_skyrat/modules/aesthetics/extinguisher/icons/extinguisher.dmi'

/obj/item/wallframe/extinguisher_cabinet
	icon = 'modular_skyrat/modules/aesthetics/extinguisher/icons/extinguisher.dmi'

/obj/structure/extinguisher_cabinet/Initialize(mapload, ndir, building)
	. = ..()
	update_icon()
