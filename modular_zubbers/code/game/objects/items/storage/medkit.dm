
/obj/item/storage/pill_bottle/lidocaine
	name = "lidocaine pills"
	desc = "A package of local anesthetic medication, used in surgery to numb patients."
	icon = 'modular_zubbers/icons/obj/storage/medkit.dmi'
	icon_state = "lidocaine_box"
	custom_price = PAYCHECK_LOWER * 3

/obj/item/storage/pill_bottle/lidocaine/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/applicator/pill/lidocaine(src)

/obj/item/reagent_containers/applicator/pill/lidocaine
	name = "lidocaine pill"
	desc = "A local anesthetic medication used in surgery to numb patients."
	icon_state = "pill3"
	layers_remaining = 1
	list_reagents = list(
		/datum/reagent/medicine/lidocaine = 17,
		/datum/reagent/consumable/astrotame = 7,
	)
