//ASH TOOL
/obj/item/screwdriver/ashwalker
	name = "primitive screwdriver"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "screwdriver"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	post_init_icon_state = null

/datum/crafting_recipe/ash_recipe/ash_screwdriver
	name = "Ash Screwdriver"
	result = /obj/item/screwdriver/ashwalker

/obj/item/wirecutters/ashwalker
	name = "primitive wirecutters"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "cutters"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	post_init_icon_state = null

/datum/crafting_recipe/ash_recipe/ash_cutters
	name = "Ash Wirecutters"
	result = /obj/item/wirecutters/ashwalker

/obj/item/wrench/ashwalker
	name = "primitive wrench"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "wrench"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	post_init_icon_state = null

/datum/crafting_recipe/ash_recipe/ash_wrench
	name = "Ash Wrench"
	result = /obj/item/wrench/ashwalker

/obj/item/secateurs/ashwalker
	name = "primitive secateurs"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "secateurs"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/ash_secateur
	name = "Ash Secateur"
	result = /obj/item/secateurs/ashwalker

/obj/item/crowbar/ashwalker
	name = "primitive crowbar"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "crowbar"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	post_init_icon_state = null

/datum/crafting_recipe/ash_recipe/ash_crowbar
	name = "Ash Crowbar"
	result = /obj/item/crowbar/ashwalker

/obj/item/chisel/ashwalker
	name = "primitive chisel"
	desc = "Where there is a will there is a way; the tool head of this chisel is fashioned from bone shaped when it was fresh and then left to calcify in iron rich water, to make a strong head for all your carving needs."
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "chisel"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	post_init_icon_state = null
	toolspeed = 4

/datum/crafting_recipe/ash_recipe/ash_chisel
	name = "Ash Chisel"
	result = /obj/item/chisel/ashwalker

/obj/item/cursed_dagger
	name = "cursed ash dagger"
	desc = "A blunted dagger that seems to cause the shadows near it to tremble."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "crysknife"
	inhand_icon_state = "crysknife"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'

/obj/item/cursed_dagger/examine(mob/user)
	. = ..()
	. += span_notice("To be used on tendrils. It will visually change the tendril to indicate whether it has been cursed or not.")

/obj/item/ash_seed
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'

	///list of things the ash seed can spawn
	var/list/spawn_list

/obj/item/ash_seed/examine(mob/user)
	. = ..()
	. += span_notice("In order to be planted, it is required to be on the mining level as well as on basalt.")

/obj/item/ash_seed/proc/harm_user(mob/living/user, sent_message, damage_amount)
	to_chat(user, span_warning(sent_message))
	user.adjust_brute_loss(damage_amount)
	if(!do_after(user, 4 SECONDS, target = src))
		to_chat(user, span_warning("You stop the process of planting [src]!"))
		return FALSE

	return TRUE

/obj/item/ash_seed/attack_self(mob/user, modifiers)
	. = ..()
	if(isnull(spawn_list))
		return

	var/turf/src_turf = get_turf(src)
	if(!is_mining_level(src_turf.z) || !istype(src_turf, /turf/open/misc/asteroid/basalt))
		return

	if(!isliving(user))
		return

	var/mob/living/living_user = user
	if(!harm_user(user, "You begin to squeeze [src]...", 20))
		return

	if(!harm_user(user, "[src] begins to crawl between your hand's appendages, crawling up your arm...", 20))
		return

	if(!harm_user(user, "[src] wraps around your chest and begins to tighten, causing an odd needling sensation...", 20))
		return

	to_chat(living_user, span_warning("[src] leaps from you satisfied and begins to grossly assemble itself!"))
	var/type = pick(spawn_list)
	new type(user.loc)
	playsound(get_turf(src), 'sound/effects/magic/demon_attack1.ogg', 50, TRUE)
	qdel(src)

/obj/item/ash_seed/tendril
	name = "tendril seed"
	desc = "A horrible fleshy mass that pulse with a dark energy."
	icon_state = "tendril_seed"
	spawn_list = list(/mob/living/basic/mining/tendril)

/obj/item/ash_seed/vent
	name = "ore seed"
	desc = "A horrible fleshy mass covers a boulder. It seems to slowly pulse, reacting to you near it"
	icon_state = "vent_seed"
	spawn_list = list(/obj/structure/ore_vent/random)
