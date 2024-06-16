/datum/reagent/changeling_zombie_virus
	name = "NT-CZV-1"
	description = "\[CLASSIFED\]. THIS INCIDENT HAS BEEN REPORTED. DO NOT CONSUME. DISPOSE OF SAFELY."
	color = "#191dff"
	metabolization_rate = INFINITY
	taste_description = "spare change"
	ph = 0.5

/datum/reagent/changeling_zombie_virus/expose_mob(mob/living/carbon/human/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(can_become_changeling_zombie(exposed_mob))
		exposed_mob.AddComponent(/datum/component/changeling_zombie_infection)

/obj/item/reagent_containers/cup/glass/changeling_zombie_virus
	name = "NT-CZV vial"
	desc = "A small bottle of the NT-CZV pathogen. Nanotrasen Bioweapons inc."
	icon = 'modular_skyrat/modules/mutants/icons/extractor.dmi'
	icon_state = "tvirus_infector"
	list_reagents = list(/datum/reagent/changeling_zombie_virus=30)
	custom_materials = list(
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/reagent_containers/cup/glass/changeling_zombie_virus/empty
	list_reagents = list()

/obj/item/reagent_containers/cup/glass/changeling_zombie_virus/smash(...)
	. = ..()
	if(.)
		var/datum/D = .
		D.AddComponent(/datum/component/changeling_zombie_infection_item)

/datum/component/changeling_zombie_infection_item/Initialize()
	. = ..()
	if (!isitem(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/changeling_zombie_infection_item/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equipped))

/datum/component/changeling_zombie_infection_item/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ITEM_EQUIPPED)


/datum/component/changeling_zombie_infection_item/proc/on_equipped(datum/source, mob/user, slot)

	SIGNAL_HANDLER

	if(!(slot & ITEM_SLOT_HANDS))
		return

	if(!ishuman(user) && !can_become_changeling_zombie(user))
		return

	var/mob/living/carbon/human/infecting_human = user

	var/held_index = infecting_human.get_held_index_of_item(parent)

	if(!held_index)
		return

	var/obj/item/bodypart/found_hand = infecting_human.hand_bodyparts[held_index]

	if(!found_hand || !(found_hand.bodytype & BODYTYPE_ORGANIC))
		return

	if(isobj(infecting_human.wear_suit) && (infecting_human.wear_suit.body_parts_covered & HANDS) && prob(infecting_human.wear_suit.get_armor_rating(BIO)))
		return

	if(isobj(infecting_human.gloves) && (infecting_human.gloves.body_parts_covered & HANDS) && prob(infecting_human.gloves.get_armor_rating(BIO)))
		return

	if(infecting_human.AddComponent(/datum/component/changeling_zombie_infection))
		to_chat(infecting_human,span_warning("You accidentally scratch your [found_hand.name] on [source]. Ouch."))
		found_hand.receive_damage(1)
