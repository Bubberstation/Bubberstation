// rework void chill to like, cause sleep and healing at max stacks? But if you touch them at all they break out
// possinly also make it just not do damage bc sleep is kinda strong
// damage resistance on the wakeup attack?

/datum/heretic_knowledge_tree_column/void
	knowledge_tier3 = /datum/heretic_knowledge/void_stealth

/datum/heretic_knowledge/spell/void_stealth
	name = "Cloak of the dark"
	desc = "Cloaks you in inpermeable void, rendering you invisible to observers. You chill the air around you in this state, so don't stay in \
	one place for too long or people will start to realize. Attacking or being attacked will break the cloak."

/datum/heretic_knowledge/spell/void_prison
	desc = "Grants you Void Prison, a spell that places your victim into a ball. In this state, \
	the target is undamageable and slowly heals. If cast on a heathen with combat mode, chills them when they exit. Can be self-cast."

/datum/action/cooldown/spell/pointed/void_prison
	desc = "Sends a target into the void for 10 seconds. \
		They will be unable to perform any actions for the duration, and will be untouchable and slowly heal. \
		Afterwards, they will be chilled (if cast with combat mode) and returned to the mortal plane. Can be self-cast."

/datum/action/cooldown/spell/pointed/void_prison/is_valid_target(atom/cast_on)
	return TRUE // self cast

/datum/status_effect/void_prison
	var/healing_per_second = 2

/datum/status_effect/void_prison/tick(seconds_between_ticks)
	. = ..()

	owner.adjust_brute_loss(healing_per_second * seconds_between_ticks)
	owner.adjust_fire_loss(healing_per_second * seconds_between_ticks)
	owner.adjust_tox_loss(healing_per_second * seconds_between_ticks)
	owner.adjust_oxy_loss(healing_per_second * seconds_between_ticks)

	// TODO heal wounds
