#define HYPOTHERMIA_PARALYSIS "hypothermia_paralysis"

#define HYPOTHERMIA_COLDLEVEL_SAFE      0
#define HYPOTHERMIA_COLDLEVEL_LOW       1
#define HYPOTHERMIA_COLDLEVEL_MODERATE  2
#define HYPOTHERMIA_COLDLEVEL_HIGH      3
#define HYPOTHERMIA_COLDLEVEL_LETHAL    4

#define HYPOTHERMIA_TRESHOLD_SAFE      (T0C + 37)
#define HYPOTHERMIA_TRESHOLD_LOW       (T0C + 35)
#define HYPOTHERMIA_TRESHOLD_MODERATE  (T0C + 32)
#define HYPOTHERMIA_TRESHOLD_HIGH      (T0C + 28)
#define HYPOTHERMIA_TRESHOLD_LETHAL    (T0C + 24)

/datum/component/hypothermia
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/stored_bodytemperature = 310
	var/cooling_rate = 0.33
	var/heating_rate = 0.2
	var/max_temp = 320
	var/maximum_diff = -120
	var/base_rate = 1
	var/cooling_cooldown = 90 SECONDS
	var/heat_cooldown = 10 SECONDS
	var/weather_effect_cooldown = 7 SECONDS
	var/area_tempeture_cooldown = 2 SECONDS
	var/lower_cooltreshhold = T0C + 10
	var/coldlevel = HYPOTHERMIA_COLDLEVEL_SAFE
	var/normal_body_temp =  310


	var/static/list/threshold_data = list(
		list("temp" = HYPOTHERMIA_TRESHOLD_SAFE, "level" = HYPOTHERMIA_COLDLEVEL_SAFE, "stamina" = 1),
		list("temp" = HYPOTHERMIA_TRESHOLD_LOW, "level" = HYPOTHERMIA_COLDLEVEL_LOW, "stamina" = 0.9),
		list("temp" = HYPOTHERMIA_TRESHOLD_MODERATE, "level" = HYPOTHERMIA_COLDLEVEL_MODERATE, "stamina" = 0.7),
		list("temp" = HYPOTHERMIA_TRESHOLD_HIGH, "level" = HYPOTHERMIA_COLDLEVEL_HIGH, "stamina" = 0.5),
		list("temp" = HYPOTHERMIA_TRESHOLD_LETHAL, "level" = HYPOTHERMIA_COLDLEVEL_LETHAL, "stamina" = 0.4),
	)

	var/list/thresholds

	COOLDOWN_DECLARE(area_tempeture_incress)
	COOLDOWN_DECLARE(temperature_incress_cooldown)
	COOLDOWN_DECLARE(shiver_cooldown)
	COOLDOWN_DECLARE(mild_message_cooldown)
	COOLDOWN_DECLARE(confusion_cooldown)
	COOLDOWN_DECLARE(frostbite_cooldown)
	COOLDOWN_DECLARE(paradox_cooldown)
	COOLDOWN_DECLARE(unconscious_cooldown)
	COOLDOWN_DECLARE(organ_damage_cooldown)
	COOLDOWN_DECLARE(temperature_decress_cooldown)
	COOLDOWN_DECLARE(weather_damage_cooldown)

	var/list/disabled_limbs

/datum/component/hypothermia/Initialize()
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	var/mob/living/L = parent
	thresholds = deep_copy_list(threshold_data)

	var/cold_mod = 1
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/datum/species/S = H.dna?.species
		if(S)
			cold_mod = S.coldmod
			var/temp_adjust = (cold_mod - 1) * 10
			for(var/list/data in thresholds)
				data["temp"] += temp_adjust
	cooling_rate *= cold_mod

	disabled_limbs = list()
	COOLDOWN_START(src, temperature_decress_cooldown, cooling_cooldown)
	RegisterWithParent()

/datum/component/hypothermia/Destroy(force)
	UnregisterFromParent()
	. = ..()

/datum/component/hypothermia/RegisterWithParent()
	var/mob/living/living_parent = parent
	living_parent.add_traits(list(TRAIT_WEATHER_IMMUNE, TRAIT_RESISTCOLD), REF(src))
	if(living_parent.bodytemperature < stored_bodytemperature)
		living_parent.bodytemperature = stored_bodytemperature
		stored_bodytemperature = max_temp
	else
		stored_bodytemperature = living_parent.bodytemperature

	RegisterSignal(living_parent, COMSIG_MOB_HEAT_SOURCE_ACT, PROC_REF(on_heat_source_act), TRUE)
	RegisterSignal(living_parent, COMSIG_LIVING_REVIVE, PROC_REF(on_revive), TRUE)
	START_PROCESSING(SSobj, src)

