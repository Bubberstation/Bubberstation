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
			50 nanites = 1 flat armor. \
			Incompatible with other dermal armor programs."
	use_rate = 2
	rogue_types = list(/datum/nanite_program/skin_decay)
	var/damage_type = BRUTE
	var/signal = COMSIG_MOB_APPLY_DAMAGE
	var/max_damage_color = 30
	var/old_flat_mod = 0
	var/rgb_color = list(255, 0, 0)
	var/filter_name = "nanite_armor_outline"
	var/hide_timer

/datum/nanite_program/dermal_armor/enable_passive_effect()
	. = ..()
	RegisterSignal(host_mob, signal, PROC_REF(pre_damage))

/datum/nanite_program/dermal_armor/disable_passive_effect()
	. = ..()
	UnregisterSignal(host_mob, signal)
	var/mob/living/carbon/human/humie = host_mob
	if(istype(humie) && humie.physiology)
		update_damage_modifier(humie, 0)

// update and handle the damage modifier before taking damage, thus only when needed
/datum/nanite_program/dermal_armor/proc/pre_damage(
		mob/living/damaged_mob,
		damage_amount,
		damagetype,
		def_zone,
		blocked,
		wound_bonus,
		bare_wound_bonus,
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
	if(damage_amount >= nanites.nanite_volume)
		playsound(host_mob, SFX_SHATTER)
		host_mob.Knockdown(1 SECONDS)
		to_chat(host_mob, span_warning("Something shatters under your skin, and you feel a sharp pain!"))
		disable_passive_effect()
		return
	// 1 for every 50 nanites, up to 30 flat armor, max of 10 at 500 nanites
	var/nanite_armor = round(nanites.nanite_volume * 0.02, 0.1)
	var/clamped_armor = clamp(nanite_armor, 1, max_damage_color)
	update_damage_modifier(humie, clamped_armor)
	// after this we don't need to prevent the rest of the code from running
	INVOKE_ASYNC(src, PROC_REF(on_pre_damage), damagetype, damage_amount, clamped_armor)

// stuff that we don't need to be syncronous
/datum/nanite_program/dermal_armor/proc/on_pre_damage(damagetype, amount, armor)
	// 2 nanites for every damage blocked, ensure that we don't spend extra nanites when armor is higher than damage
	if(armor >= amount)
		consume_nanites(amount * 2)
	else
		consume_nanites(armor * 2)
	// how long to keep the color effect, while also changing color intensity based on damage
	var/rgb_color = damage_color(amount, armor)
	host_mob.add_filter(filter_name, 2, list("type" = "outline", size = 0))
	host_mob.transition_filter(filter_name, list("type" = "outline", color = rgb(rgb_color[1], rgb_color[2], rgb_color[3]), size = 0.5), 0.5 SECONDS)

	var/damage_duration = amount / (host_mob.maxHealth * 0.5) * 6 SECONDS
	var/timeleft = timeleft(hide_timer)
	var/leftover_time = !isnull(timeleft) ? timeleft : 0
	if(hide_timer)
		deltimer(hide_timer)
	var/time_to_hide = clamp((damage_duration + leftover_time * 0.5) * 0.8, 0.5 SECONDS, 5 SECONDS)
	var/difference = max(damage_duration - time_to_hide, 0.5 SECONDS) // spend 20% of the time to hide the outline
	hide_timer = addtimer(CALLBACK(src, PROC_REF(hide_outline), difference), time_to_hide, TIMER_STOPPABLE)

// modifies the RGB color based on the damage amount, making it more or less intense based on the damage
/datum/nanite_program/dermal_armor/proc/damage_color(amount, armor)
	var/color_strength = clamp(amount / armor, 0.2, 1)
	var/colors = list()
	for(var/i in 1 to 3)
		var/color = rgb_color[i]
		colors += clamp(color * color_strength, 0, 255)
	return colors

/datum/nanite_program/dermal_armor/proc/hide_outline(hide_time = 0.5 SECONDS)
	host_mob.transition_filter(filter_name, list("type" = "outline", size = 0), hide_time)
	host_mob.remove_filter(filter_name)
	hide_timer = null

/datum/nanite_program/dermal_armor/proc/update_damage_modifier(mob/living/carbon/human/humie, amount)
	var/valid_change = clamp(amount, 1, 30)
	humie.physiology.flat_brute_mod -= old_flat_mod
	old_flat_mod = valid_change
	humie.physiology.flat_brute_mod += valid_change

/datum/nanite_program/dermal_armor/refractive
	name = "Dermal Refractive Surface"
	desc = "The nanites form a membrane above the host's skin, reducing the effect of laser and energy impacts. \
			Each hit costs nanites equilavent to damage, but the more nanites you have, the more protection you get. \
			50 nanites = 1 flat armor. \
			Incompatible with other dermal armor programs."
	damage_type = BURN
	rgb_color = list(255, 255, 0)

/datum/nanite_program/dermal_armor/refractive/update_damage_modifier(mob/living/carbon/human/humie, amount)
	humie.physiology.flat_burn_mod -= old_flat_mod
	old_flat_mod = amount
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
