#define KHARA_SPREADING_MODIFIER 1.4
#define KHARA_FINAL_EMERGENCE_DELAY (90 SECONDS)
#define KHARA_EMERGENCE_BRUTE_DAMAGE 280
#define KHARA_TUMOR_THRESHOLD_STAGE 5

/datum/disease/khara
	name = "Khara Infection"
	desc = "An incurable, contagious pathogen. Khara develops in the nervous system and bloodstream of the carrier, rapidly mutating cells. \
			Outwardly, the infection is similar to cancer. Multiple rapidly growing malignant tumors appear inside the patient's body. \
			In the first three stages, some reagents can slow down or reverse the development of the disease. \
			In the later stages, this effect is much weaker. \
			After full development, the carrier's body will be destroyed by a new form of life that has formed inside it."
	form = "Bioengineered Disease"
	agent = "Veral khara spores"
	visibility_flags = HIDDEN_MEDHUD | HIDDEN_SCANNER
	spread_flags = DISEASE_SPREAD_SPECIAL
	stage_prob = 12
	max_stages = 7
	spread_text = "Veral khara spores (contact + miasma in late stages)"
	cure_text = "Incurable. Rezadone and Haloperidol can slow / partially reverse progression. \
				Anacea toxin destroys spores very effectively. Technetium-99 greatly enhances Anacea."
	viable_mobtypes = list(/mob/living/carbon/human)
	bypasses_immunity = TRUE
	severity = DISEASE_SEVERITY_BIOHAZARD
	process_dead = FALSE
	spreading_modifier = KHARA_SPREADING_MODIFIER
	cures = list()

	var/stage_process = 0
	var/base_stage_speed = 0.65

	var/list/inverters = list(
		/datum/reagent/medicine/rezadone = 0.55,
		/datum/reagent/medicine/haloperidol = 0.75,
		/datum/reagent/toxin/anacea = 4.1,
	)
	var/invert_catalyst = /datum/reagent/inverse/technetium
	var/thing_emerg = /mob/living/basic/khara_mutant/reaper

	COOLDOWN_DECLARE(organ_failure_cd)
	COOLDOWN_DECLARE(miasma_spread_cd)
	COOLDOWN_DECLARE(tumor_pain_cd)
	COOLDOWN_DECLARE(crack_bones_cd)

	var/list/khara_tumors = list()
	var/emerging = FALSE


/datum/disease/khara/update_stage(new_stage)
	if(stage_process < 100 && new_stage > stage)
		return FALSE
	. = ..()
	if(!.)
		return

	switch(new_stage)
		if(4)
			to_chat(affected_mob, span_userdanger("Something heavy and wrong pulses deep inside your abdomen…"))
			spreading_modifier *= 0.6
			process_dead = TRUE
		if(5)
			visibility_flags = NONE
			to_chat(affected_mob, span_userdanger("Your skin bulges and writhes — something is growing far too fast!"))
			// spread_miasma_chance = 0.8
		if(6)
			to_chat(affected_mob, span_bolddanger("Your bones creak and crack under impossible internal pressure!"))
		if(7)
			to_chat(affected_mob, span_bolddanger("Everything inside you is moving. It wants out."))


/datum/disease/khara/proc/stage_evolution_process(seconds_per_tick)
	var/base = base_stage_speed

	if(affected_mob.has_reagent(invert_catalyst, 1, TRUE))
		base *= 0.2

	for(var/inverter in inverters)
		if(affected_mob.has_reagent(inverter, 1, TRUE))
			base -= inverters[inverter]

	if(base < 0 && stage >= 4)
		base *= 0.65

	stage_process = clamp(stage_process + (base * seconds_per_tick * 1.6), 0, 100)

	if(stage_process >= 100)
		if(stage < max_stages)
			update_stage(stage + 1)
			stage_process = 0
		else
			stage_process = 100

	else if(stage_process <= 0 && stage > 1)
		update_stage(stage - 1)
		stage_process = 0

