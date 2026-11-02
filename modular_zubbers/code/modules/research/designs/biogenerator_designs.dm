
/datum/design/biogen/diethylamine
	name = "Diethylamine"
	id = "diethylamine"
	materials = list(/datum/material/biomass = 0.5)
	make_reagent = /datum/reagent/diethylamine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_CHEMICALS)

/datum/design/biogen/saltpetre
	name = "Saltpetre"
	id = "saltpetre"
	materials = list(/datum/material/biomass = 0.5)
	make_reagent = /datum/reagent/saltpetre
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_CHEMICALS)

/datum/design/biogen/orangejuice
	name = "Orange Juice"
	id = "orangejuice"
	materials = list(/datum/material/biomass = 0.1)
	make_reagent = /datum/reagent/consumable/orangejuice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/lemonjuice
	name = "Lemon Juice"
	id = "lemonjuice"
	materials = list(/datum/material/biomass = 0.1)
	make_reagent = /datum/reagent/consumable/lemonjuice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/limejuice
	name = "Lime Juice"
	id = "limejuice"
	materials = list(/datum/material/biomass = 0.1)
	make_reagent = /datum/reagent/consumable/limejuice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/berryjuice
	name = "Berry Juice"
	id = "berryjuice"
	materials = list(/datum/material/biomass = 0.1)
	make_reagent = /datum/reagent/consumable/orangejuice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/berryjuice
	name = "Tomato Juice"
	id = "tomatojuice"
	materials = list(/datum/material/biomass = 0.1)
	make_reagent = /datum/reagent/consumable/tomatojuice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/grenadine
	name = "Grenadine Syrup"
	id = "grenadine"
	materials = list(/datum/material/biomass = 0.1)
	make_reagent = /datum/reagent/consumable/grenadine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/soysauce //Alternative to having to make it using sulphuric acid
	name = "Soy Sauce"
	id = "soysauce"
	materials = list(/datum/material/biomass = 0.5)
	make_reagent = /datum/reagent/consumable/soysauce
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/salt
	name = "Salt"
	id = "salt"
	materials = list(/datum/material/biomass = 0.2)
	make_reagent = /datum/reagent/consumable/salt
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/diskplantgene
	name = "Plant Data Disk"
	id = "biogen-diskplantgene"
	materials = list(/datum/material/biomass = 10)
	build_path = /obj/item/disk/computer/plantgene
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_MATERIALS)
