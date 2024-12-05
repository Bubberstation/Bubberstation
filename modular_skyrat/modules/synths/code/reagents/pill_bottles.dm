// Pill bottles for synthetic healing medications
/obj/item/storage/pill_bottle/liquid_solder
	name = "bottle of liquid solder pills"
	desc = "Contains pills used to treat synthetic brain damage."

/obj/item/storage/pill_bottle/liquid_solder/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/liquid_solder(src)

// Contains 4 liquid_solder pills instead of 7, and 10u pills instead of 50u.
// 50u pills heal 375 brain damage, 10u pills heal 75.
/obj/item/storage/pill_bottle/liquid_solder/braintumor
	desc = "Contains diluted pills used to treat synthetic brain damage symptoms. Take one when feeling lightheaded."

/obj/item/storage/pill_bottle/liquid_solder/braintumor/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/pill/liquid_solder/braintumor(src)

/obj/item/storage/pill_bottle/nanite_slurry
	name = "bottle of concentrated nanite slurry pills"
	desc = "Contains nanite slurry pills used for <b>critical system repair</b> to induce an overdose in a synthetic to repair organs."

/obj/item/storage/pill_bottle/nanite_slurry/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/nanite_slurry(src)

/obj/item/storage/pill_bottle/system_cleaner
	name = "bottle of system cleaner pills"
	desc = "Contains pills used to detoxify synthetic bodies."

/obj/item/storage/pill_bottle/system_cleaner/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/system_cleaner(src)

/obj/item/storage/pill_bottle/lidocaine
	name = "lidocaine pill bottle"
	desc = "A bottle of nonsteroidal anti-inflammatory pills, used in surgery to numb patients."
	custom_price = PAYCHECK_LOWER

/obj/item/storage/pill_bottle/lidocaine/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/lidocaine(src)

/obj/item/reagent_containers/pill/lidocaine
	name = "lidocaine pill"
	desc = "A strong, nonsteroidal anti-inflammatory drug used in surgery to numb patients."
	icon_state = "pill3"
	list_reagents = list(
		/datum/reagent/medicine/lidocaine = 17,
		/datum/reagent/consumable/astrotame = 7,
	)
