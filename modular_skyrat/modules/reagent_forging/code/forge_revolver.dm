// COMSIG_ATOM_WAS_ATTACKED check out this signal's implementation

/obj/item/gun/ballistic/revolver/handcrafted_single_action
	name = "\improper handcrafted revolver"
	desc = "A traditional-style cowboy revolver. It's single-action, so the hammer must be cocked back to cycle the round."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	icon_state = "revolver_preview"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/handcrafted_single_action
	fire_sound_volume = 90
	bolt_type = BOLT_TYPE_NO_BOLT
	semi_auto = FALSE
	mag_display = FALSE
	bolt_wording = "hammer"
	///below stats should match or exceed the murphy's
	throwforce = 19
	force = 8 //this can be lower so that (with bonus) it can be more

	//is the hammer primed (ready to fire) or released (safe)?
	var/hammer_is_primed = FALSE
	var/hammer_pull_speed_onehanded = 7 DECISECONDS

/obj/item/gun/ballistic/revolver/handcrafted_single_action/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 2 DECISECONDS) //have this for hammer fanning
	AddComponent(/datum/component/reagent_imbued/weapon)

///Can't be toggled safety -- you need to manage the hammer
/obj/item/gun/ballistic/revolver/handcrafted_single_action/give_gun_safeties()
	return

///go my snowflake code for handling the revolver's hammer!!!
/obj/item/gun/ballistic/revolver/handcrafted_single_action/rack(mob/user = null)
	if(DOING_INTERACTION(user, DOAFTER_REVOLVER_HAMMER_COCK))
		return

	if(!hammer_is_primed)
		var/obj/item/bodypart/other_hand = user.has_hand_for_held_index(user.get_inactive_hand_index()) //
		if(user.get_inactive_held_item() || !other_hand)
			if(!do_after(user, hammer_pull_speed_onehanded, src, timed_action_flags = IGNORE_USER_LOC_CHANGE, interaction_key = DOAFTER_REVOLVER_HAMMER_COCK, hidden = TRUE ))
				return
		hammer_is_primed = TRUE

		balloon_alert(user, "cocked the hammer")
		if(!istype(magazine,/obj/item/ammo_box/magazine/internal/cylinder))
			stack_trace("[usr] has a magazine that isn't a revolver cylinder!")
		var/obj/item/ammo_box/magazine/internal/cylinder/my_cylinder = magazine
		my_cylinder.rotate()
	else
		hammer_is_primed = FALSE
		balloon_alert(user, "decocked the hammer")
	update_appearance()

/obj/item/gun/ballistic/revolver/handcrafted_single_action/try_fire_gun(atom/target, mob/living/user, params)
	if(hammer_is_primed)
		return ..()
	else
		balloon_alert(user, "hammer isn't cocked!")
		return FALSE

////////////////////////// MISFIRE WHEN SHOVED OR ATTACKED ///////////////////////////////////////

/obj/item/gun/ballistic/revolver/handcrafted_single_action/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	hammer_is_primed = FALSE
	. = ..()

/obj/item/gun/ballistic/revolver/handcrafted_single_action/equipped(mob/user, slot, initial)
	. = ..()
	var/static/list/connections = list(COMSIG_ATOM_WAS_ATTACKED = PROC_REF(holster_misfire))
	if(slot != ITEM_SLOT_HANDS)
		AddComponent(/datum/component/connect_inventory, user, connections, allowed_slots = ITEM_SLOT_HANDS)

/obj/item/gun/ballistic/revolver/handcrafted_single_action/dropped(mob/user, silent)
	. = ..()
	qdel(GetComponent(/datum/component/connect_inventory))

/obj/item/gun/ballistic/revolver/handcrafted_single_action/proc/holster_misfire

/obj/item/ammo_box/magazine/internal/cylinder/handcrafted_single_action
	name = "handcrafted revolver cylinder"
	ammo_type = /obj/item/ammo_casing/c38
	caliber = CALIBER_38
	max_ammo = 6

///get round doesn't spin the cylinder; cocking the hammer (from rack()) must be used to spin the cylinder
/obj/item/ammo_box/magazine/internal/cylinder/handcrafted_single_action/get_round()
	var/casing = stored_ammo[1]
	if (ispath(casing))
		casing = new casing(src)
		stored_ammo[1] = casing
	return casing

/obj/item/ammo_box/magazine/internal/cylinder/handcrafted_single_action/spin()
	. = ..()

