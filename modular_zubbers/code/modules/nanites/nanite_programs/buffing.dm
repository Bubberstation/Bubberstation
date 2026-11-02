//Programs that buff the host in generally passive ways.

/datum/nanite_program/nervous
	name = "Nerve Support"
	desc = "The nanites act as a secondary nervous system, reducing the amount of time the host is stunned."
	use_rate = 1.5
	rogue_types = list(/datum/nanite_program/nerve_decay)

/datum/nanite_program/nervous/enable_passive_effect()
	. = ..()
	if(ishuman(host_mob))
		var/mob/living/carbon/human/H = host_mob
		H.physiology.stun_mod *= 0.5

/datum/nanite_program/nervous/disable_passive_effect()
	. = ..()
	if(ishuman(host_mob))
		var/mob/living/carbon/human/H = host_mob
		H.physiology.stun_mod *= 2

/datum/nanite_program/dermal_armor
	name = "Dermal Hardening"
	desc = "The nanites form a mesh under the host's skin, protecting them from melee and bullet impacts. \
			Each hit costs nanites two times to damage, but the more nanites you have, the more protection you get. \
			50 nanites = 1 flat armor, with each hit costing two times it's damage in nanites. \
			Will not turn on with other dermal armor programs."
	use_rate = 2
	rogue_types = list(/datum/nanite_program/skin_decay)
	var/damage_type = BRUTE
	var/signal = COMSIG_MOB_ALWAYS_APPLY_DAMAGE
	var/max_damage_resist = 30
	var/current_flat_mod = 0
	var/rgb_color = list(255, 0, 0)
	var/filter_name = "nanite_armor_outline"
	var/hide_timer
	var/cleanup_timer
	/// how much to multiply the nanite cost on the damage received
	var/cost_modifier = 2

/datum/nanite_program/dermal_armor/activate()
	if(check_duplicate_programs())
		return
	if(!ishuman(host_mob))
		return
	. = ..()

/datum/nanite_program/dermal_armor/enable_passive_effect()
	. = ..()
	RegisterSignal(host_mob, signal, PROC_REF(pre_damage))

/datum/nanite_program/dermal_armor/proc/check_duplicate_programs()
	for(var/program in nanites.programs)
		if(istype(program, type) && program != src)
			return TRUE
	return FALSE

/datum/nanite_program/dermal_armor/disable_passive_effect()
	. = ..()
	UnregisterSignal(host_mob, signal)

	delete_hide_timer()
	delete_cleanup_timer()

	update_damage_modifier(0)

/datum/nanite_program/dermal_armor/active_effect()
	// 1 for every 50 nanites, up to 30 flat armor, max of 10 at 500 nanites
	var/nanite_armor = ceil(nanites.nanite_volume * 0.02)
	var/clamped_armor = clamp(nanite_armor, 1, max_damage_resist)
	update_damage_modifier(clamped_armor)

// update and handle the damage modifier before taking damage, thus only when needed
/datum/nanite_program/dermal_armor/proc/pre_damage(
		mob/living/damaged_mob,
		damage_amount,
		damagetype,
		def_zone,
		blocked,
		wound_bonus,
		exposed_wound_bonus,
		sharpness,
		attack_direction,
		attacking_item,
		wound_clothing
	)
	SIGNAL_HANDLER
	if(damagetype != damage_type)
		return
	var/mob/living/carbon/human/humie = host_mob
	if(!istype(humie) || !humie.physiology || !nanites)
		return
	// since we are likely to already have a damage modifier, we need to calculate the actual damage received
	// as the damage_amount received here is already modified by the flat_brute_mod
	var/actual_damage = damage_amount + current_flat_mod
	if(actual_damage >= nanites.nanite_volume)
		playsound(host_mob, SFX_SHATTER)
		host_mob.Knockdown(1 SECONDS)
		to_chat(host_mob, span_warning("Something shatters under your skin, and you feel a sharp pain!"))
		disable_passive_effect()
		return

	// after this we don't need to prevent the rest of the code from running
	INVOKE_ASYNC(src, PROC_REF(on_pre_damage), damagetype, actual_damage)

/datum/nanite_program/dermal_armor/proc/on_pre_damage(damagetype, amount)
	// 2 nanites for every 1 damage blocked, ensure that we don't spend extra nanites when armor is higher than damage
	if(amount >= current_flat_mod)
		consume_nanites(current_flat_mod * cost_modifier)
	else
		consume_nanites(amount * cost_modifier)

	var/damage_duration = (amount / current_flat_mod) * 2 SECONDS
	var/timeleft = timeleft(hide_timer)
	var/leftover_time = !isnull(timeleft) ? timeleft : 0
	// if we're already showing the outline, reset the timer

	if(hide_timer)
		delete_hide_timer()
	else
		// how long to keep the color effect, while also changing color intensity based on damage
		// only add the filter if we're not cleaning up, as that means we're already showing the outline which is animating to hide itself
		if(cleanup_timer)
			delete_cleanup_timer()
		else
			host_mob.add_filter(filter_name, 2, list("type" = "outline", size = 0))
		// control the intensity of the color based on how much damage we're taking vs the armor we have
		var/rgb_color = damage_color(amount, current_flat_mod)
		host_mob.transition_filter(filter_name, list("type" = "outline", color = rgb(rgb_color[1], rgb_color[2], rgb_color[3]), size = 0.5), 0.5 SECONDS)

	var/time_to_hide = clamp((damage_duration + leftover_time * 0.5) * 0.8, 0.5 SECONDS, 2 SECONDS)
	var/difference = max(damage_duration - time_to_hide, 0.5 SECONDS) // spend 20% of the time to hide the outline
	hide_timer = addtimer(CALLBACK(src, PROC_REF(hide_outline), difference), time_to_hide, TIMER_STOPPABLE)

