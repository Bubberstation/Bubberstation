/obj/structure/chair/is_user_buckle_possible(mob/living/target, mob/user, check_loc)
	if (!iscarbon(target))
		return ..()
	
	if(HAS_TRAIT(target, TRAIT_NO_BUCKLE))
		return FALSE

	return ..()

/obj/structure/chair/user_buckle_mob(mob/living/M, force, check_loc)
	if (!istype(M, /mob/living/carbon))
		return ..()

	var/mob/living/carbon/fatty = M

	if (isnull(fatty.client))
		return ..()

	if (isnull(fatty.client.prefs))
		return ..()

	var/chair_breakage = fatty.client.prefs.read_preference(/datum/preference/numeric/helplessness/chair_breakage)

	if (chair_breakage)
		if (fatty.fatness > chair_breakage)
			. = ..()
			deconstruct()
			return

	return ..()

/obj/structure/chair/buckle_feedback(mob/living/being_buckled, mob/buckler)
	. = ..()
	if (!istype(being_buckled, /mob/living/carbon))
		return

	var/mob/living/carbon/fatty = being_buckled

	if (isnull(fatty.client))
		return

	if (isnull(fatty.client.prefs))
		return

	var/chair_breakage = fatty.client.prefs.read_preference(/datum/preference/numeric/helplessness/chair_breakage)

	if (chair_breakage == 0)
		return
	
	if (fatty.fatness >= chair_breakage)
		fatty.visible_message(
		span_notice("[buckler] slowly buckles [fatty] to [src]. Their movements slow and deliberate. As [fatty] settles into the seat, a sudden, violent crash echoes through the air. [fatty]'s massive weight mercilessly crushes the poor [src], reducing it to pieces!"),
		span_notice("You slowly try to buckle yourself to [src]. But it breaks under your massive ass!")
		)

		playsound(loc, 'sound/effects/snap.ogg', 50, 1)
		playsound(loc, 'sound/effects/woodhit.ogg', 50, 1)
		// playsound(loc, 'sound/effects/bodyfall4.ogg', 50, 1)

		return
	
	if (fatty.fatness >= chair_breakage / 2)
		fatty.visible_message(
		span_notice("[buckler] buckles [fatty] to the creaking [src]. The [src] protests audibly under the weight as [fatty]'s ample form settles onto its surface."),
		span_notice("You buckle yourself to [src]. The [src] is cracking and is barely able to hold your weight.")
		)

		playsound(loc, 'modular_gs/sound/effects/crossed.ogg', 50, 1)

		return

	if (fatty.fatness >= chair_breakage / 3)
		fatty.visible_message(
		span_notice("[buckler] buckles [fatty] to the creaking [src] as their weight spreads all over it."),
		span_notice("You buckle yourself to [src].The [src] is cracking and is barely able to hold your weight.")
		)

		playsound(loc, 'modular_gs/sound/effects/crossed.ogg', 50, 1)


/datum/species/can_equip(obj/item/I, slot, disable_warning, mob/living/carbon/human/H, bypass_equip_delay_self)
	if(!istype(I, /obj/item/mod) && HAS_TRAIT(H, TRAIT_NO_BACKPACK) && slot ==ITEM_SLOT_BACK)
		to_chat(H, "<span class='warning'>You are too fat to wear anything on your back.</span>")
		return FALSE

	if(I.modular_icon_location == null && HAS_TRAIT(H, TRAIT_NO_JUMPSUIT) && slot == ITEM_SLOT_ICLOTHING)
		to_chat(H, "<span class='warning'>You are too fat to wear [I].</span>")
		return FALSE

	if(!mod_check(I) && HAS_TRAIT(H, TRAIT_NO_MISC) && (slot == ITEM_SLOT_FEET || slot ==ITEM_SLOT_GLOVES || slot == ITEM_SLOT_OCLOTHING))
		to_chat(H, "<span class='warning'>You are too fat to wear [I].</span>")
		return FALSE
	
	if(HAS_TRAIT(H, TRAIT_NO_BELT) && slot == ITEM_SLOT_BELT)
		var/belt_BFI = H.client.prefs.read_preference(/datum/preference/numeric/helplessness/belts)
		if(istype(I, /obj/item/bluespace_belt/primitive) && belt_BFI * 2 > H.fatness)
			return ..()

		if(istype(I, /obj/item/bluespace_belt) && !istype(I, /obj/item/bluespace_belt/primitive))
			return ..()
		
		to_chat(H, "<span class='warning'>You are too fat to wear [I].</span>")
		return FALSE


	return ..()

/datum/species/proc/mod_check(I)
	if(istype(I, /obj/item/mod) || istype(I, /obj/item/clothing/head/mod) || istype(I, /obj/item/clothing/gloves/mod) || istype(I, /obj/item/clothing/shoes/mod) || istype(I, /obj/item/clothing/suit/mod) )
		return TRUE
	return FALSE
