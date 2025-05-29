/////GS13 - rayguns for metabolism and breasts/ass manipulation

//this is pretty wonky code, but ig it works

/obj/item/gun/energy/laser/alter_ray
	name = "alter-ray"
	icon = 'icons/obj/guns/energy.dmi'
	icon_state = "lasernew"
	desc = "This weapon is capable of altering one's body capabilities."
	item_state = null
	selfcharge = EGUN_SELFCHARGE
	charge_delay = 5
	ammo_x_offset = 2
	clumsy_check = 1

/obj/item/gun/energy/laser/alter_ray/gainrate
	name = "AL-T-Ray: Metabolism"
	desc = "This weapon is capable of altering one's body capabilities. This model appears to be capable of altering one's weight gain and loss rate by 10%."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/gainrate_decrease, /obj/item/ammo_casing/energy/laser/gainrate_increase, /obj/item/ammo_casing/energy/laser/lossrate_decrease, /obj/item/ammo_casing/energy/laser/lossrate_increase)


// /obj/item/gun/energy/laser/alter_ray/assbreasts //genius name, I know
// 	name = "AL-T-Ray: Voluptousness"
// 	desc = "This weapon is capable of altering one's body capabilities. This model appears to be capable of altering the size's of one's breasts or buttocks."
// 	ammo_type = list(/obj/item/ammo_casing/energy/laser/shrinkray, /obj/item/ammo_casing/energy/laser/growthray)


/obj/item/projectile/alter_ray
	name = "sizeray beam"
	icon_state = "omnilaser"
	hitsound = null
	damage = 0
	damage_type = STAMINA
	flag = "laser"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	ricochets_max = 50
	ricochet_chance = 80
	is_reflectable = TRUE
	var/ratechange_amount = 0.1


//projectile biz

/obj/item/projectile/alter_ray/gainrate_decrease
	icon_state="bluelaser"

/obj/item/projectile/alter_ray/gainrate_increase
	icon_state="laser"

/obj/item/projectile/alter_ray/lossrate_decrease
	icon_state="bluelaser"

/obj/item/projectile/alter_ray/lossrate_increase
	icon_state="laser"

// /obj/item/projectile/alter_ray/breast_decrease
// 	icon_state="bluelaser"

// /obj/item/projectile/alter_ray/breast_increase
// 	icon_state="laser"

// /obj/item/projectile/alter_ray/butt_decrease
// 	icon_state="bluelaser"

// /obj/item/projectile/alter_ray/butt_increase
// 	icon_state="laser"

//laser hitting / changing code

//wg rate increase
/obj/item/projectile/alter_ray/gainrate_increase/on_hit(atom/target, blocked)
	. = ..()
	
	var/mob/living/carbon/gainer = target

	if(iscarbon(gainer))
		if(gainer.weight_gain_rate <= 3)
			gainer.weight_gain_rate += ratechange_amount
			return TRUE
		return FALSE

	return FALSE


//wg rate decrease
/obj/item/projectile/alter_ray/gainrate_decrease/on_hit(atom/target, blocked)
	. = ..()
	
	var/mob/living/carbon/gainer = target

	if(iscarbon(gainer))
		if(gainer.weight_gain_rate >= 0.11)
			gainer.weight_gain_rate -= ratechange_amount
			return TRUE
		if(gainer.weight_gain_rate <= 0.1)
			return FALSE

	return FALSE

//wl rate increase
/obj/item/projectile/alter_ray/lossrate_increase/on_hit(atom/target, blocked)
	. = ..()
	
	var/mob/living/carbon/gainer = target

	if(iscarbon(gainer))
		if(gainer.weight_loss_rate <= 3)
			gainer.weight_loss_rate += ratechange_amount
			return TRUE
		return FALSE

	return FALSE

//wl rate decrease
/obj/item/projectile/alter_ray/lossrate_decrease/on_hit(atom/target, blocked)
	. = ..()
	
	var/mob/living/carbon/gainer = target

	if(iscarbon(gainer))
		if(gainer.weight_loss_rate >= 0.11)
			gainer.weight_loss_rate -= ratechange_amount
			return TRUE
		if(gainer.weight_loss_rate <= 0.1)
			return FALSE
		
	return FALSE

//ammo casings - these are needed to allow guns to switch between firing modes
/obj/item/ammo_casing/energy/laser/gainrate_increase
	projectile_type = /obj/item/projectile/alter_ray/gainrate_increase
	select_name = "Weight Gain Increase"

/obj/item/ammo_casing/energy/laser/gainrate_decrease
	projectile_type = /obj/item/projectile/alter_ray/gainrate_decrease
	select_name = "Weight Gain Decrease"

/obj/item/ammo_casing/energy/laser/lossrate_increase
	projectile_type = /obj/item/projectile/alter_ray/lossrate_increase
	select_name = "Weight Loss Increase"

/obj/item/ammo_casing/energy/laser/lossrate_decrease
	projectile_type = /obj/item/projectile/alter_ray/lossrate_decrease
	select_name = "Weight Loss Decrease"



//ALTRay for making someone gain from weight loss

/obj/item/gun/energy/laser/alter_ray/noloss
	name = "AL-T-Ray: Reverser"
	desc = "This weapon is capable of altering one's body capabilities. This one reverse's ones body functions, to make it so weight loss results in weight gain."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/lossrate_reverse)

/obj/item/ammo_casing/energy/laser/lossrate_reverse
	projectile_type = /obj/item/projectile/alter_ray/lossrate_reverse
	select_name = "Weight Loss Reverse"

/obj/item/projectile/alter_ray/lossrate_reverse
	ratechange_amount = -2
	icon_state="laser"

/obj/item/projectile/alter_ray/lossrate_reverse/on_hit(atom/target, blocked)
	. = ..()
	
	var/mob/living/carbon/gainer = target

	if(iscarbon(gainer))
		gainer.weight_loss_rate = ratechange_amount
		return TRUE

