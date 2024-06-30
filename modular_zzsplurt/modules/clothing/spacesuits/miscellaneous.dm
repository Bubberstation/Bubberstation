//We can either be alive monsters or dead monsters, you choose.
/obj/item/clothing/head/helmet/space/hardsuit/combatmedic
	name = "endemic combat medic helmet"
	desc = "The integrated helmet of the combat medic hardsuit, this has a bright, glowing facemask."
	icon_state = "hardsuit0-combatmedic"
	inhand_icon_state = "hardsuit0-combatmedic"
	armor_type = /datum/armor/combatmedic_hardsuit
	hardsuit_type = "combatmedic"

/datum/armor/combatmedic_hardsuit
	melee = 35
	bullet = 10
	laser = 20
	energy = 30
	bomb = 5
	bio = 100
	fire = 65
	acid = 75
	wound = 10

/obj/item/clothing/suit/space/hardsuit/combatmedic
	name = "endemic combat medic hardsuit"
	desc = "The standard issue hardsuit of infectious disease officers, before the formation of ERT teams. This model is labeled 'Veradux'."
	icon_state = "combatmedic"
	inhand_icon_state = "combatmedic"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/combatmedic
	armor_type = /datum/armor/combatmedic_hardsuit
	allowed = list(/obj/item/gun, /obj/item/melee/baton, /obj/item/circular_saw, /obj/item/tank/internals, /obj/item/storage/box/pillbottles,\
	/obj/item/storage/medkit, /obj/item/stack/medical/gauze, /obj/item/stack/medical/suture, /obj/item/stack/medical/mesh, /obj/item/storage/bag/chemistry)

//Carpsuit, bestsuit, lovesuit
/obj/item/clothing/head/helmet/space/hardsuit/carp
	name = "carp helmet"
	desc = "Spaceworthy and it looks like a space carp's head, smells like one too."
	icon_state = "carp_helm"
	inhand_icon_state = "syndicate"
	armor_type = /datum/armor/carp_hardsuit
	light_system = NO_LIGHT_SUPPORT
	light_range = 0 //luminosity when on
	actions_types = list()
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR //facial hair will clip with the helm, this'll need a dynamic_fhair_suffix at some point.

/datum/armor/carp_hardsuit
	melee = -20
	bullet = 0
	laser = 0
	energy = 0
	bomb = 0
	bio = 100
	fire = 60
	acid = 75
	wound = 10

/obj/item/clothing/head/helmet/space/hardsuit/carp/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, LOCKED_HELMET_TRAIT)

/obj/item/clothing/suit/space/hardsuit/carp
	name = "carp space suit"
	desc = "A slimming piece of dubious space carp technology, you suspect it won't stand up to hand-to-hand blows."
	icon_state = "carp_suit"
	inhand_icon_state = "space_suit_syndicate"
	slowdown = 0 //Space carp magic, never stop believing
	armor_type = /datum/armor/carp_hardsuit
	allowed = list(/obj/item/tank/internals, /obj/item/gun/ballistic/rifle/boltaction/harpoon) //I'm giving you a hint here
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/carp

/obj/item/clothing/head/helmet/space/hardsuit/carp/equipped(mob/living/carbon/human/user, slot)
	..()
	if (slot == ITEM_SLOT_HEAD)
		user.faction |= "carp"

/obj/item/clothing/head/helmet/space/hardsuit/carp/dropped(mob/living/carbon/human/user)
	..()
	if (user.head == src)
		user.faction -= "carp"

/obj/item/clothing/suit/space/hardsuit/carp/old
	name = "battered carp space suit"
	desc = "It's covered in bite marks and scratches, yet seems to be still perfectly functional."
	slowdown = 1
