/obj/item/fish/shrimp
	name = "shrimp"
	fish_id = "shrimp"
	desc = "A reddish pink crustacean. How many of them would you have to eat for your skin to turn pink?"
	icon = 'modular_zubbers/icons/obj/aquarium/fish.dmi'
	icon_state = "shrimp"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	sprite_width = 7
	sprite_height = 7
	average_size = 14
	average_weight = 300
	stable_population = 4
	fish_traits = null
	required_temperature_min = MIN_AQUARIUM_TEMP
	required_temperature_max = MIN_AQUARIUM_TEMP + 12

/obj/item/fish/shrimp/get_fish_taste()
	return list("raw shrimp" = 2)
