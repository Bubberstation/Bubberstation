/obj/machinery/iv_drip
	/// What is the name of the thing being attached to the mob?
	var/attachment_point = "needle"


/obj/machinery/iv_drip/feeding_tube
	name = "\improper Feeding tube"
	desc = "Originally meant to automatically feed cattle and farm animals, this model was repurposed for more... personal usage."
	icon = 'GainStation13/icons/obj/feeding_tube.dmi'
	icon_state = "feeding_tube"
	var/static/list/food_containers = typecacheof(list(/obj/item/reagent_containers/food,
									/obj/item/reagent_containers/glass,))
	attachment_point = "tube"

/obj/machinery/iv_drip/feeding_tube/update_icon()
	if(attached)
		if(mode)
			icon_state = "injecting"
	else
		if(mode)
			icon_state = "injectidle"

	cut_overlays()

	if(beaker)
		if(attached)
			add_overlay("beakeractive")
		else
			add_overlay("beakeridle")
		if(beaker.reagents.total_volume)
			var/mutable_appearance/filling_overlay = mutable_appearance('GainStation13/icons/obj/feeding_tube.dmi', "reagent")

			var/percent = round((beaker.reagents.total_volume / beaker.volume) * 100)
			switch(percent)
				if(0 to 9)
					filling_overlay.icon_state = "reagent0"
				if(10 to 24)
					filling_overlay.icon_state = "reagent10"
				if(25 to 49)
					filling_overlay.icon_state = "reagent25"
				if(50 to 74)
					filling_overlay.icon_state = "reagent50"
				if(75 to 79)
					filling_overlay.icon_state = "reagent75"
				if(80 to 90)
					filling_overlay.icon_state = "reagent80"
				if(91 to INFINITY)
					filling_overlay.icon_state = "reagent100"

			filling_overlay.color = mix_color_from_reagents(beaker.reagents.reagent_list)
			add_overlay(filling_overlay)

/obj/machinery/iv_drip/feeding_tube/process()
	if(!attached)
		return PROCESS_KILL

	if(!(get_dist(src, attached) <= 1 && isturf(attached.loc)))
		to_chat(attached, "<span class='userdanger'>The feeding hose is yanked out of you!</span>")
		update_icon()
		return PROCESS_KILL

	if(beaker)
		if(mode)
			if(beaker.reagents.total_volume)
				// Check to see if the person is wearing a bluespace collar
				var/obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter/K = 0
				if(istype(attached, /mob/living/carbon/human))
					var/mob/living/carbon/human/human_eater = attached
					K = human_eater.wear_neck
				var/transfer_amount = 5
				if (!(istype(K, /obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter) && K.transpose_feeding(transfer_amount, beaker, attached))) //If wearing a BS collar, use BS proc. If not, continue as normal
					var/fraction = min(transfer_amount/beaker.reagents.total_volume, 1) //the fraction that is transfered of the total volume
					beaker.reagents.reaction(attached, INJECT, fraction, FALSE) //make reagents reacts, but don't spam messages
					beaker.reagents.trans_to(attached, transfer_amount)
					attached.fullness += transfer_amount //Added feeding tube's causing fullness (But ignores limits~)
				update_icon()

			else if(!beaker.reagents.total_volume && istype(beaker, /obj/item/reagent_containers/food))
				qdel(beaker)
				beaker = null
				if(attached)
					attached = null
					update_icon()

				return PROCESS_KILL

/obj/machinery/iv_drip/feeding_tube/attackby(obj/item/W, mob/user, params)
	if(is_type_in_typecache(W, food_containers))
		if(beaker)
			to_chat(user, "<span class='warning'>There is already a reagent container loaded!</span>")
			return
		if(!user.transferItemToLoc(W, src))
			return
		beaker = W
		to_chat(user, "<span class='notice'>You attach [W] to [src].</span>")
		user.log_message("attached a [W] to [src] at [AREACOORD(src)] containing ([beaker.reagents.log_list()])", LOG_ATTACK)
		add_fingerprint(user)
		update_icon()
		return
	else
		return FALSE


//it sure is a solution.
/obj/machinery/iv_drip/feeding_tube/toggle_mode()
	return FALSE