/datum/component/hypothermia/UnregisterFromParent()
	var/mob/living/living_parent = parent
	living_parent.remove_traits(list(TRAIT_WEATHER_IMMUNE, TRAIT_RESISTCOLD), REF(src))
	UnregisterSignal(living_parent, list(COMSIG_MOB_HEAT_SOURCE_ACT, COMSIG_LIVING_REVIVE))
	cleanup_effects()
	STOP_PROCESSING(SSobj, src)


/datum/component/hypothermia/proc/on_revive(mob/living/revived)
	stored_bodytemperature = normal_body_temp
	cleanup_effects(revived)

/datum/component/hypothermia/proc/on_heat_source_act(mob/target, datum/component/heat_source/source, amount, target_temperature)
	SIGNAL_HANDLER
	if(COOLDOWN_FINISHED(src, temperature_incress_cooldown))
		if(apply_heat(amount * base_rate, target_temperature))
			COOLDOWN_START(src, temperature_incress_cooldown, heat_cooldown)

/datum/component/hypothermia/proc/apply_heat(amount, target_temperature)
	var/mob/living/L = parent
	if(!L)
		return FALSE
	if(amount < 0 || target_temperature < lower_cooltreshhold || stored_bodytemperature >= target_temperature)
		return FALSE
	if(target_temperature < lower_cooltreshhold)
		amount *= 0.5
	stored_bodytemperature = stored_bodytemperature + (amount * heating_rate)
	return TRUE

/datum/component/hypothermia/proc/adjust_scaled_temp(mob/living/living_mob, amount, ignore_protection = FALSE)
	var/area/hypothermia/HA = get_area(living_mob)
	if(!istype(HA))
		return

	var/area_temperature = HA.area_temperature
	var/protection = 0
	if(ishuman(living_mob))
		var/mob/living/carbon/human/H = living_mob
		protection = H.get_cold_protection(area_temperature)
	else
		protection = 1

	var/effective_multiplier = 1 - (ignore_protection ? 0 : protection * 0.85)
	effective_multiplier = max(effective_multiplier, 0.08)

	var/scaled_amount = amount * base_rate * effective_multiplier

	scaled_amount = clamp(scaled_amount, -1.2, 1.2)

	if(abs(scaled_amount) < 0.01)
		scaled_amount = 0

	stored_bodytemperature += scaled_amount
	stored_bodytemperature = clamp(stored_bodytemperature, T0C - 100, T0C + 500)

/datum/component/hypothermia/proc/update_visual(mob/living/L, severity = 1)
	L.overlay_fullscreen("comp_hypothermia", /atom/movable/screen/fullscreen/cold_effect, severity)

/datum/component/hypothermia/proc/adjust_coldlevel()
	var/mob/living/L = parent
	if(!L)
		return

	var/new_level = HYPOTHERMIA_COLDLEVEL_SAFE
	var/list/new_data
	for(var/list/data in thresholds)  // sorted descending, find deepest level
		if(stored_bodytemperature < data["temp"])
			new_level = data["level"]
			new_data = data
		else
			break
	if(coldlevel == new_level)
		return

	coldlevel = new_level
	apply_coldlevel_effects(L, new_level, new_data)

/datum/component/hypothermia/proc/apply_coldlevel_effects(mob/living/L, new_level, list/level_data)
	var/new_stamina_mult = level_data["stamina"] ? level_data["stamina"] : 1
	switch(new_level)
		if(HYPOTHERMIA_COLDLEVEL_SAFE)
			cleanup_effects(L)
		if(HYPOTHERMIA_COLDLEVEL_LOW)
			L.add_movespeed_modifier(/datum/movespeed_modifier/hypothermia_mild, TRUE)
		if(HYPOTHERMIA_COLDLEVEL_MODERATE)
			L.add_movespeed_modifier(/datum/movespeed_modifier/hypothermia_moderate, TRUE)
		if(HYPOTHERMIA_COLDLEVEL_HIGH, HYPOTHERMIA_COLDLEVEL_LETHAL)
			L.add_movespeed_modifier(/datum/movespeed_modifier/hypothermia_severe, TRUE)
			if(new_level == HYPOTHERMIA_COLDLEVEL_LETHAL)
				L.SetAllImmobility(4 SECONDS)

	var/initial_stamina = initial(L.max_stamina)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.max_stamina = initial_stamina * new_stamina_mult
	update_visual(L, coldlevel)
	SEND_SOUND(L, 'modular_zvents/sounds/effects/hypothermia_cooling.ogg')

