//THIS FILE HAS BEEN EDITED BY SKYRAT EDIT

/obj/structure/dresser//SKYRAT EDIT - ICON OVERRIDDEN BY AESTHETICS - SEE MODULE
	name = "dresser"
	desc = "A nicely-crafted wooden dresser. It's filled with lots of undies."
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "dresser"
	resistance_flags = FLAMMABLE
	density = TRUE
	anchored = TRUE

/obj/structure/dresser/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WRENCH)
		to_chat(user, span_notice("You begin to [anchored ? "unwrench" : "wrench"] [src]."))
		if(I.use_tool(src, user, 20, volume=50))
			to_chat(user, span_notice("You successfully [anchored ? "unwrench" : "wrench"] [src]."))
			set_anchored(!anchored)
	else
		return ..()

/obj/structure/dresser/atom_deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)

/obj/structure/dresser/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!Adjacent(user))//no tele-grooming
		return
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/dressing_human = user
	if(HAS_TRAIT(dressing_human, TRAIT_NO_UNDERWEAR))
		to_chat(dressing_human, span_warning("You are not capable of wearing underwear."))
		return

	var/choice = tgui_input_list(user, "Underwear, Bra, Undershirt, or Socks?", "Changing", list("Underwear", "Underwear Color", "Bra", "Bra Color", "Undershirt", "Undershirt Color", "Socks", "Socks Color")) //SKYRAT EDIT ADDITION - Colorable Undershirt/Socks/Bra
	if(isnull(choice))
		return

	if(!Adjacent(user))
		return
	switch(choice)
		if("Underwear")
			var/new_undies = tgui_input_list(user, "Select your underwear", "Changing", SSaccessories.underwear_list)
			if(new_undies)
				dressing_human.underwear = new_undies
				// SPLURT EDIT ADDITION - Extra Inventory
				dressing_human.dropItemToGround(dressing_human.w_underwear)
				var/datum/sprite_accessory/underwear/sprite = SSaccessories.underwear_list[new_undies]
				dressing_human.equip_to_slot_or_del(new sprite.briefs_obj(dressing_human), ITEM_SLOT_UNDERWEAR)
				// SPLURT EDIT END
		if("Underwear Color")
			var/new_underwear_color = input(dressing_human, "Choose your underwear color", "Underwear Color", dressing_human.underwear_color) as color|null
			if(new_underwear_color)
				dressing_human.underwear_color = sanitize_hexcolor(new_underwear_color)
				// SPLURT EDIT ADDITION - Extra Inventory
				var/obj/item/clothing/underwear/briefs/briefs = dressing_human.w_underwear
				dressing_human.dropItemToGround(briefs)
				dressing_human.equip_to_slot_or_del(briefs, ITEM_SLOT_UNDERWEAR)
				// SPLURT EDIT END
		if("Undershirt")
			var/new_undershirt = tgui_input_list(user, "Select your undershirt", "Changing", SSaccessories.undershirt_list)
			if(new_undershirt)
				dressing_human.undershirt = new_undershirt
				// SPLURT EDIT ADDITION - Extra Inventory
				dressing_human.dropItemToGround(dressing_human.w_shirt)
				var/datum/sprite_accessory/undershirt/sprite = SSaccessories.undershirt_list[new_undershirt]
				dressing_human.equip_to_slot_or_del(new sprite.shirt_obj(dressing_human), ITEM_SLOT_SHIRT)
				// SPLURT EDIT END
		if("Undershirt Color")
			var/new_undershirt_color = input(dressing_human, "Choose your undershirt color", "Undershirt Color", dressing_human.undershirt_color) as color|null
			if(new_undershirt_color)
				dressing_human.undershirt_color = sanitize_hexcolor(new_undershirt_color)
				// SPLURT EDIT ADDITION - Extra Inventory
				var/obj/item/clothing/underwear/shirt/shirt = dressing_human.w_shirt
				dressing_human.dropItemToGround(shirt)
				dressing_human.equip_to_slot_or_del(shirt, ITEM_SLOT_SHIRT)
				// SPLURT EDIT END
		if("Socks")
			var/new_socks = tgui_input_list(user, "Select your socks", "Changing", SSaccessories.socks_list)
			if(new_socks)
				dressing_human.socks = new_socks
				// SPLURT EDIT ADDITION - Extra Inventory
				dressing_human.dropItemToGround(dressing_human.w_socks)
				var/datum/sprite_accessory/socks/sprite = SSaccessories.socks_list[new_socks]
				dressing_human.equip_to_slot_or_del(new sprite.socks_obj(dressing_human), ITEM_SLOT_SOCKS)
				// SPLURT EDIT END
		if("Socks Color")
			var/new_socks_color = input(dressing_human, "Choose your socks color", "Socks Color", dressing_human.socks_color) as color|null
			if(new_socks_color)
				dressing_human.socks_color = sanitize_hexcolor(new_socks_color)
				// SPLURT EDIT ADDITION - Extra Inventory
				var/obj/item/clothing/underwear/socks/socks = dressing_human.w_socks
				dressing_human.dropItemToGround(socks)
				dressing_human.equip_to_slot_or_del(socks, ITEM_SLOT_SOCKS)
				// SPLURT EDIT END
		if("Bra")
			var/new_bra = tgui_input_list(user, "Select your Bra", "Changing", SSaccessories.bra_list)
			if(new_bra)
				dressing_human.bra = new_bra
				// SPLURT EDIT ADDITION - Extra Inventory
				dressing_human.dropItemToGround(dressing_human.w_shirt)
				var/datum/sprite_accessory/bra/sprite = SSaccessories.bra_list[new_bra]
				dressing_human.equip_to_slot_or_del(new sprite.bra_obj(dressing_human), ITEM_SLOT_SHIRT)
				// SPLURT EDIT END
		if("Bra Color")
			var/new_bra_color = input(dressing_human, "Choose your Bra color", "Bra Color", dressing_human.bra_color) as color|null
			if(new_bra_color)
				dressing_human.bra_color = sanitize_hexcolor(new_bra_color)
				// SPLURT EDIT ADDITION - Extra Inventory
				var/obj/item/clothing/underwear/shirt/bra = dressing_human.w_shirt
				dressing_human.dropItemToGround(bra)
				dressing_human.equip_to_slot_or_del(bra, ITEM_SLOT_SHIRT)
				// SPLURT EDIT END

		//SKYRAT EDIT ADDITION END - Colorable Undershirt/Socks/Bras

	add_fingerprint(dressing_human)
	dressing_human.update_body()
