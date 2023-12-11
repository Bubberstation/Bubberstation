/obj/machinery/power/supermatter_crystal/Initialize(mapload)
	. = ..()
	if(check_holidays(FESTIVE_SEASON) && (type == /obj/machinery/power/supermatter_crystal || type == /obj/machinery/power/supermatter_crystal/engine))
		christmasify()

/obj/machinery/power/supermatter_crystal/proc/christmasify()
	name = "Smassmatter crystal"
	desc += "\nThis one seems to be decorated with Christmas lights"
	add_overlay(image('modular_zubbers/modules/seasons/christmas/icons/supermatter.dmi', "sm-overlay-christmas-lights"))
	RegisterSignal(src, COMSIG_ATOM_ATTACKBY, PROC_REF(christmasify_attackby))

/obj/machinery/power/supermatter_crystal/proc/christmasify_attackby(datum/source, obj/item/item, mob/living/user)
	SIGNAL_HANDLER
	if(istype(item, /obj/item/clothing/head/costume/skyrat/christmas))
		balloon_alert(user, "Placed hat.")
		QDEL_NULL(item)
		add_overlay(image('modular_zubbers/modules/seasons/christmas/icons/supermatter.dmi', "sm-overlay-christmas-hat"))
		desc += "\n\nThere's a Christmas hat placed atop it. How it got there and why it didn't dust yet is a mystery"
		update_overlays()
		return COMPONENT_CANCEL_ATTACK_CHAIN
	return FALSE