/datum/component/hypothermia/proc/cleanup_effects(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/hypothermia_mild)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/hypothermia_moderate)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/hypothermia_severe)
	L.clear_fullscreen("comp_hypothermia")

	for(var/obj/item/bodypart/limb in disabled_limbs)
		REMOVE_TRAIT(limb, TRAIT_PARALYSIS, HYPOTHERMIA_PARALYSIS)
		limb.update_disabled()
	disabled_limbs.Cut()

	L.set_confusion(0)
	L.set_slurring(0)
	L.set_jitter(0)

/datum/component/hypothermia/proc/apply_effects(mob/living/L, seconds_per_tick)
	var/body_temp_c = stored_bodytemperature - T0C
	if(body_temp_c > 35)
		cleanup_effects(L)
		return

	var/is_synth = issynthetic(L)
	var/cold_mod = 1
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/datum/species/S = H.dna?.species
		if(S)
			cold_mod = S.coldmod

	switch(coldlevel)
		if(HYPOTHERMIA_COLDLEVEL_LOW)
			if(COOLDOWN_FINISHED(src, shiver_cooldown))
				if(is_synth)
					do_sparks(2, TRUE, L)
					COOLDOWN_START(src, shiver_cooldown, rand(12 SECONDS, 40 SECONDS))
				else
					L.emote(pick("shiver", "cough", "sneeze"))
					COOLDOWN_START(src, shiver_cooldown, rand(9 SECONDS, 20 SECONDS))

			if(COOLDOWN_FINISHED(src, mild_message_cooldown))
				var/list/messages = is_synth ? list(
					"Alert: Cooling detected in chassis...",
					"Warning: Circuitry temperature dropping.",
					"Alert: Hydraulic fluid viscosity increasing.",
					"System notice: Minor power fluctuations due to cold.",
					"Warning: External temperature impacting efficiency."
				) : list(
					"You feel the cold creeping under your skin...",
					"Your teeth begin to chatter uncontrollably.",
					"Your fingertips are starting to go numb.",
					"Goosebumps cover your arms.",
					"A deep chill settles in your chest."
				)
				to_chat(L, span_warning(pick(messages)))
				COOLDOWN_START(src, mild_message_cooldown, rand(60, 180) SECONDS)

		if(HYPOTHERMIA_COLDLEVEL_MODERATE)
			L.adjust_stamina_loss(0.1 * seconds_per_tick * cold_mod)
			if(COOLDOWN_FINISHED(src, confusion_cooldown))
				L.adjust_jitter(10 SECONDS)
				var/list/messages = is_synth ? list(
					"Error: Processing delay due to low temperature...",
					"Warning: System glitches detected.",
					"Alert: Sensor data corrupted by cold.",
					"Error: Logic circuits slowing.",
					"Warning: Memory access delayed."
				) : list(
					"Your thoughts are becoming sluggish and foggy...",
					"The world feels distant and unreal.",
					"You can't remember why you came here...",
					"Everything is starting to blur together.",
					"It's getting harder to focus your eyes."
				)
				to_chat(L, span_warning(pick(messages)))
				COOLDOWN_START(src, confusion_cooldown, rand(30, 60) SECONDS)

			if(COOLDOWN_FINISHED(src, unconscious_cooldown) && SPT_PROB(10, seconds_per_tick))
				COOLDOWN_START(src, unconscious_cooldown, rand(120, 180) SECONDS)
				L.Unconscious(rand(1 SECONDS, 2 SECONDS))
				L.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.25 * cold_mod)
				L.adjust_organ_loss(ORGAN_SLOT_HEART, 0.2 * cold_mod)
				L.adjust_oxy_loss(1.5 * cold_mod)

			if(SPT_PROB(10, seconds_per_tick) && COOLDOWN_FINISHED(src, frostbite_cooldown))
				COOLDOWN_START(src, frostbite_cooldown, rand(120, 300) SECONDS)
				apply_frostbite(L, rand(5, 10) * cold_mod)

		if(HYPOTHERMIA_COLDLEVEL_HIGH)
			if(SPT_PROB(10, seconds_per_tick) && COOLDOWN_FINISHED(src, paradox_cooldown))
				var/list/messages = is_synth ? list(
					"ERROR: OVERHEAT DETECTED! EMERGENCY VENTING!",
					"SYSTEM FAULT: THERMAL OVERLOAD!",
					"CRITICAL ERROR: REMOVE EXTERNAL LAYERS!"
				) : list(
					"IT'S TOO HOT! GET THIS IS BURNING ME!",
					"GET IT OFF! I'M ON FIRE!",
					"CLOTHES ARE SUFFOCATING ME!"
				)
				to_chat(L, span_userdanger(pick(messages)))
				paradox_undress(L)
				COOLDOWN_START(src, paradox_cooldown, rand(120 SECONDS, 300 SECONDS))

			if(SPT_PROB(10, seconds_per_tick)&& COOLDOWN_FINISHED(src, frostbite_cooldown))
				apply_frostbite(L, rand(10, 18) * cold_mod)
				COOLDOWN_START(src, frostbite_cooldown, rand(30, 90) SECONDS)

			if(SPT_PROB(10, seconds_per_tick))
				if(is_synth)
					do_sparks(5, TRUE, L)
				else
					L.emote(pick("gasp", "shiver", "pale"))

		if(HYPOTHERMIA_COLDLEVEL_LETHAL)
			L.adjust_stamina_loss(0.3 * seconds_per_tick * cold_mod)

			L.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.8 * seconds_per_tick * cold_mod)
			L.adjust_organ_loss(ORGAN_SLOT_HEART, 0.4 * seconds_per_tick * cold_mod)
			L.adjust_organ_loss(ORGAN_SLOT_LUNGS, 0.9 * seconds_per_tick * cold_mod)
			L.adjust_oxy_loss(1 * seconds_per_tick * cold_mod)

			if(SPT_PROB(10, seconds_per_tick) && COOLDOWN_FINISHED(src, frostbite_cooldown))
				apply_frostbite(L, rand(20, 30) * cold_mod)
				COOLDOWN_START(src, frostbite_cooldown, rand(30, 60) SECONDS)

			if(SPT_PROB(1, seconds_per_tick))
				var/list/messages = is_synth ? list(
					"Critical: All systems freezing...",
					"Error: Power failure imminent.",
					"Shutdown sequence initiated...",
					"Alert: Core temperature critical."
				) : list(
					"You can't feel anything anymore...",
					"The cold has swallowed everything.",
					"It's so quiet... so peaceful...",
					"Your heart barely beats..."
				)
				to_chat(L, span_userdanger(pick(messages)))

			if(SPT_PROB(2, seconds_per_tick))
				disable_limb(L)