/datum/disease/khara/stage_act(seconds_per_tick, times_fired)
	. = ..()
	stage_evolution_process(seconds_per_tick)

/datum/disease/khara/stage_act(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return

	stage_evolution_process(seconds_per_tick)

	if(emerging)
		return

	switch(stage)
		if(1)
			if(SPT_PROB(1.2, seconds_per_tick))
				affected_mob.emote("cough")
			if(SPT_PROB(0.8, seconds_per_tick))
				to_chat(affected_mob, span_warning("You feel a strange warmth spreading under your skin…"))

		if(2 to 3)
			if(SPT_PROB(2 + stage, seconds_per_tick))
				to_chat(affected_mob, span_warning("A dull, throbbing pain blooms somewhere inside you."))
			if(SPT_PROB(1.1, seconds_per_tick))
				affected_mob.adjust_tox_loss(1.2, forced = TRUE)

		if(4)
			if(SPT_PROB(3, seconds_per_tick))
				to_chat(affected_mob, span_danger("You feel something hard and wrong growing inside your [pick("chest","abdomen","side")]."))
			if(SPT_PROB(1.4, seconds_per_tick))
				affected_mob.adjust_brute_loss(rand(2,5), forced = TRUE)

			if(SPT_PROB(0.9, seconds_per_tick) && COOLDOWN_FINISHED(src, tumor_pain_cd))
				affected_mob.emote("scream")
				COOLDOWN_START(src, tumor_pain_cd, 25 SECONDS)

		if(5)
			if(SPT_PROB(4, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("Your flesh bulges grotesquely — something is alive in there!"))
			if(SPT_PROB(2.2, seconds_per_tick))
				damage_random_organ(rand(8, 14))
			if(SPT_PROB(1.8, seconds_per_tick) && COOLDOWN_FINISHED(src, miasma_spread_cd))
				spread_khara_miasma()
				COOLDOWN_START(src, miasma_spread_cd, 35 SECONDS)

		if(6)
			if(SPT_PROB(3.5, seconds_per_tick))
				to_chat(affected_mob, span_bolddanger("Your ribs groan and shift — something is forcing them apart!"))
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.adjust_brute_loss(rand(6,11), forced = TRUE)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.vomit(VOMIT_CATEGORY_BLOOD|VOMIT_CATEGORY_KNOCKDOWN, lost_nutrition = FALSE)
			if(SPT_PROB(1.6, seconds_per_tick) && COOLDOWN_FINISHED(src, crack_bones_cd))
				affected_mob.emote("scream")
				affected_mob.adjust_brute_loss(8, forced = TRUE)
				COOLDOWN_START(src, crack_bones_cd, 28 SECONDS)

			if(SPT_PROB(2.2, seconds_per_tick))
				spread_khara_miasma()

		if(7)
			if(!COOLDOWN_FINISHED(src, organ_failure_cd))
				return

			to_chat(affected_mob, span_bolddanger("Your body can no longer contain it."))
			affected_mob.visible_message(span_danger("[affected_mob]'s body convulses violently — something is tearing its way out!"))

			affected_mob.Paralyze(8 SECONDS)
			affected_mob.Knockdown(12 SECONDS)
			affected_mob.StaminaKnockdown(80)

			emerging = TRUE
			addtimer(CALLBACK(src, PROC_REF(perform_emergence)), KHARA_FINAL_EMERGENCE_DELAY)

/datum/disease/khara/proc/perform_emergence()
	if(QDELETED(affected_mob))
		return

	affected_mob.visible_message(
		span_bolddanger("[affected_mob]'s torso ruptures in a spray of blood and black ichor as a malformed creature tears free!"),
		span_userdanger("Your body explodes from the inside — you are no more.")
	)

	affected_mob.apply_damage(KHARA_EMERGENCE_BRUTE_DAMAGE, BRUTE, wound_bonus = 70, spread_damage = TRUE)
	affected_mob.spill_organs(DROP_ORGANS)
	if(thing_emerg)
		new thing_emerg(get_turf(affected_mob))
	stage = 1
	process_dead = FALSE

	log_virus("[key_name(affected_mob)] was consumed and torn apart by Khara at [loc_name(affected_mob)]")
	affected_mob.investigate_log("was consumed by Khara infection.", INVESTIGATE_DEATHS)


/datum/disease/khara/proc/spread_khara_miasma()
	var/obj/item/organ/lungs/l = affected_mob.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(!l || !(l.organ_flags & ORGAN_ORGANIC))
		return FALSE

	var/datum/reagents/R = new(12)
	R.my_atom = affected_mob
	R.add_reagent(/datum/reagent/toxin/khara, 12)

	var/datum/effect_system/fluid_spread/smoke/chem/S = new()
	S.set_up(1.4, holder = affected_mob, location = get_turf(affected_mob), carry = R)
	S.start()

	affected_mob.emote("cough")
	return TRUE


/datum/disease/khara/proc/damage_random_organ(dmg)
	if(affected_mob.stat == DEAD)
		return
	var/obj/item/organ/O = pick(affected_mob.organs)
	if(!O || !(O.organ_flags & ORGAN_ORGANIC))
		return
	O.apply_organ_damage(dmg)
	if(O.organ_flags & ORGAN_FAILING)
		to_chat(affected_mob, span_userdanger("Your [O.name] feels like it's being crushed from the inside!"))

#undef KHARA_SPREADING_MODIFIER
#undef KHARA_FINAL_EMERGENCE_DELAY
#undef KHARA_EMERGENCE_BRUTE_DAMAGE
#undef KHARA_TUMOR_THRESHOLD_STAGE



/datum/weather/khara_infection
	name = "Khara fog"
	desc = "Fog formed by Khara spores filling the air..."

	telegraph_message = span_warning("Fog filled with Khara spores descends from the sky!")
	telegraph_duration = 30 SECONDS

	weather_message = span_danger("A thick, acrid fog descends from the sky. It's time to switch to internals!")
	weather_overlay = "dust_med"
	weather_color = COLOR_MAROON

	end_message = span_danger("The fog is lifting!")
	end_duration = 0 SECONDS

	area_type = /area
	protected_areas = list(/area/space)
	target_trait = ZTRAIT_STATION

	use_glow = FALSE
	weather_flags = (WEATHER_MOBS | WEATHER_ENDLESS)


/datum/weather/khara_infection/New(z_levels, list/weather_data)
	. = ..()
	weather_reagent_holder = new(null)
	weather_reagent_holder.create_reagents(WEATHER_REAGENT_VOLUME, NO_REACT)
	weather_reagent_holder.reagents.add_reagent(/datum/reagent/toxin/khara, WEATHER_REAGENT_VOLUME)
	weather_reagent_holder.reagents.set_temperature(weather_temperature)

/datum/weather/khara_infection/weather_act_mob(mob/living/victim)
	if(!ishuman(victim))
		return
	var/mob/living/carbon/human/human = victim
	if(human.stat == DEAD)
		return

	var/does_breath = FALSE
	if(human.external && human.external.breathing_mob == human)
		does_breath = FALSE
	else if(human.internal && human.internal.breathing_mob == human)
		does_breath = FALSE
	else if(HAS_TRAIT(human, TRAIT_NOBREATH))
		does_breath = FALSE
	else
		var/obj/item/organ/lungs/lungs = human.get_organ_slot(ORGAN_SLOT_LUNGS)
		if(lungs && (lungs.organ_flags & ORGAN_ORGANIC))
			does_breath = TRUE
	if(!does_breath && !human.can_be_spread_airborne_disease())
		return
	if(human.has_reagent(/datum/reagent/toxin/khara, 10))
		return //Already enough
	weather_reagent_holder.reagents.expose(human, INHALE | VAPOR, show_message = TRUE)
