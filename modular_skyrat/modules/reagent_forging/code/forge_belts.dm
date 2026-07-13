////////////////////////////////////////////////////////////////////////////
////////////////////////////// HOLSTERS ////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//can't be a subtype of item/storage/belt/holster -- that can be suit storaged per \code\__DEFINES\inventory.dm
//hip holsters SHOULDN'T be able to be suit storaged.
/obj/item/storage/belt/hip_holster
	name = "hip holster"
	desc = "you shouldn't be seeing this."
	abstract_type = /obj/item/storage/belt/hip_holster
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	icon_state = "cowboy_holster"
	inhand_icon_state = "holster"
	worn_icon_state = "holster"
	alternate_worn_layer = null
	storage_type = /datum/storage/holster

/obj/item/storage/belt/hip_holster/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	update_label()
/obj/item/storage/belt/hip_holster/Exited(atom/movable/gone, direction)
	. = ..()
	update_label()
/obj/item/storage/belt/hip_holster/proc/update_label(list/contents_to_check = null)
	if(isnull(contents_to_check))
		contents_to_check = contents
	var/list/noteworthy_contents = list()
	for(var/obj/item/I in contents_to_check)
		if(!istype(I, /obj/item/ammo_box))
			noteworthy_contents += I

	if(length(noteworthy_contents) > 0)
		name = "[src::name] containing [english_list(noteworthy_contents)]"
	else
		name = src::name

//copy of the holster/equipped proc.
/obj/item/storage/belt/hip_holster/equipped(mob/user, slot)
	. = ..()
	if(slot & (ITEM_SLOT_BELT|ITEM_SLOT_SUITSTORE))
		ADD_CLOTHING_TRAIT(user, TRAIT_GUNFLIP)

/obj/item/storage/belt/hip_holster/update_overlays()
	. = ..()
	. += get_guns_contained_overlays()

/obj/item/storage/belt/hip_holster/proc/get_guns_contained_overlays(list/contents_to_check = null)
	var/list/returner = list()
	if(contents_to_check == null)
		contents_to_check = contents
	for(var/obj/item/I in contents_to_check)
		if(istype(I, /obj/item/gun/ballistic/revolver))
			returner += mutable_appearance('modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi', "belt_gun_wood")
			return returner
		if(istype(I, /obj/item/gun))
			returner += mutable_appearance('modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi', "belt_gun_black")
			return returner
		if(istype(I, /obj/item/melee/baton/security))
			returner += mutable_appearance('modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi', "belt_gun_baton")
			return returner

/obj/item/storage/belt/hip_holster/cowboy
	name = "quickdraw holster"
	desc = "A rugged leather belt. Can carry a handgun; <b>the holster pouch makes it like reflex to draw your gun</b>. Also comes with some side pockets for speedloaders and magazines."
	icon_state = "cowboy_holster"
	inhand_icon_state = "utility"
	worn_icon_state = "utility"
	storage_type = /datum/storage/cowboy_holster

/datum/storage/cowboy_holster
	max_slots = 4
	max_total_storage = 6
	open_sound = 'sound/items/handling/holster_open.ogg'
	open_sound_vary = TRUE

/datum/storage/cowboy_holster/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound, list/holdables)
	. = ..()
	if(length(holdables))
		set_holdable(holdables)
		return

	set_holdable(list(
		/obj/item/food/grown/banana,
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/gun/ballistic/revolver,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/dueling,
		/obj/item/gun/energy/e_gun/hos,
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/laser/captain,
		/obj/item/gun/energy/laser/pistol,
		/obj/item/gun/energy/laser/thermal,
		/obj/item/ammo_box/advanced/s12gauge,
		/obj/item/ammo_box/magazine,
		/obj/item/ammo_box/speedloader,
	))

/datum/storage/cowboy_holster/attempt_insert(obj/item/to_insert, mob/user, override = FALSE, force = STORAGE_NOT_LOCKED, messages = TRUE)
	. = ..()
	sort_contents()
	refresh_views()
	//parent.update_appearance()

//resorts the contents so that guns are always the first thing pulled.
/datum/storage/cowboy_holster/proc/sort_contents()
	var/list/gunz = list()
	var/list/everything_else = list()
	var/obj/parent_obj = parent
	if(!isnull(parent_obj))
		for(var/obj/item/i in parent_obj.contents)
			if(istype(i, /obj/item/gun/))
				gunz += i
			else
				everything_else += i
		parent_obj.contents = everything_else + gunz

