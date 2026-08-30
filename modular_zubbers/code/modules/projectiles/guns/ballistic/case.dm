/obj/item/storage/toolbox/guncase/skyrat/pistol/ntusp
	name = "\improper NT22-HCS 'Enforcer' case"

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntusp/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ntusp(src)
	new /obj/item/ammo_box/magazine/recharge/ntusp(src)

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5
	name = "\improper NT22-HCS-MP 'Lancer' case"

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5/PopulateContents()
	new /obj/item/gun/ballistic/automatic/ntmp5(src)
	new /obj/item/ammo_box/magazine/recharge/ntmp5(src)

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5/blueshield
	name = "\improper DAP NT22-HCS-MP 'Lancer' case"
	desc = "A thick gun case with foam inserts laid out to fit a weapon, magazines, and gear securely. On the top is a silver plaque, emblazoned with the symbol of a shield with D.A.P. written on it in bold."

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5/blueshield/PopulateContents()
	new /obj/item/gun/ballistic/automatic/ntmp5(src)
	new /obj/item/ammo_box/magazine/recharge/ntmp5(src)
	new /obj/item/ammo_box/magazine/recharge/ntmp5/laser(src)
	new /obj/item/suppressor(src)
	new /obj/item/paper/fluff/ntmp5_message(src)

