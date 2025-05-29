//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal
// cost = 700- Minimum cost, or infinite points are possible.

/datum/supply_pack/vending/mealdor
	name = "Meal Vendor Supply Crate"
	desc = "Suprising one to order. If you need a refill for the meal vendor, someone's immobile somewhere. And since you managed to make it to cargo... Well it's not our job to say no!"
	cost = 10000
	contains = list(/obj/item/vending_refill/mealdor)
	crate_name = "meal vendor supply crate"

/datum/supply_pack/misc/livestock
	name = "Livestock Implant"
	desc = "A cruel but effective method of keeping prisoners in line - turn them into docile cattle!"
	cost = 8000
	contains = list(/obj/item/implantcase/docile/livestock,
					/obj/item/implanter)
	crate_name = "livestock implant crate"
	contraband = TRUE


/datum/supply_pack/misc/stripperpole //oldcode port
	name = "Stripper Pole Crate"
	desc = "No private bar is complete without a stripper pole, show off the goods! Comes with a ready-to-assemble stripper pole, and a complementary wrench to get things set up!"
	cost = 3550
	contains = list(/obj/item/polepack,
					/obj/item/wrench)
	crate_name = "stripper pole crate"

/datum/supply_pack/critter/fennec //ported from CHOMPstation2
	name = "Fennec Crate"
	desc = "Why so ears?"
	cost = 5000
	contains = list(/mob/living/simple_animal/pet/fox/fennec)
	crate_name = "fennec crate"

/datum/supply_pack/vending/wardrobes/clothing //existing game item not in cargo for some reason
	name = "ClothesMate Supply Crate"
	desc = "ClothesMate missing your favorite outfit? Solve that issue today with this autodrobe refill."
	cost = 1500
	contains = list(/obj/item/vending_refill/clothing)
	crate_name = "clothesmate supply crate"

/datum/supply_pack/misc/sop_manuals
	name = "Standard Operating Procedure Book Pack"
	desc = "A pack of all SOP books released by GATO! Contains 9 releases."
	cost = 1000
	contains = list(/obj/item/book/manual/science_SOP,
					/obj/item/book/manual/service_SOP,
					/obj/item/book/manual/supply_SOP,
					/obj/item/book/manual/engi_SOP,
					/obj/item/book/manual/med_SOP,
					/obj/item/book/manual/sec_SOP,
					/obj/item/book/manual/command_SOP,
					/obj/item/book/manual/prisoner_SOP,
					/obj/item/book/manual/greytide_SOP)
	crate_name = "sop books crate"
