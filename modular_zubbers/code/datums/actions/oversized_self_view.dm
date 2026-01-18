/// Action that allows Oversized characters to see themselves at normal size (1x) instead of their actual 2x size.
/// This is a visual-only effect that only affects the character's own view.
/datum/action/oversized_self_view
	name = "Toggle Self-Size View"
	desc = "Toggle between seeing yourself at your actual size (2x) or at normal size (1x). Only you can see this change."
	button_icon = 'icons/hud/actions.dmi'
	button_icon_state = "default"
	background_icon_state = ACTION_BUTTON_DEFAULT_BACKGROUND
	check_flags = NONE
	/// Whether the normal-size view is currently active
	var/active = FALSE
	/// The image we create to show the normal-size version
	var/image/normal_size_image

/datum/action/oversized_self_view/New(Target)
	. = ..()
	if(!ishuman(target))
		stack_trace("Oversized self-view action created for non-human target")
		qdel(src)
		return

/datum/action/oversized_self_view/IsAvailable(feedback = FALSE)
	var/mob/living/carbon/human/human_owner = owner
	if(!istype(human_owner))
		return FALSE
	if(!HAS_TRAIT(human_owner, TRAIT_OVERSIZED))
		return FALSE
	return TRUE

/datum/action/oversized_self_view/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return

	if(active)
		disable_normal_view()
	else
		enable_normal_view()

/datum/action/oversized_self_view/proc/enable_normal_view()
	var/mob/living/carbon/human/human_owner = owner
	if(!istype(human_owner) || !human_owner.client)
		return

	// Create and update the image
	update_normal_size_image()

	// Add it to the client's images so only they see it
	human_owner.client.images |= normal_size_image

	// Register signals to update when needed
	RegisterSignal(human_owner, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_z_change))
	RegisterSignal(human_owner, COMSIG_ATOM_POST_DIR_CHANGE, PROC_REF(on_dir_change))
	RegisterSignal(human_owner, COMSIG_ATOM_UPDATED_ICON, PROC_REF(on_appearance_update))
	RegisterSignal(human_owner, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_appearance_update))
	RegisterSignal(human_owner, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(on_appearance_update))
	RegisterSignal(human_owner, COMSIG_MOB_DROPPED_ITEM, PROC_REF(on_appearance_update))
	RegisterSignal(human_owner, COMSIG_LIVING_PICKED_UP_ITEM, PROC_REF(on_appearance_update))
	RegisterSignal(human_owner, COMSIG_MOB_SWAP_HANDS, PROC_REF(on_appearance_update))

	active = TRUE
	to_chat(human_owner, span_notice("You now see yourself at normal size."))

/datum/action/oversized_self_view/proc/disable_normal_view()
	var/mob/living/carbon/human/human_owner = owner
	if(!istype(human_owner))
		return

	if(human_owner.client && normal_size_image)
		human_owner.client.images -= normal_size_image

	UnregisterSignal(human_owner, list(
		COMSIG_MOVABLE_Z_CHANGED,
		COMSIG_ATOM_POST_DIR_CHANGE,
		COMSIG_ATOM_UPDATED_ICON,
		COMSIG_MOB_EQUIPPED_ITEM,
		COMSIG_MOB_UNEQUIPPED_ITEM,
		COMSIG_MOB_DROPPED_ITEM,
		COMSIG_LIVING_PICKED_UP_ITEM,
		COMSIG_MOB_SWAP_HANDS
	))

	normal_size_image = null
	active = FALSE
	to_chat(human_owner, span_notice("You now see yourself at your actual size."))

/datum/action/oversized_self_view/proc/on_z_change(mob/living/carbon/human/source)
	SIGNAL_HANDLER
	if(normal_size_image)
		SET_PLANE_EXPLICIT(normal_size_image, ABOVE_GAME_PLANE, source)

/datum/action/oversized_self_view/proc/on_dir_change(mob/living/carbon/human/source, old_dir, new_dir)
	SIGNAL_HANDLER
	if(!active || !normal_size_image || !source.client)
		return

	// Update the image to reflect the new direction
	update_normal_size_image()

/// Updates the overlay when appearance changes (equipment, hands, etc.)
/datum/action/oversized_self_view/proc/on_appearance_update(mob/living/carbon/human/source, ...)
	SIGNAL_HANDLER
	if(!active || !source.client)
		return

	// Update the image to reflect any appearance changes
	update_normal_size_image()

/// Creates or updates the normal-size image with proper scaling and foot alignment
/datum/action/oversized_self_view/proc/update_normal_size_image()
	var/mob/living/carbon/human/human_owner = owner
	if(!istype(human_owner) || !human_owner.client)
		return

	// Remove old image if it exists
	if(normal_size_image && human_owner.client)
		human_owner.client.images -= normal_size_image

	// Create an image based on the mob's current appearance
	normal_size_image = image(human_owner.appearance, human_owner)
	normal_size_image.name = human_owner.name
	normal_size_image.override = TRUE

	// Scale it down to 0.5x (normal size) since they're 2x
	// The oversized character is 2x size (64px tall), scaling to 0.5x makes it 32px tall
	// When scaling, the image scales around its center, so we need to adjust pixel_y to align feet
	var/matrix/transform_matrix = matrix()
	transform_matrix.Scale(0.5)
	normal_size_image.transform = transform_matrix

	// Adjust pixel_y to align feet at the bottom
	// For a 2x character scaled to 0.5x: the scaled sprite is 32px tall
	// The oversized sprite is 64px tall (2 * ICON_SIZE_Y)
	// When scaling 0.5x, the center stays the same, so the bottom moves up by half the difference
	// We need to move down by ICON_SIZE_Y * 0.5 (16px) to align the feet properly
	// Negative pixel_y moves DOWN in BYOND
	normal_size_image.pixel_y = -(ICON_SIZE_Y * 0.5)

	// Set it to the correct plane
	SET_PLANE_EXPLICIT(normal_size_image, ABOVE_GAME_PLANE, human_owner)

	// Re-add to client images
	if(human_owner.client)
		human_owner.client.images |= normal_size_image


/datum/action/oversized_self_view/Remove(mob/remove_from)
	disable_normal_view()
	return ..()

