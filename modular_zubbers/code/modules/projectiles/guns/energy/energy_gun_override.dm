//Weapon Overlay Override. Includes a skyrat edit as well as a new change mode to allow for Zydras's guns to work properly.

/obj/item/gun/energy/update_overlays()
	. = ..()
	if(!automatic_charge_overlays || !cell)
		return

	var/overlay_icon_state = "[icon_state]_charge"
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]

	if(modifystate)
		if(single_shot_type_overlay)
			. += "[icon_state]_[initial(shot.select_name)]"
		overlay_icon_state += "_[initial(shot.select_name)]"

	var/ratio = get_charge_ratio()
	if(ratio == 0 && display_empty)
		. += "[icon_state]_empty"
		return

	if(shot_type_fluff_overlay)
		. += "[icon_state]_[initial(shot.select_name)]_extra"

	if(shaded_charge == SHADED_CHARGE_MODE_LABELED) // support a third shaded_charge state
		. += "[icon_state]_[initial(shot.select_name)]_charge[ratio]"
		return

	if(shaded_charge)
		. += "[icon_state]_charge[ratio]"
		return
	var/mutable_appearance/charge_overlay = mutable_appearance(icon, overlay_icon_state)
	for(var/i = ratio, i >= 1, i--)
		charge_overlay.pixel_w = ammo_x_offset * (i - 1)
		charge_overlay.pixel_z = ammo_y_offset * (i - 1)
		. += new /mutable_appearance(charge_overlay)

//New gun sprites and lore. Most of the lore is by me (IbexGoetia), while the sprites have all been made by Zydras.

/obj/item/gun/energy/laser
	name = "\improper Allstar SC-1 laser carbine"
	desc = "A basic energy-based laser carbine that fires concentrated beams of light which pass through glass and thin metal."
	icon = 'modular_zubbers/icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/laser/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Allstar Inc. StarCombat Mk. 1 (SC-1) is an energy gun that fires concentrated laser bolts through patented plasma lenses. \
		It was originally designed for fighting in space, hence the name, with bolts that can phase through windows and other translucent barriers. \
		<br>\
		Simple by design and cheap to produce, it has since become the backbone of countless security forces and military units, including Nanotrasen, \
		and is one of the most widely recognised and used firearms in the galaxy.<br>\
		<br>\
		Its distinctive silhouette has become a cultural sensation, and is often seen \
		alongside other iconic weapons in videogames and action movies.<br>\
		<br>\
		The SC-1's reliability is what allowed it to remain so popular despite its age \
		and despite the existence of newer models, such as the Mk. 2.<br>\
		<br>\
		The affordability and convenience, however, come with a catch: the weapon inherits the weaknesses of many energy weapons contemporary with its design; \
		its integrated power supply unit cannot be shielded against electromagnetic pulses without choking off thermal distribution to the heatsink, so the \
		engineers had to make a few sacrifices to avoid the risk of the weapon cooking the wielder's hands after prolonged usage and, in the worst cases, exploding in their face." \
	)

/obj/item/gun/energy/laser/carbine
	name = "\improper Allstar SC-1A laser auto-carbine"
	desc = "An basic energy-based laser auto-carbine that rapidly fires weakened, concentrated beams of light which pass through glass and thin metal."

/obj/item/gun/energy/laser/carbine/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Allstar Inc. StarCombat Mk. 1A is the automatic variant of the SC-1, an energy gun that fires concentrated laser bolts through patented plasma lenses. \
		It trades power for each shot for an automatic mode which boasts a much higher rate of fire, much more suited for suppression and close-quarter engagements.<br>\
		<br>\
		Much like its variant, the platform inherits the weaknesses of many energy weapon of its era; \
		its power supply unit cannot be shielded electromagnetic pulses without choking off thermal distribution to the heatsink. \
		The higher rate of fire of the SC-1A makes it much worse, taking months of research just to find a heat regulation \
		system efficient enough to sustain a full discharge without excessively burning the hands of the user."\
	)

/obj/item/gun/energy/laser/retro
	name = "\improper Allstar LR-1 energy gun"
	desc = "A relic of the past, Allstar's first foray into energy weapons, long abandoned, much less effective and safe compared to its many successors. Nevertheless, it is still quite deadly and easy to maintain, making it a favorite amongst pirates and other outlaws."

/obj/item/gun/energy/laser/retro/old/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_REMOVED)

/obj/item/gun/energy/laser/retro/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Allstar Inc. LR Mk. 1 is one of the earliest man-portable laser weapons ever fielded. This prototype is a heavy relic of a time now long gone. \
		A single oversized lens, a power cell just slightly smaller than a brick and a primitive cooling system make up this vintage beauty. <br>\
		<br>\
		There is a reason why the LR-1 was quickly abadoned in favour of its successor, with myths and legends being born in regards to how Allstar got rid of all of them. \
		Some say that they buried all of these weapons in a ditch somewhere, others that they simply dumped all of them into space. \
		Regardless, one way or another, heaps of surplus found themselves on the markets, being sold off for scraps, or salvaged from wrecks and derelicts.<br>\
		<br>\
		The LR-1 is now most often seen in the hands of pirates, smugglers and gangs too poor to afford anything newer. \
		Occasionally, however, a rare intact sample shows up, attracting the interest of relic collectors and scalpers alike, often selling for outrageous prices." \
	)

