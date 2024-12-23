SUBSYSTEM_DEF(interactions)
	name = "Interactions"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_INTERACTIONS
	var/list/datum/interaction/interactions
	VAR_PROTECTED/list/blacklisted_mobs = list(
		/mob/dead,
		/mob/dview,
		/mob/camera,
		/mob/living/basic/pet,
		/mob/living/basic/cockroach,
		/mob/living/basic/butterfly,
		/mob/living/basic/chick,
		/mob/living/basic/chicken,
		/mob/living/basic/cow,
		/mob/living/basic/crab,
		/mob/living/basic/kiwi,
		/mob/living/basic/parrot,
		/mob/living/basic/sloth,
		/mob/living/basic/goat
	)
	VAR_PROTECTED/initialized_blacklist

/datum/controller/subsystem/interactions/Initialize()
	prepare_interactions()
	prepare_blacklisted_mobs()
	. = ..()
	var/extra_info = "<font style='transform: translate(0%, -25%);'>↳</font> Loaded [LAZYLEN(interactions)] interactions!"
	to_chat(world, span_boldannounce(extra_info))
	log_config(extra_info)

/datum/controller/subsystem/interactions/stat_entry(msg)
	msg += "|🖐:[LAZYLEN(interactions)]|"
	msg += "🚫👨:[LAZYLEN(blacklisted_mobs)]"
	return ..()

/datum/controller/subsystem/interactions/proc/prepare_interactions()
	QDEL_LIST_ASSOC_VAL(interactions)
	QDEL_NULL(interactions)
	interactions = list()
	populate_interaction_instances()

/datum/controller/subsystem/interactions/proc/prepare_blacklisted_mobs()
	blacklisted_mobs = typecacheof(blacklisted_mobs)
	initialized_blacklist = TRUE

/datum/controller/subsystem/interactions/proc/is_blacklisted(mob/living/creature)
	if(!creature || !initialized_blacklist)
		return TRUE
	if(is_type_in_typecache(creature, blacklisted_mobs))
		return TRUE
	return FALSE