/datum/component/hypothermia/proc/handle_weather(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, weather_damage_cooldown))
		return
	var/mob/living/L = parent
	if(!L)
		return
	var/area/hypothermia/HA = get_area(L)
	if(!HA.outdoors)
		return
	var/datum/weather/affected_weather = HA.get_affected_weather()
	if(!affected_weather)
		return
	var/target_temp = affected_weather.weather_temperature
	if(stored_bodytemperature <= target_temp)
		return
	var/delta = (target_temp - stored_bodytemperature) * 0.01
	adjust_scaled_temp(L, (delta * cooling_rate * seconds_per_tick))
	COOLDOWN_START(src, weather_damage_cooldown, weather_effect_cooldown)


/datum/component/hypothermia/process(seconds_per_tick)
	var/mob/living/L = parent
	if(!L)
		return

	L.bodytemperature = stored_bodytemperature
	var/area/hypothermia/HA = get_area(L)
	if(!istype(HA, /area/hypothermia))
		return

	var/temp_diff = HA.area_temperature - stored_bodytemperature
	var/should_cool = (HA.area_temperature <= lower_cooltreshhold)

	if(temp_diff < maximum_diff)
		temp_diff = maximum_diff

	if(should_cool && COOLDOWN_FINISHED(src, temperature_decress_cooldown))
		adjust_scaled_temp(L, temp_diff * cooling_rate * seconds_per_tick)
		COOLDOWN_START(src, temperature_decress_cooldown, cooling_cooldown)

	else if(HA.area_temperature > lower_cooltreshhold && COOLDOWN_FINISHED(src, area_tempeture_incress))
		COOLDOWN_START(src, area_tempeture_incress, area_tempeture_cooldown)
		var/scaled_heat = 1 * heating_rate * 0.9 * seconds_per_tick
		if(HA.area_temperature < normal_body_temp)
			scaled_heat *= 0.8
			stored_bodytemperature = min(stored_bodytemperature + scaled_heat, normal_body_temp)
		else
			scaled_heat *= 0.7
			stored_bodytemperature = stored_bodytemperature + scaled_heat

	stored_bodytemperature = clamp(stored_bodytemperature, T0C - 100, T0C + 500)
	for(var/obj/item/bodypart/limb in disabled_limbs)
		if(world.time >= disabled_limbs[limb])
			REMOVE_TRAIT(limb, TRAIT_PARALYSIS, HYPOTHERMIA_PARALYSIS)
			limb.update_disabled()
			disabled_limbs -= limb
	handle_weather(seconds_per_tick)

	if(HAS_TRAIT(L, TRAIT_STASIS))
		return

	adjust_coldlevel()

	if(L.stat == DEAD)
		if(stored_bodytemperature <= TM70C && !(L.reagents.has_reagent(/datum/reagent/cryostylane, 2)))
			L.reagents.add_reagent(/datum/reagent/cryostylane, 3)
		return

	apply_effects(L, seconds_per_tick)

