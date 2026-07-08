/obj/item/gun/ballistic/automatic/wt550
	can_suppress = FALSE
	can_be_sawn_off = TRUE
/obj/item/gun/ballistic/automatic/wt550/sawoff(mob/user)
	. = ..()
	if(.)
		desc = "why would you do this"
		icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
		w_class = WEIGHT_CLASS_NORMAL
		spread = 10
		dual_wield_spread = 20
		recoil = SAWN_OFF_RECOIL
		update_appearance()

/obj/item/gun/ballistic/automatic/wt550/add_bayonet_point()
	return

/obj/item/gun/ballistic/automatic/wt550/Initialize(mapload)
	. = ..()
	if(type != /obj/item/gun/ballistic/automatic/wt550)
		return
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/wt550_burst, /datum/crafting_recipe/wt550_long)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/gun/ballistic/automatic/ntmp5
	burst_size = 1
	actions_types = list()
	name = "\improper NT22-HCS-MP 'Lancer'"
	desc = "A hardlight compliance submachine gun variant designed for sustained non-lethal confrontations. It has a retractable stock included in its design, allowing for easier concealment. Without the stock, its recoil is strong enough that it needs two hands to use effectively."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ntmp5.dmi'
	icon_state = "ntmp5"
	base_icon_state = "ntmp5"
	inhand_icon_state = "arg"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/ntusp
	bolt_type = BOLT_TYPE_STANDARD
	bolt_wording = "cocking handle"
	fire_delay = 0.15 SECONDS
	recoil = 1
	spread = 5
	mag_display = FALSE
	can_suppress = TRUE
	vary_fire_sound = FALSE
	fire_sound_volume = 80
	spawn_magazine_type = /obj/item/ammo_box/magazine/recharge/ntmp5
	show_bolt_icon = FALSE
	var/stock_retracted = TRUE
	var/extended_icon_state = "ntmp5-stock"
	var/retracted_icon_state = "ntmp5"
	var/weapon_charge_overlay_state
	var/suppressor_overlay_state
	var/seclite_overlay_x = 25
	var/seclite_overlay_y = 11
	var/datum/component/automatic_fire/autofire_component

/obj/item/gun/ballistic/automatic/ntmp5/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/gun/ballistic/automatic/ntmp5/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_CLICK_CTRL, PROC_REF(on_ctrl_click_stock_toggle))
	autofire_component = AddComponent(/datum/component/automatic_fire, fire_delay, allow_akimbo = FALSE)
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can " + EXAMINE_HINT("look closer") + " to learn a little more about [src]."), \
			lore = "An adaptation of the NT22-HCS, the NT22-HCS-MP, also known as the Lancer, is a Machine Pistol refined for sustained engagement scenarios. This variant was designed for operations requiring rapid, repeatable application across multiple subjects, such as crowd suppression, access denial, riot control, and 'labour dispute resolutions'.<br>\
			<br>\
			Maintaining full compatibility with the .22HL battery packs of the Enforcer, the NT22-HCS-MP integrates an expanded energy cycling architecture capable of sustaining automatic fire. Each projectile is synthesized in real time. Reloading follows a simple sequence, designed to be familiar with those trained with regular ballistic weaponry. The bolt is retracted and locked, the battery is inserted and the bolt is then released, typically with the characteristic 'slap'.<br>\
			<br>\
			.22HL rounds are accelerated to considerable velocity, which deliver significant kinetic force at the point of impact, dissipating instantly, leaving no embedded material. The increased rate of fire comes at the cost of slightly less effective bullets produced by the weapon. Nevertheless, the subjects struck by .22HL will suffer significant pain response, exhaustion and loss of voluntary motor function.<br>\
			<br>\
			The NT22-HCS-MP features a collapsible stock, reducing its size and allowing it to be discreetly concealed under jackets or bags. Operational guidelines recommend deployment against non-compliant subjects where verbal deterrence has failed, and escalation to lethal response is not warranted. Nevertheless, longitudinal data on cumulative .22HL exposure remains limited, a consequence of the particularly restricted circulation of post-incident reports." \
	)
	update_fire_delay_state()
	update_stock_state()

/obj/item/gun/ballistic/automatic/ntmp5/examine(mob/user)
	. = ..()
	. += span_notice("The stock is currently [stock_retracted ? "retracted" : "extended"]. Ctrl-click to toggle it.")

/obj/item/gun/ballistic/automatic/ntmp5/proc/on_ctrl_click_stock_toggle(datum/source, mob/user)
	SIGNAL_HANDLER
	stock_retracted = !stock_retracted
	balloon_alert(user, stock_retracted ? "stock retracted" : "stock extended")
	playsound(src, 'sound/items/weapons/batonextend.ogg', 50, TRUE)
	update_stock_state()
	return CLICK_ACTION_SUCCESS
/obj/item/gun/ballistic/automatic/ntmp5/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = seclite_overlay_x, \
		overlay_y = seclite_overlay_y)

/obj/item/gun/ballistic/automatic/ntmp5/update_icon_state()
	base_icon_state = stock_retracted ? retracted_icon_state : extended_icon_state
	return ..()

