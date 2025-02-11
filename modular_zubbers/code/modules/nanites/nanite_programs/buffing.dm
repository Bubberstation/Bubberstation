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
			Each hit costs nanites equilavent to damage, but the more nanites you have, the more protection you get. \
			50 nanites = 1 flat armor. \
			Incompatible with other dermal armor programs."
	use_rate = 0.5
	rogue_types = list(/datum/nanite_program/skin_decay)
	var/damage_type = BRUTE
	var/signal = COMSIG_MOB_APPLY_DAMAGE
	var/old_flat_mod = 0
	var/color_effect = "#ff1100"

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
/datum/nanite_program/dermal_armor/proc/pre_damage(damagetype, amount, forced)
	SIGNAL_HANDLER
	if(damagetype != damage_type)
		return
	var/mob/living/carbon/human/humie = host_mob
	if(!istype(humie) || !humie.physiology || !nanites)
		return
	if(amount >= nanites.nanite_volume)
		playsound(host_mob, SFX_SHATTER)
		host_mob.Knockdown(1 SECONDS)
		to_chat(host_mob, span_warning("Something shatters under your skin, and you feel a sharp pain."))
		disable_passive_effect()
		return
	// 1 for every 50 nanites, up to 30 flat armor, max of 10 at 500 nanites
	var/nanite_armor = nanites.nanite_volume / 50
	var/clamped_armor = clamp(nanite_armor, 1, 30)
	update_damage_modifier(humie, clamped_armor)
	INVOKE_ASYNC(src, PROC_REF(on_pre_damage), damagetype, amount, forced)

// stuff that we don't need to be syncronous
/datum/nanite_program/dermal_armor/proc/on_pre_damage(damagetype, amount, forced)
	consume_nanites(amount)
	// how long to keep the color effect, to also indicate the damage
	var/damage_duration = amount / (host_mob.maxHealth * 0.5) * 6 SECONDS
	animate(host_mob, color = color_effect, time = 0.5 SECONDS)
	animate(color = host_mob.color, time = damage_duration) // without the first arg byond chains animates

/datum/nanite_program/dermal_armor/proc/update_damage_modifier(mob/living/carbon/human/humie, amount)
	humie.physiology.flat_brute_mod -= old_flat_mod
	old_flat_mod = amount
	humie.physiology.flat_brute_mod += amount

/datum/nanite_program/dermal_armor/refractive
	name = "Dermal Refractive Surface"
	desc = "The nanites form a membrane above the host's skin, reducing the effect of laser and energy impacts. \
			Each hit costs nanites equilavent to damage, but the more nanites you have, the more protection you get. \
			50 nanites = 1 flat armor. \
			Incompatible with other dermal armor programs."
	damage_type = BURN
	color_effect = "#e5fd08"

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
