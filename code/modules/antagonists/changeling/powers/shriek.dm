/// Time in seconds for the Organic Capacitor to charge from empty to full.
#define ORGANIC_CAPACITOR_CHARGE_SECONDS 60
/// Capacitor charge value that counts as "full" and unlocks Dissonant Shriek.
#define ORGANIC_CAPACITOR_MAX 100
/// Helper to format the maptext shown on the Organic Capacitor HUD element.
#define FORMAT_CAPACITOR_TEXT(charge) MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#28c2dd'>[round(charge)]%</font></div>")
/// As above, but for when the element is being hovered over.
#define FORMAT_CAPACITOR_HOVER_TEXT(charge) MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#dd2828'>[round(charge)]%</font></div>")

/datum/action/changeling/resonant_shriek
	name = "Resonant Shriek"
	desc = "Our lungs and vocal cords shift, allowing us to emit a noise that deafens and confuses non-changelings, causing them to lose some control over their movements. \
		Best used to stop prey from escaping. Doesn't work well in a vacuum. Costs 20 chemicals."
	helptext = "Emits a high-frequency sound that confuses and deafens humans to hamper their movement, blows out nearby lights and overloads cyborg sensors."
	button_icon_state = "resonant_shriek"
	category = "combat"
	chemical_cost = 20
	dna_cost = 1
	req_human = TRUE
	disabled_by_fire = FALSE

//A flashy ability, good for crowd control and sowing chaos.
/datum/action/changeling/resonant_shriek/sting_action(mob/user)
	..()
	if(user.movement_type & VENTCRAWLING)
		user.balloon_alert(user, "can't shriek in pipes!")
		return FALSE
	playsound(user, 'sound/effects/screech.ogg', 100)
	for(var/mob/living/living in get_hearers_in_view(4, user))
		if(IS_CHANGELING(living) || !living.soundbang_act(SOUNDBANG_MASSIVE, stun_pwr = 0, damage_pwr = 0, deafen_pwr = 1 MINUTES, ignore_deafness = TRUE, send_sound = FALSE))
			continue
		if(issilicon(living))
			living.Paralyze(rand(10 SECONDS, 20 SECONDS))
			continue
		living.adjust_confusion(25 SECONDS)
		living.set_jitter_if_lower(100 SECONDS)

	for(var/obj/machinery/light/light in range(4, user))
		light.on = TRUE
		light.break_light_tube()
		stoplag()
	return TRUE

/datum/action/changeling/dissonant_shriek
	name = "Technophagic Shriek"
	desc = "We contort our vocal cords to unleash a piercing shriek that overloads nearby electronics. We grow Organic Capacitors, specialized organs that charge over time and power the pulse. \
		Headsets and cameras fail, lights burst, and lasers, doors, and modsuits can be disrupted. We alter our biology to shield us from the pulse. \
		A fully charged capacitor is required; shrieking drains it completely, and it takes one minute of remaining alive to recharge."
	button_icon_state = "technophagic_shriek"
	category = "combat"
	chemical_cost = 0
	dna_cost = 1
	disabled_by_fire = FALSE
	/// Current charge of our Organic Capacitor, from 0 to [ORGANIC_CAPACITOR_MAX].
	var/capacitor_charge = 0

/datum/action/changeling/dissonant_shriek/on_purchase(mob/user, is_respec)
	. = ..()
	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	RegisterSignal(user, COMSIG_MOB_STATCHANGE, PROC_REF(on_stat_change))
	RegisterSignal(user, SIGNAL_ADDTRAIT(TRAIT_DEATHCOMA), PROC_REF(drain_capacitor))
	RegisterSignal(user, COMSIG_CHANGELING_UPDATE_CAPACITOR_HUD, PROC_REF(on_hud_update_request))
	// Our own biology has adapted to shrug off the pulse we generate, same logic as the ninja suit's advanced EMP shield.
	user.AddElement(/datum/element/empprotection, EMP_PROTECT_SELF|EMP_PROTECT_CONTENTS)
	var/mob/living/living_user = user
	living_user.hud_used?.add_screen_object(/atom/movable/screen/ling/capacitor, HUD_CHANGELING_CAPACITOR, HUD_GROUP_INFO, update_screen = TRUE)
	update_capacitor_hud(living_user)

