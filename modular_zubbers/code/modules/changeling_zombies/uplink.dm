/datum/uplink_item/stealthy_weapons/romerol_kit
	name = "Modifiable Changeling Zombie Virus"
	desc = "A highly experimental bioterror agent which creates dormant nodules to be etched into the host. \
		On death, these nodules take control of the dead body, causing the infectious variant of Changeling Zombie virus to manifest. \
		This does not turn you into a real Changeling, just a failed experimental one that can still be useful to spread chaos with. \
		This virus can be modified if you're not too happy with the initial symptoms! Virus food not included."
	item = /obj/item/storage/box/syndie_kit/changeling_zombie
	cost = 25
	purchasable_from = UPLINK_ALL_SYNDIE_OPS
	cant_discount = TRUE

/obj/item/reagent_containers/cup/bottle/changeling_zombie
	name = "Changeling Zombie culture bottle"
	desc = "A small bottle. Contains the infamous Changeling Zombie virus, stolen from a Nanotrasen research facility."
	amount_per_transfer_from_this = 5
	spawned_disease = /datum/disease/advance/changelingzombie

/obj/item/storage/box/syndie_kit/changeling_zombie/PopulateContents()
	new /obj/item/reagent_containers/cup/bottle/changeling_zombie(src)
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/reagent_containers/dropper(src)