/////////////////////////////////////////////////

/obj/item/storage/belt/hip_holster/charging
	name = "charging holster"
	desc = "A sophisticated plastic holster belt. Bluespace tech allows it to store almost anything a standard weapon charger can; it can slowly charge that item."
	icon_state = "charger_belt"
	inhand_icon_state = "security"
	worn_icon_state = "security"
	storage_type = /datum/storage/charging_holster //null //datum/storage/charging_holster
	var/obj/machinery/recharger/belt_charger/my_charger
	var/obj/item/storage/box/real_storage

/obj/item/storage/belt/hip_holster/charging/Initialize(mapload)
	my_charger = new(src)
	my_charger.my_belt = src
	real_storage = new(src)
	. = ..()

/obj/item/storage/belt/hip_holster/charging/Destroy()
	QDEL_NULL(my_charger)
	QDEL_NULL(real_storage)
	. = ..()

/obj/item/storage/belt/hip_holster/charging/update_label(list/contents_to_check = null)
	. = ..(real_storage.contents)

/obj/item/storage/belt/hip_holster/charging/get_guns_contained_overlays(list/contents_to_check = null)
	. = ..(real_storage.contents)

/obj/item/storage/belt/hip_holster/charging/update_overlays()
	. = ..()
	if(length(real_storage?.contents) > 0)
		if(!isnull(my_charger?.charging))
			var/icon_to_use = "charger_belt_[(my_charger.using_power ? "charging" : "fullcharge")]"
			. += mutable_appearance(icon, icon_to_use, alpha = src.alpha)
		else
			. += mutable_appearance(icon, "charger_belt_precharging")

/datum/storage/charging_holster
	max_slots = 1
	max_total_storage = 12
	open_sound = 'sound/items/handling/holster_open.ogg'
	open_sound_vary = TRUE
	max_specific_storage = WEIGHT_CLASS_BULKY
	var/delay_before_charging = 20 SECONDS
	var/timer_id
	var/obj/machinery/recharger/belt_charger/my_charger

/datum/storage/charging_holster/New()
	. = ..()
	if(istype(parent, /obj/item/storage/belt/hip_holster/charging))
		var/obj/item/storage/belt/hip_holster/charging/my_belt = parent
		my_charger = my_belt.my_charger
		set_real_location(my_belt.real_storage)
	set_holdable(list(
		/obj/item/gun/energy,
		/obj/item/melee/baton/security,
		/obj/item/ammo_box/magazine/recharge,
		/obj/item/modular_computer,))

/datum/storage/charging_holster/can_insert(obj/item/to_insert, mob/user, messages = TRUE, force = STORAGE_NOT_LOCKED)
	if(istype(to_insert, /obj/item/gun/energy))
		var/obj/item/gun/energy/energy_gun = to_insert
		if(!energy_gun.can_charge)
			to_chat(user, span_notice("Your gun has no external power connector."))
			return FALSE
	. = ..()

/datum/storage/charging_holster/attempt_insert(obj/item/to_insert, mob/user, override = FALSE, force = STORAGE_NOT_LOCKED, messages = TRUE)
	. = ..()
	if(.)
		parent.name += " ([to_insert.name])"
		parent.update_overlays()
		timer_id = addtimer(CALLBACK(my_charger, TYPE_PROC_REF(/obj/machinery/recharger/belt_charger, activate_with_item)), delay_before_charging, TIMER_STOPPABLE | TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_DELETE_ME)

/datum/storage/charging_holster/remove_and_refresh(atom/movable/gone)
	. = ..()
	parent.name = initial(parent.name)
	my_charger.charging = null
	parent.update_overlays()
	deltimer(timer_id)

/obj/machinery/recharger/belt_charger
	name = "belt charger"
	desc = "the fact that you can see this means there's an error, call a dev!"
	recharge_coeff = 0.2
	var/obj/item/storage/belt/hip_holster/charging/my_belt

/obj/machinery/recharger/belt_charger/Destroy()
	my_belt = null
	. = ..()

/obj/machinery/recharger/belt_charger/RefreshParts()
	. = ..()
	recharge_coeff = initial(recharge_coeff)

