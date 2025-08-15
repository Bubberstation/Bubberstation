#define FEATURE_HASH_PART_START 1
#define FEATURE_HASH_PART_END (DNA_BLOCK_SIZE + 1)
#define FEATURE_HASH_COLOR1_START FEATURE_HASH_PART_END
#define FEATURE_HASH_COLOR1_END (FEATURE_HASH_COLOR1_START + DNA_BLOCK_SIZE_COLOR)
#define FEATURE_HASH_COLOR2_START FEATURE_HASH_COLOR1_END
#define FEATURE_HASH_COLOR2_END (FEATURE_HASH_COLOR2_START + DNA_BLOCK_SIZE_COLOR)
#define FEATURE_HASH_COLOR3_START FEATURE_HASH_COLOR2_END
#define FEATURE_HASH_COLOR3_END (FEATURE_HASH_COLOR3_START + DNA_BLOCK_SIZE_COLOR)

/datum/dna_block/feature
	/// Determines whether to check dna.mutant_bodyparts instead of dna.features for an entry
	var/mutant_part = FALSE

/datum/dna_block/feature/mutant_color/two
	block_length = DNA_BLOCK_SIZE_COLOR
	feature_key = FEATURE_MUTANT_COLOR_TWO

/datum/dna_block/feature/mutant_color/three
	block_length = DNA_BLOCK_SIZE_COLOR
	feature_key = FEATURE_MUTANT_COLOR_THREE

/datum/dna_block/feature/skin_color
	block_length = DNA_BLOCK_SIZE_COLOR
	feature_key = FEATURE_SKIN_COLOR

/datum/dna_block/feature/skin_color/create_unique_block(mob/living/carbon/human/target)
	return sanitize_hexcolor(target.dna.features[feature_key], include_crunch = FALSE)

/datum/dna_block/feature/skin_color/apply_to_mob(mob/living/carbon/human/target, dna_hash)
	target.dna.features[feature_key] = sanitize_hexcolor(get_block(dna_hash))

/datum/dna_block/feature/mutant
	block_length = DNA_FEATURE_BLOCKS_TOTAL_SIZE_PER_FEATURE
	mutant_part = TRUE
	abstract_type = /datum/dna_block/feature/mutant

/datum/dna_block/feature/mutant/create_unique_block(mob/living/carbon/human/target)
	if(isnull(target.dna.mutant_bodyparts[feature_key]))
		return random_string(block_length, GLOB.hex_characters)

	var/list/accessories_for_key = SSaccessories.sprite_accessories[feature_key]
	. = construct_block(accessories_for_key.Find(target.dna.mutant_bodyparts[feature_key][MUTANT_INDEX_NAME]), accessories_for_key.len)
	var/colors_left = DNA_FEATURE_COLOR_BLOCKS_PER_FEATURE
	for(var/color in target.dna.mutant_bodyparts[feature_key][MUTANT_INDEX_COLOR_LIST])
		colors_left--
		. += sanitize_hexcolor(color, include_crunch = FALSE)
	if(colors_left)
		. += random_string(DNA_BLOCK_SIZE_COLOR * colors_left, GLOB.hex_characters)

/datum/dna_block/feature/mutant/apply_to_mob(mob/living/carbon/human/target, dna_hash)
	var/our_block = get_block(dna_hash)
	var/feature_portion = copytext(our_block, FEATURE_HASH_PART_START, FEATURE_HASH_PART_END)
	var/accessory_index = deconstruct_block(feature_portion, length(SSaccessories.sprite_accessories[feature_key]))
	var/list/color_portions = list(
		sanitize_hexcolor(copytext(our_block, FEATURE_HASH_COLOR1_START, FEATURE_HASH_COLOR1_END)),
		sanitize_hexcolor(copytext(our_block, FEATURE_HASH_COLOR2_START, FEATURE_HASH_COLOR2_END)),
		sanitize_hexcolor(copytext(our_block, FEATURE_HASH_COLOR3_START, FEATURE_HASH_COLOR3_END)),
	)
	target.dna.mutant_bodyparts[feature_key][MUTANT_INDEX_NAME] = SSaccessories.sprite_accessories[feature_key][accessory_index]
	target.dna.mutant_bodyparts[feature_key][MUTANT_INDEX_COLOR_LIST] = color_portions

/datum/dna_block/feature/mutant/tail_generic // fucking felinid tails being just called tail
	feature_key = FEATURE_TAIL_GENERIC

/datum/dna_block/feature/mutant/snout
	feature_key = FEATURE_SNOUT

/datum/dna_block/feature/mutant/horns
	feature_key = FEATURE_HORNS

/datum/dna_block/feature/mutant/ears
	feature_key = FEATURE_EARS

/datum/dna_block/feature/mutant/wings
	feature_key = FEATURE_WINGS

/datum/dna_block/feature/mutant/frills
	feature_key = FEATURE_FRILLS

/datum/dna_block/feature/mutant/spines
	feature_key = FEATURE_SPINES

/datum/dna_block/feature/mutant/caps
	feature_key = FEATURE_MUSH_CAP

/datum/dna_block/feature/mutant/moth_antennae
	feature_key = FEATURE_MOTH_ANTENNAE

/datum/dna_block/feature/mutant/legs
	feature_key = FEATURE_LEGS

/datum/dna_block/feature/mutant/fluff
	feature_key = FEATURE_FLUFF

/datum/dna_block/feature/mutant/penis
	feature_key = FEATURE_PENIS

/datum/dna_block/feature/mutant/testicles
	feature_key = FEATURE_TESTICLES

/datum/dna_block/feature/mutant/vagina
	feature_key = FEATURE_VAGINA

/datum/dna_block/feature/mutant/womb
	feature_key = FEATURE_WOMB

/datum/dna_block/feature/mutant/anus
	feature_key = FEATURE_ANUS

/datum/dna_block/feature/mutant/breasts
	feature_key = FEATURE_BREASTS

/datum/dna_block/feature/mutant/skrell_hair
	feature_key = FEATURE_SKRELL_HAIR

/datum/dna_block/feature/mutant/xenodorsal
	feature_key = FEATURE_XENODORSAL

/datum/dna_block/feature/mutant/xenohead
	feature_key = FEATURE_XENOHEAD

/datum/dna_block/feature/mutant/taur
	feature_key = FEATURE_TAUR

#undef FEATURE_HASH_PART_START
#undef FEATURE_HASH_PART_END
#undef FEATURE_HASH_COLOR1_START
#undef FEATURE_HASH_COLOR1_END
#undef FEATURE_HASH_COLOR2_START
#undef FEATURE_HASH_COLOR2_END
#undef FEATURE_HASH_COLOR3_START
#undef FEATURE_HASH_COLOR3_END
