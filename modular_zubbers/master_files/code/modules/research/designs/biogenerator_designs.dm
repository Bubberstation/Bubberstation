
/datum/design/diethylamine
	name = "Diethylamine"
	id = "diethylamine"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 0.5)
	make_reagent = /datum/reagent/diethylamine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_CHEMICALS)

/datum/design/saltpetre
	name = "Saltpetre"
	id = "saltpetre"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 0.5)
	make_reagent = /datum/reagent/saltpetre
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_CHEMICALS)

/datum/design/orangejuice
	name = "Orange Juice"
	id = "orangejuice"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 0.1)
	make_reagent = /datum/reagent/consumable/orangejuice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/lemonjuice
	name = "Lemon Juice"
	id = "lemonjuice"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 0.1)
	make_reagent = /datum/reagent/consumable/lemonjuice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/limejuice
	name = "Lime Juice"
	id = "limejuice"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 0.1)
	make_reagent = /datum/reagent/consumable/limejuice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/berryjuice
	name = "Berry Juice"
	id = "berryjuice"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 0.1)
	make_reagent = /datum/reagent/consumable/orangejuice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/berryjuice
	name = "Tomato Juice"
	id = "tomatojuice"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 0.1)
	make_reagent = /datum/reagent/consumable/tomatojuice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/grenadine
	name = "Grenadine Syrup"
	id = "grenadine"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 0.1)
	make_reagent = /datum/reagent/consumable/grenadine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/soysauce //Alternative to having to make it using sulphuric acid
	name = "Soy Sauce"
	id = "soysauce"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 0.5)
	make_reagent = /datum/reagent/consumable/soysauce
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/salt
	name = "Salt"
	id = "salt"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 0.2)
	make_reagent = /datum/reagent/consumable/salt
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/diskplantgene
	name = "Plant Data Disk"
	id = "diskplantgene"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 10)
	build_path = /obj/item/disk/plantgene
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_MATERIALS)