/obj/machinery/recharger/belt_charger/proc/activate_with_item()
	if(length(my_belt?.real_storage?.contents) > 0)
		say("Charging...")
		charging = my_belt.real_storage.contents[1]
		playsound(src, 'sound/machines/ping.ogg', 30, TRUE, frequency = 0.8)
		START_PROCESSING(SSmachines, src)
		update_use_power(ACTIVE_POWER_USE)
		using_power = TRUE
		update_appearance()
		my_belt.update_overlays()

/obj/machinery/recharger/belt_charger/process(seconds_per_tick)
	if(length(my_belt?.real_storage?.contents) != 1 || my_belt?.real_storage.contents[1] != charging)
		charging = null
		return PROCESS_KILL
	. = ..()
	my_belt.update_appearance()
	charging.update_appearance()

/obj/machinery/recharger/belt_charger/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	to_chat(user, span_warning("You should insert the [tool] into the connected holster pouch, not the charging device itself!"))
	return ITEM_INTERACT_BLOCKING

////////////////////////////////////////////////////////////////////////////
////////////////////////////// SHEATHS /////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/obj/item/storage/belt/crusader	//Belt + sheath combination - still only holds one sword at a time though
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	name = "scabbard-utility belt"
	desc = "Holds an assortment of equipment for whatever situation an adventurer may encounter, as well as having an attached scabbard to hold a sword or bladed weapon."
	icon_state = "crusader_belt"
	worn_icon_state = "crusader_belt"
	inhand_icon_state = "utility"
	w_class = WEIGHT_CLASS_BULKY //Cant fit a sheath in your bag
	interaction_flags_click = NEED_DEXTERITY
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT)

/obj/item/storage/belt/crusader/Initialize(mapload)
	. = ..()

	create_storage(
		max_slots = 2,
		max_specific_storage = WEIGHT_CLASS_BULKY,	//This makes sure swords and the pouches can fit in here - the whitelist keeps the bad stuff out
		storage_type = /datum/storage/belt/crusader,
		canhold = list(
			/obj/item/storage/belt/storage_pouch,
			/obj/item/melee/forged_reagent_weapon/sword,
			/obj/item/melee/forged_reagent_weapon/rapier,
			/obj/item/melee/forged_reagent_weapon/dagger,
			/obj/item/melee/forged_reagent_weapon/katana,
			/obj/item/melee/forged_reagent_weapon/bokken,
			/obj/item/melee/sabre,
			/obj/item/melee/parsnip_sabre,
			/obj/item/claymore,
			/obj/item/melee/cleric_mace,
			/obj/item/knife,
			/obj/item/melee/baton,
			/obj/item/nullrod,	//holds any subset of nullrod in the sheath-storage - - -
			/obj/item/melee/energy/sword/nullrod,
		),
		canthold = list(	// - - - except the second list's items (no fedora in the sheath)
			/obj/item/nullrod/armblade,
			/obj/item/toy/plush/carpplushie/nullrod,
			/obj/item/nullrod/chainsaw,
			/obj/item/nullrod/bostaff,
			/obj/item/nullrod/hammer,
			/obj/item/nullrod/pitchfork,
			/obj/item/nullrod/pride_hammer,
			/obj/item/nullrod/spear,
			/obj/item/nullrod/staff,
			/obj/item/nullrod/fedora,
			/obj/item/nullrod/godhand,
			/obj/item/nullrod/whip,
		),
	)
	atom_storage.allow_big_nesting = TRUE // Lets the pouch work
	AddElement(/datum/element/update_icon_updates_onmob)

//Overrides normal dumping code to instead dump from the pouch item inside
/datum/storage/belt/crusader/dump_content_at(atom/dest_object, mob/dumping_mob)
	var/atom/used_belt = parent
	if(!used_belt)
		return
	var/obj/item/storage/belt/storage_pouch/pouch = locate() in real_location
	if(!pouch)
		pouch.balloon_alert(dumping_mob, "no pouch!")
		return //oopsie!! If we don't have a pouch! You're fucked!
	if(locked)
		pouch.balloon_alert(dumping_mob, "locked!")
		return
	pouch.atom_storage.dump_content_at(dest_object, dumping_mob)

/obj/item/storage/belt/crusader/item_ctrl_click(mob/user)	//Makes ctrl-click also open the inventory, so that you can open it with full hands without dropping the sword
	. = ..()
	atom_storage.show_contents(user)
	return

