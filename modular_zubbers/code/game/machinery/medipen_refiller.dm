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
