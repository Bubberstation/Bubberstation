//BUBBER EDIT (item quirk)
/datum/quirk/item_quirk/settler
	name = "Settler"
	//BUBBER EDIT (Changes text a bit)
	desc = "You are from a lineage of the earliest space settlers!  You are much better at outdoorsmanship and \
		carrying heavy equipment. You also get along great with animals. However, you are a bit on the slow side due to your small legs."
	gain_text = span_bold("You feel like the world is your oyster!")
	lose_text = span_danger("You think you might stay home today.")
	icon = FA_ICON_HOUSE
	value = 4
	mob_trait = TRAIT_SETTLER
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	medical_record_text = "Patient has been exposed to planetary conditions for extended periods, resulting in an excessively stout build."
	mail_goodies = list(
		/obj/item/clothing/shoes/workboots/mining,
		/obj/item/gps,
	)
	/// Most of the behavior of settler is from these traits, rather than exclusively the quirk
	var/list/settler_traits = list(
		TRAIT_EXPERT_FISHER,
		TRAIT_ROUGHRIDER,
		TRAIT_STUBBY_BODY,
		TRAIT_BEAST_EMPATHY,
		TRAIT_STURDY_FRAME,
	)

//BUBBER EDIT (item quick)
/datum/quirk/item_quirk/settler/add(client/client_source)
	var/mob/living/carbon/human/human_quirkholder = quirk_holder
	//SKYRAT EDIT BEGIN - This is so Teshari don't get the height decrease.
	//BUBBER EDIT REMOVAL START - Lol, not any more.
	//if(!isteshari(human_quirkholder))
	//	human_quirkholder.set_mob_height(HUMAN_HEIGHT_SHORTEST)
	//BUBBER EDIT REMOVAL END
	//SKYRAT EDIT END
	human_quirkholder.add_movespeed_modifier(/datum/movespeed_modifier/settler)
	human_quirkholder.physiology.hunger_mod *= 0.75 // BUBBER EDIT - ADDITION
	human_quirkholder.add_traits(settler_traits, QUIRK_TRAIT)

//BUBBER EDIT START
/datum/quirk/item_quirk/settler/add_unique(client/client_source)
	give_item_to_holder(/obj/item/storage/box/papersack/wheat, list(LOCATION_BACKPACK, LOCATION_HANDS))
	give_item_to_holder(/obj/item/storage/toolbox/fishing/small, list(LOCATION_BACKPACK, LOCATION_HANDS))
//BUBBER EDIT END

/datum/quirk/item_quirk/settler/remove()
	if(QDELING(quirk_holder))
		return
	var/mob/living/carbon/human/human_quirkholder = quirk_holder
	//BUBBER EDIT REMOVAL START
	//human_quirkholder.set_mob_height(HUMAN_HEIGHT_MEDIUM)
	//BUBBER EDIT REMOVAL END
	human_quirkholder.remove_movespeed_modifier(/datum/movespeed_modifier/settler)
	//BUBBER EDIT
	human_quirkholder.physiology.hunger_mod /= 0.75
	human_quirkholder.remove_traits(settler_traits, QUIRK_TRAIT)