/obj/item/paper/fluff/ntmp5_message
	name = "message from a friend"
	default_raw_text = {"Agent,
<br>
This station is worse than what they put in the reports. You'll figure it quickly enough, if you haven't already.
Well, someone in the DAP thought it'd best you went in properly equipped. Consider it a courtesy.
This is a Lancer, a NT22-HCS-MP. .22HL, battery-fed. Two of the magazines shoot less-than-lethal projectiles. The red one, well, let's just say they're a fair bit more lethal.
You'll also find a suppressor in there. I'm sure it speaks for itself.
Stay sharp.
<br>
-*A Friend in Asset Protection*"}

/// Odds that the Aniolek's second ammo box is armour piercing rather than plain lethal
#define ANIOLEK_ARMOR_PIERCING_CHANCE 15
/// How many spare magazines a magazine fed pick comes packed with
#define SZOT_CASE_SPARE_MAGAZINES 2
/// Extra mines beyond the one the radial already handed over, for four in total
#define SZOT_CASE_SPARE_MINES 3

/// A line apiece for the radial menu, so the quartermaster knows what they are choosing between
GLOBAL_LIST_INIT(szot_case_blurbs, list(
	/obj/item/gun/ballistic/automatic/lanca/jastrzab = "A prototype Lanca fitted with something called \
		\"Smart Drift Control.\" You'll still miss your ex-wife, BUT YOUR AIM IS GETTING BETTER!",
	/obj/item/gun/ballistic/revolver/aniolek = "A monstrous five-round officer's revolver chambered in \
		.310. Failure is not an option; nor, apparently, is subtlety. WARNING: YOU MUST WEIGH AT LEAST \
		20KG TO FIRE THIS WEAPON SAFELY",
	/obj/item/melee/energy/sword/opor = "A near-mint-condition CIN energy sword from the days before \
		anyone had figured out how to make one run indefinitely. Powered by a replaceable cell, and \
		every bit as defiant as the people it was made for.",
	/obj/item/minespawner/straznik = "Four reusable energy mines expertly engineered to deliver \
		\"electrothermal discouragement\" to unauthorized personnel... or anyone else you forgot to \
		warn about them.",
))

// The QM's mystery war trophy. Swipe vault access, pick one Szot gun, live with your choice.

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory
	name = "\improper Szot Dynamica gun case"
	desc = "A battered weapon case the quartermaster insists is from \"the war\", while refusing to elaborate on exactly which war. Inexplicably, security does not bother them about possession of this weapon."
	icon = 'modular_zubbers/icons/obj/szot_case.dmi'
	icon_state = "case_szot"
	req_access = list(ACCESS_VAULT)
	weapon_to_spawn = null
	extra_to_spawn = null
	/// Is the case's lock still engaged
	var/case_locked = TRUE
	/// Has a weapon been picked from the case yet
	var/gun_chosen = FALSE
	/// Guns offered by the case, associated to the magazine that comes with them (null for the Bobr, it gets shell boxes instead)
	/// Whether the lock has been forced open
	var/lock_broken = FALSE
	/// Cosmetic damage tally. The case is genuinely indestructible, so nothing here is real integrity;
	/// it exists so the case can complain convincingly and so the lock has something to give way to.
	var/scuffing = 0

	var/static/list/weapon_choices = list(
		/obj/item/gun/ballistic/automatic/lanca/jastrzab = /obj/item/ammo_box/magazine/lanca/extended,
		/obj/item/gun/ballistic/revolver/aniolek = null,
		/obj/item/melee/energy/sword/opor = null,
		/obj/item/minespawner/straznik = null,
	)

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/PopulateContents()
	return

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/Initialize(mapload)
	. = ..()
	atom_storage.set_locked(STORAGE_FULLY_LOCKED)
	atom_storage.max_slots = 5 // a gun, its ammunition, and the beret
	max_integrity = 250
	integrity_failure = 0.4
	resistance_flags |= INDESTRUCTIBLE
	atom_storage.max_total_storage = 12
	atom_storage.set_holdable(list(
		/obj/item/ammo_box,
		/obj/item/gun/ballistic/automatic/lanca,
		/obj/item/gun/ballistic/automatic/miecz,
		/obj/item/gun/ballistic/automatic/pistol/plasma_marksman,
		/obj/item/gun/ballistic/automatic/pistol/plasma_thrower,
		/obj/item/gun/ballistic/automatic/wylom,
		/obj/item/gun/ballistic/revolver/aniolek,
		/obj/item/gun/ballistic/revolver/shotgun_revolver,
		/obj/item/clothing/head/beret/szot_surplus,
		/obj/item/melee/energy/sword/opor,
		/obj/item/minespawner/straznik,
		/obj/item/stock_parts/capacitor,
		/obj/item/stock_parts/power_store/cell,
	))
	// set_holdable rebuilds this from initial(name), and the abstract ammo box's name is a placeholder
	atom_storage.can_hold_description = "Szot Dynamica weapons, their ammunition, and one very tired beret"
	register_context()

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(isnull(held_item) || lock_broken || isnull(held_item.GetID()))
		return NONE
	context[SCREENTIP_CONTEXT_LMB] = case_locked ? "Unlock with ID" : "Lock with ID"
	return CONTEXTUAL_SCREENTIP_SET

/// The case never actually loses integrity. It keeps its own tally of the beating instead, reports
/// that as though it were real damage, and pops its lock when the tally gets high enough. Until a
/// weapon has been chosen there is nothing inside to spill, so it must never be destroyed outright.
/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	. = ..()
	if(isnull(damage_amount) || damage_amount <= 0)
		return
	scuffing += damage_amount
	if(scuffing < max_integrity)
		return
	scuffing = 0
	break_lock()

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/examine(mob/user)
	. = ..()
	if(lock_broken)
		. += span_notice("The lock appears to be broken.")
	else if(!case_locked && !gun_chosen)
		. += span_notice("The time to raise arms has come again... What kind of gun did you squirrel away in this thing anyway?")
	var/wear = (scuffing / max_integrity) * 100
	switch(wear)
		if(1 to 25)
			. += "It looks a little scuffed."
		if(25 to 60)
			. += "It looks slightly damaged."
		if(60 to 90)
			. += "It appears heavily damaged."
		if(90 to INFINITY)
			. += span_warning("It's falling apart!")

/// Forces the lock and leaves the case intact
/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/proc/break_lock()
	if(lock_broken)
		return
	lock_broken = TRUE
	case_locked = FALSE
	playsound(src, 'sound/effects/structure_stress/pop3.ogg', 60, TRUE)
	atom_storage.set_locked(gun_chosen ? STORAGE_NOT_LOCKED : STORAGE_FULLY_LOCKED)
	update_appearance()

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/update_icon()
	. = ..()
	if(opened)
		return
	if(lock_broken)
		icon_state = "[initial(icon_state)]-broken"
		return
	if(case_locked)
		return
	icon_state = "[initial(icon_state)]_unlocked"

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	var/obj/item/card/id/id_card = tool.GetID()
	if(isnull(id_card))
		return NONE
	if(!check_access(id_card))
		balloon_alert(user, "access denied!")
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 30, TRUE)
		return ITEM_INTERACT_BLOCKING
	if(!case_locked && opened)
		balloon_alert(user, "close the lid first!")
		return ITEM_INTERACT_BLOCKING
	if(lock_broken)
		balloon_alert(user, "lock is broken!")
		return ITEM_INTERACT_BLOCKING
	case_locked = !case_locked
	// the storage itself only opens up once something has actually been put in it
	atom_storage.set_locked(case_locked || !gun_chosen ? STORAGE_FULLY_LOCKED : STORAGE_NOT_LOCKED)
	if(case_locked)
		atom_storage.hide_contents(user)
	balloon_alert(user, case_locked ? "case locked" : "case unlocked")
	playsound(src, 'sound/machines/click.ogg', 40, TRUE)
	update_icon()
	return ITEM_INTERACT_SUCCESS

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/attack_hand_secondary(mob/user, list/modifiers)
	if(!gun_chosen)
		balloon_alert(user, "it won't budge!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	return ..()

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/attack_self(mob/user)
	if(case_locked)
		balloon_alert(user, "it's locked!")
		return
	if(!gun_chosen)
		choose_weapon(user)
		return
	return ..()

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/click_alt(mob/user)
	if(case_locked)
		balloon_alert(user, "it's locked!")
		return CLICK_ACTION_BLOCKING
	if(!gun_chosen)
		balloon_alert(user, "pick a weapon first!")
		return CLICK_ACTION_BLOCKING
	return ..()

/// Offers the user a radial menu of the case's guns, then unpacks the case around their choice
/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/proc/choose_weapon(mob/user)
	var/list/radial_options = list()
	var/list/name_to_path = list()
	for(var/obj/item/gun_path as anything in weapon_choices)
		var/gun_name = initial(gun_path.name)
		if(ispath(gun_path, /obj/item/minespawner/straznik))
			gun_name = "Strażnik Energy Mine Pack"
		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(gun_path.icon), icon_state = initial(gun_path.icon_state))
		option.info = span_boldnotice(GLOB.szot_case_blurbs[gun_path])
		radial_options[gun_name] = option
		name_to_path[gun_name] = gun_path

	var/choice = show_radial_menu(user, src, radial_options, require_near = TRUE, tooltips = TRUE)
	if(!choice || gun_chosen || QDELETED(src))
		return
	if(!user.can_perform_action(src, NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING))
		return

	gun_chosen = TRUE
	atom_storage.set_locked(STORAGE_NOT_LOCKED)
	// it comes with the case, whatever you pick
	new /obj/item/clothing/head/beret/szot_surplus(src)
	// tallied so maintainers can see which option actually gets picked round to round
	SSblackbox.record_feedback("tally", "szot_case_choice", 1, "[choice]")
	user.log_message("chose [choice] from [src]", LOG_GAME)

	var/obj/item/picked_gun = name_to_path[choice]
	new picked_gun(src)

	var/magazine_path = weapon_choices[picked_gun]
	if(magazine_path)
		for(var/spare in 1 to SZOT_CASE_SPARE_MAGAZINES)
			new magazine_path(src)
	else if(ispath(picked_gun, /obj/item/gun/ballistic/revolver/aniolek))
		unpack_strilka()
	else if(ispath(picked_gun, /obj/item/melee/energy/sword/opor))
		return
	else if(ispath(picked_gun, /obj/item/minespawner/straznik))
		unpack_mines()
	else
		unpack_shells()

	balloon_alert(user, "case unpacked")
	atom_storage.show_contents(user)

