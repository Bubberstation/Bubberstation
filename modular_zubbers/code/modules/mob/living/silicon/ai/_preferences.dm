SUBSYSTEM_DEF(bubberAIIcons)
	name = "AI Icons"
	flags = SS_NO_FIRE


/datum/controller/subsystem/bubberAIIcons/Initialize()
	GLOB.ai_hologram_category_options[AI_HOLOGRAM_CATEGORY_ANIMAL] += list(
		AI_HOLOGRAM_MOTHROACH,
		AI_HOLOGRAM_STOAT,
		AI_HOLOGRAM_BEE,
		AI_HOLOGRAM_REDPANDA,
		AI_HOLOGRAM_FENNEC,
	)
	GLOB.ai_hologram_icons += list(
		AI_HOLOGRAM_MOTHROACH = 'icons/mob/simple/animal.dmi',
		AI_HOLOGRAM_STOAT = 'icons/mob/simple/pets.dmi',
		AI_HOLOGRAM_BEE = 'modular_skyrat/master_files/icons/mob/pets.dmi',
		AI_HOLOGRAM_REDPANDA = 'modular_skyrat/master_files/icons/mob/pets.dmi',
		AI_HOLOGRAM_FENNEC = 'modular_skyrat/master_files/icons/mob/pets.dmi',
	)
	GLOB.ai_hologram_icon_state += list(
		AI_HOLOGRAM_MOTHROACH = "mothroach",
		AI_HOLOGRAM_STOAT = "stoat",
		AI_HOLOGRAM_BEE = "bumbles",
		AI_HOLOGRAM_REDPANDA = "red_panda",
		AI_HOLOGRAM_FENNEC = "fennec",
	)
