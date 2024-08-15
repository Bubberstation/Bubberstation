/mob/living/basic/revenant
	essence = 1
	max_essence = 60
	essence_regen_amount = 1
	var/times_tossed = 0


/mob/living/basic/revenant/get_status_tab_items()
	. = ..()
	. += "Times scattered: [times_tossed]"


/obj/item/ectoplasm/revenant/proc/become_defeated()
	alpha = 0
	revenant.times_tossed++
	var/datum/action/cooldown/spell/aoe/revenant/ability = pick(revenant.abilities)
	ability.locked = initial(ability.locked)
	revenant.essence_regen_amount = 0.05 // drain a soul to get it back to normal.
