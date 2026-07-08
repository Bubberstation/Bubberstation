/// Unique machines intended for Lizard Gas, to provide them with cheap and easy to obtain items that normally they wouldn't be able to obtain,
/// this includes first aid equipment, medicines, certain food items, clothes, and some materials. These essentially act as 'upgraded' versions
/// of the unique biogens that can be ordered. Hopefully gives Lizard Gas more reason to be played and most importantly - enjoyed.
/// Honestly, could be used for other ghost roles to make them a bit more unique or to cover a certain weakness, as long as it makes sense.

/// Colonial Marine Resequencer - essentially combines the organic materials printer and clothing options from the colonial supply core.
/obj/item/circuitboard/machine/biogenerator/lizard_gas_colonial
	name = "Colonial Marine Resequencer"
	build_path = /obj/machinery/biogenerator/lizard_gas_colonial
	icon = 'modular_zubbers/icons/obj/machines/resequencer.dmi'
	icon_state = "circuitboard"
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/machinery/biogenerator/lizard_gas_colonial
	name = "Colonial Marine Resequencer"
	desc = "A derivative of the Type 34 'Colonial Supply Core,' colloquially known as the 'Gencrate/CSC'. \
		The Gencrate is at its core a matter resequencer, a highly specialized subtype of biogenerator which performs a sort of transmutation using organic \
		compounds; normally from large-scale crops or waste product. This one has been heavily modified to focus on making clothing, accessories, and also \
		a variety of materials to make up for the unreliable rate of deliveries, at the cost of not being able to make the other items it is well \
		known for producing."
	icon = 'modular_zubbers/icons/obj/machines/resequencer.dmi'
	circuit = /obj/item/circuitboard/machine/biogenerator/lizard_gas_colonial
	efficiency = 1
	productivity = 1
	max_items = 35
	show_categories = list(
		RND_CATEGORY_CMR_APPAREL,
		RND_CATEGORY_CMR_EQUIPMENT,
		RND_CATEGORY_CMR_MATERIALS,
	)

/// DeForest Brand Bio-Regenerator - just a better version of the Wall Med-Station, and not installed on a wall.
/obj/item/circuitboard/machine/biogenerator/lizard_gas_medvendor
	name = "DeForest Brand Bio-Regenerator"
	build_path = /obj/machinery/biogenerator/lizard_gas_medvendor
	icon = 'modular_zubbers/icons/obj/machines/bioregenerator.dmi'
	icon_state = "circuitboard"
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/machinery/biogenerator/lizard_gas_medvendor
	name = "DeForest Brand Bio-Regenerator"
	desc = "An advanced machine seen in frontier outposts and colonies capable of turning organic plant matter into \
		various emergency medical supplies and injectors. This is one of the more advanced models that were sold in \
		limited supply, being designed for harsher and more dangerous frontiers."
	icon = 'modular_zubbers/icons/obj/machines/bioregenerator.dmi'
	circuit = /obj/item/circuitboard/machine/biogenerator/lizard_gas_medvendor
	efficiency = 1
	productivity = 1
	max_items = 35
	show_categories = list(
		RND_CATEGORY_DFBBR_MEDICAL,
		RND_CATEGORY_DFBBR_MEDICINE,
		RND_CATEGORY_DFBBR_INJECTORS,
		RND_CATEGORY_DEFOREST_BLOOD,
	)

/// SmartFridge Organic Fabricator - Rations printer, but actually more useful than a biogen.
/obj/item/circuitboard/machine/biogenerator/lizard_gas_smartfridge
	name = "SmartFridge Organic Fabricator"
	build_path = /obj/machinery/biogenerator/lizard_gas_smartfridge
	icon = 'modular_zubbers/icons/obj/machines/smartfridge_fab.dmi'
	icon_state = "circuitboard"
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/machinery/biogenerator/lizard_gas_smartfridge
	name = "SmartFridge Organic Fabricator"
	desc = "An advanced machine seen in frontier outposts and colonies capable of turning organic plant matter into \
		various foods or ingredients. The best friend of a chef where deliveries are inconsistent or simply don't exist. \
		This model has been customized further to provide a much larger variety of food, it contains an expanded stock of \
		items, and ready to cook ingredients for making large quantities of food in a moment's notice."
	icon = 'modular_zubbers/icons/obj/machines/smartfridge_fab.dmi'
	circuit = /obj/item/circuitboard/machine/biogenerator/lizard_gas_smartfridge
	efficiency = 1
	productivity = 1
	max_items = 35
	show_categories = list(
		RND_CATEGORY_SFOF_INGREDIENT,
		RND_CATEGORY_SFOF_CONDIMENTS,
		RND_CATEGORY_SFOF_CONSUMABLES,
		RND_CATEGORY_SFOF_LUXURIES,
		RND_CATEGORY_AKHTER_FOODRICATOR_UTENSILS,
	)

// Telescreen, because you can't set custom networks without creating linter errors.
/obj/machinery/computer/security/telescreen/lizgas
	name = "Lizard Gas CCTV Monitor"
	desc = "A telescreen that connects to the gas station's camera network."
	network = list("lizardgas")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/computer/security/telescreen/lizgas, 32)
