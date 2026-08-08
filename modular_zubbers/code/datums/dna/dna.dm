/datum/dna
	var/list/list/mutant_bodyparts = list()
	features = MANDATORY_FEATURE_LIST
	///Body markings of the DNA's owner. This is for storing their original state for re-creating the character. They'll get changed on species mutation
	var/list/list/body_markings = list()
	///Current body size, used for proper re-sizing and keeping track of that

/mob/living/carbon/proc/apply_customizable_dna_features_to_species()
	if(!has_dna())
		CRASH("[src] does not have DNA")
	dna.species.body_markings = dna.body_markings.Copy()
	var/list/bodyparts_to_add = dna.mutant_bodyparts.Copy()
	for(var/key in bodyparts_to_add)
		if(SSaccessories.sprite_accessories[key] && bodyparts_to_add[key] && bodyparts_to_add[key][MUTANT_INDEX_NAME])
			var/datum/sprite_accessory/SP = SSaccessories.sprite_accessories[key][bodyparts_to_add[key][MUTANT_INDEX_NAME]]
			if(!SP?.factual)
				bodyparts_to_add -= key
				continue
	dna.species.mutant_bodyparts = bodyparts_to_add.Copy()
