/datum/vampire_clan/malkavian
	name = CLAN_MALKAVIAN
	description = "Malkavians are the brood of Malkav and one of the great vampiric clans. They are deranged vampires, afflicted with the insanity of their Antediluvian progenitor.<br><br>\
		Members of the clan have assumed the roles of seers and oracles among Kindred and kine, eerie figures bound by strange compulsions and the ability to perceive what others cannot.<br><br>\
		They are also notorious pranksters whose 'jokes' range from silly to sadistic. Against all odds, however, the children of Malkav are among the oldest surviving vampiric lineages."
	join_icon_state = "malkavian"
	joinable_clan = TRUE
	default_humanity = 8

	/// The prob chance, per life tick, of spouting a revelation.
	var/max_madness_chance = 10
	var/min_madness_chance = 5

/datum/vampire_clan/malkavian/New(datum/antagonist/vampire/owner_datum)
	. = ..()

	vampiredatum.owned_disciplines += new /datum/discipline/auspex/malkavian(vampiredatum)
	vampiredatum.owned_disciplines += new /datum/discipline/obfuscate(vampiredatum)
	vampiredatum.owned_disciplines += new /datum/discipline/dominate(vampiredatum)

	vampiredatum.owner.current.playsound_local(get_turf(vampiredatum.owner.current), 'sound/music/antag/creepalert.ogg', 80, FALSE, pressure_affected = FALSE, use_reverb = FALSE)
	to_chat(vampiredatum.owner.current, span_hypnophrase("Welcome, childe of Malkav..."))

/datum/vampire_clan/malkavian/apply_effects(mob/living/body)
	if(iscarbon(body))
		var/mob/living/carbon/carbon_body = body
		carbon_body.gain_trauma(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		carbon_body.gain_trauma(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)

	ADD_TRAIT(body, TRAIT_XRAY_VISION, TRAIT_VAMPIRE)
	body.update_sight()

/datum/vampire_clan/malkavian/remove_effects(mob/living/body)
	if(iscarbon(body))
		var/mob/living/carbon/carbon_body = body
		carbon_body.cure_trauma_type(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		carbon_body.cure_trauma_type(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)

	REMOVE_TRAIT(body, TRAIT_XRAY_VISION, TRAIT_VAMPIRE)
	body.update_sight()

/datum/vampire_clan/malkavian/handle_clan_life()
	. = ..()
	var/mob/living/living_vampire = vampiredatum.owner.current
	// Share of our starting humanity that is gone. None lost counts as all of it, so a fresh Malkavian sits at the minimum chance.
	var/humanity_lost_modifier = clamp((default_humanity - vampiredatum.humanity) / default_humanity, 0, 1)
	if(humanity_lost_modifier == 0)
		humanity_lost_modifier = 1
	var/interpolated_chance = max_madness_chance + humanity_lost_modifier * (min_madness_chance - max_madness_chance)
	var/madness_chance = clamp(interpolated_chance, min_madness_chance, max_madness_chance)
	if(!prob(madness_chance) || IS_UNCONSCIOUS_OR_CRIT(living_vampire) || HAS_TRAIT(living_vampire, TRAIT_BLUSH_OF_LIFE))
		return
	var/message = pick(strings("malkavian_revelations.json", "revelations", "modular_zubbers/strings/vampires"))
	INVOKE_ASYNC(living_vampire, TYPE_PROC_REF(/atom/movable, say), message, forced = "Malkavian Revelation")

/datum/vampire_clan/malkavian/on_exit_torpor()
	var/mob/living/carbon/carbon_vampire = vampiredatum.owner.current
	if(istype(carbon_vampire))
		carbon_vampire.gain_trauma(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		carbon_vampire.gain_trauma(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)
