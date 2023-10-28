/datum/bounty/item/blacksmith/cage
	name = "Cortical Borer Cage"
	description = "One of Nanotrasen's partner stations is undergoing a borer infestation and would like to capture some life specimen for research. Ship some off to CentCom right away."
	reward = CARGO_CRATE_VALUE * 14
	required_count = 2
	wanted_types = list(/obj/item/cortical_cage = TRUE)

/datum/bounty/item/blacksmith/cuffs
	name = "Handcuffs"
	description = "One of our wardens lost all the handcuffs again. Help restore order and ship some off for a reward."
	reward = CARGO_CRATE_VALUE * 8
	required_count = 3
	wanted_types = list(/obj/item/restraints/handcuffs = TRUE) //This includes reagent cuffs

/datum/bounty/item/blacksmith/staff
	name = "Staff"
	description = "A respected religious figure is visiting CentCom, but lost their staff on the way there! Send a replacement as soon as possible."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/item/forging/reagent_weapon/staff = TRUE)

/datum/bounty/item/blacksmith/swords
	name = "Swords"
	description = "Our interns' mosins have broken down, ship some swords so they have something to fight with."
	required_count = 3
	reward = CARGO_CRATE_VALUE * 24
	wanted_types = list(/obj/item/forging/reagent_weapon/sword = TRUE)

/datum/bounty/item/blacksmith/armor
	name = "Armor piece"
	description = "Our security commander wants a new piece of plate armor to decorate his office. Send them some immeadiately"
	required_count = 2
	reward = CARGO_CRATE_VALUE * 20
	wanted_types = list(/obj/item/clothing/shoes/forging_plate_boots = TRUE,
						/obj/item/clothing/head/helmet/forging_plate_helmet = TRUE,
						/obj/item/clothing/gloves/forging_plate_gloves = TRUE,
						/obj/item/clothing/suit/armor/forging_plate_armor = TRUE
						)

/datum/bounty/item/blacksmith/katana
	name = "Katana"
	description = "One of our Researchers is going to a Space Anime Convention and wants to show off a real katana! Ship one so he stops pestering us."
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/item/forging/reagent_weapon/katana = TRUE)
