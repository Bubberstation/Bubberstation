/obj/item/ectoplasm/revenant/attack_self(mob/user)
	if(user.job == JOB_CHAPLAIN || usr.job == JOB_CHAPLAIN)
		. = ..()
	else
		return

/obj/item/ectoplasm/revenant/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	return FALSE