/obj/item/gun/energy/laser/hellgun
	name = "\improper 'Hellfire' energy rifle"
	desc = "A black market modification of the SC-1 that trades efficiency and safety for raw power, resulting in devastating burns on impact."
	icon = 'modular_zubbers/icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/laser/hellgun/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hellgun)

/datum/atom_skin/hellgun
	abstract_type = /datum/atom_skin/hellgun

/datum/atom_skin/hellgun/allstar
	preview_name = "Allstar"
	new_icon_state = "hellgun"

/datum/atom_skin/hellgun/nanotrasen
	preview_name = "Nanotrasen"
	new_icon_state = "bshg"

/datum/atom_skin/hellgun/legacy
	preview_name = "Legacy"
	new_icon_state = "hellgun_legacy"

/obj/item/gun/energy/laser/hellfire/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The 'Hellfire' is an illegal, black market modification of the SC-1. Its battery has been reconfigured to dump power into each shot at the cost of efficiency, \
		and several safety measures are bypassed or stripped out entirely for spare parts. \
		The resulting laser bolts leave devastating burns, giving the modification its name, making the weapon far more dangerous to the person on the other end of it, as well as the wielder.<br>\
		<br>\
		Technically classified as contraband in most sectors of space, the Hellfire is nonetheless found in nearly every kind of hand, \
		especially in remote sectors such as the Spinward or C7: \
		pirates, smugglers, mercenaries, militias, FTUs and colonists.<br>\
		<br>\
		Hellfires are generally assembled in back-alley chop shops from stolen or secondhand SC-1s, so no two are alike.\
		Because the modifications worsen the weapon's existing flaw, a Hellfire runs hot, and the longer it is fired, the more likely it is to malfunction.<br>\
		<br>\
		Needless to say, the warranty for it is void."\
	)

/obj/item/gun/energy/ionrifle
	icon = 'modular_zubbers/icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/ionrifle/carbine
	icon = 'modular_zubbers/icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/e_gun
	name = "\improper Allstar SC-2 energy carbine"
	desc = "A basic hybrid energy carbine with two settings: disable and kill."
	icon = 'modular_zubbers/icons/obj/weapons/guns/energy.dmi'
	shaded_charge = SHADED_CHARGE_MODE_LABELED

/obj/item/gun/energy/laser/xray
	name = "\improper Allstar SC-XR Prototype xray rifle"
	desc = "A highly experimental energy rifle that fires concentrated x-ray beams capable of phasing through most walls and surfaces. Technically a confidential Allstar prototype."
	icon = 'modular_zubbers/icons/obj/weapons/guns/energy.dmi'
	shaded_charge = SHADED_CHARGE_MODE_LABELED

/obj/item/gun/energy/laser/xray/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Allstar SC-XR Prototype, also known by its design document codename, 'Skeleton Key', is a heavily modified descendant of the StarCombat line of firearms. \
		Concentrated rays pass through a series of synthetic crystal lenses, discharged into powerful x-ray radiations. \
		The resulting beam is a powerful beam that phases through most walls and surfaces, only releasing energy once it hits organic matter.<br>\
		<br>\
		This specific design is technically confidential; it's a classified Allstar prototype and the circumstances behind its leak remain, to this day, still unclear. \
		Whatever the case, the schematics are now in circulation, so they have begun spreading across the galaxy.<br>\
		<br>\
		Long-term exposure to the weapon is likely hazardous to anyone nearby, though studies are yet to be done. \
		Allstar Inc. was obviously quick to point out that the design is an unauthorised leak and, as such, accepts no responsibility for any harm that results from prolonged usage of the SC-XR."\
	)

/obj/item/gun/energy/e_gun/stun
	shaded_charge = FALSE

/obj/item/gun/energy/e_gun/old
	shaded_charge = FALSE

/obj/item/gun/energy/e_gun/dragnet
	shaded_charge = FALSE

/obj/item/gun/energy/e_gun/turret
	shaded_charge = FALSE

/obj/item/gun/energy/e_gun/advtaser/mounted
	shaded_charge = FALSE

/obj/item/gun/energy/laser
	icon = 'modular_zubbers/icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/laser/retro/old/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ALLSTAR_NT)

