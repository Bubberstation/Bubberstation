// Designs for the Colonial Marine Resequencer
// Completely removes the provision and medicine categories, as this version is focused on materials and clothing.

//// Apparel ////

// Jumpsuits

/datum/design/biogen/cmf_colonial_under
	name = "Colonial Uniform"
	id = "cmf_slavic_under"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/clothing/under/colonial
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_frontier_jumpsuit
	name = "Frontier Jumpsuit"
	id = "cmf_frontier_jumpsuit"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/clothing/under/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

// Boots

/datum/design/biogen/cmf_frontier_boots
	name = "Heavy Frontier Boots"
	id = "cmf_frontier_boots"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/clothing/shoes/jackboots/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_colonial_boots
	name = "Colonial Half-Boots"
	id = "cmf_slavic_boots"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/clothing/shoes/jackboots/colonial
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

// Gloves

/datum/design/biogen/cmf_frontier_gloves
	name = "Frontier Gloves"
	id = "cmf_frontier_gloves"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/clothing/gloves/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_cool_gloves
	name = "Black Gloves"
	id = "cmf_slavic_gloves"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/clothing/gloves/color/black
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

// Suit items

/datum/design/biogen/cmf_colonial_cloak
	name = "Colonial Cloak"
	id = "cmf_slavic_cloak"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/clothing/neck/cloak/colonial
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_frontier_trench
	name = "Frontier Trenchcoat"
	id = "cmf_frontier_trench"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/clothing/suit/jacket/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_frontier_jacket
	name = "Frontier Jacket"
	id = "cmf_frontier_jacket"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/clothing/suit/jacket/frontier_colonist/short
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_frontier_med_jacket
	name = "Frontier Medical Jacket"
	id = "cmf_frontier_med_jacket"
	materials = list(/datum/material/biomass = 175)
	build_path = /obj/item/clothing/suit/jacket/frontier_colonist/medical
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_frontier_flak
	name = "Frontier Flak Jacket"
	id = "cmf_frontier_flak_jacket"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/clothing/suit/frontier_colonist_flak
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_frontier_tanker_helmet
	name = "Frontier Soft Helmet"
	id = "cmf_frontier_tanker_helmet"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/clothing/head/frontier_colonist_helmet
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

// Hats

/datum/design/biogen/cmf_frontier_cap
	name = "Frontier Soft Cap"
	id = "cmf_frontier_cap"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/clothing/head/soft/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_frontier_cap_med
	name = "Frontier Medical Cap"
	id = "cmf_frontier_cap_med"
	materials = list(/datum/material/biomass = 125)
	build_path = /obj/item/clothing/head/soft/frontier_colonist/medic
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_cool_hat
	name = "Colonial Cap"
	id = "cmf_slavic_cap"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/clothing/head/hats/colonial
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

// The gas mask

/datum/design/biogen/cmf_frontier_mask
	name = "Frontier Gas Mask"
	id = "cmf_frontier_mask"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/clothing/mask/gas/atmos/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

//// Equipment ////

// Belts

/datum/design/biogen/cmf_frontier_chest_rig
	name = "Frontier Chest Rig"
	id = "cmf_frontier_chest_rig"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/storage/belt/utility/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_frontier_med_belt
	name = "Satchel Medical Kit"
	id = "cmf_frontier_med_belt"
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/storage/backpack/duffelbag/deforest_medkit
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_frontier_medtech_belt
	name = "Medical Technician Kit"
	id = "cmf_frontier_medtech_belt"
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/storage/backpack/duffelbag/deforest_paramedic
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_frontier_medkit
	name = "Frontier Medical Kit"
	id = "cmf_frontier_medkit"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/storage/medkit/frontier
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

// Backpacks

/datum/design/biogen/cmf_frontier_backpack
	name = "Frontier Backpack"
	id = "cmf_frontier_backpack"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/storage/backpack/industrial/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_frontier_satchel
	name = "Frontier Satchel"
	id = "cmf_frontier_satchel"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/storage/backpack/industrial/frontier_colonist/satchel
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_frontier_messenger
	name = "Frontier Messenger Bag"
	id = "cmf_frontier_messenger"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/storage/backpack/industrial/frontier_colonist/messenger
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

// Small Containers

/datum/design/biogen/cmf_colonial_webbing
	name = "Slim Colonial Webbing"
	id = "cmf_slavic_webbing"
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/clothing/accessory/colonial_webbing
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_genpouch
	name = "Empty General Purpose Pouch"
	id = "cmf_slavic_genpouch"
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/pouch/cin_general
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_pocket_medkit
	name = "Empty Pocket First Aid Kit"
	id = "cmf_slavic_cfap"
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/pouch/cin_medkit
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_medipouch
	name = "Empty Medipen Pouch"
	id = "cmf_slavic_medipouch"
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/pouch/cin_medipens
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_cup
	name = "Empty Paper Cup"
	id = "cmf_slavic_cup"
	materials = list(/datum/material/biomass = 10)
	build_path = /obj/item/reagent_containers/cup/glass/coffee/colonial/empty
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

//// Materials ////

/datum/design/biogen/cmf_plastic
	name = "Plastic Sheet"
	id = "cmf_plastic"
	materials = list(/datum/material/biomass = 30)
	build_path = /obj/item/stack/sheet/plastic
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_MATERIALS)

/datum/design/biogen/cmf_leather
	name = "Sheet of Leather"
	id = "cmf_leather"
	materials = list(/datum/material/biomass = 40)
	build_path = /obj/item/stack/sheet/leather
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_MATERIALS)

/datum/design/biogen/cmf_cloth
	name = "Cloth"
	id = "cmf_cloth"
	materials = list(/datum/material/biomass = 15)
	build_path = /obj/item/stack/sheet/cloth
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_MATERIALS)

/datum/design/biogen/cmf_cardboard
	name = "Sheet of Cardboard"
	id = "cmf_cardboard"
	materials = list(/datum/material/biomass = 7.5)
	build_path = /obj/item/stack/sheet/cardboard
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_MATERIALS)

/datum/design/biogen/cmf_paper
	name = "Sheet of Paper"
	id = "cmf_paper"
	materials = list(/datum/material/biomass = 2.5)
	build_path = /obj/item/paper
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_MATERIALS)

/datum/design/biogen/cmf_rolling_paper
	name = "Sheet of Rolling Paper"
	id = "cmf_rollingpaper"
	materials = list(/datum/material/biomass = 1.25)
	build_path = /obj/item/rollingpaper
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_MATERIALS)

/datum/design/biogen/cmf_candle
	name = "Candle"
	id = "cmf_candle"
	materials = list(/datum/material/biomass = 4)
	build_path = /obj/item/flashlight/flare/candle
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_MATERIALS)