/// A mine on its own is no use, so the case hands over a working set of four
/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/proc/unpack_mines()
	for(var/spare in 1 to SZOT_CASE_SPARE_MINES)
		new /obj/item/minespawner/straznik(src)

/// The Aniolek ships with two boxes of .310, one of which is occasionally the good stuff.
/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/proc/unpack_strilka()
	new /obj/item/ammo_box/c310_cargo_box(src)
	if(prob(ANIOLEK_ARMOR_PIERCING_CHANCE))
		new /obj/item/ammo_box/c310_cargo_box/piercing(src)
	else
		new /obj/item/ammo_box/c310_cargo_box(src)

/// The Bobr feeds from shell boxes instead of magazines. One guaranteed beanbag box,
/// one box of workhorse lethals, and one surprise from the bottom of the crate.
/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/proc/unpack_shells()
	new /obj/item/ammo_box/advanced/s12gauge/bean(src)

	var/workhorse_box = pick_weight(list(
		/obj/item/ammo_box/advanced/s12gauge/buckshot = 5,
		/obj/item/ammo_box/advanced/s12gauge = 5,
		/obj/item/ammo_box/advanced/s12gauge/hunter = 2,
		/obj/item/ammo_box/advanced/s12gauge/frangible = 1,
		/obj/item/ammo_box/advanced/s12gauge/flechette = 1,
	))
	new workhorse_box(src)

	var/sleeper_box = pick_weight(list(
		/obj/item/ammo_box/advanced/s12gauge/buckshot = 6,
		/obj/item/ammo_box/advanced/s12gauge = 4,
		/obj/item/ammo_box/advanced/s12gauge/flechette = 3,
		/obj/item/ammo_box/advanced/s12gauge/honkshot = 2,
		/obj/item/ammo_box/advanced/s12gauge/incendiary = 2,
		/obj/item/ammo_box/advanced/s12gauge/dragonsbreath = 2,
		/obj/item/ammo_box/advanced/s12gauge/laser = 2,
		/obj/item/ammo_box/advanced/s12gauge/pulse = 2,
	))
	new sleeper_box(src)

// Donk Co's contribution to the 12 gauge arms race, boxed for your convenience

/obj/item/ammo_box/advanced/s12gauge/donk
	name = "\improper Donk Spike ammo box"
	desc = "A box of 7 'Donk Spike' shells. Each shell holds a fistful of plastic flechettes nobody else wanted. Looks like a donk-pocket! \
		Eat and/or microwave at your own risk. Donk Co assumes no liability for damaged teeth or bodily tissue."
	icon = 'modular_zubbers/icons/obj/donk_shotbox.dmi'
	icon_state = "donk"
	ammo_type = /obj/item/ammo_casing/shotgun/flechette/donk
	// must match /datum/design/advancedgaugeboxes_donk exactly or the design_mats unit test fails
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 35, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)

#undef ANIOLEK_ARMOR_PIERCING_CHANCE
#undef SZOT_CASE_SPARE_MAGAZINES
#undef SZOT_CASE_SPARE_MINES
