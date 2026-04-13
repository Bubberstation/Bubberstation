/obj/item/gun/ballistic/automatic/pistol/ntusp
	name = "\improper NT22-HCS 'Enforcer'"
	desc = "A compact hardlight compliance sidearm from Nanotrasen's internal defense and security program."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "ntusp"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/ntusp
	can_suppress = TRUE
	bolt_type = BOLT_TYPE_LOCKING
	vary_fire_sound = FALSE
	fire_sound_volume = 80
	bolt_wording = "slide"
	suppressor_x_offset = 0

/obj/item/gun/ballistic/automatic/pistol/ntusp/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)


/obj/item/gun/ballistic/automatic/pistol/ntusp/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can " + EXAMINE_HINT("look closer") + " to learn a little more about [src]."), \
		lore = "A prototype of applied hardlight weaponry, the NT22-HCS (Hardlight Compliance System) represents Nanotrasen's first successful attempt to weaponise this novel technology in a small, compact form. Designed primarily for Nanotrasen's Division of Asset Protection, as a means to neutralise threats in a non-lethal fashion for executive protection.<br>\
		<br>\
		Rather than conventional ammunition, the NT22-HCS fires proprietary .22HL caseless hardlight projectiles. Each shot is synthesized in real time, drawing energy from rechargeable battery packs inserted into the weapon's magazine well. Upon discharge, the weapon forms hardlight bullets that disrupt neuromuscular function on impact, rapidly inducing fatigue in the target.<br>\
		<br>\
		Unlike traditional ballistics, .22HL rounds do not fragment, embed, or leave residual material, as the projectiles dissipate at the moment of impact, leaving behind only minor burns attributable to velocity. Due to this, forensic tracing is rendered effectively impossible.<br>\
		<br>\
		Long-term physiological effects of repeated hardlight exposure are, at best, unclear. There exists little credible data on their effect." \
	)

/obj/item/gun/ballistic/automatic/pistol/ntusp/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 15, \
		overlay_y = 13)
