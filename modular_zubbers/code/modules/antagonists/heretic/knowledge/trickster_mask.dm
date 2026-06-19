/datum/heretic_knowledge/tricksters_mask
	name = "Trickster's Mask"
	desc = "Sacrifice a bandana and a spray can to create a shapeshifting mask that makes you sound like whatever your ID card is set to."
	gain_text = "The Masquerade has always been dominated by the Bleeding Trickster, with its shifting face and form."
	required_atoms = list(
		/obj/item/clothing/mask/bandana = 1,
		/obj/item/toy/crayon/spraycan = 1,
	)
	result_atoms = list(/obj/item/clothing/mask/chameleon/heretic)
	drafting_tier = 1
	drafting_cost = 0.5
	research_tree_icon_path = 'icons/map_icons/clothing/mask.dmi'
	research_tree_icon_state = "/obj/item/clothing/mask/bandana/white"

/obj/item/clothing/mask/chameleon/heretic

/obj/item/clothing/mask/chameleon/heretic/examine(mob/user)
	. = ..()

	if (IS_HERETIC_OR_MONSTER(user))
		. += span_notice("You recognize this as the trickster's mask. Wearing it will force your voice to be whatever your current ID says.")

/obj/item/clothing/mask/chameleon/heretic/attack_self(mob/user)
	return // you cant disable it
