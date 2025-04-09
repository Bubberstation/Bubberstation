/obj/item/reagent_containers/cup/beaker
	desc = "A beaker. It can hold up to 60 units."
	volume = 60
	possible_transfer_amounts = list(5,10,15,20,30,60)

/obj/item/reagent_containers/cup/beaker/synthflesh
	list_reagents = list(/datum/reagent/medicine/c2/synthflesh = 60)
	list_reagents_purity = 1

/obj/item/reagent_containers/cup/beaker/large
	desc = "A large beaker. Can hold up to 120 units."
	volume = 120
	possible_transfer_amounts = list(5,10,15,20,30,40,60,120)

/obj/item/reagent_containers/cup/beaker/plastic
	desc = "An extra-large beaker. Can hold up to 150 units."
	volume = 150
	possible_transfer_amounts = list(5,10,15,20,25,30,50,75,150)

/obj/item/reagent_containers/cup/beaker/noreact
	desc = "A cryostasis beaker that allows for chemical storage without reactions. Can hold up to 60 units."
	volume = 60
	possible_transfer_amounts = list(5,10,15,20,30,60)
