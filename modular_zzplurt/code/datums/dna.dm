/datum/dna/transfer_identity(mob/living/carbon/destination, transfer_SE, transfer_species)
	var/old_size = destination.dna.features["body_size"]
	. = ..()
	destination.update_size(get_size(destination), old_size)

/mob/living/carbon/human/hardset_dna(unique_identity, list/mutation_index, list/default_mutation_genes, newreal_name, newblood_type, datum/species/mrace, newfeatures, list/mutations, force_transfer_mutations)
	var/old_size = dna.features["body_size"]
	. = ..()
	update_size(get_size(src), old_size)
