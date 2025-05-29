//GS13 Shadow/Mushroom/Plasma dressers
/obj/structure/gmushroomdresser
 	name = "dresser"
 	desc = "A nicely-crafted mushroom dresser. It's filled with lots of undies."
 	icon = 'GainStation13/icons/obj/stationobjs.dmi'
 	icon_state = "gmushroomdresser"
 	density = TRUE
 	anchored = TRUE

/obj/structure/gmushroomdresser/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WRENCH)
		to_chat(user, "<span class='notice'>You begin to [anchored ? "unwrench" : "wrench"] [src].</span>")
		if(I.use_tool(src, user, 20, volume=50))
			to_chat(user, "<span class='notice'>You successfully [anchored ? "unwrench" : "wrench"] [src].</span>")
			setAnchored(!anchored)
	else
		return ..()

/obj/structure/gmushroomdresser/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	qdel(src)

/obj/structure/gmushroomdresser/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	. = ..()
	if(. || !ishuman(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	var/mob/living/carbon/human/H = user

	if(H.dna && H.dna.species && (NO_UNDERWEAR in H.dna.species.species_traits))
		to_chat(H, "<span class='warning'>You are not capable of wearing underwear.</span>")
		return

	var/list/undergarment_choices = list("Underwear", "Underwear Color", "Undershirt", "Undershirt Color", "Socks", "Socks Color")
	if(!(GLOB.underwear_list[H.underwear]?.has_color))
		undergarment_choices -= "Underwear Color"
	if(!(GLOB.undershirt_list[H.undershirt]?.has_color))
		undergarment_choices -= "Undershirt Color"
	if(!(GLOB.socks_list[H.socks]?.has_color))
		undergarment_choices -= "Socks Color"

	var/choice = input(H, "Underwear, Undershirt, or Socks?", "Changing") as null|anything in undergarment_choices
	if(!H.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	var/dye_undie = FALSE
	var/dye_shirt = FALSE
	var/dye_socks = FALSE
	switch(choice)
		if("Underwear")
			var/new_undies = input(H, "Select your underwear", "Changing") as null|anything in GLOB.underwear_list
			if(new_undies)
				H.underwear = new_undies
				H.saved_underwear = new_undies
				var/datum/sprite_accessory/underwear/bottom/B = GLOB.underwear_list[new_undies]
				dye_undie = B?.has_color
		if("Undershirt")
			var/new_undershirt = input(H, "Select your undershirt", "Changing") as null|anything in GLOB.undershirt_list
			if(new_undershirt)
				H.undershirt = new_undershirt
				H.saved_undershirt = new_undershirt
				var/datum/sprite_accessory/underwear/top/T = GLOB.undershirt_list[new_undershirt]
				dye_shirt = T?.has_color
		if("Socks")
			var/new_socks = input(H, "Select your socks", "Changing") as null|anything in GLOB.socks_list
			if(new_socks)
				H.socks = new_socks
				H.saved_socks = new_socks
				var/datum/sprite_accessory/underwear/socks/S = GLOB.socks_list[new_socks]
				dye_socks = S?.has_color
	if(dye_undie || choice == "Underwear Color")
		H.undie_color = recolor_undergarment(H, "underwear", H.undie_color)
	if(dye_shirt || choice == "Undershirt Color")
		H.shirt_color = recolor_undergarment(H, "undershirt", H.shirt_color)
	if(dye_socks || choice == "Socks Color")
		H.socks_color = recolor_undergarment(H, "socks", H.socks_color)

	add_fingerprint(H)
	H.update_body(TRUE)

/obj/structure/gmushroomdresser/proc/recolor_undergarment(mob/living/carbon/human/H, garment_type = "underwear", default_color)
	var/n_color = input(H, "Choose your [garment_type]'\s color.", "Character Preference", default_color) as color|null
	if(!n_color || !H.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return default_color
	return sanitize_hexcolor(n_color, 3, FALSE, default_color)

/obj/structure/plaswooddresser
	name = "dresser"
	desc = "A nicely-crafted plaswood dresser. It's filled with lots of undies."
	icon = 'GainStation13/icons/obj/stationobjs.dmi'
	icon_state = "plaswooddresser"
	density = TRUE
	anchored = TRUE

/obj/structure/plaswooddresser/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WRENCH)
		to_chat(user, "<span class='notice'>You begin to [anchored ? "unwrench" : "wrench"] [src].</span>")
		if(I.use_tool(src, user, 20, volume=50))
			to_chat(user, "<span class='notice'>You successfully [anchored ? "unwrench" : "wrench"] [src].</span>")
			setAnchored(!anchored)
	else
		return ..()

/obj/structure/plaswooddresser/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	qdel(src)

/obj/structure/plaswooddresser/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	. = ..()
	if(. || !ishuman(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	var/mob/living/carbon/human/H = user

	if(H.dna && H.dna.species && (NO_UNDERWEAR in H.dna.species.species_traits))
		to_chat(H, "<span class='warning'>You are not capable of wearing underwear.</span>")
		return

	var/list/undergarment_choices = list("Underwear", "Underwear Color", "Undershirt", "Undershirt Color", "Socks", "Socks Color")
	if(!(GLOB.underwear_list[H.underwear]?.has_color))
		undergarment_choices -= "Underwear Color"
	if(!(GLOB.undershirt_list[H.undershirt]?.has_color))
		undergarment_choices -= "Undershirt Color"
	if(!(GLOB.socks_list[H.socks]?.has_color))
		undergarment_choices -= "Socks Color"

	var/choice = input(H, "Underwear, Undershirt, or Socks?", "Changing") as null|anything in undergarment_choices
	if(!H.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	var/dye_undie = FALSE
	var/dye_shirt = FALSE
	var/dye_socks = FALSE
	switch(choice)
		if("Underwear")
			var/new_undies = input(H, "Select your underwear", "Changing") as null|anything in GLOB.underwear_list
			if(new_undies)
				H.underwear = new_undies
				H.saved_underwear = new_undies
				var/datum/sprite_accessory/underwear/bottom/B = GLOB.underwear_list[new_undies]
				dye_undie = B?.has_color
		if("Undershirt")
			var/new_undershirt = input(H, "Select your undershirt", "Changing") as null|anything in GLOB.undershirt_list
			if(new_undershirt)
				H.undershirt = new_undershirt
				H.saved_undershirt = new_undershirt
				var/datum/sprite_accessory/underwear/top/T = GLOB.undershirt_list[new_undershirt]
				dye_shirt = T?.has_color
		if("Socks")
			var/new_socks = input(H, "Select your socks", "Changing") as null|anything in GLOB.socks_list
			if(new_socks)
				H.socks = new_socks
				H.saved_socks = new_socks
				var/datum/sprite_accessory/underwear/socks/S = GLOB.socks_list[new_socks]
				dye_socks = S?.has_color
	if(dye_undie || choice == "Underwear Color")
		H.undie_color = recolor_undergarment(H, "underwear", H.undie_color)
	if(dye_shirt || choice == "Undershirt Color")
		H.shirt_color = recolor_undergarment(H, "undershirt", H.shirt_color)
	if(dye_socks || choice == "Socks Color")
		H.socks_color = recolor_undergarment(H, "socks", H.socks_color)

	add_fingerprint(H)
	H.update_body(TRUE)

/obj/structure/plaswooddresser/proc/recolor_undergarment(mob/living/carbon/human/H, garment_type = "underwear", default_color)
	var/n_color = input(H, "Choose your [garment_type]'\s color.", "Character Preference", default_color) as color|null
	if(!n_color || !H.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return default_color
	return sanitize_hexcolor(n_color, 3, FALSE, default_color)

/obj/structure/shadowwdresser
	name = "dresser"
	desc = "A nicely-crafted shadow wood dresser. It's filled with lots of undies."
	icon = 'GainStation13/icons/obj/stationobjs.dmi'
	icon_state = "shadowwdresser"
	density = TRUE
	anchored = TRUE

/obj/structure/shadowwdresser/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WRENCH)
		to_chat(user, "<span class='notice'>You begin to [anchored ? "unwrench" : "wrench"] [src].</span>")
		if(I.use_tool(src, user, 20, volume=50))
			to_chat(user, "<span class='notice'>You successfully [anchored ? "unwrench" : "wrench"] [src].</span>")
			setAnchored(!anchored)
	else
		return ..()

/obj/structure/shadowwdresser/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	qdel(src)

/obj/structure/shadowwdresser/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	. = ..()
	if(. || !ishuman(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	var/mob/living/carbon/human/H = user

	if(H.dna && H.dna.species && (NO_UNDERWEAR in H.dna.species.species_traits))
		to_chat(H, "<span class='warning'>You are not capable of wearing underwear.</span>")
		return

	var/list/undergarment_choices = list("Underwear", "Underwear Color", "Undershirt", "Undershirt Color", "Socks", "Socks Color")
	if(!(GLOB.underwear_list[H.underwear]?.has_color))
		undergarment_choices -= "Underwear Color"
	if(!(GLOB.undershirt_list[H.undershirt]?.has_color))
		undergarment_choices -= "Undershirt Color"
	if(!(GLOB.socks_list[H.socks]?.has_color))
		undergarment_choices -= "Socks Color"

	var/choice = input(H, "Underwear, Undershirt, or Socks?", "Changing") as null|anything in undergarment_choices
	if(!H.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	var/dye_undie = FALSE
	var/dye_shirt = FALSE
	var/dye_socks = FALSE
	switch(choice)
		if("Underwear")
			var/new_undies = input(H, "Select your underwear", "Changing") as null|anything in GLOB.underwear_list
			if(new_undies)
				H.underwear = new_undies
				H.saved_underwear = new_undies
				var/datum/sprite_accessory/underwear/bottom/B = GLOB.underwear_list[new_undies]
				dye_undie = B?.has_color
		if("Undershirt")
			var/new_undershirt = input(H, "Select your undershirt", "Changing") as null|anything in GLOB.undershirt_list
			if(new_undershirt)
				H.undershirt = new_undershirt
				H.saved_undershirt = new_undershirt
				var/datum/sprite_accessory/underwear/top/T = GLOB.undershirt_list[new_undershirt]
				dye_shirt = T?.has_color
		if("Socks")
			var/new_socks = input(H, "Select your socks", "Changing") as null|anything in GLOB.socks_list
			if(new_socks)
				H.socks = new_socks
				H.saved_socks = new_socks
				var/datum/sprite_accessory/underwear/socks/S = GLOB.socks_list[new_socks]
				dye_socks = S?.has_color
	if(dye_undie || choice == "Underwear Color")
		H.undie_color = recolor_undergarment(H, "underwear", H.undie_color)
	if(dye_shirt || choice == "Undershirt Color")
		H.shirt_color = recolor_undergarment(H, "undershirt", H.shirt_color)
	if(dye_socks || choice == "Socks Color")
		H.socks_color = recolor_undergarment(H, "socks", H.socks_color)

	add_fingerprint(H)
	H.update_body(TRUE)

/obj/structure/shadowwdresser/proc/recolor_undergarment(mob/living/carbon/human/H, garment_type = "underwear", default_color)
	var/n_color = input(H, "Choose your [garment_type]'\s color.", "Character Preference", default_color) as color|null
	if(!n_color || !H.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return default_color
	return sanitize_hexcolor(n_color, 3, FALSE, default_color)
