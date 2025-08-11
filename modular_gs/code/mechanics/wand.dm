/obj/item/gun/magic/wand/food
	name = "Wand of Gluttony"
	desc = "Summons delicious fattening foods"
	icon = 'modular_gs/icons/obj/magic.dmi'
	icon_state = "food_wand"
	max_charges = 15
	ammo_type = /obj/item/ammo_casing/magic/food

/obj/item/gun/magic/wand/food/overpowered //This is a more overpowered version of the item
	name = "Strong wand of Gluttony"
	max_charges = 100
	ammo_type = /obj/item/ammo_casing/magic/food/strong

/obj/item/ammo_casing/magic/food
	projectile_type = /obj/projectile/magic/food

/obj/item/ammo_casing/magic/food/strong
	projectile_type = /obj/projectile/magic/food/strong

/obj/projectile/magic/food
	name = "bolt of food"
	pass_flags = PASSGLASS|PASSGRILLE
	///What foods are able to be spawned by the wand?
	var/list/spawnable_foods = list(
		/obj/item/food/burger/bigbite,
		/obj/item/food/donut/plain,
		/obj/item/food/donut/glaze,
		/obj/item/food/cake/cheese,
		/obj/item/food/cake/bscc,
		/obj/item/food/cake/bsvc,
		/obj/item/food/cake/chocolate,
		/obj/item/food/hotdog,
		/obj/item/food/pizza/margherita,
		/obj/item/food/pizza/meat,
	)

	///How much Lipoifier should be added to the spawned in food? Keep this at 10 maximum.
	var/lipoifier_to_add = 5

/obj/projectile/magic/food/on_hit(atom/target, blocked)
	. = ..()

	var/turf/floor = get_turf(target)
	if(!floor || iswallturf(floor))
		return FALSE

	var/food_to_spawn = pick(spawnable_foods)
	var/obj/item/food/spawned_food = new food_to_spawn(floor)
	if(!spawned_food)
		return FALSE

	spawned_food.reagents.add_reagent(/datum/reagent/consumable/lipoifier, lipoifier_to_add)
	return TRUE

/obj/projectile/magic/food/strong
	name = "strong bolt of food"
	lipoifier_to_add = 10
