
/datum/round_event_control/syndicate_assassination_attempt/kill_this_guy_with_hammers
	name = "Kill this guy with hammers"
	typepath = /datum/round_event/syndicate_assassination_attempt/hammers
	weight = 1
	max_occurrences = 1
	min_players = 30
	earliest_start = 40 MINUTES
	description = "Syndicate goons appear from a drop pod and attack a targeted player with hammers."
	tags = list(TAG_COMBAT, TAG_NPC_ANTAG)
	track = EVENT_TRACK_MODERATE

/datum/round_event/syndicate_assassination_attempt/hammers
	potential_assassins = list(
		/mob/living/basic/trooper/syndicate/melee/hammer,\
	)
	spawn_number = 8

/datum/round_event/syndicate_assassination_attempt/hammers/get_announce_text(victim)
	return "We are going to kill [victim] with hammers. This is a threat."

/mob/living/basic/trooper/syndicate/melee/hammer
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "hammers"
	attack_verb_simple = "hammer"
	attack_sound = 'sound/items/weapons/sonic_jackhammer.ogg'
	armour_penetration = 35
	r_hand = /obj/item/melee/breaching_hammer
