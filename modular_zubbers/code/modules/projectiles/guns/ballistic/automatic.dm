/obj/item/gun/ballistic/automatic/wt550
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/wt550/add_bayonet_point()
	return

/obj/item/gun/ballistic/automatic/wt550/security
	name = "\improper WT-551 Autorifle"
	desc = "A heavier, bulkier automatic variant of the WT-550, and now with 99% less discombobulation! It's back, baby. Uses 4.6x30mm rounds. Recommended to hold with two hands."
	icon = 'modular_zubbers/icons/obj/weapons/guns/wt551.dmi'
	fire_sound = 'modular_zubbers/sound/weapons/gun/wt551/shot.ogg'
	w_class = WEIGHT_CLASS_BULKY
	fire_delay = 3
	//18 damage per 0.3 seconds = 60 DPS
	//Reference: Laser Gun 22 damage per 0.4 seconds = 55DPS

/obj/item/gun/ballistic/automatic/ntmp5
	name = "\improper NT22-HCS-MP 'Lancer'"
	desc = "A hardlight compliance submachine gun variant designed for sustained non-lethal suppression details. It has a retractable stock included in its design, allowing for easier concealment, making this a popular choice among bodyguards."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic32x64.dmi'
	icon_state = "ntmp5"
	base_icon_state = "ntmp5"
	inhand_icon_state = "arg"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/ntusp
	burst_size = 1
	actions_types = list()
	bolt_type = BOLT_TYPE_LOCKING
	bolt_wording = "charging handle"
	fire_delay = 0.15 SECONDS
	spread = 7
	can_suppress = TRUE
	vary_fire_sound = FALSE
	fire_sound_volume = 80
	spawn_magazine_type = /obj/item/ammo_box/magazine/recharge/ntmp5
	var/stock_retracted = TRUE
	var/extended_spread = 7
	var/retracted_spread = 12
	var/extended_icon_state = "ntmp5-stock"
	var/retracted_icon_state = "ntmp5"
	var/weapon_charge_overlay_state
	var/suppressor_overlay_state
	var/seclite_overlay_x = 26
	var/seclite_overlay_y = 11

/obj/item/gun/ballistic/automatic/ntmp5/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/gun/ballistic/automatic/ntmp5/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_CLICK_CTRL, PROC_REF(on_ctrl_click_stock_toggle))
	AddComponent(/datum/component/automatic_fire, 0.15 SECONDS, allow_akimbo = FALSE)
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can " + EXAMINE_HINT("look closer") + " to learn a little more about [src]."), \
		lore = "An adaptation of the NT22-HCS platform, the NT22-HCS-MP refines applied hardlight weaponry for sustained engagement scenarios. This variant is conceptualised for riot control, crowd suppression and union busting.<br>\
		<br>\
		Maintaining compatibility with proprietary .22HL caseless hardlight projectiles, the NT22-HCS-MP utilizes an expanded energy cycling system to support automatic fire. Each shot is generated in real time from larger rechargeable battery packs housed within the magazine well, allowing for extended conflicts without the use of conventional ammunition. The increased rate of fire allows rapid overloading of muscular pathways for whoever is on the wrong end of this gun.<br>\
		<br>\
		Like its sidearm counterpart, the NT22-HCS-MP leaves no recoverable trace. Projectiles dissipate instantly upon impact, producing only superficial burns resulting from the high speed achieved by the bullet.<br>\
		<br>\
		The weapon features a retractable stock, allowing it to be concealed beneath standard-issue outerwear or inside carry bags when collapsed.<br>\
		<br>\
		While classified as non-lethal, the cumulative effects of repeated exposure to hardlight impacts remain insufficiently documented." \
	)
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
		slot_flags &= ~ITEM_SLOT_BACK
		spread = retracted_spread
	else
		update_weight_class(WEIGHT_CLASS_BULKY)
		slot_flags |= ITEM_SLOT_BACK
		spread = extended_spread
	update_appearance()