/obj/item/gun/energy/laser/captain/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "For a brief period, Allstar and Nanotrasen collaborated to produce a series of custom-made SC-1 laser guns for a select group of clients, primarily composed of wealthy starship captains, politicians, and military leaders looking to demonstrate prestige before the common folk. \
		The SC-1-HE, 'Hellfire Edition' delivered devastating shots through its improved lenses and, at the same time, holding an internal microfusion cell which replenished itself between shots.<br>\
		<br>\
		The line ended up being a massive failure. As it turned out, the weapon was an actual war crime. \
		Several laws and regulations had to be written as a result of this weapon, resulting in a scandal terrific enough to see the program shelved.<br>\
		<br>\
		Copies are now prohibited within TerraGov space, and any that are seized are quickly decommissioned. \
		This is largely why Nanotrasen insists that any examples held by ranking officers be kept under lock and key. \
		All records of the schematics were seized and destroyed. \
		One of the designers was detained in a maximum security sanatorium, while the other was unfortunately involved in a defenestration, which was quickly ruled out as suicide due to guilt.<br>\
		<br>\
		Eventually, however, Black Market weapon modders managed to copy and imitate this weapon, mainly via telephone game, \
		resulting in a crude, unreliable copy of the Hellfires now circulating among the lowest circles and sectors of space.<br>\
		<br>\
		The Syndicate, however, has been particularly interested in directly studying the older prototypes of this weapon. \
		A good captain ought to make sure that this weapon remains safe at all times... or not."\
	)

/obj/item/gun/energy/laser/soul
	name = "\improper Allstar LR-2 energy gun"
	desc = "A relic of the past, Allstar's (almost) Swansong, the SC-1's cousin. This baby almost brought Allstar into ruin. Now it's a beautiful collector's item, which, unlike its predecessor the LR-1, is actually functional."

/obj/item/gun/energy/laser/soul/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Allstar Inc. LR Mk. 2 was the last rifle in the company's LR line, and very nearly the last product Allstar ever made, its swan song. \
		It was a capable weapon, a vast improvement over the bulky LR-1, with a refined plasma lens, a better cooling system, and a power cell that only weighed as much as a brick, instead of being as big as one. \
		It was also however ruinously expensive.<br>\
		<br>\
		Every part of the LR-2 required immense care to work, and that's what made its production costs hike. \
		It was more or less a gamble, hoping that investors would be interested in giving money to Allstar, and for the clientele to be interested in the product. \
		Unfortunately, neither of them were.<br>\
		<br>\
		What saved the company was what they had learned from the LR-2. \
		The engineers had learned where the design could be simplified, and what could be dropped to lower the price a little.\
		Eventually, the LR line failed, being replaced instead by the SC. The LR walked so that the SC could run.<br>\
		<br>\
		Surviving LR-2s are uncommon and prized and, unlike the LR-1, much more usable. \
		Collectors and veterans both seek them out, even if the price has only raised ever since Allstar stopped producing them."\
	)

/obj/item/gun/energy/laser/pistol
	name = "\improper Allstar SC-1P laser pistol"
	desc = "A relic of the past, Allstar's (almost) Swansong, the SC-1's cousin. This baby almost brought Allstar into ruin. Now it's a beautiful collector's item, which, unlike its predecessor the LR-1, is actually functional."

/obj/item/gun/energy/laser/pistol/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Allstar Inc. StarCombat Mk. 1P is a compact sidearm built in the shadow of its larger sibling, the SC-1, It trades range and power for size, \
		making it a popular backup weapon for security officers, ship crews, \
		and anyone who might want a laser in their pocket.<br>\
		<br>\
		To this day, the SC-1P has yet to be replaced. \
		Even those who caved in and replaced their old Mk. 1s with Mk. 2s still likely carry a Mk. 1P. \
		Most of it is due to how simply expensive it is to keep the qualities of the Mk. 2 while, at the same time, making it small enough.<br>\
		<br>\
		Like every Allstar energy weapon, it carries the weapon's old weakness. \
		It cannot be properly shielded against electromagnetic pulses without compromising the heatsink, even more so due to the much smaller size of the weapon."\
	)

/obj/item/gun/energy/disabler
	icon = 'modular_zubbers/icons/obj/weapons/guns/energy.dmi'
	shaded_charge = TRUE

/obj/item/gun/energy/disabler/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/disabler)

/datum/atom_skin/disabler
	abstract_type = /datum/atom_skin/disabler

/datum/atom_skin/disabler/allstar
	preview_name = "Allstar"
	new_icon_state = "disabler"

/datum/atom_skin/disabler/legacy
	preview_name = "Legacy"
	new_icon_state = "disabler_legacy"

/obj/item/gun/energy/disabler/smg/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/disabler_smg)

/datum/atom_skin/disabler_smg
	abstract_type = /datum/atom_skin/disabler_smg

/datum/atom_skin/disabler_smg/allstar
	preview_name = "Allstar"
	new_icon_state = "disabler_smg"

/datum/atom_skin/disabler_smg/legacy
	preview_name = "Legacy"
	new_icon_state = "disabler_smg_legacy"

/obj/item/gun/energy/e_gun/nuclear
	icon = 'modular_zubbers/icons/obj/weapons/guns/energy.dmi'
	ammo_x_offset = 2
	shaded_charge = FALSE
