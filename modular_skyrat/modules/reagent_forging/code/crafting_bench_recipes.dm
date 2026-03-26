/datum/crafting_bench_recipe
	/// The name of the recipe to show
	var/recipe_name = "generic debug recipe"
	/// The items required to create the resulting item
	var/list/recipe_requirements
	/// What the end result of this recipe should be
	var/resulting_item = /obj/item/forging
	/// If we use the materials from the component parts
	var/transfers_materials = TRUE
	/// How long it takes at the crafting bench to assemble
	var/time_to_assemble = 2 SECONDS
	/// What skill is relevant to the creation of this item?
	var/relevant_skill = /datum/skill/smithing
	/// What skill level is required in that creation?
	var/relevant_skill_level = 0
	/// Does the recipe also require a specific trait?
	var/required_traits = null
	/// How much experience in our relevant skill do we give upon completion?
	var/relevant_skill_reward = 30

/datum/crafting_bench_recipe/weapon_completion_recipe //Exists so I don't have to modify the code too much for weapon completion
	recipe_name = "generic weapon completion recipe (should not be visible)"
	recipe_requirements = list(
		/obj/item/stack/sheet/mineral/wood = 2,
	)
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)

/datum/crafting_bench_recipe/plate_helmet
	recipe_name = "plate helmet"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 4,
	)
	resulting_item = /obj/item/clothing/head/helmet/forging_plate_helmet
	time_to_assemble = 1.5 SECONDS

/datum/crafting_bench_recipe/plate_vest
	recipe_name = "plate vest"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 6,
	)
	resulting_item = /obj/item/clothing/suit/armor/forging_plate_armor
	time_to_assemble = 3 SECONDS

/datum/crafting_bench_recipe/plate_gloves
	recipe_name = "plate gloves"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 2,
	)
	resulting_item = /obj/item/clothing/gloves/forging_plate_gloves
	time_to_assemble = 2 SECONDS

/datum/crafting_bench_recipe/plate_boots
	recipe_name = "plate boots"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 4,
	)
	resulting_item = /obj/item/clothing/shoes/forging_plate_boots
	time_to_assemble = 2 SECONDS

/datum/crafting_bench_recipe/horse_shoes
	recipe_name = "horse shoes"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 4,
	)
	resulting_item = /obj/item/clothing/shoes/horseshoe/reagent_clothing
	time_to_assemble = 1.5 SECONDS

/datum/crafting_bench_recipe/ring
	recipe_name = "ring"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 2,
	)
	resulting_item = /obj/item/clothing/gloves/ring/reagent_clothing
	time_to_assemble = 4 SECONDS

/datum/crafting_bench_recipe/collar
	recipe_name = "collar"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 3,
	)
	resulting_item = /obj/item/clothing/neck/collar/reagent_clothing
	time_to_assemble = 3 SECONDS

/datum/crafting_bench_recipe/handcuffs
	recipe_name = "handcuffs"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 5,
	)
	resulting_item = /obj/item/restraints/handcuffs/reagent_clothing
	time_to_assemble = 5 SECONDS

/datum/crafting_bench_recipe/borer_cage
	recipe_name = "cortical borer cage"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 6,
	)
	resulting_item = /obj/item/cortical_cage
	time_to_assemble = 2 SECONDS

/datum/crafting_bench_recipe/pavise
	recipe_name = "pavise"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 8,
	)
	resulting_item = /obj/item/shield/buckler/reagent_weapon/pavise
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)
	time_to_assemble = 6 SECONDS

/datum/crafting_bench_recipe/buckler
	recipe_name = "buckler"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 5,
	)
	resulting_item = /obj/item/shield/buckler/reagent_weapon
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)
	time_to_assemble = 3 SECONDS

/datum/crafting_bench_recipe/coil
	recipe_name = "coil"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 2,
	)
	resulting_item = /obj/item/forging/coil
	time_to_assemble = 2 SECONDS

/datum/crafting_bench_recipe/seed_mesh
	recipe_name = "seed mesh"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
		/obj/item/forging/complete/chain = 2,
	)
	resulting_item = /obj/item/seed_mesh
	time_to_assemble = 10 SECONDS

/datum/crafting_bench_recipe/centrifuge
	recipe_name = "centrifuge"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
	)
	resulting_item = /obj/item/reagent_containers/cup/primitive_centrifuge
	time_to_assemble = 7 SECONDS

/datum/crafting_bench_recipe/bokken
	recipe_name = "bokken"
	recipe_requirements = list(
		/obj/item/stack/sheet/mineral/wood = 4,
	)
	resulting_item = /obj/item/forging/reagent_weapon/bokken
	time_to_assemble = 3 SECONDS
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)

/datum/crafting_bench_recipe/bow
	recipe_name = "bow"
	recipe_requirements = list(
		/obj/item/stack/sheet/mineral/wood = 4,
	)
	resulting_item = /obj/item/forging/incomplete_bow
	time_to_assemble = 4 SECONDS
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)

/datum/crafting_bench_recipe/empty_circuit
	recipe_name = "circuit"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
		/obj/item/forging/coil = 1,
	)
	resulting_item = /obj/item/empty_circuit
	time_to_assemble = 20 SECONDS
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)
