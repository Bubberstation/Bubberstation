/datum/voucher_set/mining/bunny
	name = "Bunny Kit"
	description = "Designed for Miners on the planet of Carota, this kit includes all you need to imitate them! Weapons sold seperately."
	icon = 'icons/mob/simple/rabbit.dmi'
	icon_state = "rabbit_white"
	set_items = list(
		/obj/item/storage/backpack/duffelbag/mining_bunny,
		/obj/item/knife/shiv/carrot,
		/obj/item/storage/lunchbox/bunny/carrot,
		)


/obj/item/storage/lunchbox/bunny/carrot
	name = "carrot lunchbox"
	desc = "Who needs Mesons?"

/obj/item/storage/lunchbox/bunny/carrot/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/food/grown/carrot(src)

