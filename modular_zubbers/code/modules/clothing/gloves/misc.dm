/obj/item/clothing/gloves/misc/diver //Donor item for patriot210
	icon = 'modular_zubbers/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/hands.dmi'
	name = "black divers gloves"
	desc = "An old pair of gloves used by a now-defunct mining coalition."
	icon_state = "diver"
	worn_icon_state = "diver"

/obj/item/clothing/gloves/latex/allamerican
	name = "all-american diner latex gloves"
	desc = "A sterile pair of gloves for preparing food without the risk of contamination! The old fashion american style."
	icon_state = "latex_black"
	worn_icon_state = "latex_black"

//Cat Gloves seemingly by Taomayo of MonkeStation

/obj/item/clothing/gloves/cat
	desc = "\"High Tech\" paw shaped gloves perfect for cosplay enthusiasts, streamers and general weirdos. hewwo everynyaan!!"
	name = "cat gloves"
	icon = 'icons/map_icons/clothing/_clothing.dmi'
	icon_state = "/obj/item/clothing/gloves/cat"
	post_init_icon_state = "catgloves"
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#ffffff#FFC0CB#B0EAF6"
	greyscale_config_worn = /datum/greyscale_config/catgloves/worn
	greyscale_config = /datum/greyscale_config/catgloves
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	resistance_flags = FIRE_PROOF
	var/lights_on = FALSE

/obj/item/clothing/gloves/cat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/gloves/cat/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_GLOVES)
		ADD_TRAIT(user, TRAIT_GLOVE_SURGERY_PASSTHROUGH, "cat_gloves")

/obj/item/clothing/gloves/cat/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_GLOVE_SURGERY_PASSTHROUGH, "cat_gloves")

/obj/item/clothing/gloves/cat/update_overlays()
	. = ..()
	if(lights_on)
		. += emissive_appearance(icon, icon_state, src, alpha = 100)

/obj/item/clothing/gloves/cat/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(lights_on)
		. += emissive_appearance(standing.icon, standing.icon_state, src, alpha = 100)

/obj/item/clothing/gloves/cat/examine(mob/user)
	. = ..()
	. += span_notice("There's a small switch on the wrist. It's currently <b>[lights_on ? "ON" : "OFF"]</b>. <a href='byond://?src=[REF(src)];toggle_lights=1'>\[Toggle\]</a>")

/obj/item/clothing/gloves/cat/Topic(href, href_list)
	. = ..()
	if(href_list["toggle_lights"])
		if(!usr || !ishuman(usr))
			return
		var/mob/living/carbon/human/toggler = usr
		if(toggler.gloves != src)
			return
		lights_on = !lights_on
		playsound(src, 'sound/machines/click.ogg', 30, FALSE)
		to_chat(usr, span_notice("You turn the accent lighting [lights_on ? "on" : "off"]."))
		update_appearance()

/obj/item/clothing/gloves/cat/attackby(obj/item/item, mob/living/user, params)
	if(!istype(item, /obj/item/clothing/gloves/color/yellow))
		return ..()
	if(siemens_coefficient == 0)
		to_chat(user, span_warning("[src] are already insulated."))
		return
	user.visible_message(
		span_notice("[user] awkwardly crams [item] inside [src]."),
		span_notice("You press [item] against [src], after some time you succeed at inserting [item] inside.")
	)
	siemens_coefficient = 0
	name = "insulated [name]"
	if(desc == initial(desc))
		desc = "A pair of cat gloves with a pair of insulated gloves awkwardly crammed inside them. Somehow this works."
	qdel(item)
	update_appearance()
	return TRUE

/obj/item/clothing/gloves/cat/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_GLOVES)
		ADD_TRAIT(user, TRAIT_GLOVE_SURGERY_PASSTHROUGH, "cat_gloves")

/obj/item/clothing/gloves/cat/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_GLOVE_SURGERY_PASSTHROUGH, "cat_gloves")


//Metrocop Gloves by ... Dun dun dun, HL13 station.
/obj/item/clothing/gloves/color/black/security/metrocop
	name = "metrocop gloves"
	desc = "Now you can pick up that can! Uses advanced GigaSlop brand Matrixes to allow alternative varients!"
	icon = 'modular_zubbers/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/hands.dmi'
	icon_state = "civilprotection"

/obj/item/clothing/gloves/color/black/security/metrocop/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/metrocop_gloves)

/datum/atom_skin/metrocop_gloves
	abstract_type = /datum/atom_skin/metrocop_gloves

/datum/atom_skin/metrocop_gloves/metro_cop
	preview_name = "Metro Cop"
	new_icon_state = "civilprotection"

/datum/atom_skin/metrocop_gloves/overwatch
	preview_name = "Overwatch"
	new_icon_state = "overwatch"

//MGS stuff sprited by Crumpaloo for onlyplateau, please credit when porting, which you obviously have permission to do.
/obj/item/clothing/gloves/color/black/security/snake
	name = "stealth gloves"
	desc = "We will forsake our countries."
	icon = 'modular_zubbers/icons/obj/clothing/gloves/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/gloves/gloves.dmi'
	icon_state = "snake"

/obj/item/clothing/gloves/color/black/security/snake/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/gloves/bubber/snake
	name = "big boss' gloves"
	desc = "We will forsake our countries."
	icon_state = "snake"

/obj/item/clothing/gloves/maid_arm_covers
	greyscale_config_worn_teshari = /datum/greyscale_config/bubber_maid_arm_covers/worn/teshari
