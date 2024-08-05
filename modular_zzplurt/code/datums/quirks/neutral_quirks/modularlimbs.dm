/datum/quirk/modularlimbs
	name = "Modular Limbs"
	desc = "Your limbs are able to be attached and detached easily... Unfortunately, everyone around you can alter your limbs too!"
	icon = FA_ICON_PUZZLE_PIECE
	value = 0
	medical_record_text = "Patient's limbs seem to be easily detachable and reattachable."

/datum/quirk/modularlimbs/add(client/client_source)
	var/mob/living/carbon/human/C = quirk_holder
	add_verb(C,/mob/living/proc/alterlimbs)

/datum/quirk/modularlimbs/remove()
	var/mob/living/carbon/human/C = quirk_holder
	remove_verb(C,/mob/living/proc/alterlimbs)

/mob/living/proc/alterlimbs()
	set name = "Alter Limbs"
	set desc = "Remove or attach a limb!"
	set category = "IC"
	set src in view(usr.client)

	var/mob/living/carbon/human/U = usr
	var/mob/living/carbon/human/C = src

	var/obj/item/I = U.get_active_held_item()
	if(istype(I,/obj/item/bodypart))
		var/obj/item/bodypart/L = I
		if(!C.Adjacent(U))
			to_chat(U, span_warning("You must be adjacent to [C] to do this!"))
			return
		if(C.get_bodypart(L.body_zone))
			to_chat(U, span_warning("[C] already has a limb attached there!"))
			return
		C.visible_message(span_warning("[U] is attempting to attach [L] onto [C]!"), span_userdanger("[U] is attempting to re-attach one of your limbs!"))
		if(do_after(U, 40, target = C) && C.Adjacent(U))
			L.try_attach_limb(C)
			C.visible_message(span_warning("[U] successfully attaches [L] onto [C]"), span_userdanger("[U] has successfully attached a [L.name] onto you; you can use that limb again!"))
			return
		else
			to_chat(U, span_warning("You and [C] must both stand still for you to remove one of their limbs!"))
			return
	else
		if(!C.Adjacent(U))
			to_chat(U, span_warning("You must be adjacent to [C] to do this!"))
			return
		if(U.zone_selected == BODY_ZONE_CHEST || U.zone_selected == BODY_ZONE_HEAD)
			to_chat(U, span_warning("You must target either an arm or a leg!"))
			return
		if(U.zone_selected == BODY_ZONE_PRECISE_GROIN || U.zone_selected == BODY_ZONE_PRECISE_EYES || U.zone_selected == BODY_ZONE_PRECISE_MOUTH)
			to_chat(U, span_warning("There is no limb here; select an arm or a leg!"))
			return
		if(!C.get_bodypart(U.zone_selected))
			to_chat(U, span_warning("They are already missing that limb!"))
			return
		C.visible_message(span_warning("[U] is attempting to remove one of [C]'s limbs!"), span_userdanger("[U] is attempting to disconnect one of your limbs!"))
		var/obj/item/bodypart/B = C.get_bodypart(U.zone_selected)
		if(C.Adjacent(U) && do_after(U, 40, target = C))
			var/obj/item/bodypart/D = C.get_bodypart(U.zone_selected)
			if(B != D)
				to_chat(U, span_warning("You cannot target a different limb while already removing another!"))
				return
			D.drop_limb()
			C.update_equipment_speed_mods()
			C.visible_message(span_warning("[U] smoothly disconnects [C]'s [D.name]!"), span_userdanger("[U] has forcefully disconnected your [D.name]!"))
			return
		else
			to_chat(U, span_warning("You and [C] must both stand still for you to remove one of their limbs!"))
			return
