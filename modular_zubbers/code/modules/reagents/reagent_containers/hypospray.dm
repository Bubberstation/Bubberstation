/obj/item/reagent_containers/hypospray/medipen/synthcare
	name = "Small Synthetic Care Pen"
	desc = "A single use applicator made to care for synthetic parts, be it a single prosthetic or an IPC. <b> WARNING : DO NOT APPLY A SECOND APPLICATOR UNTIL FIRST HAS FULLY PROCESSED. FAILURE TO FOLLOW INSTRUCTIONS CAN PROVE HAZARDOUS TO SYNTHETICS. DOES NOT WORK ON CYBORGS. DO NOT MIX WITH ADVANCED NANITE SLURRY.</b>"
	icon_state = "syndipen"
	base_icon_state = "syndipen"
	amount_per_transfer_from_this = 9
	volume = 9
	list_reagents = list(/datum/reagent/medicine/nanite_slurry = 9)

/obj/item/reagent_containers/hypospray/medipen/survival/synthcare
	name = "Advanced Synthetic Care Pen"
	desc = "A single use applicator made to rapidly fix urgent damage to synthetic parts on the go in low pressure enviorments and provide a small speed boost. Contains chemicals that are safe but otherwise worthless for organics. <b> WARNING : DO NOT APPLY A SECOND APPLICATOR UNTIL FIRST HAS FULLY PROCESSED. FAILURE TO FOLLOW INSTRUCTIONS IS GURANTEED TO BE LETHAL TO SYNTHETICS. DOES NOT WORK ON CYBORGS. UNDER NO CIRCUMSTANCES IS THIS TO BE MIXED WITH BASIC NANITE SLURRY (FOUND IN THE SMALL SYNTHETIC CARE PEN)</b>"
	icon_state = "nanite_hypo"
	base_icon_state = "nanite_hypo"
	amount_per_transfer_from_this = 20
	volume = 20
	list_reagents = list(/datum/reagent/medicine/nanite_slurry/strong = 9, /datum/reagent/medicine/c2/penthrite = 10)


/obj/item/reagent_containers/hypospray/medipen/survival/luxury/slime
	name = "luxury slime medipen"
	desc = "Cutting edge bluespace technology allowed Nanotrasen to compact 70u of volume into a single medipen. Contains rare and powerful chemicals used by slime-like crew to aid in exploration of very hard environments. WARNING: DO NOT MIX WITH EPINEPHRINE OR ATROPINE NOR INJECT INTO NON-SLIME CREW."
	icon_state = "luxpen"
	inhand_icon_state = "atropen"
	base_icon_state = "luxpen"
	volume = 70
	amount_per_transfer_from_this = 70
	list_reagents = list(/datum/reagent/medicine/salbutamol = 10, /datum/reagent/medicine/c2/penthrite = 10, /datum/reagent/medicine/oxandrolone = 10, /datum/reagent/medicine/sal_acid = 10, /datum/reagent/toxin = 5, /datum/reagent/medicine/leporazine = 10)
