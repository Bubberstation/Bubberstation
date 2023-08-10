//Use this to add item variations

/obj/item/uplink/opfor
	name = "old radio"
	desc = "A dusty and old looking radio."

/obj/item/uplink/opfor/Initialize(mapload, owner, tc_amount = 0)
	. = ..()
	var/datum/component/uplink/hidden_uplink = GetComponent(/datum/component/uplink)
	hidden_uplink.name = "old radio"

/obj/item/reagent_containers/cup/rag/large
	volume = 30
	amount_per_transfer_from_this = 30
	desc = "A damp rag made from a highly absorbant materials. Can hold up to 30u liquids. You can also clean up messes I guess."


/obj/item/storage/box/syndie_kit/gunman_outfit
	name = "gunman clothing bundle"
	desc = "A box filled with armored and stylish clothing for the aspiring gunmans."

/obj/item/clothing/suit/armor/vest/leather/gunman
	name = "leather overcoat"
	desc = "An armored leather overcoat, intended as the go-to wear for any aspiring gunman."
	body_parts_covered = CHEST|GROIN|ARMS
	armor_type = /datum/armor/leather_gunman

/datum/armor/leather_gunman
	melee = 45
	bullet = 40
	laser = 40
	energy = 50
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/obj/item/storage/box/syndie_kit/gunman_outfit/PopulateContents() // 45, 40 armor on general without a helmet.
	new /obj/item/clothing/under/pants/black/robohand(src)
	new /obj/item/clothing/glasses/sunglasses/robohand(src)
	new /obj/item/clothing/suit/armor/vest/leather/gunman(src)
	new /obj/item/clothing/shoes/combat(src)

/obj/item/autosurgeon/syndicate/hackerman
	starting_organ = /obj/item/organ/internal/cyberimp/arm/hacker

/obj/item/storage/box/syndie_kit/insurgent
	name = "syndicate insurgent bundle"
	desc = "A box containing everything you need to LARP as your favorite syndicate operative!"

/obj/item/storage/box/syndie_kit/insurgent/PopulateContents()
	new /obj/item/clothing/under/syndicate(src)
	new /obj/item/clothing/gloves/tackler/combat(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/mask/gas/sechailer/swat(src)
	new /obj/item/storage/belt/military(src)
	new /obj/item/card/id/advanced/chameleon(src)
	new /obj/item/mod/control/pre_equipped/nuclear(src)

/obj/item/guardiancreator/tech/choose/traitor/opfor
	allowling = TRUE

/obj/item/clothing/suit/toggle/lawyer/black/better/heister
	name = "armored suit jacket"
	desc = "A professional suit jacket, it feels much heavier than a regular jacket. A label on the inside reads \"Nanite-based Self-repairing Kevlar weave\"."
	armor_type = /datum/armor/better_heister
	/// How many hits we can take before the armor breaks, PAYDAY style
	var/armor_stacks = 2

/datum/armor/better_heister
	melee = 35
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/suit/toggle/lawyer/black/better/heister/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/shielded/suit, max_charges = armor_stacks, recharge_start_delay = 8 SECONDS, charge_increment_delay = 1 SECONDS, \
	charge_recovery = armor_stacks, lose_multiple_charges = FALSE, starting_charges = armor_stacks, shield_icon_file = null, shield_icon = null)

/obj/item/clothing/suit/toggle/lawyer/black/better/heister/equipped(mob/living/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_OCLOTHING))
		return
	RegisterSignal(user, COMSIG_HUMAN_CHECK_SHIELDS, PROC_REF(armor_reaction))

/obj/item/clothing/suit/toggle/lawyer/black/better/heister/proc/armor_reaction(mob/living/carbon/human/owner, atom/movable/hitby, damage = 0, attack_text = "the attack", attack_type = MELEE_ATTACK, armour_penetration = 0)
	if(SEND_SIGNAL(src, COMSIG_ITEM_HIT_REACT, owner, hitby, attack_text, 0, damage, attack_type) & COMPONENT_HIT_REACTION_BLOCK)
		return SHIELD_BLOCK
	return NONE

/obj/item/clothing/gloves/latex/nitrile/heister
	desc = "Pricy sterile gloves that are thicker than latex. Perfect for hiding fingerprints."
	clothing_traits = null
	siemens_coefficient = 0

/obj/item/storage/backpack/duffelbag/heister
	name = "lightweight duffel"
	desc = "A large duffel bag for holding extra things. This one seems to be stitched with extra-light fabric, enabling easier movement."
	slowdown = 0
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/duffelbag/heister/PopulateContents()
	var/list/non_cursed_masks = subtypesof(/obj/item/clothing/mask/animal) - /obj/item/clothing/mask/animal/small //abstract
	non_cursed_masks.Remove(GLOB.cursed_animal_masks)
	var/obj/picked_mask = pick(non_cursed_masks)
	var/obj/item/clothing/mask/animal/new_mask = new picked_mask(src)
	new_mask.clothing_flags = VOICEBOX_DISABLED
	new_mask.set_armor(new_mask.get_armor().generate_new_with_specific(list(
		MELEE = 30,
		BULLET = 25,
		LASER = 25,
		ENERGY = 25,
		BOMB = 0,
		BIO = 0,
		FIRE = 100,
		ACID = 100,
	)))
	new /obj/item/clothing/gloves/latex/nitrile/heister(src)
	new /obj/item/clothing/under/suit/black(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/clothing/suit/toggle/lawyer/black/better/heister(src)
	new /obj/item/restraints/handcuffs/cable/zipties(src)
	new /obj/item/restraints/handcuffs/cable/zipties(src)
