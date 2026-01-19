
/datum/component/organ_corruption/tongue
	corruptable_organ_type = /obj/item/organ/tongue
	corrupted_icon_state = "tongue"
	/// The item action given to the tongue once it was corrupted.
	var/tongue_action_type = /datum/action/cooldown/bloodsucker/feed // BUBBER EDIT: BLOODSUCKER BITE OLD: /datum/action/cooldown/hemophage/drain_victim

/datum/component/organ_corruption/tongue/corrupt_organ(obj/item/organ/corruption_target)
	. = ..()

	if(!.)
		return

	var/obj/item/organ/tongue/corrupted_tongue = corruption_target
	corrupted_tongue.liked_foodtypes = BLOODY
	corrupted_tongue.disliked_foodtypes = NONE

	var/datum/action/tongue_action = corruption_target.add_item_action(tongue_action_type)

	if(corruption_target.owner)
		tongue_action.Grant(corruption_target.owner)
