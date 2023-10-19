/obj/item/mod/control/pre_equipped/contractor/set_wearer(mob/living/carbon/human/user)
	. = ..()
	var/obj/item/I = src
	ADD_TRAIT(I, TRAIT_NODROP, GLUED_ITEM_TRAIT)

/obj/item/mod/control/pre_equipped/ninja/set_wearer(mob/living/carbon/human/user)
	. = ..()
	var/obj/item/I = src
	ADD_TRAIT(I, TRAIT_NODROP, GLUED_ITEM_TRAIT)