/datum/nanite_program/dermal_armor/proc/delete_hide_timer()
	deltimer(hide_timer)
	hide_timer = null

/datum/nanite_program/dermal_armor/proc/delete_cleanup_timer()
	deltimer(cleanup_timer)
	cleanup_timer = null

// modifies the RGB color based on the damage amount, making it more or less intense based on the damage
/datum/nanite_program/dermal_armor/proc/damage_color(amount, armor)
	var/color_strength = clamp(amount / armor, 0.2, 1)
	var/colors = list()
	for(var/i in 1 to 3)
		var/color = rgb_color[i]
		colors += clamp(color * color_strength, 0, 255)
	return colors

// hiding the outline is a 2 step process as we have a delay before we start hiding it
// this is to prevent the outline from flickering when we're taking damage in quick succession
/datum/nanite_program/dermal_armor/proc/hide_outline(hide_time = 0.5 SECONDS)
	hide_timer = null
	host_mob.transition_filter(filter_name, list("type" = "outline", size = 0), hide_time)
	cleanup_timer = addtimer(CALLBACK(src, PROC_REF(cleanup_outline)), hide_time, TIMER_STOPPABLE)

/datum/nanite_program/dermal_armor/proc/cleanup_outline()
	host_mob.remove_filter(filter_name)
	cleanup_timer = null

/datum/nanite_program/dermal_armor/proc/update_damage_modifier(amount)
	var/mob/living/carbon/human/humie = host_mob
	var/valid_change = clamp(amount, 1, 30)
	if(!humie)
		stack_trace("A nanite program is running without a host mob present. Something's wrong.")
		return
	humie.physiology.flat_brute_mod += current_flat_mod
	current_flat_mod = valid_change
	humie.physiology.flat_brute_mod -= valid_change

/datum/nanite_program/dermal_armor/refractive
	name = "Dermal Refractive Surface"
	desc = "The nanites form a membrane above the host's skin, reducing the effect of laser and energy impacts. \
			Each hit costs nanites equilavent to damage, but the more nanites you have, the more protection you get. \
			50 nanites = 1 flat armor, with each hit costing two times it's damage in nanites. \
			Will not turn on with other dermal armor programs."
	damage_type = BURN
	rgb_color = list(255, 255, 0)

/datum/nanite_program/dermal_armor/refractive/update_damage_modifier(mob/living/carbon/human/humie, amount)
	if(!humie)
		stack_trace("A nanite program is running without a host mob present. Something's wrong.")
		return
	humie.physiology.flat_burn_mod -= current_flat_mod
	current_flat_mod = amount
	humie.physiology.flat_burn_mod += amount

/datum/nanite_program/coagulating
	name = "Vein Repressurization"
	desc = "The nanites re-route circulating blood away from open wounds, dramatically reducing bleeding rate."
	use_rate = 0.20
	rogue_types = list(/datum/nanite_program/suffocating)

/datum/nanite_program/coagulating/enable_passive_effect()
	. = ..()
	if(ishuman(host_mob))
		var/mob/living/carbon/human/H = host_mob
		H.physiology.bleed_mod *= 0.5

/datum/nanite_program/coagulating/disable_passive_effect()
	. = ..()
	if(ishuman(host_mob))
		var/mob/living/carbon/human/H = host_mob
		H.physiology.bleed_mod *= 2

/datum/nanite_program/conductive
	name = "Electric Conduction"
	desc = "The nanites act as a grounding rod for electric shocks, protecting the host. Shocks can still damage the nanites themselves."
	use_rate = 0.20
	program_flags = NANITE_SHOCK_IMMUNE
	rogue_types = list(/datum/nanite_program/nerve_decay)

/datum/nanite_program/conductive/enable_passive_effect()
	. = ..()
	ADD_TRAIT(host_mob, TRAIT_SHOCKIMMUNE, NANITES_TRAIT)

/datum/nanite_program/conductive/disable_passive_effect()
	. = ..()
	REMOVE_TRAIT(host_mob, TRAIT_SHOCKIMMUNE, NANITES_TRAIT)

/datum/nanite_program/mindshield
	name = "Mental Barrier"
	desc = "The nanites form a protective membrane around the host's brain, shielding them from abnormal influences while they're active."
	use_rate = 0.40
	rogue_types = list(/datum/nanite_program/brain_decay, /datum/nanite_program/brain_misfire)

/datum/nanite_program/mindshield/enable_passive_effect()
	. = ..()
	if(!host_mob.mind.has_antag_datum(/datum/antagonist/rev, TRUE)) //won't work if on a rev, to avoid having implanted revs.
		ADD_TRAIT(host_mob, TRAIT_MINDSHIELD, NANITES_TRAIT)
		host_mob.sec_hud_set_implants()

/datum/nanite_program/mindshield/disable_passive_effect()
	. = ..()
	REMOVE_TRAIT(host_mob, TRAIT_MINDSHIELD, NANITES_TRAIT)
	host_mob.sec_hud_set_implants()
