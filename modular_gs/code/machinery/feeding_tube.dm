/obj/machinery/iv_drip
	/// What is the name of the thing being attached to the mob?
	var/attachment_point = "needle"


/obj/machinery/iv_drip/feeding_tube
	name = "\improper Feeding tube"
	desc = "Originally meant to automatically feed cattle and farm animals, this model was repurposed for more... personal usage."
	icon = 'modular_gs/icons/obj/feeding_tube.dmi'
	base_icon_state = "feeding_tube"
	icon_state = "feeding_tube"
	var/static/list/food_containers = typecacheof(list(/obj/item/food,
									/obj/item/reagent_containers))
	attachment_point = "tube"

/obj/machinery/iv_drip/feeding_tube/toggle_mode()
	return FALSE

/obj/machinery/iv_drip/feeding_tube/process(seconds_per_tick)
	if(!attachment)
		return PROCESS_KILL

	var/atom/attached_to = attachment.attached_to

	if(!(get_dist(src, attached_to) <= 1 && isturf(attached_to.loc)))
		visible_message(span_warning("[attached_to] is detached from [src]."))
		detach_iv()
		return PROCESS_KILL

	var/datum/reagents/drip_reagents = get_reagents()
	if(!drip_reagents)
		return PROCESS_KILL

	if(!transfer_rate || drip_reagents.total_volume)
		return

	// Give reagents
	drip_reagents.trans_to(attached_to, transfer_rate * seconds_per_tick, methods = INJECT, show_message = FALSE) //make reagents reacts, but don't spam messages
	update_appearance(UPDATE_ICON)


/obj/machinery/iv_drip/feeding_tube/attackby(obj/item/W, mob/user, params)

//it sure is a solution.
/obj/machinery/iv_drip/feeding_tube/toggle_mode()
	return FALSE
