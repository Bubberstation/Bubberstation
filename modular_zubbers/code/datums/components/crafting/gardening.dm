/datum/crafting_recipe/ppflowers
	name = "Purple and pink flower patch"
	result = /obj/structure/flora/bush/flowers_pp/style_random
	reqs = list(
		/obj/item/food/grown/grass = 2,
	)
	tool_paths = list(/obj/item/secateurs, /obj/item/shovel/spade)
	time = 2 SECONDS
	category = CAT_GARDENING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF

/datum/crafting_recipe/ywflowers
	name = "Yellow and white flower patch"
	result = /obj/structure/flora/bush/flowers_yw/style_random
	reqs = list(
		/obj/item/food/grown/grass = 2,
	)
	tool_paths = list(/obj/item/secateurs, /obj/item/shovel/spade)
	time = 2 SECONDS
	category = CAT_GARDENING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF

/datum/crafting_recipe/brflowers
	name = "Blue and red flower patch"
	result = /obj/structure/flora/bush/flowers_br/style_random
	reqs = list(
		/obj/item/food/grown/grass = 2,
	)
	tool_paths = list(/obj/item/secateurs, /obj/item/shovel/spade)
	time = 2 SECONDS
	category = CAT_GARDENING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF

/datum/crafting_recipe/jggrass
	name = "Jungle Grass"
	result = /obj/structure/flora/grass/jungle/a/style_random
	reqs = list(
		/obj/item/food/grown/grass = 3,
	)
	tool_paths = list(/obj/item/secateurs, /obj/item/shovel/spade)
	time = 2 SECONDS
	category = CAT_GARDENING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF

/datum/crafting_recipe/tgrass
	name = "Tall Grass"
	result = /obj/structure/flora/bush/fullgrass/style_random
	reqs = list(
		/obj/item/food/grown/grass = 3,
	)
	tool_paths = list(/obj/item/secateurs, /obj/item/shovel/spade)
	time = 2 SECONDS
	category = CAT_GARDENING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF

/datum/crafting_recipe/lavgrass
	name = "Lavender Tufts"
	result = /obj/structure/flora/bush/lavendergrass/style_random
	reqs = list(
		/obj/item/food/grown/grass = 3,
	)
	tool_paths = list(/obj/item/secateurs, /obj/item/shovel/spade)
	time = 2 SECONDS
	category = CAT_GARDENING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF

/datum/crafting_recipe/leafbush
	name = "Leafy Bush"
	result = /obj/structure/flora/bush/leavy/style_random
	reqs = list(
		/obj/item/food/grown/grass = 4,
	)
	tool_paths = list(/obj/item/secateurs, /obj/item/shovel/spade)
	time = 2 SECONDS
	category = CAT_GARDENING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF

/datum/crafting_recipe/fernbush
	name = "Fern"
	result = /obj/structure/flora/bush/ferny/style_random
	reqs = list(
		/obj/item/food/grown/grass = 4,
	)
	tool_paths = list(/obj/item/secateurs, /obj/item/shovel/spade)
	time = 2 SECONDS
	category = CAT_GARDENING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF

/datum/crafting_recipe/rbush
	name = "Round Bush"
	result = /obj/structure/flora/bush/grassy/style_random
	reqs = list(
		/obj/item/food/grown/grass = 4,
		/obj/item/grown/log = 1,
	)
	tool_paths = list(/obj/item/secateurs, /obj/item/shovel/spade)
	time = 2 SECONDS
	category = CAT_GARDENING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF

/datum/crafting_recipe/sflatbush
	name = "Small Flatleaf Bush"
	result = /obj/structure/flora/bush/jungle/a/style_random
	reqs = list(
		/obj/item/food/grown/grass = 4,
		/obj/item/grown/log = 1,
	)
	tool_paths = list(/obj/item/secateurs, /obj/item/shovel/spade)
	time = 2 SECONDS
	category = CAT_GARDENING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF

/datum/crafting_recipe/lflatbush
	name = "Large Flatleaf Bush"
	result = /obj/structure/flora/bush/large/style_random
	reqs = list(
		/obj/item/food/grown/grass = 8,
		/obj/item/grown/log = 3,
	)
	tool_paths = list(/obj/item/secateurs, /obj/item/shovel/spade)
	time = 10 SECONDS
	category = CAT_GARDENING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF

/datum/crafting_recipe/bioflower
	name = "Bioluminescent Flower"
	result = /obj/structure/flora/biolumi/flower/weaklight
	reqs = list(
		/obj/item/food/grown/grass/fairy = 5,
	)
	tool_paths = list(/obj/item/secateurs, /obj/item/shovel/spade)
	time = 5 SECONDS
	category = CAT_GARDENING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF
