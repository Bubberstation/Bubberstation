/mob/living/carbon/human/species/felinid/primitive
	race = /datum/species/human/felinid/primitive

/datum/language_holder/primitive_felinid
	understood_languages = list(
		/datum/language/primitive_catgirl = list(LANGUAGE_ATOM),
		/datum/language/siiktajr = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/primitive_catgirl = list(LANGUAGE_ATOM),
		/datum/language/siiktajr = list(LANGUAGE_ATOM),
	)
	selected_language = /datum/language/primitive_catgirl

/datum/species/human/felinid/primitive
	name = "Hearthkin"
	id = SPECIES_FELINE_PRIMITIVE

	mutantlungs = /obj/item/organ/lungs/icebox_adapted
	mutanteyes = /obj/item/organ/eyes/low_light_adapted
	mutanttongue = /obj/item/organ/tongue/cat/primitive

	species_language_holder = /datum/language_holder/primitive_felinid
	language_prefs_whitelist = list(/datum/language/primitive_catgirl)

	bodytemp_normal = 270 // If a normal human gets hugged by one its gonna feel cold
	bodytemp_heat_damage_limit = 283 // To them normal station atmos would be sweltering
	bodytemp_cold_damage_limit = 213 // Man up bro its not even that cold out here

	inherent_traits = list(
		TRAIT_VIRUSIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_USES_SKINTONES,
	)
	sort_bottom = TRUE //BUBBER EDIT ADDITION: We want to sort this to the bottom because it's a ghostrole only species.

	always_customizable = TRUE

/datum/species/human/felinid/primitive/get_default_mutant_bodyparts()
	return list(
		"legs" = list("Normal Legs", FALSE),
	)

/datum/species/human/felinid/primitive/on_species_gain(mob/living/carbon/new_primitive, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	var/mob/living/carbon/human/hearthkin = new_primitive
	if(!istype(hearthkin))
		return
	hearthkin.dna.add_mutation(/datum/mutation/olfaction, MUTATION_SOURCE_SPECIES)

/datum/species/human/felinid/primitive/on_species_loss(mob/living/carbon/former_primitive, datum/species/new_species, pref_load)
	. = ..()
	var/mob/living/carbon/human/hearthkin = former_primitive
	if(!istype(hearthkin))
		return
	hearthkin.dna.remove_mutation(/datum/mutation/olfaction, MUTATION_SOURCE_SPECIES)

/datum/species/human/felinid/primitive/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.hairstyle = "Slightly Messy"
	human_for_preview.hair_color = "#954535"
	human_for_preview.skin_tone = "albino"
	human_for_preview.set_eye_color("#6ca580")

	human_for_preview.dna.species.mutant_bodyparts[FEATURE_TAIL_GENERIC] = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR_LIST = list(human_for_preview.hair_color))
	human_for_preview.dna.mutant_bodyparts[FEATURE_EARS] = list(MUTANT_INDEX_NAME = "Lynx", MUTANT_INDEX_COLOR_LIST = list(human_for_preview.hair_color))

	regenerate_organs(human_for_preview, src, visual_only = TRUE)
	human_for_preview.update_body_parts()
	human_for_preview.update_body(is_creating = TRUE)

/datum/species/human/felinid/primitive/get_species_description()
	return list(
		"Genetically modified humanoids believed to be descendants of a now centuries old colony \
			ship from the pre-bluespace travel era. Still having at least some human traits, they \
			are most comparable to today's felinids with most sporting features likely spliced from \
			the icemoon's many fauna."
	)

/datum/species/human/felinid/primitive/get_species_lore()
	return list(
		"Physically, the Hearthkin always come in the form of demihumans; appearing similar to normal Humans, \
			with tails, ears, and limbs of various arctic animals; wolves, bears, and felines to name a few. \
			They have adapted to the cold surface of Freyja, but find the mild controlled temperatures of Nanotrasen stations to be swelteringly hot. \
			The Hearthkin are the descendants of Nordic genemodders aboard the vessel Stjarndrakkr, or Star Dragon; \
			an enormous colony ship that exploded in the orbit of its last resting place four hundred years ago; \
			Freyja, the ice moon, for unknown reasons. Large sections of the Star Dragon split and were sealed, fragmenting across the surface. \
			The Hearthkin believe they arrived first. Whether they are right is unknown.",

		"The Hearth itself is sacred, protected by Kin rightfully wary of outsiders. Hearthkin are demihumans named by clan leaders \
			from a combination of a parental first name and a title given to them by the clan, such as 'Souldrowned' or 'Snoweye.' \
			Unlike the Ashwalkers, the Hearthkin are a more technologically advanced society, having developed forging, glassblowing and more from remnants of their vessel. \
			however, for a variety of reasons, they tend to shy away from using modern technology. This does not mean that Kin are isolationist, however-- \
			many seedier types have used the Hearthkin genetic miracle to lay low, and years of interbreeding with outsiders has created many types of Kin, including Silverscales.",

		"After the split, the Star Dragon had run low on medical supplies, the only remains that weren't picked clean were a store of Earthsblood used for hydroponics. \
			It healed mortal wounds, but at great cost-- their minds would never recover. Life was exceedingly difficult for the would-be colonists. Generations were very short, \
			and most technical know-how died on impact, or to exposure. While their genemods and pre-existing comfort in frozen climates helped, \
			the Hearthkin were said to have made one last desperate move to put all their resources together to protect themselves from Freyja; forever. \
			Atmospheric readings taken by Nanotrasen reveal a massive thermal signature under the feet of the Hearthkin.",

		"Today, the Hearthkin are a culture all their own. Many of the original segments of the Star Dragon are buried under ice and snow, and the Hearthkin have \
			built many dwellings to keep them secret. They dwell in longhouses and sleep in the	warm tunnels they've created, \
			hunting fauna and creatures coming from portals to the moon's planet; Indecipheres. Their faith has strengthened \
			with worship and sacrifices to their gods. Hearthkin hold reverence for their predecessors, but few remember what they were like.",
	)
