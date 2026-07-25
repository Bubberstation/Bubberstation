// Sabres, including the cargo variety

/obj/item/storage/belt/sheath/sabre/cargo
	name = "authentic shamshir leather sheath"
	desc = "A good-looking sheath that is advertised as being made of real Venusian black leather. It feels rather plastic-like to the touch, and it looks like it's made to fit a British cavalry sabre."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	stored_blade = /obj/item/melee/sabre/cargo

/obj/item/melee/sabre
	force = 20 // Original: 15
	wound_bonus = 5 // Original: 10
	exposed_wound_bonus = 20 // Original: 25 Both down slightly, to make up for the damage buff, since it'd get a bit wacky ontop of the armor pen.

/obj/item/melee/sabre/cargo
	name = "authentic shamshir sabre"
	desc = "An expertly crafted historical human sword once used by the Persians which has recently gained traction due to Venusian historal recreation sports. One small flaw, the Taj-based company who produces these has mistaken them for British cavalry sabres akin to those used by high ranking Nanotrasen officials. Atleast it cuts the same way!"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/melee.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/swords_righthand.dmi'
	block_chance = 20
	armour_penetration = 25
	force = 15

// NTC sabre

/obj/item/storage/belt/sheath/sabre/ntc_commander
	name = "consultant commander's sabre sheath"
	desc = "A beautiful sheath made of real leather, an ancient symbol of power and authority, granted to the station's Corporate consultant. This one is green, fashioned after the sheaths granted to the commanders."
	icon = 'modular_zubbers/icons/obj/weapons/melee.dmi'
	icon_state = "cc-sheath"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	worn_icon_state = "cc-sheath"
	stored_blade = /obj/item/melee/sabre/ntc

/obj/item/storage/belt/sheath/sabre/ntc_admiral
	name = "consultant admiral's sabre sheath"
	desc = "A beautiful sheath made of real leather, an ancient symbol of power and authority, granted to the station's Corporate consultant. This one is black, fashioned after the sheaths granted to the admirals."
	icon = 'modular_zubbers/icons/obj/weapons/melee.dmi'
	icon_state = "admiral-sheath"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	worn_icon_state = "admiral-sheath"
	stored_blade = /obj/item/melee/sabre/ntc

/obj/item/melee/sabre/ntc
	name = "\improper consultant's sabre"
	desc = "A well crafted and elegant weapon, oozing with Corporate identity and authority. This one appears to be somewhat used, yet well maintained, having been left less effective than the counterpart that one would find in a Captain's hands. This one is engraved with the symbol of Nanotrasen on the hilt."
	block_chance = 30
	armour_penetration = 25
	force = 20

// Centcom sabre. This one is unimplemented, it only exists for fun. It's a Centcom Commander sword, so it's effectively admin-only, hence why it's so powerful.

/obj/item/storage/belt/sheath/sabre/cargo
	name = "\improper commander sabre's leather sheath"
	desc = "A beautiful sheath made of green leather, bearing Nanotrasen's symbol. It is said that only the highest ranking officers of Central Command are bestowed this weapon."
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	stored_blade = /obj/item/melee/sabre/centcom


/obj/item/melee/sabre/centcom
	name = "\improper commander's sabre"
	desc = "A beautiful masterwork of a sword, granted only to the highest ranking officers of Central Command. Its blade is sharp and lightweight, and the hilt is engraved with the symbol of Nanotrasen. It is a symbol of authority and power, and it is said that those who wield it are to be respected and feared."
	block_chance = 75
	armour_penetration = 75
	force = 30

// This is here so that people can't buy the Sabres and craft them into powercrepes
/datum/crafting_recipe/food/powercrepe
	blacklist = list(
		/obj/item/melee/sabre/cargo,
		/obj/item/melee/sabre/ntc,
		/obj/item/melee/sabre/centcom,
	)

// Removing Assistant's bane from the cargo and ntc sabres
/obj/item/melee/sabre/cargo/Initialize(mapload)
	. = ..()
	var/list/bane_components = GetComponents(/datum/component/bane)
	QDEL_LIST(bane_components)

/obj/item/melee/sabre/ntc/Initialize(mapload)
	. = ..()
	var/list/bane_components = GetComponents(/datum/component/bane)
	QDEL_LIST(bane_components)
