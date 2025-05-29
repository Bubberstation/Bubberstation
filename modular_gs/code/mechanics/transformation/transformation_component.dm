/datum/component/transformation_item
	/// What mob do we currently have stuck in us?
	var/mob/living/transformed_mob
	/// Do we release the mob when the parent item is destroyed?
	var/release_mob = TRUE
	/// Is the mob able to speak as the item?
	var/able_to_speak = FALSE
	/// Is the mob able to emote as the item?
	var/able_to_emote = FALSE
	/// Does the object scale with the sprite size of the mob inside of it?
	var/scale_object = TRUE
	/// Show custom description.
	var/show_that_object_is_tf = TRUE
	/// Stored real name
	var/stored_real_name = ""
	/// Stored name
	var/stored_name = ""
	/// Is the component able to be removed?
	var/stuck_on_item = FALSE
	/// Is the person able to struggle out?
	var/able_to_struggle_out = TRUE
	/// Transfer to vore belly when eaten
	var/transfer_to_vore = TRUE
	/// Has the mob already been removed?
	var/mob_removed = FALSE

/datum/component/transformation_item/Initialize()
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(examine))
	RegisterSignal(parent, COMSIG_PARENT_PREQDELETED, PROC_REF(remove_mob))

/datum/component/transformation_item/Destroy(force, silent)
	if(!mob_removed)
		remove_mob()

	return ..()

/datum/component/transformation_item/proc/examine(datum/source, mob/user, list/examine_list)
	if(show_that_object_is_tf)
		examine_list += span_notice("Something about [source] seems lifelike.")

/datum/component/transformation_item/proc/register_mob(mob/living/mob_to_register)
	var/atom/parent_atom = parent
	if(!istype(mob_to_register))
		return FALSE

	transformed_mob = mob_to_register
	stored_real_name = mob_to_register.real_name
	stored_name = mob_to_register.name

	// This is really dumb, but if it works, then maybe it is not dumb.
	mob_to_register.real_name = parent_atom.name
	mob_to_register.name = parent_atom.name

	ADD_TRAIT(mob_to_register, TRAIT_TRANSFORMED, src)
	ADD_TRAIT(mob_to_register, TRAIT_RESISTCOLD, src)
	ADD_TRAIT(mob_to_register, TRAIT_RESISTLOWPRESSURE, src)
	ADD_TRAIT(mob_to_register, TRAIT_LOWPRESSURECOOLING, src)
	ADD_TRAIT(mob_to_register, TRAIT_NOBREATH, src)

	if(!able_to_speak)
		ADD_TRAIT(mob_to_register, TRAIT_MUTE, src)

	if(!able_to_emote)
		ADD_TRAIT(mob_to_register, TRAIT_EMOTEMUTE, src)

	// need to stop them from using radio headsets.
	var/mob/living/carbon/human/human_mob = mob_to_register
	if(istype(human_mob))
		ADD_TRAIT(mob_to_register, TRAIT_PARALYSIS_L_ARM, src)
		ADD_TRAIT(mob_to_register, TRAIT_PARALYSIS_R_ARM, src)
		human_mob.update_disabled_bodyparts()

	mob_to_register.forceMove(parent_atom)
	if(scale_object)
		var/target_size = mob_to_register.size_multiplier
		var/matrix/new_matrix = new

		new_matrix.Scale(target_size)
		new_matrix.Translate(0,16 * (target_size-1))
		parent_atom.transform = new_matrix

/datum/component/transformation_item/proc/remove_mob()
	if(!release_mob || !transformed_mob)
		return FALSE

	transformed_mob.real_name = stored_real_name
	transformed_mob.name = stored_name

	if(!able_to_speak)
		REMOVE_TRAIT(transformed_mob, TRAIT_MUTE, src)

	if(!able_to_emote)
		REMOVE_TRAIT(transformed_mob, TRAIT_EMOTEMUTE, src)

	REMOVE_TRAIT(transformed_mob, TRAIT_TRANSFORMED, src)
	REMOVE_TRAIT(transformed_mob, TRAIT_RESISTCOLD, src)
	REMOVE_TRAIT(transformed_mob, TRAIT_RESISTLOWPRESSURE, src)
	REMOVE_TRAIT(transformed_mob, TRAIT_LOWPRESSURECOOLING, src)
	REMOVE_TRAIT(transformed_mob, TRAIT_NOBREATH, src)

	var/mob/living/carbon/human/human_mob = transformed_mob
	if(istype(human_mob))
		REMOVE_TRAIT(human_mob, TRAIT_PARALYSIS_L_ARM, src)
		REMOVE_TRAIT(human_mob, TRAIT_PARALYSIS_R_ARM, src)
		human_mob.update_disabled_bodyparts()

	var/atom/parent_atom = parent
	var/turf/parent_turf = get_turf(parent_atom)

	transformed_mob.forceMove(parent_turf)
	if(scale_object)
		parent_atom.transform = null

	mob_removed = TRUE
	qdel(src)
