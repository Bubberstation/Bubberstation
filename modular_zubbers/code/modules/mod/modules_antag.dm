///Powered Booster Modules
/obj/item/mod/module/power_booster
	name = "MOD power booster module"
	desc = "Wuh oh"
	icon = 'modular_zubbers/icons/obj/clothing/modsuit/mod_modules.dmi'
	icon_state = "armor_booster"
	complexity = 4
	required_slots = null
	custom_materials = list()
	//default boost value that we're set to when initialized and how much we should add to all armor values.
	var/boost = 10
	//min armount of boost.
	var/min_boost = 10
	//max amount of boost.
	var/max_boost = 30
	//What do we say when changing the boost?
	var/boost_prompt = "Set boost strength."
	//What are we changing?
	var/boost_noun = "Boost"
	//Are we emagged?
	var/hacked
	//Max boost modifier while hacked
	var/hacked_boost_mod = 20

	//what anomaly core do we take
	var/accepted_anomaly = /obj/item/assembly/signaler/anomaly/flux
	//Have we been anomaly boosted?
	var/core_boosted

/obj/item/mod/module/powered_booster/examine(mob/user)
	. = ..()
	if(core_boosted)
		. += span_info("There is an flux anomaly core integrated into the module, reducing power consumption by 50%.")
	else
		. += span_info("There is a slot for a flux anomaly core.")

/obj/item/mod/module/powered_booster/screwdriver_act(mob/living/user, obj/item/tool)
	var/new_boost
	if(hacked)
		new_boost = tgui_input_number(user, boost_prompt, boost_noun, boost, max_boost + hacked_boost_mod, min_boost)
	else
		new_boost = tgui_input_number(user, boost_prompt, boost_noun, boost, max_boost, min_boost)
	boost = new_boost
	to_chat(user, ("You set the module to [new_boost]."))
	tool.play_tool_sound(src, 50)
	return TRUE

/obj/item/mod/module/powered_booster/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(hacked)
		balloon_alert(user, "reasonable limits already disabled!")
		return FALSE
	balloon_alert(user, "reasonable limits disabled")
	hacked = TRUE

/obj/item/mod/module/powered_booster/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, accepted_anomaly))
		return NONE
	if(!isnull(core_boosted))
		balloon_alert(user, "core already inserted!")
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	balloon_alert(user, "core integrated into system")
	playsound(src, 'sound/machines/click.ogg', 30, TRUE)
	core_boosted = TRUE
	icon_state += "_core"
	update_appearance()
	return ITEM_INTERACT_SUCCESS

///Armor Booster
/obj/item/mod/module/powered_booster/armor
	name = "MOD passive shield module"
	desc = "A relatively simple combat-effectiveness module, deploying a passive energy shield across the the suit, increasing armor effectiveness. \
			Incredibly high power cost, with exponentially scaling dependant on shield reactivity."
	icon = 'modular_zubbers/icons/obj/clothing/modsuit/mod_modules.dmi'
	icon_state = "armor_booster"
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 10
	incompatible_modules = list(/obj/item/mod/module/powered_armor_booster)
	boost_prompt = "Set shield strength."
	//What are we changing?
	var/boost_noun = "Shield strength"
	//Base armor we apply our multipliers to
	var/datum/armor/armor_mod = /datum/armor/mod_pab_armor

/datum/armor/mod_pab_armor
	melee = 1
	bullet = 1
	laser = 1
	energy = 0.5
	bomb = 1
	wound = 0.5

/obj/item/mod/module/powered_booster/armor/on_process(seconds_per_tick)
	if(part_process && !part_activated)
		return FALSE
	if(active)
		if(!drain_power(active_power_cost * seconds_per_tick))
			deactivate()
			return FALSE
		on_active_process(seconds_per_tick)
	else
		var/sum_drain = (idle_power_cost * seconds_per_tick) * 2**((boost/10)-1)
		if(core_boosted)
			sum_drain = sum_drain / 2
		drain_power(sum_drain)

/obj/item/mod/module/powered_booster/armor/on_part_activation()
	var/datum/armor/to_add = get_armor_by_type(armor_mod)
	for(var/obj/item/part as anything in mod.get_parts(all = TRUE))
		part.set_armor(part.get_armor().add_other_armor(to_add.generate_new_with_multipliers(list(ARMOR_ALL = boost))))

/obj/item/mod/module/powered_booster/armor/on_part_deactivation(deleting = FALSE)
	var/datum/armor/to_remove = get_armor_by_type(armor_mod)
	for(var/obj/item/part as anything in mod.get_parts(all = TRUE))
		part.set_armor(part.get_armor().subtract_other_armor(to_remove.generate_new_with_multipliers(list(ARMOR_ALL = boost))))

///Speed Booster
/obj/item/mod/module/powered_booster/speed
	name = "MOD passive stimboost module"
	desc = "A simple combat-effectiveness module, passively boosting the user's effective speed while using the module. \
			Very high power cost, with exponentially scaling dependant on stimulant strength."
	icon_state = "speed_booster"
	complexity = 4
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 5
	incompatible_modules = list(/obj/item/mod/module/powered_speed_booster)
	boost = 0.1
	min_boost = 0.1
	max_boost = 0.3
	boost_prompt = "Set stimulant potency."
	boost_noun = "Stimulant potency"
	hacked_speed_mod = 0.2

/obj/item/mod/module/powered_booster/speed/on_process(seconds_per_tick)
	if(part_process && !part_activated)
		return FALSE
	if(active)
		if(!drain_power(active_power_cost * seconds_per_tick))
			deactivate()
			return FALSE
		on_active_process(seconds_per_tick)
	else
		var/sum_drain = (idle_power_cost * seconds_per_tick) * 2**((boost*10)-1)
		if(core_boosted)
			sum_drain = sum_drain / 2
		drain_power(sum_drain)

/obj/item/mod/module/powered_booster/speed/on_part_activation()
	mod.slowdown -= speed_boost

/obj/item/mod/module/powered_booster/speed/on_part_deactivation(deleting = FALSE)
	mod.slowdown -= speed_boost
