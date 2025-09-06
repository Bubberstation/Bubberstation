/obj/structure/closet/crate/secure/loot/luna_energy_upgrade
	name = "\improper B&C-Lock high-security crate"
	desc = "Secure your research materials with this ingenious \"new\" method: a game of bulls and cows. Guaranteed to explode if you look at it funny!"
	icon_state = "scisecurecrate"
	base_icon_state = "scisecurecrate"

/obj/structure/closet/crate/secure/loot/luna_energy_upgrade/spawn_loot()
	new /obj/item/luna_fragment/energy_retrofit(src)
	spawned_loot = TRUE
