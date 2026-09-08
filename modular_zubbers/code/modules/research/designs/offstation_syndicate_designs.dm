/datum/design/syndicate_express_console
	name = "Syndicate Express Cargo Console"
	desc = "The circuit board for a computer used to purchase goods on a black market."
	id = "cargoconsole_syndicate"
	build_type = AWAY_IMPRINTER
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	transfered_materials = list(/obj/item/circuitboard/computer/cargo/express/interdyne = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT))
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
	transfered_materials = list(/obj/item/circuitboard/machine/syndiepad = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT))
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
	transfered_materials = list(/obj/item/circuitboard/computer/syndiepad = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT))
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
	transfered_materials = list(/obj/item/circuitboard/machine/powerator/interdyne = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT))
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
	transfered_materials = list(/obj/item/circuitboard/machine/mechfab/interdyne = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT))
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
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3)
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
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.7)
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
	inherit_materials = DESIGN_DONT_INHERIT_MATS
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
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/encryptionkey/headset_syndicate/cybersun
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/interdyne_mining_equipment_vendor
	name = "Offstation Mining Rewards Vendor Board"
	desc = "The circuit board for a offstation Mining Rewards Vendor."
	id = "interdyne_mining_equipment_vendor"
	build_type = AWAY_IMPRINTER
	build_path = /obj/item/circuitboard/computer/order_console/mining/interdyne
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO
