//Niim Pocket Reolver - Fires Murphy ammo
/obj/item/gun/ballistic/revolver/protector_revolver
	name = "\improper 'Protector' Revolver"
	desc = "The Protector was designed to be a compact backup gun for NT law enforcement. Features a built in light and carefully polished action to ensure functionality no matter the environment, chambered in the same NT issue 9mm Murphy to maintain ammo compatibility. 'Murphy' magazines can be notched onto the cylinder for easy reloading."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "niimpocketrevolver_sec"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/sec9mm
	fire_sound = 'sound/items/weapons/gun/revolver/shot.ogg'
	load_sound = 'sound/items/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/items/weapons/gun/revolver/empty.ogg'
	fire_sound_volume = 40
	dry_fire_sound = 'sound/items/weapons/gun/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	w_class = WEIGHT_CLASS_SMALL
	force = 9.5 //slightly worse than murphy/batong

/obj/item/gun/ballistic/revolver/protector_revolver/add_seclight_point()
	// The revolver's light comes attached but is unremovable.
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
		light_overlay_icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi', \
		light_overlay = "niimpocketrevolver_light")


/obj/item/gun/ballistic/revolver/defender_revolver
	name = "\improper 'Defender' revolver"
	desc = "The Defender is a cheap, subpar Martian made knockoff of the Protector series, albeit street lore is that both came out of the same factories. Fires .38 rounds. The poor quality of the machining slightly reduces the round's power and accuracy."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "niimpocketrevolver_civvie"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/defender38
	fire_sound = 'sound/items/weapons/gun/revolver/shot.ogg'
	load_sound = 'sound/items/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/items/weapons/gun/revolver/empty.ogg'
	fire_sound_volume = 50
	dry_fire_sound = 'sound/items/weapons/gun/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	w_class = WEIGHT_CLASS_SMALL
	projectile_damage_multiplier = 0.8
	spread = 10
	force = 9.5 //slightly worse than murphy/batong


/obj/item/gun/ballistic/revolver/consultant
	name = "The Verdict"
	desc = "A beautiful revolver inspired by the renowned Unica, commissioned for Nanotrasen officials who needed the style of a hand cannon without the burden of carrying one. This polished imitation offers less raw stopping power than its Slavic cousin, but it's much lighter and more comfortable to use."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "niimconsultantrevolver"
	base_icon_state = "niimconsultantrevolver"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev32
	projectile_damage_multiplier = 0.7

/obj/item/gun/ballistic/revolver/consultant/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/gun/ballistic/revolver/consultant/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can " + EXAMINE_HINT("look closer") + " to learn a little more about [src]."), \
			lore = "The Verdict is a somewhat experimental design. It was first drafted up by Nanotrasen Armories as a ceremonial sidearm for Commanders, Admirals, and other authoritative Central Command roles. It's an instrument of authority first, and a tool of self-defense second, whose actual capabilities were only addressed after its silhouette had been given a design which the procurement board described as 'appropriately authoritative'.<br>\
<br>\
The Verdict has been given a cast in a high-polish, chrome-nickel alloy and finished by hand, a process that Nanotrasen never dared to automate, instead being worked on by theoretically paid Interns. It uses .32 magnum rounds, more than sufficient to end a confrontation should the need arise.<br>\
<br>\
The Verdict is distributed exclusively through commendation and promotion; engraved along its barrel is the recipient's name and division. This one does not have any name on it yet, but you may just be able to earn the right to have it bear yours..." \
	)

/obj/item/ammo_box/magazine/internal/cylinder/rev32
	name = ".32 revolver cylinder"
	ammo_type = /obj/item/ammo_casing/c38/c32
	caliber = CALIBER_32
	max_ammo = 6
