/obj/item/flatpack/export_gate
	name = "bounty cube export gate"
	board = /obj/item/circuitboard/machine/export_gate
	custom_premium_price = PAYCHECK_CREW * 1.5

/obj/item/flatpack/export_gate/Initialize(mapload)
	. = ..()
	var/turf/our_turf = get_turf(src)
	new /obj/item/paper/fluff/export_gate(our_turf)

/obj/item/flatpack/export_gate/multitool_act(mob/living/user, obj/item/tool)
	if(isturf(loc))
		var/turf/location = loc
		if(!locate(/obj/machinery/conveyor) in location)
			balloon_alert(user, "needs conveyor belt!")
			return ITEM_INTERACT_BLOCKING

	return ..()
