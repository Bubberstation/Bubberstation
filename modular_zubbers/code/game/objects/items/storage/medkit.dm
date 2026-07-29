
/obj/item/storage/pill_bottle/lidocaine
	name = "lidocaine pills"
	desc = "A package of local anesthetic medication, used in surgery to numb patients."
	icon = 'modular_zubbers/icons/obj/storage/medkit.dmi'
	icon_state = "lidocaine_box"
	custom_price = PAYCHECK_LOWER * 3
	spawn_type = /obj/item/reagent_containers/applicator/pill/lidocaine
	spawn_count = 7

/obj/item/reagent_containers/applicator/pill/lidocaine
	name = "lidocaine pill"
	desc = "A local anesthetic medication used in surgery to numb patients."
	icon_state = "pill3"
	layers_remaining = 1
	list_reagents = list(
		/datum/reagent/medicine/lidocaine = 17,
		/datum/reagent/consumable/astrotame = 7,
	)
