/datum/design/biogen/frontier_clothing
	name = "Frontier Clothing"
	materials = list(/datum/material/biomass = 100)

	build_path = /obj/item/clothing/under/frontier_colonist
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_AKHTER_CLOTHING,
	)

// Jumpsuit

/datum/design/biogen/frontier_clothing/frontier_jumpsuit
	name = "Frontier Jumpsuit"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/clothing/under/frontier_colonist

// Boots

/datum/design/biogen/frontier_clothing/frontier_boots
	name = "Heavy Frontier Boots"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/clothing/shoes/jackboots/frontier_colonist

// Gloves

/datum/design/biogen/frontier_clothing/frontier_gloves
	name = "Frontier Gloves"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/clothing/gloves/frontier_colonist

// Suit items

/datum/design/biogen/frontier_clothing/frontier_trench
	name = "Frontier Trenchcoat"
	build_path = /obj/item/clothing/suit/jacket/frontier_colonist

/datum/design/biogen/frontier_clothing/frontier_jacket
	name = "Frontier Jacket"
	build_path = /obj/item/clothing/suit/jacket/frontier_colonist/short

/datum/design/biogen/frontier_clothing/frontier_med_jacket
	name = "Frontier Medical Jacket"
	materials = list(/datum/material/biomass = 125)
	build_path = /obj/item/clothing/suit/jacket/frontier_colonist/medical

/datum/design/biogen/frontier_clothing/frontier_flak
	name = "Frontier Flak Jacket"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/clothing/suit/frontier_colonist_flak

/datum/design/biogen/frontier_clothing/frontier_tanker_helmet
	name = "Frontier Soft Helmet"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/clothing/head/frontier_colonist_helmet

// Hats

/datum/design/biogen/frontier_clothing/frontier_cap
	name = "Frontier Soft Cap"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/clothing/head/soft/frontier_colonist

/datum/design/biogen/frontier_clothing/frontier_cap_med
	name = "Frontier Medical Cap"
	build_path = /obj/item/clothing/head/soft/frontier_colonist/medic

// That one gas mask

/datum/design/biogen/frontier_clothing/frontier_mask
	name = "Frontier Gas Mask"
	build_path = /obj/item/clothing/mask/gas/atmos/frontier_colonist
