/datum/dna
	var/last_capped_size //For some reason this feels dirty... I suppose it should go somewhere else

/datum/dna/transfer_identity(mob/living/carbon/destination, transfer_SE, transfer_species)
	var/old_size = destination.dna.features["body_size"]
	. = ..()
	destination.update_size(get_size(destination), old_size)

/mob/living/carbon/human/hardset_dna(unique_identity, list/mutation_index, list/default_mutation_genes, newreal_name, newblood_type, datum/species/mrace, newfeatures, list/mutations, force_transfer_mutations)
	var/old_size = dna.features["body_size"]
	. = ..()
	update_size(get_size(src), old_size)

/datum/dna/copy_dna(datum/dna/new_dna)
	. = ..()
	if(holder)
		holder.adjust_mobsize(get_size(holder))

/datum/dna/update_body_size()
	if(!holder || species.body_size_restricted || current_body_size == features["body_size"])
		return ..()

	holder.remove_movespeed_modifier(/datum/movespeed_modifier/small_stride)

	. = ..()

	if(get_size(holder) >= (RESIZE_A_BIGNORMAL + RESIZE_NORMAL) / 2)
		holder.small_sprite.Grant(holder)
	else
		holder.small_sprite.Remove(holder)

	if(!iscarbon(holder))
		return

	/* Needs genital updates
	var/mob/living/carbon/C = holder
	for(var/obj/item/organ/genital/G in C.internal_organs)
		if(istype(G))
			G.update()
	*/

	var/new_slowdown = (abs(get_size(holder) - 1) * CONFIG_GET(number/body_size_slowdown_multiplier))
	holder.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/small_stride, TRUE, new_slowdown)

	var/size_cap = CONFIG_GET(number/macro_health_cap)
	if((size_cap > 0) && (get_size(holder) > size_cap))
		last_capped_size = (last_capped_size ? last_capped_size : current_body_size)
		return
	if(last_capped_size)
		current_body_size = last_capped_size
		last_capped_size = null
	var/healthmod_old = ((current_body_size * 75) - 75)
	var/healthmod_new = ((get_size(holder) * 75) - 75)
	var/healthchange = healthmod_new - healthmod_old
	holder.maxHealth += healthchange
	holder.health += healthchange

/mob/living/carbon/set_species(datum/species/mrace, icon_update, pref_load, list/override_features, list/override_mutantparts, list/override_markings)
	. = ..()
	adjust_mobsize(get_size(src))

/datum/preference/choiced/species/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/prefs)
	. = ..()
	target.adjust_mobsize(get_size(target))