/datum/component/hypothermia/proc/disable_limb(mob/living/carbon/C)
	var/static/list/limb_weights = list(
		BODY_ZONE_L_ARM = 15,
		BODY_ZONE_R_ARM = 15,
		BODY_ZONE_L_LEG = 35,
		BODY_ZONE_R_LEG = 35
	)
	var/zone = pick_weight(limb_weights)
	var/obj/item/bodypart/limb = C.get_bodypart(zone)
	if(!limb || HAS_TRAIT(limb, TRAIT_PARALYSIS))
		return

	ADD_TRAIT(limb, TRAIT_PARALYSIS, HYPOTHERMIA_PARALYSIS)
	limb.update_disabled()
	disabled_limbs[limb] = world.time + rand(60 SECONDS, 150 SECONDS)

	to_chat(C, span_userdanger("Your [limb.name] goes completely numb — you can't feel or move it!"))

/datum/component/hypothermia/proc/apply_frostbite(mob/living/L, damage)
	if(!iscarbon(L))
		return
	var/mob/living/carbon/C = L

	var/obj/item/bodypart/affecting = C.get_bodypart(pick(list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_HEAD)))
	if(!affecting)
		return
	affecting.receive_damage(burn = max(1, round(damage * 0.6)), wound_bonus = 8)
	to_chat(L, span_danger("Your [affecting.name] burns with freezing pain and turns black!"))

/datum/component/hypothermia/proc/paradox_undress(mob/living/carbon/C)
	var/list/items = C.get_equipped_items()
	items += C.held_items
	for(var/obj/item/I in shuffle(items))
		to_chat(C, span_userdanger("[I.name] burns you, you want to take it off!"))
		to_chat(C, span_notice("Too hot... must... cool down..."))
		break

/datum/movespeed_modifier/hypothermia_mild
	multiplicative_slowdown = 0.2

/datum/movespeed_modifier/hypothermia_moderate
	multiplicative_slowdown = 0.5

/datum/movespeed_modifier/hypothermia_severe
	multiplicative_slowdown = 1.0


#undef HYPOTHERMIA_PARALYSIS


/datum/component/heat_source
	dupe_mode = COMPONENT_DUPE_UNIQUE

	var/heat_output = 0
	var/heat_range = 1
	var/target_temperature = T20C

	VAR_PRIVATE/list/alerts = list()
	VAR_PRIVATE/alert_category = ""

/datum/component/heat_source/Initialize(_heat_output, _heat_power = 1 JOULES, _range = 1, _target_temperature = T20C)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	heat_output = _heat_output * _heat_power
	heat_range = _range
	target_temperature = _target_temperature
	alert_category = "heat_source_[REF(parent)]"

	RegisterSignal(parent, COMSIG_QDELETING, PROC_REF(on_parent_delete))

	var/area/A = get_area(parent)
	if(istype(A, /area/hypothermia))
		var/area/hypothermia/HA = A
		HA.heat_sources += WEAKREF(src)

	START_PROCESSING(SSobj, src)


/datum/component/heat_source/Destroy(force)
	. = ..()
	STOP_PROCESSING(SSobj, src)
	for(var/mob/living/alert_holder as anything in alerts)
		alert_holder.clear_alert(alert_category)
	alerts.Cut()

