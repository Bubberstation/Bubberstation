/datum/opposing_force_equipment/antagonist_powers
	category = OPFOR_EQUIPMENT_CATEGORY_OTHER

// Traitor
/datum/opposing_force_equipment/antagonist_powers/uplink
	item_type = /obj/item/uplink/standard
	name = "Standard Syndicate Uplink"
	description = "A mass-produced and cheap Syndicate uplink without a password and a balance of 25 telecrystals. It doesn't get more standard than this."
	admin_note = "Traitor uplink with 20 telecrystals." // LIES. LIES. LIES!!! ITS NOT EMPTY, IT HAD 20 TC BEFORE! No more.

/datum/opposing_force_equipment/antagonist_powers/tc1
	item_type = /obj/item/stack/telecrystal
	name = "1 Raw Telecrystal"
	description = "A telecrystal in its rawest and purest form; can be utilized on active uplinks to increase their telecrystal count."

/datum/opposing_force_equipment/antagonist_powers/tc5
	item_type = /obj/item/stack/telecrystal/five
	name = "5 Raw Telecrystals"
	description = "A bunch of telecrystals in their rawest and purest form; can be utilized on active uplinks to increase their telecrystal count."

/datum/opposing_force_equipment/antagonist_powers/tc20
	item_type = /obj/item/stack/telecrystal/twenty
	name = "20 Raw Telecrystals"
	description = "A bundle of telecrystals in their rawest and purest form; can be utilized on active uplinks to increase their telecrystal count."

/datum/opposing_force_equipment/antagonist_powers/codeword_manual
	item_type = /obj/item/codeword_granter
	name = "Codeword Manual"
	description = "A one-use manual able to impart knowledge of codewords typically used by members of the Syndicate to identify each other in the field covertly."

// Changeling
/datum/opposing_force_equipment/antagonist_powers/changeling
	item_type = /obj/item/antag_granter/changeling
	name = "Changeling Injector"
	description = "A heavy-duty injector containing a highly infectious virus, turning the user into a \"Changeling\"."
	admin_note = "Changeling antag granter."

// Heretic
/datum/opposing_force_equipment/antagonist_powers/heretic
	item_type = /obj/item/antag_granter/heretic
	name = "Heretical Book"
	description = "A purple book with an eldritch eye on it, capable of making one into a \"Heretic\", one with the Forgotten Gods."
	admin_note = "Heretic antag granter."

// Clock Cultist
/datum/opposing_force_equipment/antagonist_powers/clock_cult
	item_type = /obj/item/antag_granter/clock_cultist
	name = "Clockwork Contraption"
	description = "A cogwheel-shaped device of brass, with a glass lens floating, suspended in the center. Capable of making one become a \"Clock Cultist\"."
	admin_note = "Clockwork Cultist (solo) antag granter."

// Contractor
/datum/opposing_force_equipment/antagonist_powers/contractor
	name = "Contractor Bundle"
	item_type = /obj/item/storage/box/syndicate/contract_kit
	description = "A box containing everything you need to take contracts from the Syndicate. Kidnap people and drop them off at specified locations for rewards in the form of Telecrystals (Usable in the provided uplink) and Contractor Points."
	admin_note = "This bundle is a pretty large change-up of how a person plays a round, giving them access to a swathe of new gear, in addition to a contractor tablet. This contractor tablet lets them take on objectives to non-lethally kidnap people in exhange for telecrystals, usable in the provided uplink."
