//Energy katana switches from slashing to stabbing.
//Slashing: 30 damage, 15 penetration.
//Piercing: 20 damage, 50 penetration.
//Innate 100% chance to block unarmed attacks.
//On switching: For 2 seconds, have a +100% chance to block melee attacks, +50% chance to block ranged attacks.
//Switching has a cooldown of 4 seconds.

/obj/item/energy_katana

	desc = "A katana infused with strong energy, folded over one thousand times."
	desc_controls = "Right-click to teleport a short (5 tiles), safe distance away. Note that space does not count as safe!\nClick in hand to change stance, with a 4 second cooldown.\nChanging stance gives you a 100% chance to block melee attacks, and a 50% chance to block ranged attacks for 2 seconds.\nWhile in slash stance, your damage is high but your penetration is low.\nWhile in piercing stance, your damage is low but your penetration is high."
	attack_verb_continuous = list("slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("slash", "slice", "tear", "lacerate", "rip", "dice", "cut")

	throwforce = 30
	block_chance = 0

	//Slash Stance
	force = 30
	armour_penetration = 15
	sharpness = SHARP_EDGED

	//Stab Stance
	var/force_stab = 20
	var/armour_penetration_stab = 50

	var/block_chance_stance_melee = 100
	var/block_chance_stance_ranged = 50

	var/stance_cooldown = 4 SECONDS
	var/stance_block_chance_duration = 2 SECONDS

/obj/item/energy_katana/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == UNARMED_ATTACK)
		final_block_chance += block_chance_stance_melee
	else
		var/datum/component/transforming/transforming_component = src.GetComponent(/datum/component/transforming)
		if(COOLDOWN_TIMELEFT(transforming_component,transform_cooldown) > stance_cooldown - stance_block_chance_duration) //If you have more than 2 seconds left to the switch cooldown, +100% chance to block melee attacks, +50% chance to block ranged attacks.
			if(attack_type == MELEE_ATTACK)
				final_block_chance += block_chance_stance_melee
			else
				final_block_chance += block_chance_stance_ranged
	. = ..()

/obj/item/energy_katana/Initialize(mapload)
	. = ..()
	AddComponent(
		/datum/component/transforming, \
		transform_cooldown_time = stance_cooldown, \
		force_on = force_stab, \
		sharpness_on = SHARP_POINTY, \
		attack_verb_continuous_on = list("stabs", "pokes", "jabs", "tears", "gores"), \
		attack_verb_simple_on = list("stab", "poke", "jab", "tear", "gore"), \
		inhand_icon_change = FALSE,\
		clumsy_check = FALSE\
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))


/obj/item/energy_katana/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER
	if(active)
		if(user) balloon_alert(user, "stabbing")
		armour_penetration = armour_penetration_stab
	else
		if(user) balloon_alert(user, "slashing")
		armour_penetration = initial(armour_penetration)
	SEND_SOUND(user, sound('modular_zubbers/sound/effects/ninja_block.ogg'))
	return COMPONENT_NO_DEFAULT_MESSAGE


/datum/action/innate/dash/ninja/proc/has_dense_obj(var/turf/T)
	for(var/obj/checked_object in T)
		if(checked_object.density)
			return TRUE
	return FALSE

/datum/action/innate/dash/ninja/teleport(mob/user, atom/target)

	if(target)
		target = get_turf(target)
		while(target && (target.density || get_dist(user,target) > 5 || !isfloorturf(target) || src.has_dense_obj(target))
			var/turf/old_target = target
			target = get_step(target,get_dir(target,user))
			if(!target || target == old_target) //Bad turf or didn't even do anything.
				target = null
				break

	return ..()

/datum/action/innate/dash/ninja
	current_charges = 3
	max_charges = 3
	charge_rate = 20 SECONDS