/mob/living/simple_animal/hostile/megafauna/devour(mob/living/victim)
	var/mob/dead/observer/ghost = victim.get_ghost(TRUE, TRUE)
	if(!(ghost?.can_reenter_corpse && ghost?.client) && !victim.client)
		victim.gib()

	if(isnull(victim) || victim.has_status_effect(/datum/status_effect/gutted))
		LoseTarget()
		return FALSE
	celebrate_kill(victim)
	if(!is_station_level(z) || client) //NPC monsters won't heal while on station
		heal_overall_damage(victim.maxHealth * 0.5)
	victim.investigate_log("has been devoured by [src].", INVESTIGATE_DEATHS)
	if(iscarbon(victim))
		qdel(victim.get_organ_slot(ORGAN_SLOT_LUNGS))
		qdel(victim.get_organ_slot(ORGAN_SLOT_HEART))
		qdel(victim.get_organ_slot(ORGAN_SLOT_LIVER))
	victim.adjust_brute_loss(500)
	victim.death() //make sure they die
	victim.apply_status_effect(/datum/status_effect/gutted)
	LoseTarget()
	return TRUE