/obj/item/storage/belt/crusader/click_alt(mob/user)	//This is basically the same as the normal sheath, but because there's always an item locked in the first slot it uses the second slot for swords
	if(contents.len == 2)
		var/obj/item/drawn_item = contents[2]
		add_fingerprint(user)
		playsound(src, 'sound/items/unsheath.ogg', 50, TRUE, -5)
		if(!user.put_in_hands(drawn_item))
			to_chat(user, span_notice("You fumble for [drawn_item] and it falls on the floor."))
			update_appearance()
			return CLICK_ACTION_SUCCESS
		user.visible_message(
			span_notice("[user] takes [drawn_item] out of [src]."),
			span_notice("You take [drawn_item] out of [src]."))
		update_appearance()
	else
		to_chat(user, span_warning("[src] is empty!"))
	return CLICK_ACTION_SUCCESS

/obj/item/storage/belt/crusader/update_icon(updates)
	if(contents.len == 2)	//Checks for a sword/rod in the sheath slot, changes the sprite accordingly
		icon_state = "crusader_belt_sheathed"
		worn_icon_state = "crusader_belt_sheathed"
	else
		icon_state = "crusader_belt"
		worn_icon_state = "crusader_belt"
	. = ..()

/obj/item/storage/belt/crusader/examine(mob/user)
	. = ..()
	.+= span_notice("Ctrl-click it to easily open its inventory.")
	if(contents.len == 2)	//If there's no sword/rod in the sheath slot it doesnt display the alt-click instruction
		. += span_notice("Alt-click it to quickly draw the blade.")
		return


/obj/item/storage/belt/crusader/PopulateContents()
	. = ..()
	new /obj/item/storage/belt/storage_pouch(src)

/obj/item/storage/belt/storage_pouch	//seperate mini-storage inside the belt, leaving room for only one sword. Inspired by a (very poorly implemented) belt on Desert Rose
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	name = "storage pouch"
	desc = span_notice("Click on this to open your belt's inventory!")
	icon_state = "storage_pouch_icon"
	worn_icon_state = "no_name"	//Intentionally sets the worn icon to an error
	w_class = WEIGHT_CLASS_BULKY //Still cant put it in your bags, its technically a belt
	anchored = 1	//Dont want people taking it out with their hands

/obj/item/storage/belt/storage_pouch/attack_hand(mob/user, list/modifiers)	//Opens the bag on click - considering it's already anchored, this makes it function similar to how ghosts can open all nested inventories
	. = ..()
	atom_storage.show_contents(user)

/obj/item/storage/belt/storage_pouch/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 6
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL //Rather than have a huge whitelist, the belt can simply hold anything a pocket can hold - Can easily be changed if it somehow becomes an issue

/////////////////////////////////////////////////

/obj/item/storage/belt/sheath/multi
	name = "multi-scabbard"
	desc = "A set of harnesses that enable carrying multiple bulky swords and/or shields."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	icon_state = "multiscabbard_swords_0"
	inhand_icon_state = "sheath"
	worn_icon_state = "sheath"
	actions_types = null
	storage_type = /datum/storage/multi_scabbard

/obj/item/storage/belt/sheath/multi/update_icon(updates)
	. = ..()
	var/numswords = 0
	if(!isnull(contents) && contents.len > 0)
		for(var/obj/item/i in contents)
			if(istype(i, /obj/item/melee))
				numswords ++
	numswords = clamp(numswords, 0, 2)
	icon_state = "multiscabbard_swords_[numswords]"

/obj/item/storage/belt/sheath/multi/update_overlays()
	. = ..()
	var/obj/item/shield/my_shield = null
	for(var/obj/item/i in contents)
		if(istype(i, /obj/item/shield))
			my_shield = i
			break
	if(!isnull(my_shield))
		. += mutable_appearance(my_shield.icon, my_shield.icon_state)

/datum/storage/multi_scabbard
	max_slots = 2
	do_rustle = TRUE
	max_specific_storage = WEIGHT_CLASS_HUGE
	click_alt_open = FALSE

/datum/storage/multi_scabbard/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(list(
		/obj/item/melee/forged_reagent_weapon,
		/obj/item/shield,
		/obj/item/melee/sabre,
		/obj/item/melee/parsnip_sabre,
		/obj/item/claymore,
		/obj/item/melee/cleric_mace,
		/obj/item/knife,
		/obj/item/melee/baton,
		/obj/item/nullrod,
		/obj/item/melee/energy/sword/nullrod,
	))

