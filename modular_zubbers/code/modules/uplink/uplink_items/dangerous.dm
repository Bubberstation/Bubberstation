/datum/uplink_item/dangerous/advanced_energy_katana
	name = "Advanced Energy Katana"
	desc = "An advanced energy katana that was totally not stolen and repurposed from a ninja research facility. Nope."
	progression_minimum = 30 MINUTES
	item = /obj/item/energy_katana/advanced

	cost = 16  //Cost of syndicate advanced teleporter (8) plus an energy sword (8). Funny enough, this is the same cost as a dsword.
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS) //Don't want ops teleporting like crazy.
	cant_discount = TRUE //Until this is balanced, no funny discounts.
	refundable = TRUE //Prototype item that people might not like.