/obj/item/gun/ballistic/automatic/ntmp5/proc/update_overlay_states()
	weapon_charge_overlay_state = null
	suppressor_overlay_state = null

	if(magazine)
		var/current_ammo = magazine.ammo_count()
		if(current_ammo <= 0 || magazine.max_ammo <= 0)
			weapon_charge_overlay_state = "ntmp5-empty"
		else
			var/ammo_percent = current_ammo / magazine.max_ammo
			weapon_charge_overlay_state = "ntmp5-full"
			if(ammo_percent < 0.5)
				weapon_charge_overlay_state = "ntmp5-half"

	if(suppressed)
		suppressor_overlay_state = "ntmp5-suppressor"

/obj/item/gun/ballistic/automatic/ntmp5/proc/update_fire_delay_state()
	if(istype(magazine, /obj/item/ammo_box/magazine/recharge/ntmp5/laser) || magazine?.type == /obj/item/ammo_box/magazine/recharge/ntusp)
		fire_delay = 0.25 SECONDS
	else
		fire_delay = 0.15 SECONDS

	if(autofire_component)
		autofire_component.autofire_shot_delay = fire_delay

/obj/item/gun/ballistic/automatic/ntmp5/insert_magazine(mob/user, obj/item/ammo_box/magazine/AM, display_message)
	. = ..()
	if(.)
		update_fire_delay_state()

/obj/item/gun/ballistic/automatic/ntmp5/eject_magazine(mob/user, display_message, obj/item/ammo_box/magazine/tac_load)
	. = ..()
	update_fire_delay_state()

/obj/item/gun/ballistic/automatic/ntmp5/update_overlays()
	var/previous_can_unsuppress = can_unsuppress
	can_unsuppress = FALSE
	. = ..()
	can_unsuppress = previous_can_unsuppress

	update_overlay_states()

	if(suppressor_overlay_state)
		. += suppressor_overlay_state
	if(weapon_charge_overlay_state)
		. += weapon_charge_overlay_state


/obj/item/gun/ballistic/automatic/ntmp5/proc/update_stock_state()
	if(stock_retracted)
		update_weight_class(WEIGHT_CLASS_NORMAL)
		weapon_weight = WEAPON_HEAVY
		recoil = 1
		spread = 12
	else
		update_weight_class(WEIGHT_CLASS_BULKY)
		weapon_weight = WEAPON_MEDIUM
		recoil = 0
		spread = 5
	update_appearance()

/obj/item/gun/ballistic/automatic/wt550/burst
	name = "\improper WT-550-B Autoburstrifle"
	desc = "Not so much of a rifle, being modified closer to a submachine gun, but still somehow just as bulky. Outfitted with a modified frame and barrel and a two-shot burst trigger mechanism. Performs overall better than the average autorifle, but kicks a bit more. Has a threaded barrel for suppressors. Uses 4.6x30mm rounds."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "wt550b"
	fire_sound = 'modular_zubbers/sound/weapons/gun/wt551/shot.ogg'
	can_suppress = TRUE
	can_be_sawn_off = FALSE
	suppressor_x_offset = 4
	spread = 3
	recoil = 0.25
	burst_delay = 1
	burst_size = 2
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3
	)

/obj/item/gun/ballistic/automatic/wt550/burst/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.5 SECONDS)

/obj/item/gun/ballistic/automatic/wt550/burst/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 17, \
		overlay_y = 9)

/obj/item/gun/ballistic/automatic/wt550/dmr
	name = "\improper WT-550-C Autorifle"
	desc = "A longer range WT-550, assembled using an aftermarket kit and parts. Outfitted with the longest barrel and custom trigger to enhance performance at a distance. Equipped with a custom scope and a threaded barrel for suppressors. Uses 4.6x30mm rounds."
	icon = 'modular_zubbers/icons/obj/weapons/guns/wide_guns.dmi'
	worn_icon = 'icons/mob/clothing/belt.dmi'
	worn_icon_state = "gun"
	fire_sound = 'modular_zubbers/sound/weapons/gun/wt551/shot.ogg'
	weapon_weight = WEAPON_HEAVY
	can_suppress = TRUE
	can_be_sawn_off = FALSE
	suppressor_x_offset = 6
	slot_flags = ITEM_SLOT_BACK
	projectile_damage_multiplier = 1.50 // 30 damage base + wounding at half the firerate
	projectile_speed_multiplier = 1.50
	projectile_wound_bonus = 5
	burst_delay = 6
	burst_size = 1
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3
	)

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/automatic/wt550/dmr/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.6 SECONDS)
	AddComponent(/datum/component/scope, range_modifier = 2.0)

/obj/item/gun/ballistic/automatic/battle_rifle_basic
	name = "\improper .38 battle rifle"
	desc = "A lower-tech alternative version of Nanotrasen's latest prototype longarm, granting a different option to those who don't care for the NT-38. \
		Technically a pistol-caliber carbine, despite the name and its use as a battle rifle. \
		Forsaking the advanced electronics and integrated technological advantages allows it to perform infinitely more reliably."
	icon = 'modular_zubbers/icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "battle_rifle"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "battle_rifle"
	worn_icon = 'icons/mob/clothing/back.dmi'
	worn_icon_state = "battle_rifle"
	slot_flags = ITEM_SLOT_BACK

	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/m38
	w_class = WEIGHT_CLASS_BULKY
	force = 15
	mag_display = TRUE
	empty_indicator = TRUE
	fire_delay = 1.5 DECISECONDS
	burst_size = 1
	actions_types = list()
	fire_sound = 'sound/items/weapons/thermalpistol.ogg'
	suppressor_x_offset = 0

	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 11,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
	)

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/automatic/battle_rifle_basic/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 26, \
		overlay_y = 10)