/datum/component/heat_source/proc/on_parent_delete(datum/source)
	SIGNAL_HANDLER
	var/area/A = get_area(parent)
	if(istype(A, /area/hypothermia))
		var/area/hypothermia/HA = A
		HA.heat_sources -= WEAKREF(src)
	qdel(src)

/datum/component/heat_source/process(seconds_per_tick)
	var/atom/movable/AM = parent
	if(QDELETED(AM))
		qdel(src)
		return

	for (var/mob/living/remove_alert_from as anything in alerts)
		remove_alert_from.clear_alert(alert_category)
		alerts -= remove_alert_from

	var/area/A = get_area(AM)
	if(istype(A, /area/hypothermia) && !A.outdoors)
		var/area/hypothermia/HA = A
		if(!(HA.area_temperature >= target_temperature))
			var/heat_energy = heat_output * seconds_per_tick
			var/volume = HA.get_volume()
			if(volume > 0)
				var/temp_delta = heat_energy / (20 * volume)
				HA.adjust_temperature_scaled(temp_delta, target_temperature)

	if(heat_range > 0)
		for(var/mob/living/L in range(heat_range, parent))
			var/atom/movable/screen/alert/heating/alert = L.throw_alert(alert_category, /atom/movable/screen/alert/heating, new_master = parent)
			alert.desc = "You are heating by [parent]."
			alerts[L] = TRUE

			var/dist = get_dist(AM, L)
			if(dist == 0)
				dist = 1
			var/heat_energy = (heat_output * seconds_per_tick) / 2000
			var/effective_heat = heat_energy / (1 + dist * 2)
			SEND_SIGNAL(L, COMSIG_MOB_HEAT_SOURCE_ACT, src, effective_heat * seconds_per_tick, target_temperature)


/atom/movable/screen/alert/heating
	name = "Heating"
	icon_state = "template"
	use_user_hud_icon = TRUE



/datum/component/perma_death_timer
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/time_left = 10 MINUTES
	var/last_decrease_time = 0
	var/active = FALSE

/datum/component/perma_death_timer/Initialize()
	. = ..()
	if(!iscarbon(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(start_timer))
	RegisterSignal(parent, COMSIG_LIVING_REVIVE, PROC_REF(on_revive))

/datum/component/perma_death_timer/Destroy()
	UnregisterSignal(parent, list(COMSIG_LIVING_DEATH, COMSIG_LIVING_REVIVE))
	STOP_PROCESSING(SSobj, src)
	return ..()

/datum/component/perma_death_timer/proc/start_timer(datum/source)
	SIGNAL_HANDLER
	if(active)
		return
	var/mob/living/carbon/C = parent
	to_chat(C, span_warning("You feel your life force fading... Revival window closing in 10 minutes!"))
	last_decrease_time = world.time
	active = TRUE
	START_PROCESSING(SSobj, src)

/datum/component/perma_death_timer/proc/on_revive(datum/source)
	SIGNAL_HANDLER
	active = FALSE
	time_left = initial(time_left)
	STOP_PROCESSING(SSobj, src)

/datum/component/perma_death_timer/process(seconds_per_tick)
	var/mob/living/carbon/C = parent
	var/delta = world.time - last_decrease_time
	var/paused = FALSE

	if(HAS_TRAIT(C, TRAIT_STASIS))
		paused = TRUE
	else if(C.bodytemperature <= T0C)
		paused = TRUE
	else if(C.reagents.has_reagent(/datum/reagent/toxin/formaldehyde, 0.01))
		C.reagents.remove_reagent(/datum/reagent/toxin/formaldehyde, 0.01)
		paused = TRUE

	if(!paused)
		C.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.1 * seconds_per_tick)
		time_left -= delta

	last_decrease_time = world.time

	if(time_left <= 0)
		make_perma_dead()
		STOP_PROCESSING(SSobj, src)
		active = FALSE

/datum/component/perma_death_timer/proc/make_perma_dead()
	var/mob/living/carbon/C = parent
	if(!C || C.stat != DEAD)
		return
	ADD_TRAIT(C, TRAIT_DNR, "perma_death_timer")
	to_chat(C, span_userdanger("Your essence has dissipated... Revival is now impossible."))

/atom/movable/screen/fullscreen/cold_effect
	icon = 'modular_zvents/icons/fullscreen/fullscreen_effects.dmi'
	icon_state = "hypothermiaoverlay"
