/obj/item/nullrod/sylvanstaff
	name = "Sylvan Staff"
	desc = "Dryads and druids use staves like this one as a focus to better attune with Nature"
	icon = 'icons/obj/weapons/guns/magic.dmi'
	icon_state = "staffofdoor"
	inhand_icon_state = "staffofdoor"
	icon_angle = -45
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/staves_righthand.dmi'
	damtype = BURN
	force = 16
	throwforce = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("bashes", "smacks", "whacks")
	attack_verb_simple = list("bash", "smack", "whack")
	menu_description = "A staff strongly attuned to nature. Doesnt hit as hard, but deals burn damage, also has a chance to transfer your reagents to the target. Wearable in the back."

// Pride hammer reagent transfer effect.

#define CHEMICAL_TRANSFER_CHANCE 30

/obj/item/nullrod/sylvanstaff/Initialize(mapload)
	. = ..()
	AddElement(
		/datum/element/chemical_transfer,\
		span_notice("You feel your body being cleansed"),\
		span_userdanger("You feel the hit transfer impurities within you."),\
		CHEMICAL_TRANSFER_CHANCE\
	)

#undef CHEMICAL_TRANSFER_CHANCE

// makes the staff function as a cultivator

/obj/item/nullrod/sylvanstaff/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
    if(istype(/obj/machinery/hydroponics, target))
       if(weedlevel > 0)
            user.visible_message(span_notice("[user] uproots the weeds."), span_notice("You remove the weeds from [src]."))
            set_weedlevel(0)
            return
        else
            to_chat(user, span_warning("This plot is completely devoid of weeds! It doesn't need uprooting."))
            return
