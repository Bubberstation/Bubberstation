//The value is not rarity, but rather the amount.
GLOBAL_LIST_INIT(abandoned_crate_disasters,list(
	/mob/living/basic/cockroach = 20,
	/mob/living/basic/bee/toxin = 10,
))

/obj/structure/closet/crate/secure/loot/spawn_loot()

	if(prob(10))
		var/atom/movable/chosen_disaster = pick(GLOB.abandoned_crate_disasters)
		for(var/i=1,i<=GLOB.abandoned_crate_disasters[chosen_disaster],i++)
			new chosen_disaster(src)
	else if(length(GLOB.one_of_a_kind_loot) && prob(1))
		var/atom/movable/chosen_loot = pick_n_take(GLOB.one_of_a_kind_loot)
		new chosen_loot(src)
	else if(prob(40))
		var/atom/movable/chosen_loot = pick_weight_recursive(GLOB.oddity_loot)
		new chosen_loot(src)
	else
		var/atom/movable/chosen_loot = pick_weight_recursive(GLOB.rarity_loot)
		for(var/i=1,i<=rand(3,10),i++)
			new chosen_loot(src)

	spawned_loot = TRUE
