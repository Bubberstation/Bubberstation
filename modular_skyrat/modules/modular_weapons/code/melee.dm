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
	name = "consultant's commander sabre sheath"
	desc = "An ornate sheathe bestowed to Nanotrasen officials, decorated in fine green-dyed leather, with ornate gold plating, engraved with the Nanotrasen logo. A weapon from a more elegant age, but no less deadly. While it may not have the same cutting power as the Captain's own sabre, this one practically exudes an aura of authority in and of itself. To wield this is to understand your role as an intimidating presence, but not a casual combatant."
	icon = 'modular_zubbers/icons/obj/weapons/melee.dmi'
	icon_state = "cc-sheath"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	worn_icon_state = "cc-sheath"
	stored_blade = /obj/item/melee/sabre/ntc

/obj/item/storage/belt/sheath/sabre/ntc_admiral
	name = "consultant admiral's sabre sheath"
	desc = "An ornate sheathe bestowed to Nanotrasen officials, decorated in fine black-dyed leather, with ornate gold plating, engraved with the Nanotrasen logo. A weapon from a more elegant age, but no less deadly. While it may not have the same cutting power as the Captain's own sabre, this one practically exudes an aura of authority in and of itself. To wield this is to understand your role as an intimidating presence, but not a casual combatant."
	icon = 'modular_zubbers/icons/obj/weapons/melee.dmi'
	icon_state = "admiral-sheath"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	worn_icon_state = "admiral-sheath"
	stored_blade = /obj/item/melee/sabre/ntc

/obj/item/melee/sabre/ntc
	name = "\improper consultant's sabre"
	desc = "An elegant sabre, similar to those bestowed upon captains. The hilt is plated in gold with a Nanotrasen logo carved into it, the grip wrapped neatly in real leather. The blade shimmers with ripples in the light, polished almost to a gleam. It would seem a shame to sully such a beautiful blade, but that's part of the point. This is a weapon of intimidation, not a weapon of true combat. Despite that, it's still a formidable weapon in close-quarters, though not quite as deadly as the sabre bestowed to the Captain themselves."
	block_chance = 30
	armour_penetration = 25
	force = 20

/obj/item/melee/sabre/ntc/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can " + EXAMINE_HINT("look closer") + " to learn a little more about [src]."), \
			lore = "Nanotrasen's earliest trade envoys carried nothing but a briefcase and a contract, and lost far more negotiations than the Board was willing to tolerate. The Nanotrasen diplomats were outwardly indistinguishable from any regular accountant, dispatched to sit on a table across rival corporations, governors and brokers alike. Many returned from negotiations having conceded terms no sober board member would have accepted, simply for the lack of anything to suggest Nanotrasen was not a force to be trifled with.<br>\
The envoys and diplomats required a symbol, a heirloom of their status as dignitaries, which is when the board commissioned Nanotrasen Armories to draft up a tool that carried both the authority and strength necessary.<br>\
<br>\
What followed was months of revision, with Nanotrasen combing through ancient Terran sword-making traditions long-since abandoned in favour of mass production, before settling on a design worth producing, inspired by the ancient napoleonic sabres used by the cavalry and the officers. The blade itself is forged from a high-carbon steel alloyed with vanadium and nickel, folded and layered to produce what the Venusians describe as 'Damascus' steel. The hilt is plated in gold and cast with the Nanotrasen logo in sharp relief, with a grip made of real leather.<br>\
<br>\
Such a weapon is distributed exclusively to Nanotrasen Officers who have shown distinguished conduct, appointed by the board of Central Command. Engraved upon its pommel is the bearer's Employee Identification Number, fixed at time of issuance and, per Corporate Regulations, not removable without voiding the bearer's pension. This one has yet to be assigned a number, but perhaps you'll be the one to earn it..."\
	)

// Centcom sabre. This one is unimplemented, it only exists for fun. It's a Centcom Commander sword, so it's effectively admin-only, hence why it's so powerful.

/obj/item/storage/belt/sheath/sabre/centcom
	name = "\improper commander sabre's leather sheath"
	desc = "A beautiful sheath made of green leather, bearing Nanotrasen's symbol. It is said that only the highest ranking officers of Central Command are bestowed this weapon."
	icon = 'modular_zubbers/icons/obj/weapons/melee.dmi'
	icon_state = "cc-sheath"
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
