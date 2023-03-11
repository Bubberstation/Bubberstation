/datum/opposing_force_equipment/language
	category = OPFOR_EQUIPMENT_CATEGORY_LANGUAGES
	item_type = /obj/effect/gibspawner/generic
	/// The language typepath to be given to the mind's language holder
	var/language

/datum/opposing_force_equipment/language/on_issue(mob/living/target)
	target.grant_language(language, TRUE, TRUE, LANGUAGE_MIND)

/datum/opposing_force_equipment/language/codespeak
	name = "Codespeak"
	description = "Syndicate operatives can use a series of codewords to convey complex information, while sounding like random concepts and drinks to anyone listening in."
	language = /datum/language/codespeak

/datum/opposing_force_equipment/language/narsie
	name = "Nar'Sian"
	description = "The ancient, blood-soaked, impossibly complex language of Nar'Sian cultists."
	language = /datum/language/narsie

/datum/opposing_force_equipment/language/piratespeak
	name = "Piratespeak"
	description = "The language of space pirates."
	language = /datum/language/piratespeak

/datum/opposing_force_equipment/language/calcic
	name = "Calcic"
	description = "The disjointed and staccato language of plasmamen. Also understood by skeletons."
	language = /datum/language/calcic

/datum/opposing_force_equipment/language/shadowtongue
	name = "Shadowtongue"
	description = "What a grand and intoxicating innocence."
	language = /datum/language/shadowtongue

/datum/opposing_force_equipment/language/buzzwords
	name = "Buzzwords"
	description = "A common language to all insects, made by the rhythmic beating of wings."
	language = /datum/language/buzzwords

/datum/opposing_force_equipment/language/xenocommon
	name = "Xenomorph"
	description = "The common tongue of the xenomorphs."
	language = /datum/language/xenocommon

/datum/opposing_force_equipment/language/monkey
	name = "Chimpanzee"
	description = "Ook ook ook."
	language = /datum/language/monkey

/datum/opposing_force_equipment/language/nekomimetic
	name = "Nekomimetic"
	description = "To the casual observer, this langauge is an incomprehensible mess of broken Japanese. To the felinids, it's somehow comprehensible."
	language = /datum/language/nekomimetic

/datum/opposing_force_equipment/language/mushroom
	name = "Mushroom"
	description = "A language that consists of the sound of periodic gusts of spore-filled air being released."
	language = /datum/language/mushroom

/datum/opposing_force_equipment/language/drone
	name = "Drone"
	description = "A heavily encoded damage control coordination stream, with special flags for hats."
	language = /datum/language/drone

/datum/opposing_force_equipment/language/beachbum
	name = "Beachtongue"
	description = "An ancient language from the distant Beach Planet. People magically learn to speak it under the influence of space drugs."
	language = /datum/language/beachbum

/datum/opposing_force_equipment/language/aphasia
	name = "Gibbering"
	description = "It is theorized that any sufficiently brain-damaged person can speak this language."
	language = /datum/language/aphasia
