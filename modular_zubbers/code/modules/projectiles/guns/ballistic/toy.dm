/obj/item/gun/ballistic/toy/foamforce_implant
	name = "Pop-up Donksoft Blaster"
	desc = "A spring primed Donksoft blaster that pops out of a panel on your arm. You wonder if having a high tension spring installed in your arm was a good idea."
	icon = 'modular_zubbers/icons/obj/guns/popupdart_toy.dmi' //modified Derringer sprite by the wonderful Niim. Further modified by myself/MrGloopy.
	icon_state = "popupdart_toy"
	force = 0
	throwforce = 0
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/foamforce_implant
	item_flags = NONE

//JAM CODE
	var/jammed = FALSE
	var/can_jam = TRUE
	var/jamming_chance = 10
	var/unjam_chance = 50
	var/draw_time = 1.3 SECONDS

/obj/item/gun/ballistic/toy/foamforce_implant/attack_self(mob/user)
	if(jammed)
		if(prob(unjam_chance))
			jammed = FALSE
			unjam_chance = initial(unjam_chance)
		else
			balloon_alert(user, "jammed!")
			playsound(user,'sound/items/weapons/jammed.ogg', 75, TRUE)
			return FALSE
	return ..()

/obj/item/gun/ballistic/toy/foamforce_implant/process_fire(mob/user)
	if(can_jam)
		if(chambered.loaded_projectile)
			if(prob(jamming_chance))
				jammed = TRUE
			jamming_chance = clamp (jamming_chance, 0, 100)
	return ..()
//JAM CODE END

//RACKING CODE
/obj/item/gun/ballistic/toy/foamforce_implant/rack(mob/user = null)
	if (bolt_locked)
		drop_bolt(user)
		return
	balloon_alert(user, "plunger deprimed")
	playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
	handle_chamber(empty_chamber =  FALSE, from_firing = FALSE, chamber_next_round = FALSE)
	bolt_locked = TRUE
	update_appearance()

/obj/item/gun/ballistic/toy/foamforce_implant/drop_bolt(mob/user = null)
	if(!do_after(user, draw_time, target = src))
		return
	playsound(src, bolt_drop_sound, bolt_drop_sound_volume, FALSE)
	balloon_alert(user, "plunger drawn")
	chamber_round()
	bolt_locked = FALSE
	update_appearance()

/obj/item/gun/ballistic/toy/foamforce_implant/shoot_live_shot(mob/living/user)
	..()
	rack()

/obj/item/gun/ballistic/toy/foamforce_implant/can_shoot()
	if (bolt_locked)
		return FALSE
	return ..()

/obj/item/gun/ballistic/toy/foamforce_implant/shoot_with_empty_chamber(mob/living/user)
	if(chambered || !magazine || !length(magazine.contents))
		return ..()
	drop_bolt(user)

/obj/item/gun/ballistic/toy/foamforce_implant/examine(mob/user)
	. = ..()
	. += "The blaster is [bolt_locked ? "not ready" : "ready"] to fire."

/obj/item/gun/ballistic/toy/foamforce_implant/update_overlays()
	. = ..()
	if(!bolt_locked)
		. += "[initial(icon_state)]" + "_bolt_locked"
//RACKING CODE END

//AUDIO
	fire_sound = 'sound/items/syringeproj.ogg'
	load_sound = 'sound/items/weapons/gun/general/mag_bullet_insert.ogg'
	load_sound_vary = TRUE
	rack_sound_volume = 50
	rack_sound = 'sound/items/weapons/gun/sniper/rack.ogg'
	bolt_drop_sound = 'sound/items/weapons/gun/rifle/bolt_in.ogg'
	fire_delay = 7
	sound_vary = TRUE
	rack_sound_vary = TRUE
	click_on_low_ammo = FALSE
	internal_magazine = TRUE
	casing_ejector = FALSE
//HANDLING
	clumsy_check = FALSE
	casing_ejector = FALSE
	can_suppress = FALSE
	weapon_weight = WEAPON_LIGHT
	pb_knockback = 0
	cartridge_wording = "dart"
	pinless = TRUE
	gun_flags = NOT_A_REAL_GUN
	can_muzzle_flash = FALSE
	bolt_type = BOLT_TYPE_OPEN
	semi_auto = FALSE
	can_be_sawn_off = FALSE
	tac_reloads = FALSE
	bolt_wording = "plunger"
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	mag_display = FALSE
