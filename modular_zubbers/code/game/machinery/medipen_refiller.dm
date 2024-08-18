/obj/machinery/medipen_refiller
	///List of medipen subtypes it can refill and the chems needed for it to work.

	var/static/list/moreallowed_pens = list(
		/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate = /datum/reagent/medicine/inacusiate,
		/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate = /datum/reagent/medicine/oculine,
		/obj/item/reagent_containers/hypospray/medipen/deforest/morpital = /datum/reagent/medicine/morphine,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lipital = /datum/reagent/medicine/c2/probital,
		/obj/item/reagent_containers/hypospray/medipen/deforest/meridine = /datum/reagent/medicine/potass_iodide,
		/obj/item/reagent_containers/hypospray/medipen/deforest/synephrine = /datum/reagent/medicine/epinephrine,
		/obj/item/reagent_containers/hypospray/medipen/deforest/calopine = /datum/reagent/medicine/atropine,
		/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants = /datum/reagent/medicine/salglu_solution,
		/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin = /datum/reagent/medicine/antihol,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi = /datum/reagent/medicine/c2/lenturi,
	)

/obj/machinery/medipen_refiller/attackby(obj/item/weapon, mob/user, params)
	if(istype(weapon, /obj/item/reagent_containers/hypospray/medipen))
		var/obj/item/reagent_containers/hypospray/medipen/medipen = weapon
		if(!(LAZYFIND(moreallowed_pens, medipen.type)))
			balloon_alert(user, "medipen incompatible!")
			return
		if(medipen.reagents?.reagent_list.len)
			balloon_alert(user, "medipen full!")
			return
		if(!reagents.has_reagent(moreallowed_pens[medipen.type], 10))
			balloon_alert(user, "not enough reagents!")
			return
		add_overlay("active")
		if(do_after(user, 2 SECONDS, src))
			medipen.used_up = FALSE
			medipen.add_initial_reagents()
			reagents.remove_reagent(moreallowed_pens[medipen.type], 10)
			balloon_alert(user, "refilled")
		cut_overlays()
		return
	return ..()
