/obj/item/mod/control/seal_part(obj/item/clothing/part, is_sealed)
	. = ..()
	if(activating)
		return

	update_external_organs_modsuit_status(is_sealed && active)
	wearer.update_body_parts(TRUE)

/obj/item/mod/control/control_activation(is_on)
	. = ..()
	update_external_organs_modsuit_status(is_on)
	wearer.update_body_parts(TRUE)

/obj/item/mod/control/deploy(mob/user, obj/item/part, instant = FALSE)
	. = ..()
	update_external_organs_modsuit_status(active)
	wearer.update_body_parts(TRUE)

/obj/item/mod/control/retract(mob/user, obj/item/part, instant = FALSE)
	. = ..()
	update_external_organs_modsuit_status(FALSE)
	wearer.update_body_parts(TRUE)

/// Simple helper proc to force an update of the external organs appearance
/// if necessary.
/obj/item/mod/control/proc/update_external_organs_modsuit_status(status)
	if(!wearer?.organs)
		return

	for(var/obj/item/organ/to_update in wearer.organs)
		to_update.bodypart_overlay?.set_modsuit_status(status)
