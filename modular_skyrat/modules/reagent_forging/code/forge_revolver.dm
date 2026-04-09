/obj/item/gun/ballistic/revolver/handcrafted_single_action
	name = "\improper handcrafted revolver"
	desc = "A traditional-style cowboy revolver. It's single-action, so the hammer must be cocked back to cycle the round."
	icon_state = "revolver"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/handcrafted_single_action
	fire_sound_volume = 90
	bolt_type = BOLT_TYPE_STANDARD
	semi_auto = FALSE
	bolt_wording = "hammer"
	///below stats should match or exceed the murphy's
	throwforce = 19
	force = 8 //this can be lower so that (with bonus) it can be more

	//is the hammer primed (ready to fire) or released (safe)?
	var/hammer_is_primed = FALSE

///Can't be toggled safety -- you need to manage the hammer
/obj/item/gun/ballistic/revolver/handcrafted_single_action/give_gun_safeties()
	return

///go my snowflake code for handling the revolver's hammer!!!
/obj/item/gun/ballistic/revolver/handcrafted_single_action/rack(mob/user = null)
	hammer_is_primed = !hammer_is_primed
	if(hammer_is_primed)
		user.balloon_alert("cocked the hammer")
		if(!istype(magazine,/obj/item/ammo_box/magazine/internal/cylinder))
			stack_trace("[usr] has a magazine that isn't a revolver cylinder!")
		var/obj/item/ammo_box/magazine/internal/cylinder/my_cylinder = magazine
		my_cylinder.rotate()
	else
		user.balloon_alert("decocked the hammer")
	update_appearance()

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
