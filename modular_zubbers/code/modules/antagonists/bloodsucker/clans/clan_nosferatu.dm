/datum/bloodsucker_clan/nosferatu
	name = CLAN_NOSFERATU
	description = "The Nosferatu Clan is unable to blend in with the crew, with no abilities such as Masquerade and Veil. \n\
		Additionally, has a permanent bad back and looks like a Bloodsucker upon a simple examine, and their face is disfigured \n\
		they can fit in the vents regardless of their form and equipment. \n\
		The Favorite Ghoul is also permanently disfigured, and can also ventcrawl, but only while entirely nude. \n\
		They also have night vision, know what each wire does, and have silent footsteps."
	clan_objective = /datum/objective/bloodsucker/kindred
	join_icon_state = "nosferatu"
	join_description = "You are permanetly disfigured, look like a Bloodsucker to all who examine you, \
		lose your Masquerade ability, but gain the ability to Ventcrawl even while clothed."
	blood_drink_type = BLOODSUCKER_DRINK_INHUMANELY

/datum/bloodsucker_clan/nosferatu/New(datum/antagonist/bloodsucker/owner_datum)
	. = ..()
	for(var/datum/action/cooldown/bloodsucker/power as anything in bloodsuckerdatum.powers)
		if(istype(power, /datum/action/cooldown/bloodsucker/masquerade) || istype(power, /datum/action/cooldown/bloodsucker/veil))
			bloodsuckerdatum.RemovePower(power)
	if(!bloodsuckerdatum.owner.current.has_quirk(/datum/quirk/badback))
		bloodsuckerdatum.owner.current.add_quirk(/datum/quirk/badback)
	bloodsuckerdatum.owner.current.add_traits(list(TRAIT_VENTCRAWLER_ALWAYS, TRAIT_DISFIGURED), BLOODSUCKER_TRAIT)
	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_EXAMINE, PROC_REF(on_mob_examine))

/datum/bloodsucker_clan/nosferatu/proc/on_mob_examine(datum/antagonist/bloodsucker/owner_datum, datum/source, mob/examiner, examine_text)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/ogled = owner_datum.owner.current
	var/mob/living/ogler = examiner
	if(isliving(examiner) && examiner != ogled && !ogler.mob_mood.has_mood_of_category("nosferatu_examine"))
		ogler.add_mood_event("nosferatu_examine", /datum/mood_event/nosferatu_examined, ogled, owner_datum.GetRank())
		ogler.adjust_disgust(owner_datum.GetRank() * 10)
	// show that they are dangerous nosferatu, as if you're gazing upon them with fear, without mentioning the clan name/antagonist name, describe their appearance
	examine_text += span_danger("[ogled.p_They()] look[ogled.p_s()] like a pale, grotesque hunchback, with a mouth full of jagged yellowy teeth, and breath that reeks of fresh blood. You feel both afraid and disgusted as you gaze upon [ogled.p_them()].")
	examine_text += span_userdanger("[ogled.p_They()] [ogled.p_are()] clearly a BLOODSUCKER!")

/datum/bloodsucker_clan/nosferatu/Destroy(force)
	var/datum/action/cooldown/bloodsucker/feed/suck = locate() in bloodsuckerdatum.powers
	if(suck)
		bloodsuckerdatum.RemovePower(suck)
	bloodsuckerdatum.give_starting_powers()
	bloodsuckerdatum.owner.current.remove_quirk(/datum/quirk/badback)
	bloodsuckerdatum.owner.current.remove_traits(list(TRAIT_VENTCRAWLER_ALWAYS, TRAIT_DISFIGURED), BLOODSUCKER_TRAIT)
	UnregisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_EXAMINE)
	return ..()

/datum/bloodsucker_clan/nosferatu/favorite_ghoul_gain(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	var/list/traits_to_add = list(TRAIT_VENTCRAWLER_NUDE, TRAIT_DISFIGURED, TRAIT_TRUE_NIGHT_VISION, TRAIT_KNOW_ENGI_WIRES, TRAIT_SILENT_FOOTSTEPS)
	ghouldatum.owner.current.add_traits(traits_to_add, GHOUL_TRAIT)
	ghouldatum.traits += traits_to_add
	ghouldatum.owner.current.update_sight()
	to_chat(ghouldatum.owner.current, span_notice("Additionally, you can now ventcrawl while naked, and are permanently disfigured. You also have night vision, know how which wires to cut, and have silent footsteps."))

/datum/bloodsucker_clan/nosferatu/favorite_ghoul_loss(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	ghouldatum.owner.current.update_sight()
