/datum/bounty/item/blacksmith/cage
	name = "Cortical Borer Cage"
	description = "One of Nanotrasen's partner stations is undergoing a borer infestation and would like to capture some life specimen for research. Ship some off to CentCom right away."
	reward = CARGO_CRATE_VALUE * 14
	required_count = 3
	wanted_types = list(/obj/item/cortical_cage = TRUE)

/datum/bounty/item/blacksmith/cuffs
	name = "Handcuffs"
	description = "One of our wardens lost all the handcuffs again. Help restore order and ship some off for a reward."
	reward = CARGO_CRATE_VALUE * 8
	required_count = 3
	wanted_types = list(/obj/item/restraints/handcuffs = TRUE) //This includes reagent cuffs

/datum/bounty/item/blacksmith/staff
	name = "Reagent staff"
	description = "A respected religious figure is visiting CentCom, but lost their staff on the way there! Send a replacement as soon as possible."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/item/forging/reagent_weapon/staff = TRUE)
