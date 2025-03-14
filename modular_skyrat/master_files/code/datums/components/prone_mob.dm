/datum/component/prone_mob
	var/hand_blocking = FALSE

/datum/component/prone_mob/Initialize(mob/living/source, block_hands = FALSE)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	source = parent
	hand_blocking = block_hands

	if(hand_blocking)
		parent.add_traits(list(TRAIT_HANDS_BLOCKED), type)
	parent.add_traits(list(TRAIT_PRONE, TRAIT_FLOORED, TRAIT_NO_THROWING, TRAIT_IGNORE_ELEVATION), type)
	passtable_on(parent, type)
	source.layer = PROJECTILE_HIT_THRESHHOLD_LAYER

/datum/component/prone_mob/RegisterWithParent()
	RegisterSignals(parent, list(COMSIG_MOVABLE_REMOVE_PRONE_STATE, COMSIG_LIVING_GET_PULLED), PROC_REF(stop_army_crawl))

/datum/component/prone_mob/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_LIVING_GET_PULLED,
		COMSIG_LIVING_TRY_PULL,
		))
	return ..()

/datum/component/prone_mob/proc/stop_army_crawl(mob/living/source)
	SIGNAL_HANDLER
	source = parent
	parent.remove_traits(list(TRAIT_PRONE, TRAIT_FLOORED, TRAIT_NO_THROWING, TRAIT_HANDS_BLOCKED, TRAIT_IGNORE_ELEVATION), type)
	passtable_off(parent, type)
	source.layer = MOB_LAYER
	qdel(src)
