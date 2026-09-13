// TURRET_LETHAL and TURRET_FLAG_SHOOT_ANOMALOUS are file-local in portable_turret.dm
// (#undef'd out of reach there), so they are re-declared here and #undef'd at the end.
// The unit test in vitezstvi_turret_flags.dm guards the anomalous value against drift.
#define TURRET_LETHAL 1
#define TURRET_FLAG_SHOOT_ANOMALOUS (1<<4)

/// Shared id that links the shuttle's sentries to their bridge control console.
#define VITEZSTVI_TURRET_ID "vitezstvi_sentry"

/obj/machinery/porta_turret/vitezstvi
	name = "\improper Vítězství Arms sentry"
	desc = "A mind-boggling Vítězství Arms product you've never seen on the market. No doubt cooked up as part of a half-baked, vodka-soaked scheme. An ammo box on the side indicates it's loaded with .60 Strela, the same anti-material round the Wyłom chambers; it will probably atomize anyone it deems insufficiently Tsarist, though that part is merely implied."
	installation = null
	uses_stored = FALSE // we hardcode projectiles, so process() must not wait on a stored_gun
	max_integrity = 260
	always_up = TRUE
	use_power = NO_POWER_USE
	has_cover = FALSE
	scan_range = 9
	mode = TURRET_LETHAL
	icon = 'modular_skyrat/modules/encounters/icons/turrets.dmi'
	icon_state = "gun_turret_off"
	base_icon_state = "gun_turret"
	system_id = VITEZSTVI_TURRET_ID
	stun_projectile = /obj/projectile/bullet/p60strela
	lethal_projectile = /obj/projectile/bullet/p60strela
	lethal_projectile_sound = 'modular_skyrat/modules/novaya_ert/sound/amr_fire.ogg'
	stun_projectile_sound = 'modular_skyrat/modules/novaya_ert/sound/amr_fire.ogg'
	shot_delay = 2 SECONDS
	faction = list(
		FACTION_TURRET,
		FACTION_VITEZSTVI,
	)
	req_access = list()
	req_one_access = list(ACCESS_MERC, ACCESS_SECURITY)
	turret_flags = TURRET_FLAG_SHOOT_ANOMALOUS

/obj/machinery/porta_turret/vitezstvi/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF | EMP_PROTECT_WIRES)

/obj/machinery/porta_turret/vitezstvi/setup()
	return

/obj/machinery/porta_turret/vitezstvi/assess_perp(mob/living/carbon/human/perp)
	// Hostiles are judged before any access check, because syndicate agents routinely
	// carry stolen all-access IDs that would otherwise clear the whitelist.
	if(ROLE_SYNDICATE in perp.get_faction())
		return 10
	var/obj/item/card/id/id_card = perp.wear_id?.GetID()
	if(id_card && ((ACCESS_SYNDICATE in id_card.access) || (ACCESS_SYNDICATE_LEADER in id_card.access)))
		return 10
	var/datum/record/crew/record = find_record(perp.get_face_name(perp.get_id_name()))
	if(record?.wanted_status == WANTED_ARREST)
		return 10
	return 0

/obj/machinery/turretid/vitezstvi
	name = "sentry control"
	desc = "Used to control the Vítězství Arms shuttle's automated defenses. The labelling is confident about which way they point."
	system_id = VITEZSTVI_TURRET_ID
	req_access = list()
	req_one_access = list(ACCESS_MERC, ACCESS_COMMAND)

#undef TURRET_LETHAL
#undef TURRET_FLAG_SHOOT_ANOMALOUS
#undef VITEZSTVI_TURRET_ID
