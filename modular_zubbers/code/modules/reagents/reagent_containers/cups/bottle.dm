/obj/item/reagent_containers/cup/bottle/large
	name = "large bottle"
	desc = "A large bottle."
	icon = 'modular_zubbers/icons/obj/medical/chemical.dmi'
	icon_state = "bottle_large"
	fill_icon = 'modular_zubbers/icons/obj/medical/reagent_fillings.dmi'
	fill_icon_state = "bottle_large"
	possible_transfer_amounts = list(5, 10, 15, 25, 50, 100)
	volume = 100

/obj/item/reagent_containers/cup/bottle/large/Initialize(mapload)
	. = ..()
	if(!icon_state)
		icon_state = "bottle_large"
	update_appearance()

/obj/item/reagent_containers/cup/bottle/medi

/obj/item/reagent_containers/cup/bottle/plushmium
	name = "plushmium bottle"
	desc = "A small bottle of plushmium."
	icon = 'icons/obj/medical/chemical.dmi'
	list_reagents = list(/datum/reagent/plushmium = 30)

/obj/item/reagent_containers/cup/bottle/forgorine
	name = "forgorine bottle"
	desc = "A small bottle, loaded with forgorine. Combine with knockout drugs, high dose of alcohol or severe beating."
	icon = 'icons/obj/medical/chemical.dmi'
	list_reagents = list(/datum/reagent/forgorine = 50)
