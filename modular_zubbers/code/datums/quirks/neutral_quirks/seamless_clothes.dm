/datum/quirk/equipping/seamless_clothes
	name = "Seamless Heels"
	desc = "You come with heels stuck on you. Whether it be a freak accident or part of your design, you can't take them off."
	medical_record_text = "Subject appears to have clothing attire fused to their body."
	value = 0
	icon = FA_ICON_TSHIRT
	gain_text = span_notice("You feel things stick to your body.")
	lose_text = span_notice("You feel things loose their grip on your body.")
	quirk_flags = QUIRK_HIDE_FROM_SCAN
	forced_items = list(/obj/item/clothing/shoes/fancy_heels = list(ITEM_SLOT_FEET))
	var/prefix = "seamless"
	var/obj/item/clothing/shoes/shoes

/datum/quirk/equipping/seamless_clothes/on_equip_item(obj/item/equipped, success)
	shoes = equipped

/datum/quirk/equipping/seamless_clothes/post_add() // Quirks init on round start ready up before client does.
	if(!istype(shoes, /obj/item/clothing/shoes/fancy_heels))
		CRASH("Type mismatch on [src] during on_equip_item. Tried to equip [shoes]")
	shoes.name = "[prefix] [initial(shoes.name)]"
	shoes.desc = "A pair of heels which refuse to come off your feet."
	shoes.greyscale_colors = quirk_holder.client.prefs.read_preference(/datum/preference/color/seamless_shoe_color)
	shoes.resistance_flags = ACID_PROOF | FIRE_PROOF
	shoes.update_greyscale()
	ADD_TRAIT(shoes, TRAIT_NODROP, CLOTHING_TRAIT)
	RegisterSignal(shoes, COMSIG_ITEM_DROPPED, PROC_REF(remove_quirk))

/datum/quirk/equipping/seamless_clothes/remove()
	if(isnull(shoes))
		return
	UnregisterSignal(shoes, COMSIG_ITEM_DROPPED)
	QDEL_NULL(shoes)

/datum/quirk/equipping/seamless_clothes/proc/remove_quirk()
	SIGNAL_HANDLER
	qdel(src)

/datum/quirk_constant_data/seamless_clothes
	associated_typepath = /datum/quirk/equipping/seamless_clothes
	customization_options = list(
		/datum/preference/color/seamless_shoe_color
	)

/datum/preference/color/seamless_shoe_color
	savefile_key = "seamless_shoe_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED

/datum/preference/color/seamless_shoe_color/create_default_value()
	return "#e7e7e7"

/datum/preference/color/seamless_shoe_color/apply_to_human(mob/living/carbon/human/target, value)
	return
