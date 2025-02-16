///// Bubber added Syndicate Tech /////

///// First we enstate a techweb so we can add the node. /////
/datum/techweb/interdyne
	id = "INTERDYNE"
	organization = "Interdyne Pharmaceutics"
	should_generate_points = TRUE

/datum/techweb/interdyne/New()
	. = ..()
	research_node_id("oldstation_surgery", TRUE, TRUE, FALSE)
	research_node_id(TECHWEB_NODE_INTERDYNE, TRUE, TRUE, FALSE)

//techweb nodes
/datum/techweb_node/interdyne
	id = TECHWEB_NODE_INTERDYNE
	display_name = "Syndicate Technology"
	description = "Tools used by the Syndicate."
	required_items_to_unlock = list(
		/obj/item/circuitboard/machine/syndiepad,
		/obj/item/circuitboard/computer/cargo/express/interdyne,
		/obj/item/circuitboard/computer/syndiepad,
		/obj/item/circuitboard/machine/powerator/interdyne

	)
	design_ids = list(
		"cargoconsole_syndicate",
		"bountypad_syndicate",
		"bountyconsole_syndicate",
		"powerator_syndicate",
		"exofab_syndicate",
		"syndicate_firing_pin",
		"syndicate_headset",
		"cybersun_encryption"

	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE

/datum/techweb_node/encryption
	id = TECHWEB_NODE_INTERDYNE_ENCRYPTION
	display_name = "Advanced Syndicate Encryption"
	description = "Provides emergency use Interdyne encryption keys in case operational comms are compromised."
	required_items_to_unlock = list(
		/obj/item/encryptionkey/headset_syndicate/interdyne
	)
	design_ids = list(
		"interdyne_encryption",
	)
	prereq_ids = list(TECHWEB_NODE_INTERDYNE)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE

//specific techweb designs

//Circuit boards
/datum/design/syndicate_express_console
	name = "Syndicate Express Cargo Console"
	desc = "The circuit board for a computer used to purchase goods on a black market."
	id = "cargoconsole_syndicate"
	build_type = AWAY_IMPRINTER
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	build_path = /obj/item/circuitboard/computer/cargo/express/interdyne
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/syndicate_bounty_pad
	name = "Syndicate Bounty Pad"
	desc = "The circuit board for a machine used to sell goods on a black market."
	id = "bountypad_syndicate"
	build_type = AWAY_IMPRINTER
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	build_path = /obj/item/circuitboard/machine/syndiepad
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_CONSTRUCTION_MACHINERY
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/syndicate_bounty_pad_console
	name = "Syndicate Bounty Pad Console"
	desc = "The circuit board for the computer used to control a bounty pad to sell goods on a black market."
	id = "bountyconsole_syndicate"
	build_type = AWAY_IMPRINTER
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	build_path = /obj/item/circuitboard/computer/syndiepad
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/syndicate_powerator
	name = "Syndicate Powerator"
	desc = "The circuit board for a machine that can sell power."
	id = "powerator_syndicate"
	build_type = AWAY_IMPRINTER
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	build_path = /obj/item/circuitboard/machine/powerator/interdyne
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_CONSTRUCTION_MACHINERY
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/syndicate_exofab
	name = "Syndicate Exofab"
	desc = "The circuit board for a standard issue exofab produced by Interdyne."
	id = "exofab_syndicate"
	build_type = AWAY_IMPRINTER
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	build_path = /obj/item/circuitboard/machine/mechfab/interdyne
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_CONSTRUCTION_MACHINERY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

//Items
/datum/design/syndicate_firing_pin
	name = "Syndicate Firing Pin"
	desc = "A Syndicate Implant restricted firing pin."
	id = "syndicate_firing_pin"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = SMALL_MATERIAL_AMOUNT * 6, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 6, /datum/material/uranium =SMALL_MATERIAL_AMOUNT * 2)
	build_path =/obj/item/firing_pin/implant/pindicate
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_FIRING_PINS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/syndicateciv_headset
	name = "Syndicate Headset"
	desc = "Standard issue headset for syndicate civillians."
	id = "syndicate_headset"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1)
	build_path = /obj/item/radio/headset/syndicateciv
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/interdyne_key
	name = "Interdyne Encryption Key"
	desc = "Standard issue headset for syndicate civillians."
	id = "interdyne_encryption"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1)
	build_path = /obj/item/encryptionkey/headset_syndicate/interdyne
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/cybersun_key
	name = "Cybersun Encryption Key"
	desc = "Standard issue headset for syndicate civillians."
	id = "cybersun_encryption"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1)
	build_path = /obj/item/encryptionkey/headset_syndicate/cybersun
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

//Syndicate Machinery Boards

/obj/machinery/rnd/production/protolathe/interdyne
	name = "Interdyne Branded Protolathe"
	desc = "Converts raw materials into useful objects. Refurbished and updated from its previous, limited capabilities."
	circuit = /obj/item/circuitboard/machine/protolathe/interdyne
	stripe_color = "#d40909"

/obj/item/circuitboard/machine/protolathe/interdyne
	name = "Interdyne Branded Protolathe"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/rnd/production/protolathe/interdyne

//Adding the actual physical Server

/obj/item/circuitboard/machine/rdserver/interdyne
	name = "Interdyne Pharmaceutics R&D Server"
	build_path = /obj/machinery/rnd/server/interdyne

/obj/machinery/rnd/server/interdyne
	name = "\improper Interdyne Pharmaceutics R&D Server"
	circuit = /obj/item/circuitboard/machine/rdserver/interdyne
	req_access = list(ACCESS_RESEARCH)

/obj/machinery/rnd/server/interdyne/Initialize(mapload)
	var/datum/techweb/interdyne_techweb = locate(/datum/techweb/interdyne) in SSresearch.techwebs
	stored_research = interdyne_techweb
	return ..()

/obj/machinery/rnd/server/interdyne/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(held_item && istype(held_item, /obj/item/research_notes))
		context[SCREENTIP_CONTEXT_LMB] = "Generate research points"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/rnd/server/interdyne/examine(mob/user)
	. = ..()
	if(!in_range(user, src) && !isobserver(user))
		return
	. += span_notice("Insert [EXAMINE_HINT("Research Notes")] to generate points.")

/obj/machinery/rnd/server/interdyne/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/research_notes) && stored_research)
		var/obj/item/research_notes/research_notes = attacking_item
		stored_research.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = research_notes.value))
		playsound(src, 'sound/machines/copier.ogg', 50, TRUE)
		qdel(research_notes)
		return
	return ..()