//////////////////////////////////////////////////////////////////

/obj/item/storage/belt/sheath/repairing
	name = "repairing scabbard"
	desc = "A bluespace crystal in this scabbard causes it to slowly rejuvenate whatever's stored inside it."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	icon_state = "repairsheath"
	inhand_icon_state = "sheath"
	worn_icon_state = "sheath"
	actions_types = null
	storage_type = /datum/storage/repairing_scabbard

	var/integ_restoration_amount_per_seconds = 0.5

/obj/item/storage/belt/sheath/repairing/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	START_PROCESSING(SSdcs, src)

/obj/item/storage/belt/sheath/repairing/process(seconds_per_tick)
	if(contents.len == 0)
		return PROCESS_KILL

	var/obj/item/my_item = contents[1]
	if(isnull(my_item))
		return PROCESS_KILL

	if(my_item.get_integrity() < my_item.max_integrity)
		my_item.repair_damage(integ_restoration_amount_per_seconds * seconds_per_tick)

/datum/storage/repairing_scabbard
	max_slots = 1
	do_rustle = FALSE
	max_specific_storage = WEIGHT_CLASS_BULKY
	click_alt_open = FALSE

/datum/storage/repairing_scabbard/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(list(
		/obj/item/melee/forged_reagent_weapon,
		/obj/item/shield,
		/obj/item/melee/sabre,
		/obj/item/melee/parsnip_sabre,
		/obj/item/claymore,
		/obj/item/melee/cleric_mace,
		/obj/item/knife,
		/obj/item/melee/baton,
		/obj/item/nullrod,
		/obj/item/melee/energy/sword/nullrod,
	))

/////////////////////////////////////////////////

/obj/item/storage/belt/knifethrowers_belt
	name = "knifethrower's belt"
	desc = "Stores a frankly ridiculous number of knives and comparable short, bladed weapons. The shallow pocket depth makes it poor at storing other objects."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	icon_state = "knifethrowers"
	inhand_icon_state = "utility"
	worn_icon_state = "utility"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/knifethrowers

/obj/item/storage/belt/knifethrowers_belt/update_overlays()
	. = ..()
	if(contents.len > 0)
		var/icon_to_use = "belt_knives_[(contents.len > 8 ? 8 : contents.len)]"
		. += mutable_appearance(icon, icon_to_use, alpha = src.alpha)

/datum/storage/knifethrowers
	max_slots = 14
	max_total_storage = 60
	open_sound = 'sound/items/handling/holster_open.ogg'
	open_sound_vary = TRUE

/datum/storage/knifethrowers/New()
	. = ..()
	set_holdable(list(
		/obj/item/melee/forged_reagent_weapon/dagger,
		/obj/item/knife,
		/obj/item/pen,
		/obj/item/scalpel,
		/obj/item/shard,
		/obj/item/spess_knife,
		/obj/item/toy/toy_dagger,
	))

/////////////////////////////////////////////////

/obj/item/storage/bag/plants/bluespace
	name = "bluespace plant bag"
	desc = "A bluespace banana peel grants much larger storage capacity here. It malfunctions when trying to store specific mutant plants -- ironically, bluespace bananas are one such plant..."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	icon_state = "bluespace_botany_bag"
	worn_icon_state = "plantbag"
	storage_type = /datum/storage/bag/plants_bluespace

/datum/storage/bag/plants_bluespace
	max_total_storage = 1000
	max_slots = 300

/datum/storage/bag/plants_bluespace/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(list(
		/obj/item/food/grown,
		/obj/item/graft,
		/obj/item/grown,
		/obj/item/food/honeycomb,
		/obj/item/seeds,
	), list(
		/obj/item/food/grown/banana/bluespace,
		/obj/item/grown/bananapeel/bluespace,
		/obj/item/food/grown/cherry_bomb,
		/obj/item/food/grown/firelemon,
		/obj/item/food/grown/gatfruit,
		/obj/item/food/grown/holymelon,
		/obj/item/food/grown/barrelmelon,
		/obj/item/food/grown/tomato/blue/bluespace,
		/obj/item/food/grown/tomato/killer,
	)
	)

