/**
 * Tests Protean suit transformation and species handling. Makes sure any storage is dropped and its contents not deleted.
 */
/datum/unit_test/protean_species_handling/Run()
	var/mob/living/carbon/human/consistent/protean = EASY_ALLOCATE()
	var/obj/item/stack/sheet/iron/twenty/iron = EASY_ALLOCATE()
	var/obj/item/storage/backpack/bag = EASY_ALLOCATE()
	protean.equip_to_slot_if_possible(bag, ITEM_SLOT_BACK, TRUE, TRUE, TRUE, TRUE, TRUE)
	protean.equip_to_storage(iron, ITEM_SLOT_BACK)

	protean.set_species(/datum/species/protean)
	var/datum/species/protean/p_species = protean.dna.species
	var/backslot = protean.get_item_by_slot(ITEM_SLOT_BACK)
	var/obj/item/mod/core/protean/core = p_species.species_modsuit.core
	TEST_ASSERT_EQUAL(p_species.owner, protean, "Protean species did not assign dummy as its owner.")
	TEST_ASSERT(istype(backslot, /obj/item/mod/control/pre_equipped/protean), "Protean species did not assign /obj/item/mod/control/protean to ITEM_SLOT_BACK. Backslot: [isnull(backslot) ? "Null" : "[backslot]"]")
	TEST_ASSERT_NOTNULL(p_species.species_modsuit, "Protean species failed to link to modsuit.")
	TEST_ASSERT_EQUAL(core.linked_species, p_species, "Protean modsuit core failed to link to its species.")

	TEST_ASSERT(isturf(bag.loc), "[bag::name] did not drop onto a turf! Location: [isnull(bag.loc) ? "Nullspace" : "[bag.loc]"]")
	TEST_ASSERT(locate(/obj/item/stack/sheet/iron/twenty) in bag.contents, "[iron::name] are not inside [bag::name]")

	protean.equip_to_storage(iron, ITEM_SLOT_BACK)
	TEST_ASSERT_EQUAL(iron.loc, p_species.species_modsuit.atom_storage.real_location, "[iron::name] did not enter [p_species.species_modsuit.name] storage. Does it have a storage module?")

	protean.set_species(/datum/species/human)
	TEST_ASSERT(isturf(iron.loc), "[iron::name] has not dropped to a turf after species loss. Location: [isnull(iron.loc) ? "Nullspace" : "[iron.loc]"]")
