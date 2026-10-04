///New Armor Booster
/obj/item/mod/module/powered_armor_booster
	name = "MOD passive shield module"
	desc = "A relatively simple combat-effectiveness module, deploying a passive energy shield across the the suit, increasing armor effectiveness. \
			Incredibly high power cost, with exponentially scaling dependant on shield reactivity."
	icon = 'modular_zubbers/icons/obj/clothing/modsuit/mod_modules.dmi'
	icon_state = "armor_booster"
	complexity = 4
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 10
	incompatible_modules = list(/obj/item/mod/module/powered_armor_booster)
	required_slots = null
	custom_materials = list()
	//default armor value that we're set to when initialized and how much we should add to all armor values.
	var/armor_boost = 10
	//min armount of armor that we add to all values while the suit is powered.
	var/min_armor = 10
	//max amount of armor that we add to all values while the suit is powered.
	var/max_armor = 30
	//Base armor we apply our multipliers to
	var/datum/armor/armor_mod = /datum/armor/mod_pab_armor

	//Are we emagged?
	var/hacked
	//Max armor value modifier while hacked
	var/hacked_armor_mod = 20

	//what anomaly core do we take
	var/accepted_anomaly = /obj/item/assembly/signaler/anomaly/flux
	//Have we been anomaly boosted?
	var/core_boosted

/datum/armor/mod_pab_armor
	melee = 1
	bullet = 1
	laser = 1
	energy = 0.5
	bomb = 1
	wound = 0.5

/obj/item/mod/module/powered_armor_booster/examine(mob/user)
	. = ..()
	if(core_boosted)
		. += span_info("There is an flux anomaly core integrated into the module, reducing power consumption by 50%.")
	else
		. += span_info("There is a slot for a flux anomaly core.")

/obj/item/mod/module/powered_armor_booster/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
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

/obj/item/mod/module/powered_armor_booster/screwdriver_act(mob/living/user, obj/item/tool)
	var/new_armor
	if(hacked)
		new_armor = tgui_input_number(user, "Set armor reactiveness.", "Reactivity", armor_boost, max_armor + hacked_armor_mod, min_armor)
	else
		new_armor = tgui_input_number(user, "Set armor reactiveness.", "Reactivity", armor_boost, max_armor, min_armor)
	armor_boost = new_armor
	to_chat(user, ("You set the armor reactiveness to [new_armor]."))
	tool.play_tool_sound(src, 50)
	return TRUE

/obj/item/mod/module/powered_armor_booster/on_process(seconds_per_tick)
	if(part_process && !part_activated)
		return FALSE
	if(active)
		if(!drain_power(active_power_cost * seconds_per_tick))
			deactivate()
			return FALSE
		on_active_process(seconds_per_tick)
	else
		var/sum_drain = (idle_power_cost * seconds_per_tick) * 2**((armor_boost/10)-1)
		if(core_boosted)
			sum_drain = sum_drain / 2
		drain_power(sum_drain)

/obj/item/mod/module/powered_armor_booster/on_part_activation()
	var/datum/armor/to_add = get_armor_by_type(armor_mod)
	for(var/obj/item/part as anything in mod.get_parts(all = TRUE))
		part.set_armor(part.get_armor().add_other_armor(to_add.generate_new_with_multipliers(list(ARMOR_ALL = armor_boost))))

/obj/item/mod/module/powered_armor_booster/on_part_deactivation(deleting = FALSE)
	var/datum/armor/to_remove = get_armor_by_type(armor_mod)
	for(var/obj/item/part as anything in mod.get_parts(all = TRUE))
		part.set_armor(part.get_armor().subtract_other_armor(to_remove.generate_new_with_multipliers(list(ARMOR_ALL = armor_boost))))

/obj/item/mod/module/powered_armor_booster/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(hacked)
		balloon_alert(user, "reasonable limits already disabled!")
		return FALSE
	balloon_alert(user, "reasonable limits disabled")
	hacked = TRUE

///Speed Booster
/obj/item/mod/module/powered_speed_booster
	name = "MOD passive stimboost module"
	desc = "A simple combat-effectiveness module, passively boosting the user's effective speed while using the module. \
			Very high power cost, with exponentially scaling dependant on stimulant strength."
	icon = 'modular_zubbers/icons/obj/clothing/modsuit/mod_modules.dmi'
	icon_state = "armor_booster"
	complexity = 4
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 5
	incompatible_modules = list(/obj/item/mod/module/powered_speed_booster)
	required_slots = null
	custom_materials = list()
	//default
	var/speed_boost = 0.1
	//min
	var/min_speed = 0.1
	//max
	var/max_speed = 0.3

	//Are we emagged?
	var/hacked
	//Max armor value modifier while hacked
	var/hacked_speed_mod = 0.2

	//what anomaly core do we take
	var/accepted_anomaly = /obj/item/assembly/signaler/anomaly/flux
	//Have we been anomaly boosted?
	var/core_boosted

/obj/item/mod/module/powered_speed_booster/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
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

/obj/item/mod/module/powered_speed_booster/screwdriver_act(mob/living/user, obj/item/tool)
	var/new_speed
	if(hacked)
		new_speed = tgui_input_number(user, "Set stimulant strength.", "Strength", speed_boost, max_speed + hacked_speed_mod, min_speed)
	else
		new_speed = tgui_input_number(user, "Set stimulant strength.", "Strength", speed_boost, max_speed, min_speed)
	speed_boost = new_speed
	to_chat(user, ("You set the stimulant strength to [new_speed]."))
	tool.play_tool_sound(src, 50)
	return TRUE

/obj/item/mod/module/powered_speed_booster/on_process(seconds_per_tick)
	if(part_process && !part_activated)
		return FALSE
	if(active)
		if(!drain_power(active_power_cost * seconds_per_tick))
			deactivate()
			return FALSE
		on_active_process(seconds_per_tick)
	else
		var/sum_drain = (idle_power_cost * seconds_per_tick) * 2**((speed_boost*10)-1)
		if(core_boosted)
			sum_drain = sum_drain / 2
		drain_power(sum_drain)

/obj/item/mod/module/powered_speed_booster/on_part_activation()
	mod.slowdown -= speed_boost

/obj/item/mod/module/powered_speed_booster/on_part_deactivation(deleting = FALSE)
	mod.slowdown -= speed_boost
