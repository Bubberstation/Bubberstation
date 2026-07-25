/datum/species
	var/remove_features = FALSE

/datum/species/abductor
	remove_features = TRUE

/datum/species/skeleton
	remove_features = TRUE

/datum/species/monkey
	remove_features = TRUE // No more monkeys with tits, sorry

/datum/species/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	if(remove_features)
		human_who_gained_species.dna.mutant_bodyparts = list()
		human_who_gained_species.dna.body_markings = list()
	. = ..()

/// Tries to override our bodypart_overrides with digi varieties
/// Doesnt actually give us the limbs, you might have to call replace_body after this
/datum/species/proc/try_make_digitigrade(mob/living/carbon/human/human_who_gained_species)
	var/ignore_digi = FALSE // You can jack into this var with other checks, if you want.
	if(type == /datum/species/synthetic)
		var/list/chassis = human_who_gained_species.dna.mutant_bodyparts[MUTANT_SYNTH_CHASSIS]
		if(chassis)
			var/list/chassis_accessory = SSaccessories.sprite_accessories[MUTANT_SYNTH_CHASSIS]
			var/datum/sprite_accessory/synth_chassis/body_choice
			if(chassis_accessory)
				body_choice = chassis_accessory[chassis[MUTANT_INDEX_NAME]]
			if(body_choice && !body_choice.is_digi_compatible)
				ignore_digi = TRUE

	if(!ignore_digi && ((digitigrade_customization == DIGITIGRADE_OPTIONAL && human_who_gained_species.dna.features[FEATURE_LEGS] == DIGITIGRADE_LEGS) || digitigrade_customization == DIGITIGRADE_FORCED))
		var/obj/item/bodypart/leg/right/r_leg = bodypart_overrides[BODY_ZONE_R_LEG]
		if(r_leg)
			bodypart_overrides[BODY_ZONE_R_LEG] = initial(r_leg.digitigrade_type)
		var/obj/item/bodypart/leg/left/l_leg = bodypart_overrides[BODY_ZONE_L_LEG]
		if(l_leg)
			bodypart_overrides[BODY_ZONE_L_LEG] = initial(l_leg.digitigrade_type)
