/datum/dna
	var/list/list/mutant_bodyparts = list()
	features = MANDATORY_FEATURE_LIST
	///Body markings of the DNA's owner. This is for storing their original state for re-creating the character. They'll get changed on species mutation
	var/list/list/body_markings = list()
	///Current body size, used for proper re-sizing and keeping track of that
	var/current_body_size = BODY_SIZE_NORMAL

/datum/dna/proc/update_body_size()
	if(!holder || species.body_size_restricted || current_body_size == features["body_size"])
		return
	var/change_multiplier = features["body_size"] / current_body_size
	//We update the translation to make sure our character doesn't go out of the southern bounds of the tile
	var/translate = ((change_multiplier-1) * 32)/2
	holder.transform = holder.transform.Scale(change_multiplier)
	// Splits the updated translation into X and Y based on the user's rotation.
	var/translate_x = translate * ( holder.transform.b / features["body_size"] )
	var/translate_y = translate * ( holder.transform.e / features["body_size"] )
	holder.transform = holder.transform.Translate(translate_x, translate_y)
	holder.maptext_height = 32 * features["body_size"] // Adjust runechat height
	current_body_size = features["body_size"]

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
