/datum/action/cooldown/spell/pointed/healing_light
	name = "Healing Light"
	desc = "Heals a small amount of damage from the selected target, moving will break your concentration and disturbe the grimoire's energy for a short duration, people with a peaceful mind or bearing a healing relic empower this spell."
	button_icon = 'icons/mob/actions/actions_genetic.dmi'
	button_icon_state = "mending_touch"
	sound = 'sound/effects/magic/staff_healing.ogg'
	school = SCHOOL_RESTORATION
	cooldown_time = 9 SECONDS
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC|SPELL_REQUIRES_HUMAN

	invocation = "Victus sano!"
	invocation_type = INVOCATION_SHOUT

	/// Value that multiply healing
	var/heal_multiplier = 1
	/// Healing amount the spell will provide per cast
	var/healing_power = 10

/datum/action/cooldown/spell/pointed/healing_light/cast(mob/living/cast_on)
	. = ..()

	var/mob/living/carbon/human/H = owner
	if(!istype(H))
		return FALSE

	var/mob/living/spelltarget = cast_on

	if(!isliving(spelltarget))
		return FALSE

/// If you are using the Rod of Asclepius, heal some more.
	if(HAS_TRAIT(owner, TRAIT_HIPPOCRATIC_OATH))
		heal_multiplier *= 4.5 /// 10 base, 45 total with the Rod active in hand

/// If a normal pacifist, heal more.
	else if(HAS_TRAIT(owner, TRAIT_PACIFISM))
		heal_multiplier *= 3 /// 10 base, 30 total by being pacifist

	if(do_after(owner, 1.5 SECONDS, TRUE, IGNORE_TARGET_LOC_CHANGE, target = cast_on))
		var/need_mob_update = FALSE
		cast_on.adjust_brute_loss(-(healing_power*heal_multiplier), 0)
		cast_on.adjust_fire_loss(-(healing_power*heal_multiplier), 0)
		cast_on.adjust_tox_loss(-(healing_power*heal_multiplier), 0)
		cast_on.adjust_oxy_loss(-(healing_power*heal_multiplier), 0)
		cast_on.visible_message(
		span_warning("A wreath of gentle light wash over [cast_on]!"),
		)
		if(need_mob_update)
			cast_on.updatehealth()
	return TRUE
