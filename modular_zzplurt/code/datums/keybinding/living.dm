/datum/keybinding/living/combat_indicator/down(client/user)
	. = ..()
	var/mob/living/carbon/human/humie = user.mob
	if(. && istype(humie))
		return
	humie.set_combat_focus(!humie.combat_focus)
