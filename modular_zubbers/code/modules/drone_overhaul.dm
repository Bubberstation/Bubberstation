/mob/living/basic/drone
	laws = "\
		1. You may not hinder, harm, or interfere with any being, regardless of intent or cicumstance.\n\
		2. You may not involve yourself in the matters of another being, even if such matters conflict with Law 1.\n\
		3. You may actively build, maintain, repair, improve, and provide power to the facility that housed your activation, to the best of your abilities."
	flavortext = "\
		\n<big><span class='warning'>DO NOT INTERFERE WITH THE CREW OR ANTAGONISTS AS A DRONE OR YOU WILL BE DRONE BANNED</span></big>\n\
		<span class='notice'>Drones are a ghost role that are allowed to fix the station and build things. Interfering with the round as a drone is against the rules.</span>\n\
		<span class='notice'>Actions that constitute interference include, but are not limited to:</span>\n\
		<span class='notice'>     - Interacting with antagonist or crew critical objects (IDs, weapons, contraband, powersinks, bombs, etc.)</span>\n\
		<span class='notice'>     - Interacting with the health of living beings (attacking, healing, etc.)</span>\n\
		<span class='notice'>     - Interacting with non-living beings (dragging bodies, looting bodies, etc.)</span>\n\
		<span class='notice'>     - Informing crew about threats/dangers (showing crew where bodies are, telling security who killed someone, etc.)</span>\n\
		<span class='warning'>These rules are at admin discretion and will be heavily enforced.</span>\n\
		<span class='warning'><u>If you do not have the regular drone laws, follow your laws to the best of your ability.</u></span>\n\
		<span class='notice'>Prefix your message with :b to speak in Drone Chat.</span>\n"

	/*
	drone_area_blacklist_flat = null
	drone_area_blacklist_recursive = null

	drone_machinery_blacklist_flat = null
	drone_machinery_blacklist_recursive = null

	drone_machinery_whitelist_flat = null
	drone_machinery_whitelist_recursive = null

	drone_item_whitelist_flat = null
	drone_item_whitelist_recursive = null

	shy_machine_whitelist = null
	*/

	shy = FALSE

/mob/living/basic/drone/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_PACIFISM,TRAIT_NOGUNS))

/datum/language_holder/drone
	understood_languages = list(
		/datum/language/drone = list(LANGUAGE_ATOM),
		/datum/language/common = list(LANGUAGE_ATOM)
	)
	spoken_languages = list(
		/datum/language/drone = list(LANGUAGE_ATOM)
	)
	blocked_languages = null
	selected_language = /datum/language/drone

