/datum/species/vox
	// Bird-like humanoids
	name = "Vox Primalis"
	id = SPECIES_VOX
	can_augment = FALSE
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutanttongue = /obj/item/organ/tongue/vox
	mutantlungs = /obj/item/organ/lungs/nitrogen/vox
	mutantbrain = /obj/item/organ/brain/cybernetic/cortical/vox
	mutanteyes = /obj/item/organ/eyes/vox
	breathid = "n2"
	mutant_bodyparts = list()
	payday_modifier = 1.0
	outfit_important_for_life = /datum/outfit/vox
	species_language_holder = /datum/language_holder/vox
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	// Vox are cold resistant, but also heat sensitive
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 15) // being cold resistant, should make you heat sensitive actual effect ingame isn't much
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 30)
	digitigrade_customization = DIGITIGRADE_FORCED
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/vox,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/vox,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/vox,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/vox,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/vox,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/vox,
	)
	custom_worn_icons = list(
		OFFSET_HEAD = VOX_HEAD_ICON,
		OFFSET_FACEMASK = VOX_MASK_ICON,
		OFFSET_SUIT = VOX_SUIT_ICON,
		OFFSET_UNIFORM = VOX_UNIFORM_ICON,
		OFFSET_GLOVES =  VOX_HANDS_ICON,
		OFFSET_SHOES = VOX_FEET_ICON,
		OFFSET_GLASSES = VOX_EYES_ICON,
		OFFSET_BELT = VOX_BELT_ICON,
		OFFSET_BACK = VOX_BACK_ICON,
		OFFSET_EARS = VOX_EARS_ICON
	)

	meat = /obj/item/food/meat/slab/chicken/human //item file in teshari module

/datum/species/vox/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Vox Tail", FALSE),
		"legs" = list(DIGITIGRADE_LEGS,FALSE),
		"snout" = list("Vox Snout", FALSE),
		"spines" = list("Vox Bands", TRUE),
	)

/datum/species/vox/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only)
	. = ..()
	if(job?.vox_outfit)
		equipping.equipOutfit(job.vox_outfit, visuals_only)
	else
		give_important_for_life(equipping)

/datum/species/vox/randomize_features()
	var/list/features = ..()
	features[FEATURE_MUTANT_COLOR] = pick("#77DD88", "#77DDAA", "#77CCDD", "#77DDCC")
	features[FEATURE_MUTANT_COLOR_TWO] = pick("#EEDD88", "#EECC88")
	features[FEATURE_MUTANT_COLOR_THREE] = pick("#222222", "#44EEFF", "#44FFBB", "#8844FF", "#332233")
	return features

/datum/species/vox/get_random_body_markings(list/passed_features)
	var/name = pick(list("Vox", "Vox Hive", "Vox Nightling", "Vox Heart", "Vox Tiger"))
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/vox/get_custom_worn_icon(item_slot, obj/item/item)
	// snowflakey but vox legs weird.
	if(item_slot == OFFSET_SHOES)
		var/obj/item/bodypart/leg = bodypart_overrides[BODY_ZONE_L_LEG] || bodypart_overrides[BODY_ZONE_R_LEG]
		if(initial(leg?.limb_id) != "digitigrade")
			// normal legs, use normal human shoes
			return DEFAULT_SHOES_FILE

	return item.worn_icon_vox

/datum/species/vox/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_vox = icon

/datum/species/vox/get_species_description()
	return list(
		"By the account of those unaware, the vox seem to be a nomadic race of avianoid creatures that operate in and around human space at the behest of “crazed, dreaming gods.“ \
		The true vox are the wholly reclusive Vox Auralis, vastly powerful psychics and bio-engineers. They are a distant race at the best of times. \
		The Primalis are the laboring underclass that the Auralis use to sustain the Arkships, following a convoluted trail throughout the Milky Way."
	)

/datum/species/vox/get_species_lore()
	return list(
		"The Vox are a theocratic nation led by the Vox Auralis. All of the engineered species beneath them are more than predisposed to follow the Auralis, they must utterly obey them. \
		The Vox are perhaps one of the oldest races in the galaxy, drifting through the stars in their massive Ark Ships, often scattered about the vast cosmos. \
		Yet, the Auralis are almost entirely unknown to the galaxy at large, as the distinction of “Vox” falls almost solely upon the Vox Primalis.",
		"The Vox Primalis are not only the physical form, but rather a biomechanical entity known as a “Cortical Stack”. A body without a stack is little more than a husk. \
		The task of coordinating available stacks on an Arkship is given to the Apex, a powerful biocomputer woven into the vessel's systems. \
		The average Primalis is a reptilian avian with stiff, semi-rigid keratin quills atop their head, a long and prehensile tail, and a beak containing rows of angled teeth. \
		They tend to have two tongues, one on the roof of the mouth and the other on the lower jaw, allowing them to speak the complex Vox language with ease. \
		The Primalis do not generally need to live frugal, though they have been predisposed to doing so.",
		"The height of a Primalis varies heavily, ranging from as small as 3 feet, to as large as ten feet for living haulers of heavy equipment. So long as the Cortical Stack remains intact, \
		death is only an inconvenience. The stack can be transferred to a new body within minutes to hours, and operating in almost no time at all. If a stack is damaged, \
		the Vox experiences ego death, its “true death”. Even if the stack can be repaired at this stage, the personality cannot. Primalis are created with a purpose, \
		the Cortical Stack imbued with the needed skills. Primalis must still practice their craft and hone their skills, though they are always prodigal compared to humans. \
		Vox live a rigid life, with little room for advancement in a society where everything has its place under the Armalis, a caste made for combat.",
		"Armalis are entirely dependent on the psychic network of the Apex to function, and are much like an AI with its cyborgs. \
		As a result, Armalis can never stray far from their ship as all higher brain function effectively ceases. They have not been given the gift of free will. \
		The Arkships do not want for much, but they still have use for commerce. Vox bioengineering is second to none, making it a prime bartering chip for research, \
		and Arkships are often willing to trade in fragments of knowledge for resource aid and engineering assistance. The Auralis have even been known to contract Vox Primalis \
		with galactic entities for a continuous supply of resources, though it is often seen as exploitation near wage slavery."
	)

/datum/species/vox/prepare_human_for_preview(mob/living/carbon/human/vox)
	vox.dna.features[FEATURE_MUTANT_COLOR] = "#77DD88"
	vox.dna.features[FEATURE_MUTANT_COLOR_TWO] = "#EEDD88"
	vox.dna.features[FEATURE_MUTANT_COLOR_THREE] = "#222222"
	vox.dna.mutant_bodyparts[FEATURE_SNOUT] = list(MUTANT_INDEX_NAME = "Vox Snout", MUTANT_INDEX_COLOR_LIST = list("#EEDD88"))
	regenerate_organs(vox, src, visual_only = TRUE)
	vox.update_body(TRUE)

/obj/item/organ/eyes/vox
	name = "vox eyes"
	eye_icon = 'modular_skyrat/modules/organs/icons/vox_eyes.dmi'