/datum/action/changeling/dissonant_shriek/Remove(mob/user)
	UnregisterSignal(user, list(COMSIG_LIVING_LIFE, COMSIG_MOB_STATCHANGE, SIGNAL_ADDTRAIT(TRAIT_DEATHCOMA), COMSIG_CHANGELING_UPDATE_CAPACITOR_HUD))
	user.RemoveElement(/datum/element/empprotection, EMP_PROTECT_SELF|EMP_PROTECT_CONTENTS)
	var/mob/living/living_user = user
	living_user.hud_used?.remove_screen_object(HUD_CHANGELING_CAPACITOR)
	return ..()

/// The capacitor charges up while we're alive and out of stasis.
/datum/action/changeling/dissonant_shriek/proc/on_life(mob/living/source, seconds_per_tick)
	SIGNAL_HANDLER
	if(capacitor_charge >= ORGANIC_CAPACITOR_MAX)
		return
	if(source.stat == DEAD || HAS_TRAIT_FROM(source, TRAIT_DEATHCOMA, CHANGELING_TRAIT))
		return
	capacitor_charge = min(capacitor_charge + (ORGANIC_CAPACITOR_MAX / ORGANIC_CAPACITOR_CHARGE_SECONDS) * DELTA_WORLD_TIME(SSmobs), ORGANIC_CAPACITOR_MAX)
	update_capacitor_hud(source)

/// Dying drains the capacitor immediately, same as entering Reviving Stasis.
/datum/action/changeling/dissonant_shriek/proc/on_stat_change(mob/living/source, new_stat, old_stat)
	SIGNAL_HANDLER
	if(new_stat == DEAD)
		drain_capacitor(source)

/// Zeroes the capacitor out. Used on death and on entering Reviving Stasis.
/datum/action/changeling/dissonant_shriek/proc/drain_capacitor(mob/living/source)
	SIGNAL_HANDLER
	capacitor_charge = 0
	update_capacitor_hud(source)

/// Signal proc for the HUD element asking to be redrawn, such as on mouse hover.
/datum/action/changeling/dissonant_shriek/proc/on_hud_update_request(mob/living/source)
	SIGNAL_HANDLER
	update_capacitor_hud(source)

/// Pushes our current capacitor charge to the HUD element, if we have one.
/datum/action/changeling/dissonant_shriek/proc/update_capacitor_hud(mob/living/user)
	var/atom/movable/screen/ling/capacitor/capacitor = user.hud_used?.screen_objects[HUD_CHANGELING_CAPACITOR]
	if(isnull(capacitor))
		return
	capacitor.maptext = capacitor.hovering ? FORMAT_CAPACITOR_HOVER_TEXT(capacitor_charge) : FORMAT_CAPACITOR_TEXT(capacitor_charge)

/datum/action/changeling/dissonant_shriek/can_sting(mob/living/user, mob/living/target)
	if(capacitor_charge < ORGANIC_CAPACITOR_MAX)
		user.balloon_alert(user, "capacitor at [round(capacitor_charge)]%!")
		return FALSE
	return ..()

/datum/action/changeling/dissonant_shriek/sting_action(mob/user)
	..()
	if(user.movement_type & VENTCRAWLING)
		user.balloon_alert(user, "can't shriek in pipes!")
		return FALSE
	empulse(get_turf(user), 2, 5, 1, emp_source = src)
	for(var/obj/machinery/light/light in range(5, user))
		light.on = TRUE
		light.break_light_tube()
		stoplag()
	capacitor_charge = 0
	update_capacitor_hud(user)
	return TRUE

#undef ORGANIC_CAPACITOR_CHARGE_SECONDS
#undef ORGANIC_CAPACITOR_MAX
#undef FORMAT_CAPACITOR_TEXT
#undef FORMAT_CAPACITOR_HOVER_TEXT
