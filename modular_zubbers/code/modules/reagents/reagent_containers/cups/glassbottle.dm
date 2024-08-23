/obj/item/reagent_containers/cup/glass/bottle/beer/starwine
	name = "starwire wine bottle"
	desc = "A fusion of cheap wine, liquefied candy and stimulants that will give you a kickstart."
	icon = 'modular_zubbers/icons/obj/drinks/bottles.dmi'
	icon_state = "wine"
	volume = 30
	list_reagents = list(/datum/reagent/consumable/ethanol/wine = 30)

/obj/item/reagent_containers/cup/glass/bottle/ornate	//Donator item exclusive for Blovy. Sprited by Casey/Keila.
	name = "ornate bottle"
	desc = "A very large bottle with very ornate decorations on the sides. It is easy to hold, with the top having a moon shaped cork."
	icon = 'modular_zubbers/icons/obj/drinks/bottles.dmi'
	icon_state = "ornate"
	volume = 100
	fill_icon = 'modular_zubbers/icons/obj/medical/reagent_fillings.dmi'
	fill_icon_state = "ornate"
	fill_icon_thresholds = list(0, 10, 20, 30, 40, 50, 60, 70, 80, 90)
