// ======================== STATION ======================== //

/datum/armor/hardsuit
	melee = 10
	bullet = 5
	laser = 10
	energy = 20
	bomb = 10
	bio = 100
	fire = 50
	acid = 75
	wound = 10

/datum/armor/hardsuit/engine
	melee = 30
	bullet = 5
	laser = 10
	energy = 20
	bomb = 10
	bio = 100
	fire = 100
	acid = 75
	wound = 10

/datum/armor/hardsuit/engine/elite
	melee = 40
	bullet = 5
	laser = 10
	energy = 20
	bomb = 50
	bio = 100
	fire = 100
	acid = 90
	wound = 10

/datum/armor/hardsuit/engine/ancient
	melee = 30
	bullet = 5
	laser = 5
	energy = 15
	bomb = 50
	bio = 100
	fire = 100
	acid = 75
	wound = 10

/datum/armor/hardsuit/mining
	melee = 30
	bullet = 5
	laser = 10
	energy = 20
	bomb = 50
	bio = 100
	fire = 50
	acid = 75
	wound = 15

/datum/armor/hardsuit/clown
	melee = 30
	bullet = 5
	laser = 10
	energy = 20
	bomb = 10
	bio = 100
	fire = 60
	acid = 30
	wound = 10

/datum/armor/hardsuit/medical
	melee = 30
	bullet = 5
	laser = 10
	energy = 20
	bomb = 10
	bio = 100
	fire = 60
	acid = 75
	wound = 10

/datum/armor/hardsuit/rd
	melee = 30
	bullet = 5
	laser = 10
	energy = 20
	bomb = 100
	bio = 100
	fire = 60
	acid = 80
	wound = 15

/datum/armor/hardsuit/security
	melee = 35
	bullet = 15
	laser = 30
	energy = 40
	bomb = 10
	bio = 100
	fire = 75
	acid = 75
	wound = 20

/datum/armor/hardsuit/security/hos
	melee = 45
	bullet = 25
	laser = 30
	energy = 40
	bomb = 25
	bio = 100
	fire = 95
	acid = 95
	wound = 25

/datum/armor/hardsuit/security/swat
	melee = 40
	bullet = 50
	laser = 50
	energy = 60
	bomb = 50
	bio = 100
	fire = 100
	acid = 100
	wound = 25

/datum/armor/hardsuit/security/swat/mk3
	melee = 80
	bullet = 80
	laser = 50
	energy = 60
	bomb = 100
	bio = 100
	fire = 100
	acid = 100
	wound = 30

/datum/armor/hardsuit/security/ert
	melee = 65
	bullet = 50
	laser = 50
	energy = 60
	bomb = 50
	bio = 100
	fire = 80
	acid = 80
	wound = 25

// ======================== ANTAGONISTS ======================== //

/datum/armor/hardsuit/syndi
	melee = 40
	bullet = 50
	laser = 30
	energy = 40
	bomb = 35
	bio = 100
	fire = 50
	acid = 90
	wound = 25

/datum/armor/hardsuit/syndi/elite
	melee = 60
	bullet = 60
	laser = 50
	energy = 60
	bomb = 55
	bio = 100
	fire = 100
	acid = 100
	wound = 40

/datum/armor/hardsuit/syndi/elite/debug
	melee = 100
	bullet = 100
	laser = 100
	energy = 100
	bomb = 100
	bio = 100
	fire = 100
	acid = 100
	wound = 100

/datum/armor/hardsuit/wizard
	melee = 40
	bullet = 40
	laser = 40
	energy = 50
	bomb = 35
	bio = 100
	fire = 100
	acid = 100
	wound = 30

// ======================== SHIELDED ======================== //

/datum/armor/hardsuit/shielded
	melee = 30
	bullet = 15
	laser = 30
	energy = 40
	bomb = 10
	bio = 100
	fire = 100
	acid = 100
	wound = 15

/datum/armor/hardsuit/shielded/syndie
	melee = 40
	bullet = 50
	laser = 30
	energy = 40
	bomb = 35
	bio = 100
	fire = 100
	acid = 100
	wound = 30

/datum/armor/hardsuit/shielded/swat
	melee = 80
	bullet = 80
	laser = 50
	energy = 60
	bomb = 100
	bio = 100
	fire = 100
	acid = 100
	wound = 30

/obj/item/clothing
	var/alt_desc = null

/mob
	/// I have no idea tbh
	var/research_scanner = FALSE

//Hardsuit toggle code
/obj/item/clothing/suit/space/hardsuit/Initialize(mapload)
	MakeHelmet()
	. = ..()

/obj/item/clothing/suit/space/hardsuit/Destroy()
	if(!QDELETED(helmet))
		helmet.suit = null
		qdel(helmet)
		helmet = null
	if (isatom(jetpack))
		QDEL_NULL(jetpack)
	return ..()

/obj/item/clothing/head/helmet/space/hardsuit/Destroy()
	if(suit)
		suit.helmet = null
	return ..()

/obj/item/clothing/suit/space/hardsuit/proc/MakeHelmet()
	if(!helmettype)
		return
	if(!helmet)
		var/obj/item/clothing/head/helmet/space/hardsuit/W = new helmettype(src)
		W.suit = src
		helmet = W

/obj/item/clothing/suit/space/hardsuit/ui_action_click()
	..()
	ToggleHelmet()

/obj/item/clothing/suit/space/hardsuit/equipped(mob/user, slot)
	if(!helmettype)
		return
	if(slot != ITEM_SLOT_OCLOTHING)
		RemoveHelmet()
	..()

/obj/item/clothing/suit/space/hardsuit/proc/RemoveHelmet()
	if(!helmet)
		return
	helmet_on = FALSE
	if(ishuman(helmet.loc))
		var/mob/living/carbon/H = helmet.loc
		if(helmet.on)
			helmet.attack_self(H)
		H.transferItemToLoc(helmet, src, TRUE)
		H.update_worn_oversuit()
		to_chat(H, span_notice("The helmet on the hardsuit disengages."))
		playsound(src.loc, 'sound/mecha/mechmove03.ogg', 50, TRUE)
	else
		helmet.forceMove(src)

/obj/item/clothing/suit/space/hardsuit/dropped()
	..()
	RemoveHelmet()

/obj/item/clothing/suit/space/hardsuit/proc/ToggleHelmet()
	var/mob/living/carbon/human/H = src.loc
	if(!helmettype)
		return
	if(!helmet)
		to_chat(H, span_warning("The helmet's lightbulb seems to be damaged! You'll need a replacement bulb."))
		return
	if(!helmet_on)
		if(ishuman(src.loc))
			if(H.wear_suit != src)
				to_chat(H, span_warning("You must be wearing [src] to engage the helmet!"))
				return
			if(H.head)
				to_chat(H, span_warning("You're already wearing something on your head!"))
				return
			else if(H.equip_to_slot_if_possible(helmet,ITEM_SLOT_HEAD,0,0,1))
				to_chat(H, span_notice("You engage the helmet on the hardsuit."))
				helmet_on = TRUE
				H.update_worn_oversuit()
				playsound(src.loc, 'sound/mecha/mechmove03.ogg', 50, TRUE)
	else
		RemoveHelmet()
