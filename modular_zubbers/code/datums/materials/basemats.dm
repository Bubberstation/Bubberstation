/datum/material/silver/on_applied(atom/source, mat_amount, multiplier, from_slot)
	. = ..()
	source.AddComponent(/datum/component/bane, affected_biotypes = MOB_VAMPIRIC, damage_multiplier = 0.5)

/* /datum/material/silver/on_removed(atom/source, mat_amount, multiplier, from_slot)
	. = ..()
	source.RemoveComponentSource(/datum/component/bane, affected_biotypes = MOB_VAMPIRIC, damage_multiplier = 0.5)

//this component should be removed when silver is naturally removed, it should be possible for silver to be removed without this proc being called.
 */
