/datum/species/abductor
	name = "Abductor"
	id = SPECIES_ABDUCTOR
	sexes = TRUE//ZUBBER EDIT
	species_traits = list(
		NOEYESPRITES,
		NO_UNDERWEAR,
	)
	inherent_traits = list(
		TRAIT_NOBREATH,
		TRAIT_NOHUNGER,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOBLOOD,
		TRAIT_NO_DEBRAIN_OVERLAY,
		TRAIT_CHUNKYFINGERS_IGNORE_BATON,
	)
	mutanttongue = /obj/item/organ/internal/tongue/abductor
	mutantstomach = null
	mutantheart = null
	mutantlungs = null
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	ass_image = 'icons/ass/assgrey.png'

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/abductor,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/abductor,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/abductor,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/abductor,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/abductor,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/abductor,
	)

/datum/species/abductor/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.show_to(C)

	C.set_safe_hunger_level()

/datum/species/abductor/on_species_loss(mob/living/carbon/C)
	. = ..()
	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.hide_from(C)

/datum/species/abductor/get_species_description()
	return "The Greys are a slim and colorless species, \
	possessing no blood and stand completely still with no motions of breathing. \
	Their entire existence on-station and their roots are largely a mystery. Where did they come from?"


/datum/species/abductor/get_species_lore()
	return list(
		"IMPORTANT NOTICE",
		"Despite their Origins, no Abductor technology was left in the Vault and the Greys \
		can not recall the existence of the Abductors at all. They hold no records of the Abductors, \
		and most researchers come to the conclusion that the Greys were most likely an experiment by a powerful \
		precursor species that was left in stasis for an unknown amount of time before suddenly being ejected. \
		Since the Greys lack any memories from before being expelled from their Pods, \
		they have come to agree with this idea.",

		"Lore written by MyphicBowser",

		"The Greys: At a Glance",
		"The Greys are genetically related to, but not politically or ideologically connected to, \
		the Abductors that frequently perform stealth operations in Human dominated environments. \
		The Greys are an attempt at Low-Grade mimicry, \
		with their DNA containing an almost microscopic amount of all major humanoid species except humans. \	
		Human DNA, sourced directly from Earth, makes up a much larger percentage of all Grey’s DNA. \
		This has given the Greys one major advantage over the abductors: Humanoid Organ Systems. \	
		The Greys are able to consume human food and \	
		are even theorized to be able to reproduce with humans if they are further augmented to have sexual \
		reproduction capability and characteristics. \
		The biggest change, and the reason for their abandonment as a Project, \
		was the human individual mindset. Whereas the Abductors play their part and adhere to the rigid rules \
		and roles that make up their society, the Greys desire their freedom of choice and even have only \
		slightly muted human feelings. While they are less expressive than a human and much less able to express \
		genuine empathy, the Abductors viewed this as a weakness and left the project, \
		leaving the Greys a highly intelligent but isolated entity.",

		"Biology and Relation to the Greys",
		"The Greys are phenotypically extremely similar to the Abductors. \
		While they may be leaner in most cases, \
		their weight varies as much as a human's depending on their dietary habits. \
		The Greys possess low grade telepathic abilities, \
		able to communicate in a local \"Network\" that requires other radio waves present to \"connect\" to, \
		they are also able to broadcast their thoughts directly into a visible being's mind. \
		This process leaves no physical harm, but many dislike the odd sensation of speech beamed directly to their brain. \
		Due to their modified Abductor genetic structure many Greys find physically speaking to be exceptionally painful, unless given accomodating organs, \
		and those who do talk are barely able to speak above a Whisper. \
		Their difficulty with speaking and non-expressive body language has aided the misconception that Greys are not able to replicate human feelings, \
		and has isolated many of them. In truth, the Greys are a highly communal species but feel the need to a lesser extent. \
		While they greatly enjoy a lively debate and find working together efficiently to be greatly rewarding, \
		they do not feel the NEED to do it so if they believe that they would be a hindrance or annoyance they simply wouldn’t engage. \
		They do not like to draw undue attention to themselves.",

		"Beyond the simple things that separate them from other individuals, \
		they are very similar to humans to an almost worrying degree. \
		Their organ system, while arguably more efficient, is exceptionally similar to humans. \
		Human Medical Doctors have been able to effectively mimic human medicines and surgical operations \
		(Barring Brain Surgery) on Grey volunteers. \
		This connection has made it exceptionally easy for Greys to merge into human stations, \
		but their presence is still relatively low due to their low population. \
		Greys do not mate in the conventional sense, instead they are Vat-Grown much like their Abductor cousins. \
		While it is possible for a singular Grey to use their genetic manipulation technology to create sexual characteristics, \
		the vast majority do not. Leading to the slow yet infallible process of Vat-Growing \
		to maintain their population and produce more of their budding civilization. \
		To make such a population method even more difficult is the fact that Greys only live for around sixty years, \
		a much shorter than expected lifespan and one that they are constantly trying to improve without damaging their exceptionally fragile genetic structure. \
		Cybernetics have been highly successful in increasing their lifespan upwards of twenty years, \
		but at that age the biggest failure is their incredibly complex brain.",

		"Monochrome History",
		"The Greys have only been around for eighty six years. \
		A very observable history to all but the Greys themselves. \
		During this time they were on what was a heavily specialized Abductor worksite deep in the fifth moon of the gas giant Nephora. \
		This moon, previously known as Nephora V, is now called Kabrus, \
		which the Greys claim is a bastardization of the few words of the Maker Alien language they are able to understand. \
		This rough translation equates to: Progenitor Vault. Kabrus is now the Capital of their Civilization, not being a full diplomatic entity yet.",

		"Their discovery was even by accident, for the first thirty years of their existence they were alone but hopeful, \
		and utilizing the stripped technology they could find they created an antenna that would have theoretically broadcast \
		to all systems within a twelve lightyear distance. This single burst SoS transmission utilized what little plasma they had and begged for help. \
		Unbeknownst to the Greys however, Nephora's electromagnetic waves managed to completely snuff their radio waves and nothing comprehensible \
		or even outstanding as a transmission managed to escape their system. But thankfully, Nephora was a planet that the mining division of Nanotrasen \
		was already heading to.",

		"Upon their first contact around thirty lives were lost, twenty seven Greys and three Nanotrasen personnel. \
		This was due to Nanotrasen’s mistaken belief that the structure they found was entirely uninhabited. \
		The sudden depressurization killed the many Grey, and the automated defenses returned the favor to the humans. \
		A few Greys managed to secure, stabilize, and negotiate with the Foreman of the Mining group, \
		and after reparations that were paid with what little technology they had, the Greys were welcomed to the Galactic Stage \
		by their corporate sponsors. The Greys now mine Nephora with mining bases now connecting to the other moons of the Gas Giant. \
		Ninety percent of their Plasma output goes directly to Nanotrasen, \
		but with what they keep they are beginning to slowly build up a new technological and societal based heavily influenced by human development.",

		"Despite their Origins, no Abductor technology was left in the Vault and the Greys can not recall the existence of the Abductors at all. \
		They hold no records of the Abductors, and most researchers come to the conclusion that the Greys were most likely an experiment by a powerful precursor \
		species that was left in stasis for an unknown amount of time before suddenly being ejected. \
		Since the Greys lack any memories from before being expelled from their Pod, \
		they have come to agree with this idea.",

		"Mindset of the Greys",
		"The Greys are variable, much like humanity, but their muted emotions and highly developed brain makes them fine scientists and doctors. \
		While they normally fill these departments on human stations, many Greys have also found a simple joy in more basic labors. \
		They do not feel shame at food preparation or janitorial duty, \
		and some of them even develop the muscle mass needed to be efficient miners without the aid of exosuits or other devices.",

		"While the Greys are exceptional in most things they put their mind to, \
		their rather short lifespan has left them with interests in the Genetic and Cybernetic lines of research. \
		They tend to want to improve their lot in life and, truthfully, \
		if they did not need credits to survive in this Galaxy it is incredibly possible many would just be content to build around Nephora and research until they collapse.",

		"The Greys are not the best at social situations, but do enjoy it. They can not hold their alcohol like many species, \
		and they may not fully understand comedy, but some of them do become exceptionally interesting individuals. \
		There have been accusations of Greys using their telepathic abilities to reach into the minds of those they are conversing with and read their deepers thoughts to learn more about their target, \
		but this has been nothing but an unsubstantiated Rumor… so far.",

		"The Greys have a few little traits left over from the Abductors, mainly their desire of study to be a hands off self-study. \
		Xenobiological Greys tend to prefer observation methods, \
		letting Slimes and other aliens interact with their environments in ways that they do not impede directly typically. \
		While they do often branch to other types of research, when it comes to most biological or sapient things, \
		they enjoy a hands off approach and let it develop.",
	)
